/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradePayinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradeTraceService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.dao.trade.OrderinfoDao;
import com.thinkgem.jeesite.modules.wlpt.dao.trade.TradePayinfoDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserDisputeDao;

/**
 * 争议处理Service
 * 
 * @author fjc
 * @version 2016-08-05
 */
@Service
@Transactional(readOnly = true)
public class UserDisputeService extends CrudService<UserDisputeDao, UserDispute> {

	@Autowired
	private UserDisputeDao userDisputeDao;

	@Autowired
	private OrderinfoDao orderinfoDao;

	@Autowired
	private TradePayinfoDao tradePayinfoDao;

	@Autowired
	private TradePayinfoService tradePayinfoService;

	@Autowired
	private TradeTraceService tradeTraceService;

	@Autowired
	private OrderinfoService orderinfoService;

	public UserDispute get(String id) {
		return super.get(id);
	}

	/**
	 * 通过运单id获取争议信息
	 * 
	 * @param orderId
	 * @return
	 */
	public UserDispute getByUserDispute(String orderId) {
		return userDisputeDao.getByUserDispute(orderId);
	}

	public List<UserDispute> findList(UserDispute userDispute) {
		return super.findList(userDispute);
	}

	public Page<UserDispute> findPage(Page<UserDispute> page, UserDispute userDispute) {
		return super.findPage(page, userDispute);
	}

	@Transactional(readOnly = false)
	public void save(UserDispute userDispute) {
		super.save(userDispute);
	}

	@Transactional(readOnly = false)
	public void delete(UserDispute userDispute) {
		super.delete(userDispute);
	}

	/**
	 * 后台争议审核
	 * 
	 * @param userDispute
	 * @param model
	 * @return
	 *//*
	@Transactional(readOnly = false)
	public Map<String, Object> editUserdispute(UserDispute userDispute) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "保存成功";
		Orderinfo orderinfo = new Orderinfo();
		TradePayinfo tradePayinfo = new TradePayinfo();
		User user = UserUtils.findUser(UserUtils.getUser());
		UserDispute dispute = get(userDispute.getId());
		if (user == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "登陆信息失效,请重新登陆";
		}
		if (userDispute.getId() == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "争议id信息异常,请重新登陆";
		}
		if (userDispute.getStatus() == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "争议处理状态异常,请重新登陆";
		}
		if (userDispute.getDealname() == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "争议处理人名字异常,请重新登陆";
		}
		if (userDispute.getDealphone() == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "争议处理人电话异常,请重新登陆";
		}
		if (userDispute.getStatus() == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "争议处理反馈信息异常,请重新登陆";
		}
		if (dispute == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "争议信息异常,请重新登陆";
		}
		String status = userDispute.getStatus();
		String disputeStatus = dispute.getStatus();
		if (state == DataDic.RETURN_STATUS_NORMAL && (DataDic.DISPUTE_STATUS_CREATE.equals(disputeStatus)
				|| DataDic.DISPUTE_STATUS_BEING.equals(disputeStatus))) {// 信息存在并且状态为发起或者处理中
			if (status.equals(DataDic.DISPUTE_STATUS_CREATE) || status.equals(DataDic.DISPUTE_STATUS_BEING)) {// 处理后争议发起状态或者处理中状态
				super.save(userDispute);
			} else if (status.equals(DataDic.DISPUTE_STATUS_END) || status.equals(DataDic.DISPUTE_STATUS_QUIDCO)) {// 争议处理完成状态
																													// //或争议退款状态
				String disputeMoney = userDispute.getDisputemoney();// 后台争议处理手动输入的金额
				if (disputeMoney == null) {
					state = DataDic.RETURN_STATUS_AUTHBUG;
					message = "处理争议结果费用不能为空";
				}
				if (userDispute.getOrderinfo().getId() == null) {
					state = DataDic.RETURN_STATUS_AUTHBUG;
					message = "运单id异常";
				}
				if (userDispute.getOrderinfo().getId() != null) {
					orderinfo = orderinfoDao.get(userDispute.getOrderinfo().getId());
				}
				if (orderinfo == null) {
					state = DataDic.RETURN_STATUS_AUTHBUG;
					message = "运单信息异常";
				} else {
					tradePayinfo = tradePayinfoDao.getByorderId(orderinfo.getId());
				}

				if (tradePayinfo == null) {
					state = DataDic.RETURN_STATUS_AUTHBUG;
					message = "运单支付信息异常";
				}
				if (state == DataDic.RETURN_STATUS_NORMAL) {
					Double disputeMoneyNum = Double.valueOf(disputeMoney);// 后台争议处理手动输入的金额
					Double ordertotal = Double.valueOf(tradePayinfo.getActualamount());// 现在实际支付金额
					Double Beforemoney = Double.valueOf(dispute.getDisputemoneybefore());// 处理之前实际支付金额
					if (disputeMoneyNum < Beforemoney || disputeMoneyNum == Beforemoney
							|| disputeMoneyNum.equals(Beforemoney)) {
						// 争议表
						Double disputeAmount = Beforemoney - disputeMoneyNum;// 处理后的实际支付金额
						userDispute.setDisputemoney(String.valueOf(disputeMoneyNum)); // 争议金额
						userDispute.setDealuser(user);
						userDispute.setDisputemoneydiff(String.valueOf(disputeAmount));// 处理后的实际支付金额
						super.save(userDispute);

						// tradePayinfo运单支付表
						tradePayinfo.setDisputeamount(String.valueOf(disputeMoneyNum));// 争议金额
						tradePayinfo.setActualamount(String.valueOf(disputeAmount));// 处理后的实际支付金额
						tradePayinfoService.save(tradePayinfo);
						tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_DISPUTE, orderinfo.getOrderstatus(),
								orderinfo);// 保存运单信息变更日志

						Orderinfo neworder = new Orderinfo();
						neworder.setId(orderinfo.getId());
						neworder.setOrderstatus(DataDic.ORDER_STATUS_DISPUTE_END);// 状态争议已完成
						orderinfoService.save(neworder);// 更新运单状态信息
						tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, DataDic.ORDER_STATUS_DISPUTE_END,
								orderinfo);// 保存运单信息变更日志
						message = "争议处理成功!";
					}

				}
			}
		}
		return Tools.getMapResult(state, message, null);
	}
*/
	/**
	 * 确认争议
	 * 
	 * @param orderId
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean confirmUserdispute(String orderId) {
		Boolean result = false;
		int state = 1;
		UserDispute userDispute = new UserDispute();
		if (orderId == null) {
			state = 0;
		}
		if (state == 1) {
			userDispute = userDisputeDao.getByUserDispute(orderId);
			if (userDispute != null && userDispute.getDisputeeverconfirmed().equals(DataDic.DISPUTE_CONFIRMFALSE)) {// 争议存在并且还没有同意
				userDispute.setDisputeeverconfirmed(DataDic.DISPUTE_CONFIRMTRUE);
				super.save(userDispute);
				result = true;
			}
		}
		return result;
	}
}