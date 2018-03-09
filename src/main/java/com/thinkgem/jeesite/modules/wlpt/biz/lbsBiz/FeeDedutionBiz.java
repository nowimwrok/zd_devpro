package com.thinkgem.jeesite.modules.wlpt.biz.lbsBiz;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.Enum.FeeDecutionWay;
import com.thinkgem.jeesite.common.utils.LBSUtil;
import com.thinkgem.jeesite.common.utils.PageData;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * lbs费用
 * 
 * @author 曾煜佳
 * @version 2016-10-17
 *
 */
@Service
@Transactional(readOnly = true)
public class FeeDedutionBiz {

	@Autowired
	private JobBiz jobBiz;

	@Autowired
	private OrderinfoService orderService;

	@Autowired
	private WlptUserService userService;

	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;

	/***
	 * 定位前检查是否符合扣费标准
	 * 
	 * @Description: TODO
	 * @param @param
	 *            userID
	 * @param @param
	 *            feeDecutionWay
	 * @param @param
	 *            charge
	 * @param @return
	 * @return boolean
	 * @throws @author
	 *             zyj
	 * @date 2016年10月17日
	 */
	@Transactional(readOnly = false)
	public boolean checkFee(String userID, FeeDecutionWay feeDecutionWay, double charge) {
		User user = new User();
		user.setId(userID);
		boolean result = true;
		try {
			List<User> ulst = userService.getByUser(user);
			if (ulst.size() == 0) {
				return false;
			}
			user = ulst.get(0);
			if (feeDecutionWay == FeeDecutionWay.WebBalance) {
				if (user.getUserPurse().getWebbalance() < charge)
					result = false;
			} else if (feeDecutionWay == FeeDecutionWay.CoinBalance) {
				if (user.getUserPurse().getWebcoin() < charge)
					result = false;
			}
			return result;
		} catch (Exception ex) {
			return false;
		}
	}

	/***
	 * 车辆定位扣除费用
	 * 
	 * @Description: TODO
	 * @param @param
	 *            orderId
	 * @param @param
	 *            feeDecutionWay
	 * @param @return
	 * @return boolean
	 * @throws @author
	 *             zyj
	 * @date 2016年10月10日
	 */
	@Transactional(readOnly = false)
	public boolean feeDeduction(String orderId, FeeDecutionWay feeDecutionWay, double charge) {
		String iscoin = DataDic.YES;
		try {
			if (feeDecutionWay == FeeDecutionWay.WebBalance) {
				iscoin = DataDic.NO;
			}
			// 生成消费记录
			int back=consumeRecodBiz.payOrderLbsBiz(orderId, iscoin, charge);
			if(back!=1){
				return false;
			}
			return true;
		} catch (Exception ex) {
			return false;
		}
	}

	/***
	 * 定位成功后减去订单定位的相应次数，如果次数为0时结束定位
	 * 
	 * @Description: TODO
	 * @param @param
	 *            order
	 * @param @return
	 * @return boolean
	 * @throws @author
	 *             zyj
	 * @date 2016年10月17日
	 */
	@Transactional(readOnly = false)
	public boolean feeDeductionOrder(Orderinfo order) {
		Orderinfo orderinfo = new Orderinfo();
		Double LBSCost = Double.parseDouble(Const.LBS_COST);
		try {
			
			orderinfo.setId(order.getId());
			orderinfo.setOrderno(order.getOrderno());
			if (DataDic.ORDER_STATUS_RECEIPT.equals(order.getOrderstatus())) {
				orderinfo.setLocationstate(Integer.parseInt(DataDic.LBS_STATUS_END));
				orderinfo.setIslocated("0");
				BscJob bscjob = new BscJob();
				bscjob.setJobcode(order.getOrderno());
				jobBiz.delete(bscjob);
			} else {

				// 卓币支付
				if (DataDic.CONSUMERECODE_WAY_COIN.equals(String.valueOf(order.getLocationpayway()))) {

					if (checkFee(order.getSeller().getId(), FeeDecutionWay.CoinBalance, LBSCost)) {
						feeDeduction(order.getId(), FeeDecutionWay.CoinBalance, LBSCost);
					}

				}
				// 余额支付
				if (DataDic.CONSUMERECODE_WAY_BALANCE.equals(String.valueOf(order.getLocationpayway()))) {
					if (checkFee(order.getSeller().getId(), FeeDecutionWay.WebBalance, LBSCost)) {
						feeDeduction(order.getId(), FeeDecutionWay.WebBalance, LBSCost);
					}

				}
				orderinfo.setLocationstate(Integer.parseInt(DataDic.LBS_STATUS_BEING));
				orderinfo.setLocationstate(2);
				orderinfo.setLocationcount(order.getLocationcount() + 1);
				orderinfo.setLocationamount(order.getLocationamount() + LBSCost);
			}

			orderService.save(orderinfo);
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}

	/***
	 * 检查是否满足定位，获取定位信息，扣费
	 * @Description: TODO
	 * @param @throws Exception   
	 * @return void  
	 * @throws
	 * @author lqz
	 * @date 2015年8月16日
	 */
	@Transactional(readOnly = false)
	public PageData txMethodSendLocation(String mobile,String carNumber,String traderOrder,String userName, String userIP,
			String userID,FeeDecutionWay feeDecutionWay,double charge,boolean isImmediate) throws Exception{
		 PageData result=new PageData();
		 try{
		if(checkFee(userID, feeDecutionWay, charge)){
			result=LBSUtil.SendLocation(mobile, carNumber, traderOrder, userName, userIP,isImmediate); 
			/*String res = result.getString("result");
			if(Integer.valueOf(res) == 1){
				feeDeduction(userID, feeDecutionWay, charge);
			}*/
			
	       }else{  
	    	   result.put("errormessage", (feeDecutionWay==FeeDecutionWay.CoinBalance?"卓币":"账号")+"余额不足,请充值后再定位");
	       }
		 }catch(Exception ex){
			 ex.printStackTrace();
		 }
		 return result;
		}
}
