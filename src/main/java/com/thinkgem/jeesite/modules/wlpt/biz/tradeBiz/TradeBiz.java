/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantLock;

import javax.annotation.Resource;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.barcode.QRCodeUtils;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.MapBaidu;
import com.thinkgem.jeesite.common.utils.OrderNumberUtil;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.MessagePushUtil;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.base.BscMessageBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BiddingBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.gps.GpsInfoBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.HistrackBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.LocationBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.railregistBiz.RailRegistBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.subscribeBiz.CarSubscribeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJobAccount;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.TradeComment;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.railregist.RailRegist;
import com.thinkgem.jeesite.modules.wlpt.entity.subscribe.CarSubscribe;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeReceipt;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeTrace;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserMessage;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;
import com.thinkgem.jeesite.modules.wlpt.service.comment.TradeCommentService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.QuoteinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;
import com.thinkgem.jeesite.modules.wlpt.service.railregist.RailRegistService;
import com.thinkgem.jeesite.modules.wlpt.service.subscribe.CarSubscribeService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradePayinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradeReceiptService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradeTraceService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserDisputeService;

/**
 * 运单信息Service
 *
 * @author 饶江龙
 * @version 2016-07-28
 */
@Service(value = "tradeBiz")
@Transactional(readOnly = true)
public class TradeBiz {

	@Autowired
	private OrderinfoService orderinfoService;

	@Autowired
	private TradePayinfoService payinfoService;

	@Autowired
	private QuoteinfoService quoteinfoService;

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private TradeTraceService tradeTraceService;

	@Autowired
	private TradePayinfoService tradePayinfoService;

	@Autowired
	private CarService carService;

	@Autowired
	private TradeReceiptService tradeReceiptService;

	@Autowired
	private UserDisputeService userDisputeService;

	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;

	@Autowired
	private GoodsBiz goodsBiz;

	@Autowired
	private TradeCommentService tradeCommentService;

	@Autowired
	private BiddingBiz biddingBiz;

	@Autowired
	private BidBlinfoService blinfoService;

	@Autowired
	private AccountBiz accountBiz;

	@Autowired
	private UserInsuranceService userInsuranceService;

	@Autowired
	private RailRegistService railRegistService;

	@Autowired
	private RailRegistBiz railRegistBiz;

	@Autowired
	private CarSubscribeBiz carSubscribeBiz;

	@Autowired
	private CarSubscribeService carSubscribeService;

	@Autowired
	private GpsCarInfoService carInfoService;

	@Autowired
	private LocationBiz zjxlbiz;

	@Autowired
	private InterfaceLogBiz interfacelogbiz;

	@Autowired
	private GpsInfoBiz gpsInfoBiz;
	
	@Autowired
	private ConsumeRecodBiz consumebiz;
	@Autowired
	private OrderinfoService orderservice;
	@Autowired
	private HistrackBiz histrackBiz;

	private final ReentrantLock lock1 = new ReentrantLock();
	private final ReentrantLock lock2 = new ReentrantLock();
	private final ReentrantLock lock3 = new ReentrantLock();
	private final ReentrantLock lock4 = new ReentrantLock();
	private final ReentrantLock lock5 = new ReentrantLock();
	private final ReentrantLock lock6 = new ReentrantLock();

	public Orderinfo get(String id) {
		return orderinfoService.get(id);
	}

	@Resource(name = "jobBiz")
	private JobBiz jobBiz;

	@Autowired
	private IntegrityBiz integrityBiz;

    @Autowired
    private BscMessageBiz bscMessageBiz;
    @Autowired
    private LocationBiz locationBiz;

	/***
	 * 获取统计数据
	 *
     * @param orderinfo 必传showtime 与timeflag
	 * @param user
	 * @return
	 */
	public Object getEverDataBiz(Orderinfo orderinfo, User user) {
		/// 如果用户不为空,则查询用户列表信息
		if (user != null) {
			orderinfo.setCurrentUser(user);
		}
		List<Orderinfo> listVal = orderinfoService.getEverData(orderinfo);
		return Tools.getMapResult(DataDic.RETURN_STATUS_NORMAL, "获取成功", listVal);
	}


	/***
	 * 运单打印功能
	 *
	 * @param order_id
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object editPrintBiz(String order_id) {
		lock5.lock();
		try {
			int state = DataDic.RETURN_STATUS_NORMAL;
			String message = "缴纳成功";
			Orderinfo orderinfo = orderinfoService.get(order_id);
			User seller = UserUtils.findUser(orderinfo.getSeller());
            Double webmoney = Double.parseDouble(orderinfo.getPayinfo().getOnlineamount() != null ? orderinfo.getPayinfo().getOnlineamount() : "0");
            Double webcoin = Double.parseDouble(orderinfo.getPayinfo().getCoinamount() != null ? orderinfo.getPayinfo().getCoinamount() : "0");
			Double payMoney = Double.parseDouble(DictUtils.getDictValue("打单交费", "printPay", "20"));
			/// 限额
			Double udmoney = Double.parseDouble(DictUtils.getDictValue("限额", "printPay", "2000"));
			if (udmoney < (webcoin + webmoney)) {
				return Tools.getMapResult(state, message, null);
			}
			/// 如果已经打印过，则无需缴费
			if (DataDic.YES.equals(orderinfo.getIsprint())) {
				return Tools.getMapResult(state, message, null);
			}
			if (orderinfo == null || orderinfo.getSeller() == null) {
				state = DataDic.RETURN_STATUS_INFOBUG;
				message = "打印失败,信息缺失";
				return Tools.getMapResult(state, message, null);
			}

			Double avaliv = seller.getUserPurse().getAvailablebalance();
            if (!Tools.IsNullOrWhiteSpace(seller.getMemberId()) && (DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway()) || DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))) {
				avaliv = accountBiz.getAmount(seller, DataDic.AVAILABLE_BALANCE);
			}

			// if (payMoney > seller.getUserPurse().getAvailablebalance()) {
			if (payMoney > avaliv) {
				state = DataDic.RETURN_STATUS_MONEYBUG;
				message = "账户余额不足,请及时充值";
			}
			//// 是否操作频繁
			// if (!consumeRecodBiz.IsCommitData(UserUtils.getUser().getId(),
//                    DataDic.CONSUMERECODE_TYPE_PRINTPAY, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
			// return DataDic.RETURN_STATUS_REMORE;
			// }
			if (state == DataDic.RETURN_STATUS_NORMAL) {
				/// 交易记录
				int back = consumeRecodBiz.payPrintOrderBiz(order_id, payMoney);
				if (back != DataDic.RETURN_STATUS_NORMAL) {
					if (back == 8) {
						message = "提现金额大于单笔交易最高限额";
					} else if (back == 10) {
						message = "电子钱包最低留存额度不足";
					} else if (back == 11) {
						message = "提现金额大于单日交易最高限额";
					} else if (back == 12) {
						message = "提现金额大于单日累计提现限额";
					} else if (back == -1) {
						message = "账户系统异常";
					} else if (back == DataDic.RETURN_STATUS_SIGNOUT) {
						message = "应用正在日结中，等银行结算完毕再开放使用，结算时间为1-2小时";
					}
					return Tools.getMapResult(back, message, null);
				}
				Orderinfo upod = new Orderinfo();
				upod.setId(order_id);
				upod.setIsprint(DataDic.YES);//// 更新运单打印状态
				orderinfoService.save(upod);

				// 发送退还保证金
				String[] keywords = { payMoney.toString()};
                SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_PLRINTPAY, seller.getPhone(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keywords, null, null, true, SmsConfig.smsPrintPay);
			}

			return Tools.getMapResult(state, message, null);
		} finally {
			lock5.unlock();
		}
	}

	/**
	 * 获取完整的运单信息
	 *
	 * @param id
	 * @return
	 */
	public Orderinfo getOrder(String id) {
		Orderinfo orderinfo = orderinfoService.get(id);
		/// 获取报价信息
		orderinfo.setQuoteinfo(quoteinfoService.get(orderinfo.getQuoteinfo().getId()));
		/// 获取货源信息
		orderinfo.getQuoteinfo().setGoods(goodsService.get(orderinfo.getQuoteinfo().getGoods().getId()));
		return orderinfo;
	}

	/***
	 * 获取订单信息通过订单号
	 *
	 * @param orderinfo
	 * @return
	 */
	public Orderinfo getOrderByNo(Orderinfo orderinfo) {
		List<Orderinfo> olist = orderinfoService.findList(orderinfo);
		if (olist.size() <= 0) {
			return null;
		}
		orderinfo = olist.get(0);

		/// 获取报价信息
		orderinfo.setQuoteinfo(quoteinfoService.get(orderinfo.getQuoteinfo().getId()));
		/// 获取货源信息
		orderinfo.getQuoteinfo().setGoods(goodsService.get(orderinfo.getQuoteinfo().getGoods().getId()));
		return orderinfo;
	}

	/**
	 * 获取订单详情
	 *
     * @param id   订单ID
     * @param user 当前登录用户ID
	 * @return
	 */
	public Orderinfo getDetail(String id, User user) {
		/// 获取运单详情
		Orderinfo orderinfo = this.getOrder(id);

		/// 是否是买家
		if (StringUtils.isNoneBlank(user.getId()) && user.getId().equals(orderinfo.getBuyer().getId())) {
			orderinfo.setIsBuyer(true);
		} else {
			orderinfo.setIsBuyer(false);
		}
		if (DataDic.ORDER_ISDISPUTE_TRUE.equals(orderinfo.getIsdispute())) {// 运单已发起争议
			UserDispute userDispute = userDisputeService.getByUserDispute(orderinfo.getId());
			orderinfo.setUserDispute(userDispute);
		}

		return orderinfo;
	}


	/**
	 * 获取交易记录信息
	 *
     * @param orderinfo 传入orderinfo
     * @param type      类型：0:运单状态，2:支付状态，3运单运输 4 争议
	 * @return
	 */

	public Object getTraceBiz(Orderinfo orderinfo, String type) {
		int state = DataDic.RETURN_STATUS_NORMAL;

		TradeTrace tradeTrace = new TradeTrace();
		tradeTrace.setOrderinfo(orderinfo);
		tradeTrace.setType(type);
		List<TradeTrace> traceList = tradeTraceService.findList(tradeTrace);
		for (TradeTrace trace : traceList) {
			String code = "order_status";
			// 运单状态
			if (DataDic.ORDER_TRACE_TYPE_STATUS.equals(type)) {
				code = "order_status";
			} else if (DataDic.ORDER_TRACE_TYPE_PAY.equals(type)) {/// 支付状态
				code = "order_paystatus";
			}
			trace.setStatus(DictUtils.getDictLabel(trace.getStatus(), code, null));

		}
		return Tools.getMapResult(state, Tools.statusMessage(state, "交易记录"), traceList);
	}

	/***
	 * 查询分页信息
	 *
     * @param page      分页信息
     * @param orderinfo 运单条件
     * @param user      是否查询用户信息,传入用户ID,用户如果不为空的话
	 * @return 返回分页信息
	 */
	public Page<Orderinfo> findPage(Page<Orderinfo> page, Orderinfo orderinfo, User user) {
		/// 如果用户不为空,则查询用户列表信息
		if (user != null && !Tools.IsNullOrWhiteSpace(user.getId())) {
			orderinfo.setSeller(user);
		}
		Page<Orderinfo> pageVal = orderinfoService.findPage(page, orderinfo);
		/// 如果是查询个人用户的运单信息则判断是否是买家
		for (Orderinfo var : pageVal.getList()) {
			if (user != null && !Tools.IsNullOrWhiteSpace(user.getId())) {
				/// 判断用户ID是否相等
				if (user.getId().equals(var.getBuyer().getId())) {
					var.setIsBuyer(true);
				} else {
					var.setIsBuyer(false);
				}
			}
			/// 查询货源信息
			if (var.getQuoteinfo() != null && var.getQuoteinfo().getGoods() != null) {
				var.getQuoteinfo().setGoods(goodsService.get(var.getQuoteinfo().getGoods().getId()));
			}
			/// 字符状态--运单状态转化为中文
			var.setStatusStr(DictUtils.getDictLabel(var.getOrderstatus(), "order_status", null));
		}

		return pageVal;
	}

	/***
	 * 查询招标合同运单分页信息
	 *
	 * @param page
	 * @param orderinfo
	 * @param user
	 * @return
	 */
	public Page<Orderinfo> findBidOrderPage(Page<Orderinfo> page, Orderinfo orderinfo, User user) {
		/// 如果用户不为空,则查询用户列表信息
		Page<Orderinfo> pageVal = orderinfoService.findBidOrderPage(page, orderinfo);
		/// 如果是查询个人用户的运单信息则判断是否是买家
		for (Orderinfo var : pageVal.getList()) {
			if (user != null && !Tools.IsNullOrWhiteSpace(user.getId())) {
				/// 判断用户ID是否相等
				if (user.getId().equals(var.getBuyer().getId())) {
					var.setIsBuyer(true);
				} else {
					var.setIsBuyer(false);
				}
			}
			/// 查询货源信息
			if (var.getQuoteinfo() != null && var.getQuoteinfo().getGoods() != null) {
				var.getQuoteinfo().setGoods(goodsService.get(var.getQuoteinfo().getGoods().getId()));
			}
			/// 字符状态--运单状态转化为中文
			var.setStatusStr(DictUtils.getDictLabel(var.getOrderstatus(), "order_status", null));
		}

		return pageVal;
	}

	/***
	 * 运单取消功能
	 *
     * @param orderinfo orderId
	 * @param model
	 * @return
	 */
	@Transactional(readOnly = false)
	public int cancelOrderBiz(Orderinfo orderinfo, Model model) {
		lock4.lock();
		try {
			String message = "修改成功";//// 提示信息
			int result = DataDic.RETURN_STATUS_NORMAL;
			if (orderinfo == null) {
				model.addAttribute("message", "获取运单失败");
				/// 信息缺失
				return DataDic.RETURN_STATUS_INFOBUG;
			}
			/// 当前用户信息
			User curUser = UserUtils.getUser();
			/// 获取原运单信息
			orderinfo = orderinfoService.get(orderinfo.getId());
			/// 运单支付信息是否完整
			if (orderinfo == null || orderinfo.getQuoteinfo() == null || orderinfo.getBuyer() == null
					|| orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
				return DataDic.RETURN_STATUS_INFOBUG;
			} else if (curUser == null) {// 判断用户是否登录;未登录则权限不足
				return DataDic.RETURN_STATUS_AUTHBUG;
			}
			/// 获取报价信息
			Quoteinfo quoteinfo = quoteinfoService.get(orderinfo.getQuoteinfo().getId());

			if (quoteinfo == null || quoteinfo.getGoods() == null) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}
			//// 是否操作频繁
			// if (!consumeRecodBiz.IsCommitData(UserUtils.getUser().getId(),
//                    DataDic.CONSUMERECODE_TYPE_RETURNFORZEN, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
			// return DataDic.RETURN_STATUS_REMORE;
			// }
			//// 修改的报价信息
			Quoteinfo upQuote = new Quoteinfo();
			upQuote.setId(quoteinfo.getId());
			upQuote.preUpdate();
			/// 获取货源信息
			Goods goods = goodsService.get(quoteinfo.getGoods().getId());
			/// 货源来源
			String dataSouce = goods.getDatasource();
			Float residual = Float.parseFloat(goods.getResidualvolume());
			/// 实际配载吨位
			Float quoteWeight = Float.valueOf(quoteinfo.getActload());
			/// 运单取消货源 的剩余运量增加
			Float cur_resWeights = residual + quoteWeight;
			Double cur_resWeight = PreciseCompute.round(cur_resWeights, 4);
			//// 修改运单对象
			Orderinfo uporder = new Orderinfo();
			/// 设置主键
			uporder.setId(orderinfo.getId());

			/// 修改前的运单状态
			String orderStatus = orderinfo.getOrderstatus();
			// 修改前的支付状态
			String payStatus = orderinfo.getPaystatus();
			/// 如何接受运单--确认运单

			/// 判断运单修改前的状态
			if (!DataDic.ORDER_STATUS_NEW.equals(orderStatus)) {
				model.addAttribute("message", "操作失败");
				/// 如果运单的状态不为新运单,则确认运单操作失败
				return DataDic.RETURN_STATUS_AUTHBUG;
			} else {
				// 运单取消
				uporder.setOrderstatus(DataDic.ORDER_STATUS_CANCEL);
				/// 如果原先的运单状态为冻结状态,则需要冻结线上支付部分资金,支付状态改为取消冻结状态
				if (DataDic.ORDER_PAY_FORZEN.equals(payStatus)) {
					/// 运单修改为取消冻结
					uporder.setPaystatus(DataDic.ORDER_PAY_CANCELFORZEN);
				}
				uporder.preUpdate();
				/// 运单是线上支付状态,并且修改前的运单支付状态为预支付状态
				/// 新增消费记录并返款冻结资金卖家资金
				if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())
						&& DataDic.ORDER_PAY_FORZEN.equals(payStatus)) {
					result = consumeRecodBiz.orderRefundCodeBiz(orderinfo.getId());
					if (DataDic.RETURN_STATUS_NORMAL != result) {
						return result;
					}
					if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
						/// 退还卓币冻结运费
						result = consumeRecodBiz.orderRefundCoinCodeBiz(orderinfo.getId());
						if (DataDic.RETURN_STATUS_NORMAL != result) {
							return result;
						}
					}
                    tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_PAY, DataDic.ORDER_PAY_CANCELFORZEN, orderinfo);// 保存运单冻结记录
				}
				if (result == DataDic.RETURN_STATUS_NORMAL) {
					Goods upgoods = new Goods();
					upgoods.setId(goods.getId());
					upgoods.setResidualvolume(cur_resWeight.toString());
					// 运单取消,如果货源的交易状态报价完成,则修改状态为报价中
					if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())) {
						upgoods.setTradestatus(DataDic.GDS_QUOTING);
					}
					upgoods.preUpdate();
					/// 修改货源
					goodsService.save(upgoods);
					upQuote.setQuotestatus(DataDic.QUOTE_QUOTCALCEL);
					/// 修改报价信息为报价取消
					quoteinfoService.save(upQuote);
					/// 修改提货单运输状态为未发布状态
					if (DataDic.GDS_DATASORCE_NORMAL.equals(dataSouce)) {
						biddingBiz.updateTradeUnPubBiz(upQuote.getId());
					} else {
						biddingBiz.updateTradeUnTradeBiz(upQuote.getId());
					}
					uporder.setOrderstatus(DataDic.ORDER_STATUS_CANCEL);
					uporder.preUpdate();
					orderinfoService.save(uporder);
					/// 确认运单操作记录
                    tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, DataDic.ORDER_STATUS_CANCEL, orderinfo);
					/*
					 * String[]
					 * keyword={orderinfo.getOrderno(),orderinfo.getSeller().
					 * getLoginName()}; SmsUtil.sendSmsMesge(null,
					 * DataDic.SMSCODE_ORDERCANCEL,
					 * orderinfo.getSeller().getPhone(),
					 * Const.System_Module_Enum.LogisticsWebSystem,
					 * Const.SMSFUN_CONSUME, keyword, null, null, true);
					 */
					// 统计取消的单数
					UserStatistics statistics = new UserStatistics();
					statistics.setCanceltrade("1");
					UserUtils.userDataSourceCount(statistics);

					// 默認為發貨方
					String userid = orderinfo.getBuyer().getId();
					String phone = orderinfo.getBuyer().getPhone();
					// 判斷當前是哪方取消運單
					if (curUser.getId().equals(orderinfo.getBuyer().getId())) {
						userid = orderinfo.getSeller().getId();
						phone = orderinfo.getSeller().getPhone();
					}
					// 给货主发送短信并推送微信信息
					sendMesge(userid, DataDic.ORDER_STATUS_CANCEL, orderinfo, DataDic.SMSCODE_ORDERCANCEL, phone, true,
							Const.SMSFIRST[1], SmsConfig.smsOrderCancel);

				}
				model.addAttribute("message", Tools.statusMessage(result, "取消运单"));
			}

			return result;
		} finally {
			lock4.unlock();
		}
	}

	/***
	 * 运单取消功能
	 *
     * @param orderinfo orderId
	 * @param model
     * @param user 系统用户操作 
	 * @return
	 */
	@Transactional(readOnly = false)
	public int cancelTradeBiz(Orderinfo orderinfo, Model model, User user) {
		String message = "修改成功";//// 提示信息
		int result = DataDic.RETURN_STATUS_NORMAL;
		if (orderinfo == null) {
			model.addAttribute("message", "获取运单失败");
			/// 信息缺失
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		/// 当前用户信息
		User curUser = user;

		/// 获取原运单信息
		orderinfo = orderinfoService.get(orderinfo.getId());
		/// 运单支付信息是否完整
		if (orderinfo == null || orderinfo.getQuoteinfo() == null || orderinfo.getBuyer() == null
				|| orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
			return DataDic.RETURN_STATUS_INFOBUG;
		} else if (curUser == null) {// 判断用户是否
			return DataDic.RETURN_STATUS_AUTHBUG;
		}
		/// 获取报价信息
		Quoteinfo quoteinfo = quoteinfoService.get(orderinfo.getQuoteinfo().getId());

		if (quoteinfo == null || quoteinfo.getGoods() == null) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		//// 是否操作频繁
        if (!consumeRecodBiz.IsCommitData(UserUtils.getUser().getId(),
                DataDic.CONSUMERECODE_TYPE_RETURNFORZEN, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
			return DataDic.RETURN_STATUS_REMORE;
		}
		//// 修改的报价信息
		Quoteinfo upQuote = new Quoteinfo();
		upQuote.setId(quoteinfo.getId());
		upQuote.preUpdate();
		/// 获取货源信息
		Goods goods = goodsService.get(quoteinfo.getGoods().getId());
		/// 货源来源
		String dataSouce = goods.getDatasource();
		Float residual = Float.parseFloat(goods.getResidualvolume());
		/// 实际配载吨位
		Float quoteWeight = Float.valueOf(quoteinfo.getActload());
		/// 运单取消货源 的剩余运量增加
		Float cur_resWeights = residual + quoteWeight;
		Double cur_resWeight = PreciseCompute.round(cur_resWeights, 4);
		//// 修改运单对象
		Orderinfo uporder = new Orderinfo();
		/// 设置主键
		uporder.setId(orderinfo.getId());

		/// 修改前的运单状态
		String orderStatus = orderinfo.getOrderstatus();
		// 修改前的支付状态
		String payStatus = orderinfo.getPaystatus();
		/// 如何接受运单--确认运单

		/// 判断运单修改前的状态
		if (!DataDic.ORDER_STATUS_DISPUTE.equals(orderStatus)) {
			model.addAttribute("message", "操作失败");
			/// 如果运单的状态不为新运单,则确认运单操作失败
			return DataDic.RETURN_STATUS_AUTHBUG;
		} else {
			// 运单取消
			uporder.setOrderstatus(DataDic.ORDER_STATUS_CANCEL);
			/// 如果原先的运单状态为冻结状态,则需要冻结线上支付部分资金,支付状态改为取消冻结状态
			if (DataDic.ORDER_PAY_FORZEN.equals(payStatus)) {
				/// 运单修改为取消冻结
				uporder.setPaystatus(DataDic.ORDER_PAY_CANCELFORZEN);
			}
			uporder.preUpdate();
			/// 运单是线上支付状态,并且修改前的运单支付状态为预支付状态
			/// 新增消费记录并返款冻结资金卖家资金
            if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay()) && DataDic.ORDER_STATUS_DISPUTE.equals(orderinfo.getOrderstatus())) {
				result = consumeRecodBiz.orderRefundCodeBiz(orderinfo.getId());
				if (DataDic.RETURN_STATUS_NORMAL != result) {
					return result;
				}
				if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
					/// 退还卓币冻结运费
					result = consumeRecodBiz.orderRefundCoinCodeBiz(orderinfo.getId());
					if (DataDic.RETURN_STATUS_NORMAL != result) {
						return result;
					}
				}
				tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_PAY, DataDic.ORDER_PAY_CANCELFORZEN, orderinfo);// 保存运单冻结记录
			}
			if (result == DataDic.RETURN_STATUS_NORMAL) {
				Goods upgoods = new Goods();
				upgoods.setId(goods.getId());
				upgoods.setResidualvolume(cur_resWeight.toString());
				// 运单取消,如果货源的交易状态报价完成,则修改状态为报价中
				if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())) {
					upgoods.setTradestatus(DataDic.GDS_QUOTING);
				}
				upgoods.preUpdate();
				/// 修改货源
				goodsService.save(upgoods);
				upQuote.setQuotestatus(DataDic.QUOTE_QUOTCALCEL);
				/// 修改报价信息为报价取消
				quoteinfoService.save(upQuote);
				/// 修改提货单运输状态为未发布状态
				if (DataDic.GDS_DATASORCE_NORMAL.equals(dataSouce)) {
					biddingBiz.updateTradeUnPubBiz(upQuote.getId());
					BidBlinfo blinfo = new BidBlinfo();
					blinfo.setGoods(orderinfo.getQuoteinfo().getGoods());
					blinfo.setBiddingstatus(DataDic.BL_WAREHOUSE_STATUS_YRK);
					blinfoService.updateBiddingstatusByGoods(blinfo);// 更新提货单仓库状态
				} else {
					biddingBiz.updateTradeUnTradeBiz(upQuote.getId());
					BidBlinfo blinfo = new BidBlinfo();
					blinfo.setGoods(orderinfo.getQuoteinfo().getGoods());
					blinfo.setBiddingstatus(DataDic.BL_WAREHOUSE_STATUS_DCK);
					blinfoService.updateBiddingstatusByGoods(blinfo);// 更新提货单仓库状态
				}
				uporder.setOrderstatus(DataDic.ORDER_STATUS_CANCEL);
				uporder.preUpdate();
				orderinfoService.save(uporder);
				/// 确认运单操作记录
				tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, DataDic.ORDER_STATUS_CANCEL, orderinfo);
				/*
				 * String[]
				 * keyword={orderinfo.getOrderno(),orderinfo.getSeller().
				 * getLoginName()}; SmsUtil.sendSmsMesge(null,
				 * DataDic.SMSCODE_ORDERCANCEL,
				 * orderinfo.getSeller().getPhone(),
				 * Const.System_Module_Enum.LogisticsWebSystem,
				 * Const.SMSFUN_CONSUME, keyword, null, null, true);
				 */
				// 统计取消的单数
				UserStatistics statistics = new UserStatistics();
				statistics.setCanceltrade("1");
				UserUtils.userDataSourceCount(statistics);

				// 默認為發貨方
				String userid = orderinfo.getBuyer().getId();
				String phone = orderinfo.getBuyer().getPhone();
				// 判斷當前是哪方取消運單
				if (curUser.getId().equals(orderinfo.getBuyer().getId())) {
					userid = orderinfo.getSeller().getId();
					phone = orderinfo.getSeller().getPhone();
				}
				// 给货主发送短信并推送微信信息
				sendMesge(userid, DataDic.ORDER_STATUS_CANCEL, orderinfo, DataDic.SMSCODE_ORDERCANCEL, phone, true,
						Const.SMSFIRST[1], SmsConfig.smsOrderCancel);

			}

			model.addAttribute("message", Tools.statusMessage(result, "取消运单"));
		}

		return result;
	}

	/***
	 * 确认运单接口
	 *
     * @param orderinfo 运单ID
	 * @param model
	 * @return
	 */
	@Transactional(readOnly = false)
	public int confrimOrderBiz(Orderinfo orderinfo, Model model) {
		String message = "修改成功";//// 提示信息
		int result = DataDic.RETURN_STATUS_NORMAL;
		if (orderinfo == null) {
			model.addAttribute("message", "获取运单失败");
			/// 信息缺失
			return DataDic.RETURN_STATUS_INFOBUG;
		}

		/// 当前用户信息
		User curUser = UserUtils.getUser();
		Quoteinfo quo = orderinfo.getQuoteinfo();
		/// 获取原运单信息
		orderinfo = orderinfoService.get(orderinfo.getId());
		/// 运单支付信息是否完整
		if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null
				|| orderinfo.getPayinfo() == null) {
			return DataDic.RETURN_STATUS_INFOBUG;
		} else if (curUser == null) {// 判断用户是否登录;未登录则权限不足
			return DataDic.RETURN_STATUS_AUTHBUG;
		}

		/// 如果当前登录用户是否是运单的买方用户,只有运输方才能确认运单信息
		if (!curUser.getId().equals(orderinfo.getBuyer().getId())) {
			return DataDic.RETURN_STATUS_AUTHBUG;
		}

		// 修改车俩司机信息
		if (quo != null && DataDic.YES.equals(quo.getIschange())) {
			quo.setId(orderinfo.getQuoteinfo().getId());
			int state = goodsBiz.updateQuoteinfo(quo);
			if (state == DataDic.RETURN_STATUS_INFOBUG) {
				model.addAttribute("message", "车俩或司机信息为空");
				/// 信息缺失
				return DataDic.RETURN_STATUS_INFOBUG;
			}
		}
		//// 修改货源对象
		Orderinfo uporder = new Orderinfo();
		/// 设置主键
		uporder.setId(orderinfo.getId());

		/// 修改前的运单状态
		String orderStatus = orderinfo.getOrderstatus();
		// 修改前的支付状态
		String payStatus = orderinfo.getPaystatus();
		/// 如何接受运单--确认运单

		/// 判断运单修改前的状态
		if (!DataDic.ORDER_STATUS_NEW.equals(orderStatus)) {
			model.addAttribute("message", "操作失败");
			/// 如果运单的状态不为新运单,则确认运单操作失败
			return DataDic.RETURN_STATUS_AUTHBUG;
		} else {
			uporder.setOrderstatus(DataDic.ORDER_STATUS_SURE);

			uporder.preUpdate();
			orderinfoService.save(uporder);
			/// 确认运单操作记录
			tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, DataDic.ORDER_STATUS_SURE, orderinfo);


			// 统计交易接单数
			UserStatistics statistics = new UserStatistics();
			statistics.setTradeordercount("1");
			UserUtils.userDataSourceCount(statistics);

			// 发送信息
			// 给货主发送短信并推送微信信息
			sendMesge(orderinfo.getSeller().getId(), DataDic.ORDER_STATUS_SURE, orderinfo, DataDic.SMSCODE_NEWORDER,
					null, false, Const.SMSFIRST[1], SmsConfig.smsNewOrder);


			model.addAttribute("message", Tools.statusMessage(result, "确认运单"));
		}

		return result;
	}


	/***
	 * 创建订单信息--现用的
	 *
     * @param orderinfo 订单信息对象
	 * @return
	 */
	@Transactional(readOnly = false)
	public int createReLoadOrderBiz(Orderinfo orderinfo, Model model) {
		lock1.lock();
		try {
			Boolean isnomal = true;// 是否是普通发布货源
			Boolean iscp = true;/// 是否是成品
			int result = DataDic.RETURN_STATUS_NORMAL;
			if (orderinfo == null || orderinfo.getQuoteinfo() == null || orderinfo.getPayinfo() == null) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}
			Orderinfo vaidOrder = new Orderinfo();
			vaidOrder.setQuoteinfo(orderinfo.getQuoteinfo());
			//// 验证报价信息是否已经生产运单
			if (orderinfoService.getByOrderinfo(vaidOrder) != null) {
				return DataDic.RETURN_STATUS_OVERCONTROLBUG;
			}
			/// 配载吨位不可为空
			if (Tools.IsNullOrWhiteSpace(orderinfo.getQuoteinfo().getActload())) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}
			if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
				/// 如果是线上支付,则判断线上支付金额是否填写
				if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getOnlineamount())) {
					return DataDic.RETURN_STATUS_INFOBUG;
				}

			}
			/// 如果选择了线上预支付,则判断是否选择预支付比列
			if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprepay())) {
				if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getPreraio())) {
					return DataDic.RETURN_STATUS_INFOBUG;
				}
			}
			/// 判断是否卓币支付
			if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
				/// 如果是线上支付,则判断线上支付金额是否填写
				if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getCoinamount())) {
					return DataDic.RETURN_STATUS_INFOBUG;
				}
				/// 如果选择了卓币线上预支付,则判断是否选择预支付比列
				if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprecoin())) {
					if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getCoinprepaio())) {
						return DataDic.RETURN_STATUS_INFOBUG;
					}
				}
			}
			//// 是否操作频繁
			// if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
			// if (!consumeRecodBiz.IsCommitData(UserUtils.getUser().getId(),
//                        DataDic.CONSUMERECODE_TYPE_FORZENONLINE, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_ACCOUNT)) {
			// return DataDic.RETURN_STATUS_REMORE;
			// }
			// }else{
			// if (!consumeRecodBiz.IsCommitData(UserUtils.getUser().getId(),
//                        DataDic.CONSUMERECODE_TYPE_FORZENONLINE, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
			// return DataDic.RETURN_STATUS_REMORE;
			// }
			// }

			/// 设置主键
			// orderinfo.preInsert();
			/// 设置运单号
			orderinfo.setOrderno(OrderNumberUtil.getOrderNo(DataDic.MODEL_ORDERINFO));

			/// 判断运单的报价信息是否完整
			Quoteinfo quoteinfo = orderinfo.getQuoteinfo();
			//// 验证报价主键
			if (Tools.IsNullOrWhiteSpace(quoteinfo.getId())) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}

			// 报价ID
			String quote_id = quoteinfo.getId();
			/// 是否重新配载吨位
			String isreLoad = quoteinfo.getIsreload();
			/// 实际配载吨位
			Double actLoad = Double.parseDouble(quoteinfo.getActload());
			// 提货单列表
			List<BidBlinfo> blinfoList = quoteinfo.getBlinfoList();


			// 报价信息的修改对象
			Quoteinfo upQuote = new Quoteinfo();
			// 设置主键
			upQuote.setId(quoteinfo.getId());
			upQuote.preUpdate();
			//// 查询报价信息,是否存在
			quoteinfo = quoteinfoService.get(quoteinfo.getId());
			if (quoteinfo == null || Tools.IsNullOrWhiteSpace(quoteinfo.getOddloadweight())
					|| Tools.IsNullOrWhiteSpace(quoteinfo.getOoferprice()) || !quoteinfo.getQuotestatus().equals("1")) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}

			/// 获取当前报价中的货源信息
			Goods goods = goodsService.get(quoteinfo.getGoods().getId());
			if (goods == null || Tools.IsNullOrWhiteSpace(goods.getId())) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}
			/// 货源修改对象
			Goods upgoods = new Goods();
			String goods_Id = goods.getId();
			/// 货源来源
			String dataSource = goods.getDatasource();
			/// 报价吨位
			Double quoteWeight = Double.parseDouble(quoteinfo.getOddloadweight());
			/// 货物的剩余运输量
			Double residual = Double.parseDouble(goods.getResidualvolume());

			/// 实际配载吨位必须大于0小于货源剩余吨位
			if (actLoad < 0 || actLoad > residual) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}
			/// 如果是重新配载吨位
			if (DataDic.YES.equals(isreLoad)) {
				upgoods.setGsoddtype(DataDic.GDS_ODDTYPE_CP);// 只要上传货物明细，判定该货源为成品货源
				/// 如果是提货单货源,提货单的信息不可为空
                if (DataDic.GDS_DATASORCE_BLNOMAL.equals(dataSource) || DataDic.GDS_DATASORCE_BIDORDERBL.equals(dataSource)) {
					if (blinfoList == null || blinfoList.size() < 0) {
						return DataDic.RETURN_STATUS_INFOBUG;
					}
				}
			} else {
				BidBlinfo blinfo = new BidBlinfo();
				blinfo.setGoods(goods);
				blinfoList = blinfoService.findList(blinfo);
				/// 如果不重新配载：拉的就是报价吨位
				actLoad = quoteWeight;
			}

			Double price = Double.parseDouble(quoteinfo.getOoferprice());
			Double totalCost = PreciseCompute.round(PreciseCompute.mul(actLoad, price), 2);


			if (actLoad - residual > 0) {

				model.addAttribute("message", "报价吨位大于剩余吨位");
				return DataDic.RETURN_STATUS_INFOBUG;

			} else {

				/// 要修改货源的主键
				upgoods.setId(goods.getId());

				/// 货源的剩余运输量=原货源剩余吨位-当前报价吨位
				residual = residual - actLoad;
				if (residual == 0) {
					upgoods.setTradestatus(DataDic.GDS_FULLQUOTE);
				}
				residual = PreciseCompute.round(residual, 4);
				/// 剩余运输吨位
				upgoods.setResidualvolume(residual.toString());
			}

			/// 运单支付信息绑定
			TradePayinfo payinfo = new TradePayinfo();
			payinfo = orderinfo.getPayinfo();

			/// 是否线上支付
			if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
				// 线上支付首是账户余额支付
				// orderinfo.setPayway(DataDic.ORDER_PAYWAY_BALANCE);
				// 当前支付用户信息
				User curUser = UserUtils.findUser(goods.getUser());
				/// 当前用户的可用余额
				Double cur_Avaliable = curUser.getUserPurse().getAvailablebalance();

                if (!Tools.IsNullOrWhiteSpace(curUser.getMemberId()) && (DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway()) || DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))) {
					orderinfo.setIsLockWay(DataDic.YES);
					cur_Avaliable = accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE);
				}

				/// 当前卓币可用额度
				Double cur_AvaliCoin = curUser.getUserPurse().getAvailablecoin();
				/// 支付总金额
				orderinfo.setTotalcost(totalCost.toString());
				payinfo.setTotalcost(totalCost.toString());

				/// 线上支付金额
                Double onlineAmount = Double.parseDouble(orderinfo.getPayinfo().getOnlineamount() != null ? orderinfo.getPayinfo().getOnlineamount() : "0");
				onlineAmount = PreciseCompute.round(onlineAmount, 2);
				/// 线上支付卓币金额
                Double onlinCoin = Double.parseDouble(!Tools.IsNullOrWhiteSpace(payinfo.getCoinamount()) ? payinfo.getCoinamount() : "0");

				/// 线上支付比例order_onlineratio
				Double onlieratio = 1 - (totalCost - onlineAmount) / totalCost;
				onlieratio = PreciseCompute.round(onlieratio, 2);
				/// 线下支付金额
				Double lineAmount = totalCost - onlineAmount;
				lineAmount = PreciseCompute.round(lineAmount, 2);

				if (totalCost < onlineAmount) {
					model.addAttribute("message", "线上支付运费不可高于总运费");
					return DataDic.RETURN_STATUS_INFOBUG;
				} else if (cur_Avaliable < onlineAmount) {/// 线上支付金额是否满足支付
					model.addAttribute("message", "线上支付资金不足,请及时充值");
					return DataDic.RETURN_STATUS_MONEYBUG;
				} else if (onlineAmount < 0) {/// 线上支付金额是否满足支付
					model.addAttribute("message", "支付信息有误,请重新填写");
					return DataDic.RETURN_STATUS_MONEYBUG;
				}
				/// 是否支付卓币
				if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
					// 选择卓币支付则是卓币于与余额支付方式
					if (DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())) {
						orderinfo.setPayway(DataDic.ORDER_PAYWAY_ACCOUNTCOIN);
					} else {
						orderinfo.setPayway(DataDic.ORDER_PAYWAY_BALANCECOIN);
					}

					if (onlinCoin > lineAmount) {
						model.addAttribute("message", "卓币支付不能高于运费,请及时充值");
						return DataDic.RETURN_STATUS_MONEYBUG;
					}
					if (cur_AvaliCoin < onlinCoin) {
						model.addAttribute("message", "卓币余额不足,请及时充值");
						return DataDic.RETURN_STATUS_MONEYBUG;
					}
					if (onlinCoin < 0) {
						model.addAttribute("message", "支付信息有误,请重新填写");
						return DataDic.RETURN_STATUS_MONEYBUG;
					}
					lineAmount = lineAmount - onlinCoin;// 线下支付金额减去卓币部分
				}
				/// 是否预支付
				if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprepay())) {
					/// 预支付比列
					Double preratio = Double.parseDouble(orderinfo.getPayinfo().getPreraio());
					/// 预支付金额
					Double preAmount = onlineAmount * preratio;
					/// 线上支付余额
					Double onlinebalance = onlineAmount - preAmount;
					if (onlinebalance < 0) {
						model.addAttribute("message", "支付信息有误,请重新填写");
						return DataDic.RETURN_STATUS_MONEYBUG;
					}
					onlinebalance = PreciseCompute.round(onlinebalance, 2);
					payinfo.setOnlinebalance(onlinebalance.toString());
					payinfo.setPreraio(preratio.toString());
					payinfo.setPreamount(preAmount.toString());
					/// 线上实际支付余额应为线上支付余额,如果发起争议则:线上运费余额-争议金额
					payinfo.setActualamount(onlinebalance.toString());

				} else {
					/// 否预支付
					// 预支付金额
					payinfo.setPreamount("0");
					/// 线上余下支付金额
					payinfo.setOnlinebalance(onlineAmount.toString());
					payinfo.setPreraio("0");/// y预支付比例
					/// 实际支付金额
					payinfo.setActualamount(onlineAmount.toString());
				}
				/// 是否卓币预支付
				if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprecoin())) {
					/// 预支付比列
                    Double precoinratio = Double.parseDouble(orderinfo.getPayinfo().getCoinprepaio() != null ? orderinfo.getPayinfo().getCoinprepaio() : "0");
					/// 预支付卓币
					Double preCoin = PreciseCompute.round(onlinCoin * precoinratio, 2);
					/// 线上支付余额
					Double onlineactue = onlinCoin - preCoin;
					if (onlineactue < 0) {
						model.addAttribute("message", "支付信息有误,请重新填写");
						return DataDic.RETURN_STATUS_MONEYBUG;
					}
					onlineactue = PreciseCompute.round(onlineactue, 2);
					payinfo.setPreraio(precoinratio.toString());
					payinfo.setCoinpreamount(preCoin.toString());
					/// 线上实际支付卓币应为线上支付余额
					payinfo.setCoinactualpay(onlineactue.toString());
					orderinfo.setIsprecoin(DataDic.ORDER_PREPAY);

				} else {
					/// 否预支付
					// 预支付金额
					payinfo.setCoinpreamount("0");
					/// 线上余下支付金额
					payinfo.setCoinactualpay(onlinCoin.toString());
					payinfo.setCoinprepaio("0");/// y预支付比例
					/// 实际支付金额
				}

				// 支付信息
				payinfo.setOnlineamount(onlineAmount.toString());
				payinfo.setLineamount(lineAmount.toString());
				payinfo.setOnlineratio(onlieratio.toString());
				/// 线上支付就得冻结运费
				orderinfo.setPaystatus(DataDic.ORDER_PAY_FORZEN);
			} else {
				// 线下支付:线上支付未0元,线下支付为总运费
				orderinfo.setTotalcost(totalCost.toString());
				payinfo.setOnlineamount("0");
				payinfo.setTotalcost(totalCost.toString());
				payinfo.setLineamount(totalCost.toString());
				orderinfo.setPaystatus(DataDic.ORDER_PAY_UNPAY);
			}

			/// 报价用户是买家角色
			orderinfo.setBuyer(quoteinfo.getUser());

			/// 报价中的货源信息中的用户ID是卖家--供货方
			orderinfo.setSeller(goods.getUser());

			orderinfo.setIsNewRecord(true);
			orderinfo.setId(IdGen.uuid());
			payinfo.setIsNewRecord(true);
			payinfo.setId(IdGen.uuid());
			// payinfo.preInsert();
			payinfo.setOrderinfo(orderinfo);
			orderinfo.setPayinfo(payinfo);

			Orderinfo vaid = new Orderinfo();
			vaid.setQuoteinfo(orderinfo.getQuoteinfo());
			//// 验证报价信息是否已经生产运单
			if (orderinfoService.getByOrderinfo(vaid) != null) {
				return DataDic.RETURN_STATUS_OVERCONTROLBUG;
			}
			Orderinfo neworder = orderinfoService.get(orderinfo.getId());
			if (neworder != null) {
				return DataDic.RETURN_STATUS_REMORE;
			}
			/// 如果是线上支付则冻结账户资金
			if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
				/// 冻结线上运费
				result = consumeRecodBiz.orderOnlineFreezeRecodeBiz(orderinfo);
				if (DataDic.RETURN_STATUS_NORMAL != result) {
					return result;
				}
				if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
					/// 如果线上支付卓币,则冻结卓币
					result = consumeRecodBiz.orderCoinFreezeRecodeBiz(orderinfo);
					if (DataDic.RETURN_STATUS_NORMAL != result) {
						return result;
					}
				}

			}
			/// 如果冻结成功
			if (result == DataDic.RETURN_STATUS_NORMAL) {
				// 货主购买保险
                if (DataDic.YES.equals(goods.getIsinsur()) && !DataDic.INSUR_PAYPEOPLE_CAROWNER.equals(goods.getPaypeople())) {
					double money = 40;
					User user = UserUtils.getUser();
					UserInsurance userInsurance = new UserInsurance();
					userInsurance.setOrderno(orderinfo.getOrderno());
					userInsurance.setStatus("1");
					String uuid = IdGen.uuid();
					userInsurance.setId(uuid);
					userInsurance.setUser(user);
					userInsurance.setIsNewRecord(true);
					userInsurance.setInsurancefeel(String.valueOf(money));
					userInsuranceService.save(userInsurance);
					String paytype = DataDic.CONSUMERECODE_WAY_BALANCE;
					// if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())){
					// paytype = DataDic.CONSUMERECODE_WAY_ACCOUNT;
					// }

					consumeRecodBiz.tradeBuyInsurBiz(uuid, user.getId(), money, paytype);// 以支付
					orderinfo.setInsurispay(DataDic.INSUR_PAY);
					orderinfo.setInsurstatus("1");
				}


				orderinfoService.save(orderinfo);
				payinfoService.save(payinfo);
				/// 修改货源剩余吨位
				upgoods.preUpdate();
				/// 如果运输完成了,其他的用户报价信息修改为报价失败
				if (DataDic.GDS_FULLQUOTE.equals(upgoods.getTradestatus())) {
					quoteinfoService.updateQuoteFiled(upgoods.getId());
				}
				goodsService.save(upgoods);
				// 当前的报价信息报价成功
				upQuote.setQuotestatus(DataDic.QUOTE_SUCCESS);
				upQuote.setIsreload(isreLoad);
				upQuote.setActload(actLoad.toString());
				quoteinfoService.save(upQuote);
				/// 如果是招标合同的提货单货源
				if (DataDic.GDS_DATASORCE_BIDORDERBL.equals(dataSource)) {
					isnomal = false;
				}
                if (DataDic.GDS_DATASORCE_NORMAL.equals(dataSource) || DataDic.GDS_DATASORCE_BIDORDERBL.equals(dataSource)
						|| DataDic.GDS_DATASORCE_BLNOMAL.equals(dataSource)) {
					if (blinfoList.size() > 0) {
						goodsBiz.saveQuoteBlinfoBIz(blinfoList, goods_Id, goods.getFreightunit(), quote_id, isnomal);
					}
				}
				/// 保存运单记录
				tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, DataDic.ORDER_STATUS_NEW, orderinfo);
				// 保存运单支付记录
				tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_PAY, DataDic.ORDER_PAY_FORZEN, orderinfo);// 保存运单冻结记录


				try {
                    QRCodeUtils.encode("http://" + Global.LINK_WEB + "/wx/weixin/trade/trade_details?id=" + orderinfo.getId(), orderinfo.getOrderno(), Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + "/code/getheadimg.jpeg", Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + "/code", true);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			String address = goods.getShipAddress().getAddress() + "-" + goods.getConsignAddress().getAddress(); // 地址
			String[] keyword = { Const.SMSFIRST[0], orderinfo.getOrderno(), address, goods.getGoodsname(),
					goods.getYmdDate(), Const.REMARK[0] };
			User buyer = UserUtils.getUserById(orderinfo.getBuyer().getId());// 获取用户信息
			// 给车主发送短信并推送微信信息
			SmsUtil.sendSmsMesge(buyer.getUserinfo().getOpenid(), DataDic.SMSCODE_NEWORDER, buyer.getPhone(),
                    Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, ConstantWeChat.NEW_ORDER,
                    null, true, SmsConfig.smsNewOrder);

			messagePush(goods, orderinfo);// 极光推送

			return DataDic.RETURN_STATUS_NORMAL;
		} finally {
			lock1.unlock();
		}
	}


	/***
	 * 创建订单信息
	 *
     * @param orderinfo 订单信息对象
	 * @return
	 */
	@Transactional(readOnly = false)
	public int createOrderBiz(Orderinfo orderinfo, Model model) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		if (orderinfo == null || orderinfo.getQuoteinfo() == null || orderinfo.getPayinfo() == null) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		Orderinfo vaidOrder = new Orderinfo();
		vaidOrder.setQuoteinfo(orderinfo.getQuoteinfo());
		//// 验证报价信息是否已存在
		if (orderinfoService.getByOrderinfo(vaidOrder) != null) {
			return DataDic.RETURN_STATUS_OVERCONTROLBUG;
		}
		if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
			/// 如果是线上支付,则判断线上支付金额是否填写
			if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getOnlineamount())) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}

		}
		/// 如果选择了线上预支付,则判断是否选择预支付比列
		if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprepay())) {
			if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getPreraio())) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}
		}
		/// 判断是否卓币支付
		if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
			/// 如果是线上支付,则判断线上支付金额是否填写
			if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getCoinamount())) {
				return DataDic.RETURN_STATUS_INFOBUG;
			}
			/// 如果选择了卓币线上预支付,则判断是否选择预支付比列
			if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprecoin())) {
				if (Tools.IsNullOrWhiteSpace(orderinfo.getPayinfo().getCoinprepaio())) {
					return DataDic.RETURN_STATUS_INFOBUG;
				}
			}
		}
		//// 是否操作频繁
        if (!consumeRecodBiz.IsCommitData(UserUtils.getUser().getId(),
                DataDic.CONSUMERECODE_TYPE_FORZENONLINE, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
			return DataDic.RETURN_STATUS_REMORE;
		}
		/// 设置主键
		// orderinfo.preInsert();
		/// 设置运单号
		orderinfo.setOrderno(OrderNumberUtil.getOrderNo(DataDic.MODEL_ORDERINFO));

		/// 判断运单的报价信息是否完整
		Quoteinfo quoteinfo = orderinfo.getQuoteinfo();
		// 报价信息的修改对象
		Quoteinfo upQuote = new Quoteinfo();
		// 设置主键
		upQuote.setId(quoteinfo.getId());
		upQuote.preUpdate();
		if (Tools.IsNullOrWhiteSpace(quoteinfo.getId())) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		//// 查询报价信息,是否存在
		quoteinfo = quoteinfoService.get(quoteinfo.getId());
		if (quoteinfo == null || Tools.IsNullOrWhiteSpace(quoteinfo.getOddloadweight())
				|| Tools.IsNullOrWhiteSpace(quoteinfo.getOoferprice()) || !quoteinfo.getQuotestatus().equals("1")) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}

		/// 获取当前报价中的货源信息
		Goods goods = goodsService.get(quoteinfo.getGoods().getId());
		/// 货源修改对象
		Goods upgoods = new Goods();

		if (goods == null) {
			return DataDic.RETURN_STATUS_INFOBUG;

		}
		/// 运费计算
		Double weight = Double.parseDouble(quoteinfo.getOddloadweight());
		Double price = Double.parseDouble(quoteinfo.getOoferprice());
		Double totalCost = Double.parseDouble(Tools.toTwoDecimal(weight * price));
		/// 货物的剩余运输量
		Double residual = Double.parseDouble(goods.getResidualvolume());

		if (weight - residual > 0) {

			model.addAttribute("message", "报价吨位大于剩余吨位");
			return DataDic.RETURN_STATUS_INFOBUG;

		} else {
			/// 要修改货源的主键
			upgoods.setId(goods.getId());

			/// 货源的剩余运输量=原货源剩余吨位-当前报价吨位
			residual = residual - weight;
			if (residual == 0) {
				upgoods.setTradestatus(DataDic.GDS_FULLQUOTE);
			}
			residual = PreciseCompute.round(residual, 4);
			/// 剩余运输吨位
			upgoods.setResidualvolume(residual.toString());
		}

		/// 运单支付信息绑定
		TradePayinfo payinfo = new TradePayinfo();
		payinfo = orderinfo.getPayinfo();

		/// 是否线上支付
		if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
			// 线上支付首是账户余额支付
			orderinfo.setPayway(DataDic.ORDER_PAYWAY_BALANCE);
			// 当前支付用户信息
			User curUser = UserUtils.findUser(goods.getUser());
			/// 当前用户的可用余额
			Double cur_Avaliable = curUser.getUserPurse().getAvailablebalance();

            if (!Tools.IsNullOrWhiteSpace(curUser.getMemberId()) && (DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway()) || DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))) {
				cur_Avaliable = accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE);
			}

			/// 当前卓币可用额度
			Double cur_AvaliCoin = curUser.getUserPurse().getAvailablecoin();
			/// 支付总金额
			orderinfo.setTotalcost(totalCost.toString());
			payinfo.setTotalcost(totalCost.toString());

			/// 线上支付金额
            Double onlineAmount = Double.parseDouble(orderinfo.getPayinfo().getOnlineamount() != null ? orderinfo.getPayinfo().getOnlineamount() : "0");
			onlineAmount = PreciseCompute.round(onlineAmount, 2);
			/// 线上支付卓币金额
            Double onlinCoin = Double.parseDouble(!Tools.IsNullOrWhiteSpace(payinfo.getCoinamount()) ? payinfo.getCoinamount() : "0");

			/// 线上支付比例order_onlineratio
			Double onlieratio = 1 - (totalCost - onlineAmount) / totalCost;
			onlieratio = PreciseCompute.round(onlieratio, 2);
			/// 线下支付金额
			Double lineAmount = totalCost - onlineAmount;
			lineAmount = PreciseCompute.round(lineAmount, 2);

			if (totalCost < onlineAmount) {
				model.addAttribute("message", "线上支付运费不可高于总运费");
				return DataDic.RETURN_STATUS_INFOBUG;
			} else if (cur_Avaliable < onlineAmount) {/// 线上支付金额是否满足支付
				model.addAttribute("message", "线上支付资金不足,请及时充值");
				return DataDic.RETURN_STATUS_MONEYBUG;
			} else if (onlineAmount < 0) {/// 线上支付金额是否满足支付
				model.addAttribute("message", "支付信息有误,请重新填写");
				return DataDic.RETURN_STATUS_MONEYBUG;
			}
			/// 是否支付卓币
			if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
				// 选择卓币支付则是卓币于与余额支付方式
				orderinfo.setPayway(DataDic.ORDER_PAYWAY_BALANCECOIN);
				if (onlinCoin > lineAmount) {
					model.addAttribute("message", "卓币支付不能高于运费,请及时充值");
					return DataDic.RETURN_STATUS_MONEYBUG;
				}
				if (cur_AvaliCoin < onlinCoin) {
					model.addAttribute("message", "卓币余额不足,请及时充值");
					return DataDic.RETURN_STATUS_MONEYBUG;
				}
				if (onlinCoin < 0) {
					model.addAttribute("message", "支付信息有误,请重新填写");
					return DataDic.RETURN_STATUS_MONEYBUG;
				}
				lineAmount = lineAmount - onlinCoin;// 线下支付金额减去卓币部分
			}
			/// 是否预支付
			if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprepay())) {
				/// 预支付比列
				Double preratio = Double.parseDouble(orderinfo.getPayinfo().getPreraio());
				/// 预支付金额
				Double preAmount = onlineAmount * preratio;
				/// 线上支付余额
				Double onlinebalance = onlineAmount - preAmount;
				if (onlinebalance < 0) {
					model.addAttribute("message", "支付信息有误,请重新填写");
					return DataDic.RETURN_STATUS_MONEYBUG;
				}
				onlinebalance = PreciseCompute.round(onlinebalance, 2);
				payinfo.setOnlinebalance(onlinebalance.toString());
				payinfo.setPreraio(preratio.toString());
				payinfo.setPreamount(preAmount.toString());
				/// 线上实际支付余额应为线上支付余额,如果发起争议则:线上运费余额-争议金额
				payinfo.setActualamount(onlinebalance.toString());

			} else {
				/// 否预支付
				// 预支付金额
				payinfo.setPreamount("0");
				/// 线上余下支付金额
				payinfo.setOnlinebalance(onlineAmount.toString());
				payinfo.setPreraio("0");/// y预支付比例
				/// 实际支付金额
				payinfo.setActualamount(onlineAmount.toString());
			}
			/// 是否卓币预支付
			if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprecoin())) {
				/// 预支付比列
                Double precoinratio = Double.parseDouble(orderinfo.getPayinfo().getCoinprepaio() != null ? orderinfo.getPayinfo().getCoinprepaio() : "0");
				/// 预支付卓币
				Double preCoin = PreciseCompute.round(onlinCoin * precoinratio, 2);
				/// 线上支付余额
				Double onlineactue = onlinCoin - preCoin;
				if (onlineactue < 0) {
					model.addAttribute("message", "支付信息有误,请重新填写");
					return DataDic.RETURN_STATUS_MONEYBUG;
				}
				onlineactue = PreciseCompute.round(onlineactue, 2);
				payinfo.setPreraio(precoinratio.toString());
				payinfo.setCoinpreamount(preCoin.toString());
				/// 线上实际支付卓币应为线上支付余额
				payinfo.setCoinactualpay(onlineactue.toString());
				orderinfo.setIsprecoin(DataDic.ORDER_PREPAY);

			} else {
				/// 否预支付
				// 预支付金额
				payinfo.setCoinpreamount("0");
				/// 线上卓币支付金额
				payinfo.setCoinactualpay(onlinCoin.toString());
				payinfo.setCoinprepaio("0");/// y预支付比例
				/// 实际支付金额
			}

			// 支付信息
			payinfo.setOnlineamount(onlineAmount.toString());
			payinfo.setLineamount(lineAmount.toString());
			payinfo.setOnlineratio(onlieratio.toString());
			/// 线上支付就得冻结运费
			orderinfo.setPaystatus(DataDic.ORDER_PAY_FORZEN);
		} else {
			// 线下支付:线上支付未0元,线下支付为总运费
			orderinfo.setTotalcost(totalCost.toString());
			payinfo.setOnlineamount("0");
			payinfo.setTotalcost(totalCost.toString());
			payinfo.setLineamount(totalCost.toString());
			orderinfo.setPaystatus(DataDic.ORDER_PAY_UNPAY);
		}

		/// 报价用户是买家角色
		orderinfo.setBuyer(quoteinfo.getUser());

		/// 报价中的货源信息中的用户ID是卖家--供货方
		orderinfo.setSeller(goods.getUser());

		orderinfo.setIsNewRecord(true);
		orderinfo.setId(IdGen.uuid());
		payinfo.setIsNewRecord(true);
		payinfo.setId(IdGen.uuid());
		// payinfo.preInsert();
		payinfo.setOrderinfo(orderinfo);
		orderinfo.setPayinfo(payinfo);
		/// 如果是线上支付则冻结账户资金
		if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
			/// 冻结线上运费
			result = consumeRecodBiz.orderOnlineFreezeRecodeBiz(orderinfo);
			if (DataDic.RETURN_STATUS_NORMAL != result) {
				return result;
			}
			if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
				/// 如果线上支付卓币,则冻结卓币
				result = consumeRecodBiz.orderCoinFreezeRecodeBiz(orderinfo);
				if (DataDic.RETURN_STATUS_NORMAL != result) {
					return result;
				}
			}

		}
		/// 如果冻结成功
		if (result == DataDic.RETURN_STATUS_NORMAL) {
			orderinfoService.save(orderinfo);
			payinfoService.save(payinfo);
			/// 修改货源剩余吨位
			upgoods.preUpdate();
			/// 如果运输完成了,其他的用户报价信息修改为报价失败
			if (DataDic.GDS_FULLQUOTE.equals(upgoods.getTradestatus())) {
				quoteinfoService.updateQuoteFiled(upgoods.getId());
			}
			goodsService.save(upgoods);
			// 当前的报价信息报价成功
			upQuote.setQuotestatus(DataDic.QUOTE_SUCCESS);
			quoteinfoService.save(upQuote);
			/// 保存运单记录
			tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, DataDic.ORDER_STATUS_NEW, orderinfo);
			// 保存运单支付记录
			tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_PAY, DataDic.ORDER_PAY_FORZEN, orderinfo);// 保存运单冻结记录


			try {
                QRCodeUtils.encode("http://" + Global.LINK_WEB + "/wx/weixin/trade/trade_details?id=" + orderinfo.getId(), orderinfo.getOrderno(), Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + "/code/getheadimg.jpeg", Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + "/code", true);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		String address = goods.getShipAddress().getAddress() + "-" + goods.getConsignAddress().getAddress(); // 地址
		String[] keyword = { Const.SMSFIRST[0], orderinfo.getOrderno(), address, goods.getGoodsname(),
				goods.getYmdDate(), Const.REMARK[0] };
		User buyer = UserUtils.getUserById(orderinfo.getBuyer().getId());// 获取用户信息
		// 给车主发送短信并推送微信信息
		SmsUtil.sendSmsMesge(buyer.getUserinfo().getOpenid(), DataDic.SMSCODE_NEWORDER, buyer.getPhone(),
				Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, ConstantWeChat.NEW_ORDER,
				null, true, SmsConfig.smsNewOrder);

		return DataDic.RETURN_STATUS_NORMAL;
	}

	/**
	 * 获取个人的运单信息
	 *
	 * @param page
	 * @param orderinfo
	 * @return
	 */
	public Page<Orderinfo> getOrderList(Page<Orderinfo> page, Orderinfo orderinfo) {
		if (orderinfo == null) {
			return page;
		}
		orderinfo.setSeller(UserUtils.getUser());
		List<Orderinfo> list = orderinfoService.findList(orderinfo);
		for (Orderinfo od : list) {
			/// 获取报价信息
			Quoteinfo quoteinfo = quoteinfoService.get(od.getQuoteinfo().getId());
			/// 获取货源信息
			Goods goods = goodsService.get(quoteinfo.getGoods().getId());
			/// 赋值报价信息
			od.setQuoteinfo(quoteinfo);
			od.getQuoteinfo().setGoods(goods);
			/// 获取买卖双方的信息
			od.setBuyer(systemService.getUser(od.getBuyer().getId()));
			od.setSeller(systemService.getUser(od.getSeller().getId()));
			/// 获取支付信息
			od.setPayinfo(payinfoService.get(od.getPayinfo().getId()));
		}
		page.setList(list);
		return page;
	}

	/**
	 * 运单上传提货凭据
	 *
     * @param orderId       订单id
     * @param photos        照片
     * @param oddLoadWeight 实际吨数
	 * @return
	 */
	@Transactional(readOnly = false)
	public int saveTradeTakeGoods(String orderId, String photos, String oddLoadWeight) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		int upcount = 0;
		int state = 1;
		lock2.lock();
		try {
			Orderinfo orderinfo = new Orderinfo();
			// 获取运单信息
			orderinfo = orderinfoService.get(orderId);
			TradeReceipt tradeReceipt = new TradeReceipt();
			if (orderinfo == null) {
				state = DataDic.RETURN_STATUS_INFOBUG;
			}
			// 上传图片的信息是否存在
			if (photos == null) {
				state = DataDic.RETURN_STATUS_INFOBUG;
			}
			/// 获取当前用户信息
			User curUser = UserUtils.getUser();
			if (curUser == null || !curUser.getId().equals(orderinfo.getBuyer().getId())) {
				state = DataDic.RETURN_STATUS_AUTHBUG;
			}
			/// 修改前的运单信息,运单是否司机已确认
			if (!orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_SURE)
					&& !orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_TAKEGOODS)) {
				state = DataDic.RETURN_STATUS_AUTHBUG;
			}
			tradeReceipt.setOrderinfo(orderinfo);
			tradeReceipt.setType(DataDic.TRADERECEIPT_TYPE_TAKEGOODS);
			tradeReceipt = tradeReceiptService.getByorderidAndtype(tradeReceipt);// 获取凭据信息
			if (tradeReceipt != null) {
				upcount = Integer.parseInt(tradeReceipt.getUpdatecount());
				if (upcount <= 0) {
					state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
				}
			}
			//// 是否操作频繁
			// if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
			// if (!consumeRecodBiz.IsCommitData(curUser.getId(),
//                        DataDic.CONSUMERECODE_TYPE_PAYPREMONEY, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_ACCOUNT)) {
			// state=DataDic.RETURN_STATUS_REMORE;
			// }
			// }else{
			// if (!consumeRecodBiz.IsCommitData(curUser.getId(),
//                        DataDic.CONSUMERECODE_TYPE_PAYPREMONEY, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
			// state=DataDic.RETURN_STATUS_REMORE;
			// }
			// }

			if (state == 1) {
				/// 如果提货单为保存,则新增一条记录
				if (tradeReceipt == null) {
					tradeReceipt = new TradeReceipt();
					tradeReceipt.setOrderinfo(orderinfo);
					tradeReceipt.setReceiptimg(photos);
					tradeReceipt.setType(DataDic.TRADERECEIPT_TYPE_TAKEGOODS);
					tradeReceipt.setOddloadweight(oddLoadWeight);
					tradeReceipt.setUpdatecount("4");
				} else {
					tradeReceipt.preUpdate();
					upcount = upcount - 1;
					tradeReceipt.setReceiptimg(photos);
					tradeReceipt.setUpdatecount(upcount + "");
					tradeReceipt.setOddloadweight(oddLoadWeight);
				}

				tradeReceiptService.save(tradeReceipt);
				// 提货凭据
				orderinfo.setOrderstatus(DataDic.ORDER_STATUS_TAKEGOODS);
				/// 如果运单的支付状态为冻结状态,并且运单可以预支付
				if (DataDic.ORDER_PAY_FORZEN.equals(orderinfo.getPaystatus())
						&& DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
					if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprepay())) {
						result = consumeRecodBiz.orderPrePayRecodeBiz(orderinfo);
						/// 如果保存信息失败
						if (DataDic.RETURN_STATUS_NORMAL != result && DataDic.RETURN_STATUS_PAYBUG != result) {
							return result;
						}
					}

					//// 预付卓币
					if (DataDic.ORDER_PREPAY.equals(orderinfo.getIsprecoin())) {
						result = consumeRecodBiz.orderPrePayCoinRecodeBiz(orderinfo);
						if (DataDic.RETURN_STATUS_NORMAL != result) {
							return result;
						}
					}
					/// 预支付成功
					orderinfo.setPaystatus(DataDic.ORDER_PAY_PAYPREMONEY);
					tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_PAY, DataDic.ORDER_PAY_PAYPREMONEY, orderinfo);// 保存运单支付记录
				}
				orderinfo.preUpdate();
				if (DataDic.YES.equals(orderinfo.getIslocated())) {
					orderinfo.setLocationstate(Integer.parseInt(DataDic.LBS_STATUS_BEING));
				}
				orderinfoService.save(orderinfo);// 更新运单状态信息
				BidBlinfo blinfo = new BidBlinfo();
				blinfo.setGoods(orderinfo.getQuoteinfo().getGoods());
				blinfo.setBiddingstatus(DataDic.BL_WAREHOUSE_STATUS_YCK);
				blinfo.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_YCK);
				blinfo.setBiddingOutboundDate(new Date());
				blinfoService.updateBiddingstatusByGoods(blinfo);// 更新提货单仓库状态和出库时间

				try {
					if (DataDic.YES.equals(orderinfo.getIslocated())) {
						updateJobList(orderinfo, true);// 添加或启动
					}

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, DataDic.ORDER_STATUS_TAKEGOODS, orderinfo);// 保存运单操作记录

				// 给货主发送短信并推送微信信息
				sendMesge(orderinfo.getSeller().getId(), DataDic.ORDER_STATUS_TAKEGOODS, orderinfo,
						DataDic.SMSCODE_NEWORDER, null, false, Const.SMSFIRST[1], SmsConfig.smsNewOrder);
			} else {
				return result;
			}

			return result;
		} finally {
			lock2.unlock();
		}

	}

	/**
	 * 运单上传回单
	 *
     * @param orderId       订单id
     * @param photos        照片
     * @param oddLoadWeight 实际吨数
	 * @return
	 */
	@Transactional(readOnly = false)
	public int saveTradeReceipt(String orderId, String photos, String oddLoadWeight) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		int state = 1;
		int upcount = 0;
		Orderinfo orderinfo = new Orderinfo();

		// 获取运单信息
		orderinfo = orderinfoService.get(orderId);
		TradeReceipt tradeReceipt = new TradeReceipt();
		if (orderinfo == null) {
			state = DataDic.RETURN_STATUS_INFOBUG;
		}
		// 上传图片的信息是否存在
		if (photos == null) {
			state = DataDic.RETURN_STATUS_INFOBUG;
		}
		/// 获取当前用户信息
		User curUser = UserUtils.getUser();
		if (curUser == null || !curUser.getId().equals(orderinfo.getBuyer().getId())) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
		}
		/// 修改前的运单信息,运单是否已提货 或者已回单
		if (!orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_RECEIPT)
				&& !orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_TAKEGOODS)) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
		}
		tradeReceipt.setOrderinfo(orderinfo);
		tradeReceipt.setType(DataDic.TRADERECEIPT_TYPE_RECEIPT);
		tradeReceipt = tradeReceiptService.getByorderidAndtype(tradeReceipt);// 获取凭据信息
		if (tradeReceipt != null) {
			upcount = Integer.parseInt(tradeReceipt.getUpdatecount());
			if (upcount <= 0) {
				state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
			}
		}
		if (state == 1) {
			/// 如果提货单为保存,则新增一条记录
			if (tradeReceipt == null) {
				tradeReceipt = new TradeReceipt();
				tradeReceipt.setOrderinfo(orderinfo);
				tradeReceipt.setReceiptimg(photos);
				tradeReceipt.setType(DataDic.TRADERECEIPT_TYPE_RECEIPT);
				tradeReceipt.setOddloadweight(oddLoadWeight);
				tradeReceipt.setUpdatecount("4");
			} else {
				tradeReceipt.preUpdate();
				upcount = upcount - 1;
				tradeReceipt.setReceiptimg(photos);
				tradeReceipt.setUpdatecount(upcount + "");
				tradeReceipt.setOddloadweight(oddLoadWeight);
			}
			// 保存回单信息
			tradeReceiptService.save(tradeReceipt);
			if (DataDic.YES.equals(orderinfo.getIslocated())) {
				orderinfo.setLocationstate(Integer.parseInt(DataDic.LBS_STATUS_END));
			}
			// 回单凭据
			orderinfo.setOrderstatus(DataDic.ORDER_STATUS_RECEIPT);
			orderinfo.preUpdate();
			orderinfoService.save(orderinfo);// 更新运单状态信息
			tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, orderinfo.getOrderstatus(), orderinfo);// 保存运单操作记录
			/*
			 * String[] keyword={orderinfo.getBuyer().getLoginName(),orderinfo.
			 * getQuoteinfo().getGoods().getGoodsname()};
			 * 
			 * SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_DELIVERGOODS,
			 * orderinfo.getBuyer().getPhone(),
			 * Const.System_Module_Enum.LogisticsWebSystem,
			 * Const.SMSFUN_CONSUME, keyword, null, null, true);
			 */

			try {
				if (DataDic.YES.equals(orderinfo.getIslocated())) {
					updateJobList(orderinfo, false);// 删除定位
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// 给货主发送短信并推送微信信息
			sendMesge(orderinfo.getSeller().getId(), DataDic.ORDER_STATUS_RECEIPT, orderinfo,
                    DataDic.SMSCODE_DELIVERGOODS, orderinfo.getBuyer().getPhone(), true, Const.SMSFIRST[1], SmsConfig.smsGoodsEnd);
		} else {
			return result;
		}
		return result;
	}

	/**
	 * 运单发起争议
	 *
     * @param orderId        运单ID
     * @param goodsName      货物名称
     * @param takeLoadWeight 提货吨数
     * @param upLoadWeight   卸货吨数
     * @param disputeInfo    争议说明
     * @param disputetype    争议类型
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object saveUserDispute(String orderId, String goodsName, String takeLoadWeight, String upLoadWeight,
			String disputeInfo, String disputemoney, String disputetype) {

		String message = "保存成功";
		int state = DataDic.RETURN_STATUS_NORMAL;
		Orderinfo orderinfo = new Orderinfo();
		UserDispute userDispute = new UserDispute();
		if (orderId == null) {
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "信息缺失";
		} else {
			orderinfo = orderinfoService.get(orderId);// 获取订单信息
			if (orderinfo == null) {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "运单不存在";
			}
			if ((!orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_RECEIPT))
					&& (!orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_DISPUTE))) {// 判断是否已上传回单状态
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "运单未上传回单";
			}
			// 如果是全额争议
			if (DataDic.DISPUTE_TYPE_FULL.equals(disputetype)) {
				// 运单如果为线下支付或运单预付运单-将不给予全额争议处理
                if (DataDic.ORDER_LINEPAY.equals(orderinfo.getIsonlinepay()) || DataDic.ORDER_PREPAY.equals(orderinfo.getIsprepay()) ||
                        DataDic.ORDER_PREPAY.equals(orderinfo.getIsprecoin())) {
					state = DataDic.RETURN_STATUS_SYSBUG;
					message = "该运单不支持全额退款";
				}
			}
		}

		if (state == DataDic.RETURN_STATUS_NORMAL) {
			userDispute = userDisputeService.getByUserDispute(orderId);// 争议信息是否存在
			if (userDispute == null) {
				userDispute = new UserDispute();
				userDispute.setOrderinfo(orderinfo);
				userDispute.setOrderno(orderinfo.getOrderno());
				userDispute.setDisputemoneybefore(orderinfo.getPayinfo().getActualamount());// 争议前运单金额
				userDispute.setStatus(DataDic.DISPUTE_STATUS_CREATE);// 争议处理状态
				userDispute.setGoodsname(goodsName);// 货物名称
				userDispute.setTakeloadweight(takeLoadWeight);// 提货吨数
				userDispute.setUnloadweight(upLoadWeight);// 卸货吨数
				userDispute.setDisputeinfo(disputeInfo);// 争议说明
				userDispute.setDisputemoney(disputemoney);// 争议金额
				userDispute.setDisputetype(disputetype);// 争议类型
				userDisputeService.save(userDispute);// 保存争议

				orderinfo.preUpdate();
				orderinfo.setOrderstatus(DataDic.ORDER_STATUS_DISPUTE);// 发起争议
				orderinfo.setIsdispute(DataDic.ORDER_ISDISPUTE_TRUE);// 是否争议 是
				orderinfoService.save(orderinfo);// 更新运单状态信息
				tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, orderinfo.getOrderstatus(), orderinfo);// 保存运单操作记录

				TradePayinfo upinfo = new TradePayinfo();
				upinfo.setId(orderinfo.getPayinfo().getId());
				upinfo.setDisputeamount(disputemoney);
				payinfoService.save(upinfo);// 保存运单支付信息的争议金额
				/*
				 * //发送通知 String[] keyword={orderinfo.getOrderno(),
				 * Global.LINK_WEB}; SmsUtil.sendSmsMesge(null,
				 * DataDic.SMSCODE_DISPUTE, orderinfo.getBuyer().getPhone(),
				 * Const.System_Module_Enum.LogisticsWebSystem,
				 * Const.SMSFUN_CONSUME, keyword, null, null, true);
				 */
				// 给货主发送短信并推送微信信息
				sendMesge(orderinfo.getSeller().getId(), DataDic.ORDER_STATUS_DISPUTE, orderinfo,
                        DataDic.SMSCODE_DISPUTE, orderinfo.getBuyer().getPhone(), true, Const.SMSFIRST[1], SmsConfig.smsDispute);

			} else {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "该运单已发起争议";
			}
		}
		return Tools.getMapResult(state, message, null);
	}

	/**
	 * 运单确认完成状态
	 *
     * @param orderid 运单号
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object saveOrderEnd(String orderid, User user) {
		lock3.lock();
		try {
			Orderinfo ss = orderinfoService.get(orderid);
			if (ss.getOrderstatus().equals(DataDic.ORDER_STATUS_PAY)) {
				return Tools.getMapResult(3, Tools.statusMessage(3, "确认运输完成"), null);
			}
			int state = 1;
			int back = 1;
			String message = "运输完成";
			boolean isdisput = false; /// 是否发起争议
			Orderinfo orderinfo = new Orderinfo();
			if (Tools.IsNullOrWhiteSpace(orderid)) {
				state = DataDic.RETURN_STATUS_INFOBUG;
				message = "信息缺失";
			} else {
				orderinfo = getDetail(orderid, user);
				if (orderinfo == null) {
					state = DataDic.RETURN_STATUS_INFOBUG;
					message = "信息缺失";
				} else if (!user.getId().equals(orderinfo.getSeller().getId())) {/// 只有卖家才能确认运输完成
					state = DataDic.RETURN_STATUS_AUTHBUG;

				} else if (DataDic.ORDER_ISDISPUTE_TRUE.equals(orderinfo.getIsdispute())
						&& orderinfo.getUserDispute() != null) {//// 判断运单是否发起争议
                    if (!(DataDic.DISPUTE_STATUS_END.equals(orderinfo.getUserDispute().getStatus()) || DataDic.DISPUTE_STATUS_QUIDCO.equals(orderinfo.getUserDispute().getStatus()))) {/// 判断争议状态
						state = DataDic.RETURN_STATUS_INFOBUG;
					} else {
						isdisput = true;
					}
				}
			}
			// if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
			// if (!consumeRecodBiz.IsCommitData(user.getId(),
//                        DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_ACCOUNT)) {
			// state=DataDic.RETURN_STATUS_REMORE;
			// message="操作频繁，请稍后再试";
			// }
			// }else{
			// if (!consumeRecodBiz.IsCommitData(user.getId(),
//                        DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY, DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
			// state=DataDic.RETURN_STATUS_REMORE;
			// message="操作频繁，请稍后再试";
			// }
			// }

			if (state == 1) {
				if ((orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_RECEIPT)
						|| orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_DISPUTE)
						|| orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_DISPUTE_END))) {// 已上传回单
					// 或者发起争议状态
					orderinfo.preUpdate();
					//// 是否是线上支付
					if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
						if (isdisput) {//// 如果发起争议
							back = consumeRecodBiz.orderDisputePayRecodeBiz(orderid);
						} else {
							back = consumeRecodBiz.orderBalancePayRecodeBiz(orderinfo);/// 支付余款运费
						}

						// 如果是账户体系的虚拟账号到银行卡，则需要后台审核，金额才能到账
						// if(DataDic.RETURN_STATUS_OREDERAPPLYPAY==back){
						// back= DataDic.RETURN_STATUS_NORMAL;
						// orderinfo.setOrderispay(DataDic.ORDER_APPLY_UNPAY);//设置支付状态为未支付
						// }
						if (back == DataDic.RETURN_STATUS_NORMAL) {

							/// 交易卓币运费支付
							if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
								consumeRecodBiz.orderCoinPayRecodeBiz(orderinfo);
							}
							if (orderinfo.getPayinfo() != null) {
								double actualamount = Double.parseDouble(orderinfo.getPayinfo().getActualamount());
								if (actualamount >= 100) {//线上业务结算（线上交易金额每高于1000元）
                                    integrityBiz.updateIntegrityPoint(user.getUserinfo(), DataDic.INTEGRITY_POINT_SETTLEMONE, user.getRole().getEnname());//更新诚信积分
								}
							}

							orderinfo.setPaystatus(DataDic.ORDER_PAY_BANANCE);
						}
					}
					/// 平台服务支付信息
					Double locMoney = 0.00;/// 定位服务费用
					Double trailMoney = 0.00;/// 轨迹回放轨迹回放价格
					Double railMoney = 0.00;/// 电子围栏服务费用
					String serStr = "开通";
					int locCount = orderinfo.getLocCount();/// 定位次数
					int trailCount = orderinfo.getTrailCount();/// 轨迹回放次数
					/*if (DataDic.YES.equals(orderinfo.getLocationFlag())) {
						serStr += "定位服务";
						if (trailCount != 0) {
							serStr += "、轨迹订阅";
						}
                        Double locPrice = Double.parseDouble(DictUtils.getMsgLabel(DataDic.ZJXL_LASTlOCATION, "zjxl_port", "") != null ? DictUtils.getMsgLabel(DataDic.ZJXL_LASTlOCATION, "zjxl_port", "") : "0");
                        Double trailPrice = Double.parseDouble(DictUtils.getMsgLabel(DataDic.ZJXL_HISTRACK, "zjxl_port", "") != null ? DictUtils.getMsgLabel(DataDic.ZJXL_HISTRACK, "zjxl_port", "") : "0");
						locMoney = PreciseCompute.mul(locCount, locPrice);
						trailMoney = PreciseCompute.mul(trailCount, trailPrice);
					}*/
					if (DataDic.YES.equals(orderinfo.getRailFlag())) {
						serStr += "、电子围栏";
                        Double railPrice = Double.parseDouble(DictUtils.getMsgLabel(DataDic.ZJXL_AREAREG, "zjxl_port", "") != null ? DictUtils.getMsgLabel(DataDic.ZJXL_AREAREG, "zjxl_port", "") : "0");
						railMoney = railPrice;
					}
                    if (DataDic.YES.equals(orderinfo.getLocationFlag()) || DataDic.YES.equals(orderinfo.getRailFlag())) {
						serStr += "服务";
						Double serviceMoney = PreciseCompute.round(locMoney + trailMoney + railMoney, 2);
						if (serviceMoney > 0) {
                            back = consumeRecodBiz.payGPSLocationBiz(orderinfo.getSeller().getId(), serviceMoney, serStr);
						}
					}
					if (back != 1) {
						if (back == 8) {
							message = "提现金额大于单笔交易最高限额";
						} else if (back == 10) {
							message = "电子钱包最低留存额度不足";
						} else if (back == 11) {
							message = "提现金额大于单日交易最高限额";
						} else if (back == 12) {
							message = "提现金额大于单日累计提现限额";
						} else if (back == -1) {
							message = "账户系统异常";
						} else if (back == 0) {
							message = "权限不足";
						} else if (back == 2) {
							message = "信息缺失";
						} else if (back == DataDic.RETURN_STATUS_BANKBUG) {
							message = "银行卡信息错误，请收款方核对默认银行卡信息";
						} else if (back == DataDic.RETURN_STATUS_SIGNOUT) {
							message = "应用正在日结中，等银行结算完毕再开放使用，结算时间为1-2小时";
						} else if (back == DataDic.RETURN_STATUS_PAYBUG) {
							orderinfo.setOrderispay(DataDic.ORDER_APPLY_PAYIN);
							orderinfoService.save(orderinfo);// 更新运单状态信息
						}
						return Tools.getMapResult(state, Tools.statusMessage(back, "确认运输完成"), null);
					}


					orderinfo.setOrderstatus(DataDic.ORDER_STATUS_PAY);
					orderinfo.setPayDate(new Date());// 支付时间
					orderinfoService.save(orderinfo);// 更新运单状态信息
					/// 保存支付运费记录
					tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_PAY, DataDic.ORDER_PAY_BANANCE, orderinfo);
					tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, orderinfo.getOrderstatus(), orderinfo);// 保存运单操作记录
					String[] keyword = { orderinfo.getPayinfo().getActualamount()};
					SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_GETFREIGHT, orderinfo.getBuyer().getPhone(),
                            Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsGetFreight);
					// 统计交易成功单数
					UserStatistics statistics = new UserStatistics();
					statistics.setSuccesstrade("1");
					UserUtils.userDataSourceCount(statistics);
					Car car = orderinfo.getQuoteinfo().getCar();
					carService.updateTradeNum(car);
					// 给货主发送短信并推送微信信息
					sendMesge(orderinfo.getSeller().getId(), DataDic.ORDER_PAY_BANANCE, orderinfo,
                            DataDic.SMSCODE_DELIVERGOODS, orderinfo.getBuyer().getPhone(), true, Const.SMSFIRST[1], SmsConfig.smsGoodsEnd);
				}
			}
			return Tools.getMapResult(state, Tools.statusMessage(state, "确认运输完成"), null);
		} finally {
			lock3.unlock();
		}

	}


	/**
	 * 运单完成--轮询修改状态
	 *
	 * @param bscJobAccount
	 * @return
	 */
	@Transactional(readOnly = false)
	public int saveOrderinfoEnd(BscJobAccount bscJobAccount, int type) {
		int back = 1;
		if (Tools.IsNullOrWhiteSpace(bscJobAccount.getTargetid())) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		Orderinfo orderinfo = new Orderinfo();
		orderinfo.setOrderno(bscJobAccount.getTargetid());
		orderinfo = orderinfoService.getByOrderinfo(orderinfo);
		if (orderinfo == null) {
			return DataDic.RETURN_STATUS_INFOBUG;
		} else if (DataDic.ORDER_STATUS_PAY.equals(orderinfo.getOrderstatus())) {
			return DataDic.RETURN_STATUS_NORMAL;// 已经是支付的状态
		}
		// 处理支付失败
		if (type == -1) {
			/// 获取支付信息
			TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
			// 支付失败重新冻结
			AccountUtils accountUtils = new AccountUtils();
			String tradeSettlementId = accountUtils.getTradeSettlementId();
			if (DataDic.YES.equals(orderinfo.getIsLockWay())) {
                back = accountBiz.lockAccount(orderinfo.getSeller(), payinfo.getOnlineamount(), DataDic.TRANSFER_LOCK, tradeSettlementId);
			} else {
                back = accountBiz.freezeAccount(orderinfo.getSeller(), payinfo.getOnlineamount(), DataDic.TRANSFER_FREEZE, tradeSettlementId);
			}

			if (back != DataDic.RETURN_STATUS_NORMAL) {
				return back;
			}
			orderinfo.setOrderispay(DataDic.ORDER_APPLY_PAY);
			orderinfoService.save(orderinfo);// 更新运单状态信息
			return DataDic.RETURN_STATUS_NORMAL;

		}
		// 处理支付成功
        if (DataDic.ORDER_ISDISPUTE_TRUE.equals(orderinfo.getIsdispute())
                && orderinfo.getUserDispute() != null) {//// 如果发起争议
			back = consumeRecodBiz.orderDisputePayConsumeRecod(orderinfo.getId());
		} else {
			back = consumeRecodBiz.orderPayConsumeRecode(orderinfo);/// 支付余款运费

		}
		if (back == 1) {
			/// 交易卓币运费支付
			if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIspaycoin())) {
				consumeRecodBiz.orderCoinPayRecodeBiz(orderinfo);
			}

			orderinfo.setPaystatus(DataDic.ORDER_PAY_BANANCE);
			orderinfo.preUpdate();
			orderinfo.setOrderstatus(DataDic.ORDER_STATUS_PAY);
			orderinfo.setPayDate(new Date());// 支付时间
			orderinfo.setOrderispay(DataDic.ORDER_APPLY_PAY);
			orderinfoService.save(orderinfo);// 更新运单状态信息
			/// 保存支付运费记录
			tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_PAY, DataDic.ORDER_PAY_BANANCE, orderinfo);
			tradeTraceService.saveTrace(DataDic.ORDER_TRACE_TYPE_STATUS, orderinfo.getOrderstatus(), orderinfo);// 保存运单操作记录
			String[] keyword = { orderinfo.getPayinfo().getActualamount()};
			SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_GETFREIGHT, orderinfo.getBuyer().getPhone(),
                    Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsGetFreight);
			// 统计交易成功单数
			UserStatistics statistics = new UserStatistics();
			statistics.setUser(orderinfo.getSeller());
			statistics.setSuccesstrade("1");
			UserUtils.userDataSourceCount(statistics);
			Car car = orderinfo.getQuoteinfo().getCar();
			carService.updateTradeNum(car);
			// 给货主发送短信并推送微信信息
            sendMesge(orderinfo.getSeller().getId(), DataDic.ORDER_PAY_BANANCE, orderinfo,
                    DataDic.SMSCODE_DELIVERGOODS, orderinfo.getSeller().getPhone(), true, Const.SMSFIRST[1], SmsConfig.smsGoodsEnd);
			return DataDic.RETURN_STATUS_NORMAL;
		} else {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
	}

	/**
	 * 运单支付审核
	 *
     * @param orderid 运单号
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> orderPayApply(String orderid) {
		lock6.lock();
		try {
			int state = DataDic.RETURN_STATUS_NORMAL;
			int back = DataDic.RETURN_STATUS_NORMAL;
			String message = "放款成功";
			Orderinfo orderinfo = new Orderinfo();
			if (Tools.IsNullOrWhiteSpace(orderid)) {
				state = DataDic.RETURN_STATUS_INFOBUG;
				message = "信息缺失";
			} else {
				orderinfo = getOrder(orderid);
				if (orderinfo == null) {
					state = DataDic.RETURN_STATUS_INFOBUG;
					message = "信息缺失";
				}
			}
			if (state == 1) {
				if (orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_PAY)
						&& DataDic.ORDER_APPLY_UNPAY.equals(orderinfo.getOrderispay())) {// 运单状态为已支付并且运单审核支付状态为未支付
					// 或者发起争议状态
					orderinfo.preUpdate();
					//// 是否是线上支付
					if (DataDic.ORDER_ONLINEPAY.equals(orderinfo.getIsonlinepay())) {
						/// 获取支付信息
						TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
						if (payinfo == null) {
							state = DataDic.RETURN_STATUS_INFOBUG;
							message = "信息缺失";
						}
						// 线上支付实际余款金额
						AccountUtils accountUtils = new AccountUtils();
						String tradeSettlementId = accountUtils.getTradeSettlementId();
                        Double actualAmount = Double.parseDouble(payinfo.getActualamount() != null ? payinfo.getActualamount() : "0");
                        back = accountBiz.freezeBalanceTransfer(orderinfo.getSeller(), orderinfo.getBuyer(), actualAmount.toString(), DataDic.TRANSFER_OUTER_BANK, orderinfo.getOrderno(), DataDic.CONSUMERECODE_MODEL_TRADEORDER, tradeSettlementId, orderinfo.getIsLockWay());

						orderinfo.setOrderispay(DataDic.ORDER_APPLY_PAY);// 设置支付状态为已支付
					}
					if (back != 1) {
						if (back == 8) {
							message = "提现金额大于单笔交易最高限额";
						} else if (back == 10) {
							message = "电子钱包最低留存额度不足";
						} else if (back == 11) {
							message = "提现金额大于单日交易最高限额";
						} else if (back == 12) {
							message = "提现金额大于单日累计提现限额";
						} else if (back == -1) {
							message = "账户系统异常";
						} else if (back == 0) {
							message = "权限不足";
						} else if (back == 2) {
							message = "信息缺失";
						} else if (back == DataDic.RETURN_STATUS_BANKBUG) {
							message = "银行卡信息错误，请收款方核对默认银行卡信息";
						} else if (back == DataDic.RETURN_STATUS_SIGNOUT) {
							message = "应用正在日结中，等银行结算完毕再开放使用，结算时间为1-2小时";
						} else if (back == DataDic.RETURN_STATUS_PAYBUG) {
							orderinfo.setOrderispay(DataDic.ORDER_APPLY_PAYIN);
							orderinfoService.save(orderinfo);// 更新运单状态信息
						}
						return Tools.getMapResult(state, message, null);
					}
					orderinfoService.save(orderinfo);// 更新运单状态信息

				}
			}
			return Tools.getMapResult(state, message, null);
		} finally {
			lock6.unlock();
		}

	}


	/**
	 * 获取运单提货单 回单信息
	 *
	 * @param orderId
	 * @param type
	 * @return
	 */
	public TradeReceipt getTradeReceiptBiz(String orderId, String type) {
		TradeReceipt tradeReceipt = new TradeReceipt();
		Orderinfo orderinfo = new Orderinfo();
		orderinfo.setId(orderId);
		tradeReceipt.setOrderinfo(orderinfo);
		tradeReceipt.setType(type);
		tradeReceipt = tradeReceiptService.getByorderidAndtype(tradeReceipt);
		return tradeReceipt;
	}

	/**
	 * 司机是否同意争议
	 *
	 * @param disputeId
     * @param isReject  0同意 1驳回
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean confirmUserdispute(String disputeId, String isReject) {
		Boolean result = false;
		int state = 1;
		UserDispute userDispute = new UserDispute();
		if (disputeId == null) {
			state = 0;
		}
		if (state == 1) {
			userDispute = userDisputeService.get(disputeId);
			if (userDispute != null && userDispute.getDisputeeverconfirmed().equals(DataDic.DISPUTE_CONFIRMFALSE)) {// 争议存在并且还没有同意
				UserDispute newDispute = new UserDispute();
				if (isReject.equals(DataDic.DISPUTE_ISREJECT_FALSE)) {// 同意争议
					newDispute.setDisputeeverconfirmed(DataDic.DISPUTE_CONFIRMTRUE);
					//// 获取争议订单信息
					String order_id = userDispute.getOrderinfo().getId();
					if (!Tools.IsNullOrWhiteSpace(order_id)) {
						//// 获取运单信息获取支付信息
						Orderinfo orderinfo = orderinfoService.get(order_id);
						/// 争议后的运单实际支付金额减少
                        Double disputMoney = Double.parseDouble(orderinfo.getPayinfo().getDisputeamount() != null ? orderinfo.getPayinfo().getDisputeamount() : "0");
                        Double actAmount = Double.parseDouble(orderinfo.getPayinfo().getActualamount() != null ? orderinfo.getPayinfo().getActualamount() : "0");
						TradePayinfo upinfo = new TradePayinfo();
						upinfo.setId(orderinfo.getPayinfo().getId());
						actAmount = actAmount - disputMoney;
						upinfo.setActualamount(actAmount.toString());
						payinfoService.save(upinfo);
						newDispute.setDisputemoneydiff(actAmount.toString());// 争议后实际支付
					}
				} else if (isReject.equals(DataDic.DISPUTE_ISREJECT_TRUE)) {// 驳回争议
					newDispute.setIsreject(DataDic.DISPUTE_ISREJECT_TRUE);
				}
				newDispute.setId(userDispute.getId());
				userDisputeService.save(newDispute);
				result = true;
			}
		}
		return result;
	}

	/**
	 * 后台争议审核
	 *
	 * @param userDispute
	 * @param model
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> editUserdispute(UserDispute userDispute, Model model) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "争议处理成功!";
		Orderinfo orderinfo = new Orderinfo();
		TradePayinfo tradePayinfo = new TradePayinfo();
		User user = UserUtils.findUser(UserUtils.getUser());
		UserDispute dispute = userDisputeService.get(userDispute.getId());
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
				userDisputeService.save(userDispute);
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
					orderinfo = get(userDispute.getOrderinfo().getId());
				}
				if (orderinfo == null) {
					state = DataDic.RETURN_STATUS_AUTHBUG;
					message = "运单信息异常";
				} else {
					tradePayinfo = tradePayinfoService.getByorderId(orderinfo.getId());
				}

				if (tradePayinfo == null) {
					state = DataDic.RETURN_STATUS_AUTHBUG;
					message = "运单支付信息异常";
				}
				if (DataDic.DISPUTE_CONFIRMFALSE.equals(dispute.getDisputeeverconfirmed())) {
					state = DataDic.RETURN_STATUS_AUTHBUG;
					message = "争议必须司机同意";
				}
				if (state == DataDic.RETURN_STATUS_NORMAL) {
					// 如果是全额争议--把运单改完取消状态
					if (DataDic.DISPUTE_TYPE_FULL.equals(userDispute.getDisputetype())) {
						cancelTradeBiz(orderinfo, model, orderinfo.getBuyer());
						userDispute.setDealuser(user);
						userDispute.setDisputemoneydiff("0");// 处理后的实际支付金额
						userDisputeService.save(userDispute);

					} else {// 普通争议

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
							userDisputeService.save(userDispute);

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
		}
		return Tools.getMapResult(state, message, null);
	}


	/**
	 * 发送短信
	 *
     * @param userid    用户id
     * @param status    状态
     * @param orderinfo 运单
     * @param code      短信模板
     * @param phone     电话号码
     * @param falg      是否发短信
     * @param first     短信模板第一个参数
	 */
	public void sendMesge(String userid, String status, Orderinfo orderinfo, String code, String phone, boolean falg,
			String first, String aliSmsCode) {
		// 查询报价信息,是否存在
		Quoteinfo quoteinfo = quoteinfoService.get(orderinfo.getQuoteinfo().getId());
		// 获取当前报价中的货源信息
		Goods goods = goodsService.get(quoteinfo.getGoods().getId());
		String addressStart = goods.getShipAddress().getAddress(); // 起点
		String addressEnd = goods.getConsignAddress().getAddress(); /// 终点
		String orderstatus = DictUtils.getDictLabel(status, "order_status", null);
		String[] keyword = { Const.SMSFIRST[1], orderinfo.getOrderno(), DateUtil.getDay(), orderstatus, addressStart,
				addressEnd, Const.REMARK[0] };
		User us = UserUtils.getUserById(userid);// 获取用户信息
		// 给货主发送短信并推送微信信息
		SmsUtil.sendSmsMesge(us.getUserinfo().getOpenid(), code, phone, Const.System_Module_Enum.LogisticsWebSystem,
				Const.SMSFUN_CONSUME, keyword, ConstantWeChat.ORDER_STATUS, null, falg, aliSmsCode);

	}

	public List<Orderinfo> findList(Orderinfo orderinfo) {
		return orderinfoService.findList(orderinfo);
	}

	public Page<Orderinfo> findPage(Page<Orderinfo> page, Orderinfo orderinfo) {

		return orderinfoService.findPage(page, orderinfo);
	}

	@Transactional(readOnly = false)
	public void save(Orderinfo orderinfo) {
		orderinfoService.save(orderinfo);
	}

	@Transactional(readOnly = false)
	public void delete(Orderinfo orderinfo) {
		orderinfoService.delete(orderinfo);
	}

	/**
	 * 根据条件统计运单信息 全部
	 *
	 * @param orderinfo
	 * @return
	 */
	public Orderinfo sumOrderinfo(Orderinfo orderinfo) {
		return orderinfoService.sumOrderinfo(orderinfo);
	}

	/**
	 * 根据条件统计运单信息 买家的
	 *
	 * @param orderinfo
	 * @return
	 */
	public Orderinfo sumBuyOrderinfo(Orderinfo orderinfo) {
		orderinfo.setBuyer(UserUtils.getUser());
		return orderinfoService.sumOrderinfo(orderinfo);
	}

	/**
	 * 根据条件统计运单信息 卖家的
	 *
	 * @param orderinfo
	 * @return
	 */
	public Orderinfo sumSellOrderinfo(Orderinfo orderinfo) {
		orderinfo.setSeller(UserUtils.getUser());
		return orderinfoService.sumOrderinfo(orderinfo);
	}

	/**
	 * 运单统计--增量
	 *
     * @param orderParameter 1新运单 2运输中 3待支付 4已支付
     * @param userType       true卖家数据--企业 false买家数据 --车主
	 * @return 增量的数据
	 */
	public Orderinfo sumOrderinfo(String orderParameter, Boolean userType) {
		Orderinfo orderinfo = new Orderinfo();// 今天之前
		Orderinfo nowOrderinfo = new Orderinfo();// 所有
		Orderinfo returnOrderinfo = new Orderinfo();// 返回的

		if (orderParameter.equals(DataDic.ORDER_SUM_NEW)) {// 新运单
			orderParameter = DataDic.ORDER_SUM_NEW;
		} else if (orderParameter.equals(DataDic.ORDER_SUM_INTRANSIT)) {// 运输中
			orderParameter = DataDic.ORDER_SUM_INTRANSIT;
		} else if (orderParameter.equals(DataDic.ORDER_SUM_NOPAYMENT)) {// 待支付
			orderParameter = DataDic.ORDER_SUM_NOPAYMENT;
		} else if (orderParameter.equals(DataDic.ORDER_SUM_END)) {// 已支付
			orderParameter = DataDic.ORDER_SUM_END;
		} else {

		}
		// 今天0点之前运单类型参数
		orderinfo.setEndCreateDate(DateUtil.getCurrentDayTimeDate());// 获取今天0点时间
		orderinfo.setSumsearch(orderParameter);
		// 所有运单类型参数
		nowOrderinfo.setSumsearch(orderParameter);
		if (userType) {
			// 卖家数据--企业
			orderinfo = sumSellOrderinfo(orderinfo);// 今天0点之前的运单数据
			nowOrderinfo = sumSellOrderinfo(nowOrderinfo);// 所有运单数据
		} else {
			// 买家数据--车主
			orderinfo = sumBuyOrderinfo(orderinfo);// 今天0点之前的运单数据
			nowOrderinfo = sumBuyOrderinfo(nowOrderinfo);// 所有运单数据
		}

		if (orderinfo != null && nowOrderinfo != null) {
			String Sumorder = orderinfo.getSumorder();// 运单数
			String Sumoddloadweight = orderinfo.getSumoddloadweight();// 吨数
			String Sumtotalcost = orderinfo.getSumtotalcost();// 运费
			BigDecimal douSumorder = new BigDecimal(Sumorder != null ? Sumorder : "0");
			BigDecimal douSumoddloadweight = new BigDecimal(Sumoddloadweight != null ? Sumoddloadweight :

					"0");
			BigDecimal douSumtotalcost = new BigDecimal(Sumtotalcost != null ? Sumtotalcost : "0");

			String nowSumorder = nowOrderinfo.getSumorder();// 运单数
			String nowSumoddloadweight = nowOrderinfo.getSumoddloadweight();// 吨数
			String nowSumtotalcost = nowOrderinfo.getSumtotalcost();// 运费
			BigDecimal douNowSumorder = new BigDecimal(nowSumorder != null ? nowSumorder : "0");
			BigDecimal douNowSumoddloadweight = new BigDecimal(nowSumoddloadweight != null ?

					nowSumoddloadweight : "0");
			BigDecimal douNowSumtotalcost = new BigDecimal(nowSumtotalcost != null ? nowSumtotalcost : "0");
			// 现在的减去今天之前的数据 得到增量
			returnOrderinfo.setSumorder((douNowSumorder.subtract(douSumorder)).toString());
			returnOrderinfo.setSumoddloadweight((douNowSumoddloadweight.subtract

			(douSumoddloadweight)).toString());
			returnOrderinfo.setSumtotalcost((douNowSumtotalcost.subtract(douSumtotalcost)).toString());
		}
		return returnOrderinfo;
	}

	/**
	 * orderinfo的数据相加
	 *
	 * @param orderinfo
	 * @param nowOrderinfo
	 * @return
	 */
	public Orderinfo addOrderinfo(Orderinfo orderinfo, Orderinfo nowOrderinfo) {
		Orderinfo returnOrderinfo = new Orderinfo();// 返回的

		String Sumorder = orderinfo.getSumorder();// 运单数
		String Sumoddloadweight = orderinfo.getSumoddloadweight();// 吨数
		String Sumtotalcost = orderinfo.getSumtotalcost();// 运费
		BigDecimal douSumorder = new BigDecimal(Sumorder != null ? Sumorder : "0");
		BigDecimal douSumoddloadweight = new BigDecimal(Sumoddloadweight != null ? Sumoddloadweight : "0");
		BigDecimal douSumtotalcost = new BigDecimal(Sumtotalcost != null ? Sumtotalcost : "0");

		String nowSumorder = nowOrderinfo.getSumorder();// 运单数
		String nowSumoddloadweight = nowOrderinfo.getSumoddloadweight();// 吨数
		String nowSumtotalcost = nowOrderinfo.getSumtotalcost();// 运费
		BigDecimal douNowSumorder = new BigDecimal(nowSumorder != null ? nowSumorder : "0");
		BigDecimal douNowSumoddloadweight = new BigDecimal(nowSumoddloadweight != null ?

				nowSumoddloadweight : "0");
		BigDecimal douNowSumtotalcost = new BigDecimal(nowSumtotalcost != null ? nowSumtotalcost : "0");
		// 传入的对象的数据相加
		returnOrderinfo.setSumorder((douNowSumorder.add(douSumorder)).toString());
		returnOrderinfo.setSumoddloadweight((douNowSumoddloadweight.add(douSumoddloadweight)).toString());
		returnOrderinfo.setSumtotalcost((douNowSumtotalcost.add(douSumtotalcost)).toString());

		return returnOrderinfo;
	}

	/**
	 * 运单统计数据
	 *
     * @param orderParameter 1新运单 2运输中 3待支付 4已支付
     * @param buyOrSell      true卖家数据--企业 false买家数据 --车主
	 * @return
	 */
	public Orderinfo getSumOrderinfoByRoleType(String orderParameter, Boolean buyOrSell) {
		Orderinfo orderinfo = new Orderinfo();
		if (orderParameter.equals(DataDic.ORDER_SUM_INTRANSIT)) {// -----运输中数据

			orderinfo = sumOrderinfo(DataDic.ORDER_SUM_INTRANSIT, buyOrSell);// 运输中增量

			Orderinfo orderinfoNopayment = new Orderinfo();// 待支付对象
			Orderinfo orderinfoEnd = new Orderinfo();// 已完成对象

			orderinfoNopayment = sumOrderinfo(DataDic.ORDER_SUM_NOPAYMENT, buyOrSell);// 待支付增量
			orderinfoEnd = sumOrderinfo(DataDic.ORDER_SUM_END, buyOrSell);// 已完成增量

			orderinfoNopayment = addOrderinfo(orderinfoNopayment, orderinfoEnd);// 先获取待支付数据
			// =待支付增量+已完成增量
			orderinfo = addOrderinfo(orderinfoNopayment, orderinfo);// 计算运输中数据
			// =待支付数据+运输中增量

		} else if (orderParameter.equals(DataDic.ORDER_SUM_NOPAYMENT)) {// -----待支付数据
			// ==待支付的增量+已完成增量

			orderinfo = sumOrderinfo(DataDic.ORDER_SUM_NOPAYMENT, buyOrSell);// 待支付增量
			Orderinfo orderinfoEnd = new Orderinfo();
			orderinfoEnd = sumOrderinfo(DataDic.ORDER_SUM_END, buyOrSell);// 已完成增量

			orderinfo = addOrderinfo(orderinfo, orderinfoEnd);// 计算待支付数据
			// =待支付增量+已完成增量

		} else if (orderParameter.equals(DataDic.ORDER_SUM_NEW)) {// -----新运单数据
			// =新运单增量+运输中数据
			orderinfo = sumOrderinfo(DataDic.ORDER_SUM_NEW, buyOrSell);// 新运单增量

			Orderinfo orderinfoNopayment = new Orderinfo();// 待支付对象
			Orderinfo orderinfoEnd = new Orderinfo();// 已完成对象
			Orderinfo orderinfoIntransit = new Orderinfo();// 运输中对象

			orderinfoIntransit = sumOrderinfo(DataDic.ORDER_SUM_INTRANSIT, buyOrSell);// 运输中增量
			orderinfoNopayment = sumOrderinfo(DataDic.ORDER_SUM_NOPAYMENT, buyOrSell);// 待支付增量
			orderinfoEnd = sumOrderinfo(DataDic.ORDER_SUM_END, buyOrSell);// 已完成增量

			orderinfoNopayment = addOrderinfo(orderinfoNopayment, orderinfoEnd);// 先获取待支付数据
			// =待支付增量+已完成增量
			orderinfoIntransit = addOrderinfo(orderinfoNopayment, orderinfoIntransit);// 计算运输中数据
			// =待支付数据+运输中增量
			orderinfo = addOrderinfo(orderinfoIntransit, orderinfo);// 计算新运单数据
			// =运输中数据+新运单增量

		} else if (orderParameter.equals(DataDic.ORDER_SUM_END)) {// -----已完成数据
			orderinfo = sumOrderinfo(DataDic.ORDER_SUM_END, buyOrSell);// 已完成数据=已完成增量
		}
		return orderinfo;
	}

	/**
	 * 个人中心运单统计--
	 *
     * @param orderParameter 1新运单 2运输中 3待支付 4已支付
	 * @param userRoleEname
	 * @return 数据
	 */
	public Orderinfo getSumOrderinfoByRoleEname(String userRoleEname, String orderParameter) {
		Orderinfo orderinfo = new Orderinfo();
		if (userRoleEname.equals(DataDic.ROLE_ENTERPRISE) || userRoleEname.equals(DataDic.ROLE_GOODSOWNER)) {// 企业
			// 或者货主
			/* orderinfo = getSumOrderinfoByRoleType(orderParameter, true); */
			orderinfo = sumOrderinfoCount(orderParameter, true);
		} else if (userRoleEname.equals(DataDic.ROLE_CAROWNER)) {// 车主
			/* orderinfo = getSumOrderinfoByRoleType(orderParameter, false); */
			orderinfo = sumOrderinfoCount(orderParameter, false);
		}
		return orderinfo;
	}

	/**
	 * 运单统计--累计统计
	 *
     * @param orderParameter 1新运单 2运输中 3待支付 4已支付
     * @param userType       true卖家数据--企业 false买家数据 --车主
	 * @return 累计的数据
	 */
	public Orderinfo sumOrderinfoCount(String orderParameter, Boolean userType) {
		Orderinfo nowOrderinfo = new Orderinfo();// 所有
		Orderinfo returnOrderinfo = new Orderinfo();// 返回的

		if (orderParameter.equals(DataDic.ORDER_SUM_NEW)) {// 新运单
			orderParameter = DataDic.ORDER_SUM_NEW;
		} else if (orderParameter.equals(DataDic.ORDER_SUM_INTRANSIT)) {// 运输中
			orderParameter = DataDic.ORDER_SUM_INTRANSIT;
		} else if (orderParameter.equals(DataDic.ORDER_SUM_NOPAYMENT)) {// 待支付
			orderParameter = DataDic.ORDER_SUM_NOPAYMENT;
		} else if (orderParameter.equals(DataDic.ORDER_SUM_END)) {// 已支付
			orderParameter = DataDic.ORDER_SUM_END;
			nowOrderinfo.setPayDate(DateUtil.getCurrentDayTimeDate());// 设置支付时间开始于今天0点
		} else {

		}
		// 设置运单类型参数
		nowOrderinfo.setSumsearch(orderParameter);
		if (userType) {
			// 卖家数据--企业
			nowOrderinfo = sumSellOrderinfo(nowOrderinfo);// 运单数据
		} else {
			// 买家数据--车主
			nowOrderinfo = sumBuyOrderinfo(nowOrderinfo);// 运单数据
		}

		if (nowOrderinfo != null) {
			String nowSumorder = nowOrderinfo.getSumorder() != null ? nowOrderinfo.getSumorder() : "0";// 运单数
            String nowSumoddloadweight = nowOrderinfo.getSumoddloadweight() != null ? nowOrderinfo.getSumoddloadweight() : "0";// 吨数
			String nowSumtotalcost = nowOrderinfo.getSumtotalcost() != null ? nowOrderinfo.getSumtotalcost() : "0";// 运费

			returnOrderinfo.setSumorder(nowSumorder);
			returnOrderinfo.setSumoddloadweight(nowSumoddloadweight);
			returnOrderinfo.setSumtotalcost(nowSumtotalcost);
		}
		return returnOrderinfo;
	}

	/**
	 * 运单评价
	 *
	 * @param tradeComment
	 * @param
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object ordercommentBiz(TradeComment tradeComment) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		String message = "评价成功";
		String orderNo = tradeComment.getOrderno();
		String commInfo = tradeComment.getSellercomment();
		User user = UserUtils.getUser();
		if (user.getId() == null || user.getId().equals("")) {
			result = DataDic.RETURN_STATUS_INFOBUG;
			message = "您还未登录";
			return Tools.getMapResult(result, message, null);
		}
		if (Tools.IsNullOrWhiteSpace(commInfo)) {
			result = DataDic.RETURN_STATUS_INFOBUG;
			message = "缺少评价内容";
		} else if (Tools.IsNullOrWhiteSpace(orderNo)) {
			result = DataDic.RETURN_STATUS_INFOBUG;
			message = "缺少运单信息";
		} else {
			Orderinfo orderinfo = new Orderinfo();
			orderinfo.setOrderno(orderNo);
			List<Orderinfo> order = this.findList(orderinfo);
			if (order.size() == 0) {
				result = DataDic.RETURN_STATUS_INFOBUG;
				message = "运单不存在";
			} else if (order.get(0).getIscomment().equals("1")) {
				result = DataDic.RETURN_STATUS_INFOBUG;
				message = "运单已评价";
			}
			List<TradeComment> comment = tradeCommentService.findList(tradeComment);
			if (comment.size() != 0) {
				result = DataDic.RETURN_STATUS_INFOBUG;
				message = "运单已评价";
			}
			if (result == DataDic.RETURN_STATUS_NORMAL) {
				if (user.getId().equals(order.get(0).getSeller().getId())) {
					tradeComment.setSellercommenttime(new Date());
					tradeCommentService.save(tradeComment);
					orderinfo = order.get(0);
					orderinfo.setIscomment("1");
					orderinfoService.save(orderinfo);
				} else {
					result = DataDic.RETURN_STATUS_INFOBUG;
					message = "您无权评价";
				}
			}
		}
		return Tools.getMapResult(result, message, null);
	}

	/**
	 * @param orderinfo
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object torderlbs(Orderinfo orderinfo) {
		Orderinfo oinfo = new Orderinfo();
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "开启定位成功";


		try {
			if (Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
				state = DataDic.RETURN_STATUS_INFOBUG;
				message = "信息缺失";
			} else {
				Orderinfo order = getOrder(orderinfo.getId());
				if (order == null) {
					state = DataDic.RETURN_STATUS_INFOBUG;
					message = "运单不存在";
				} else {
					if (DataDic.ORDER_STATUS_TAKEGOODS.equals(order.getOrderstatus())) {
						oinfo.setLocationstate(Integer.parseInt(DataDic.LBS_STATUS_BEING));
					} else {
						oinfo.setLocationstate(Integer.parseInt(DataDic.LBS_STATUS_CREATE));
					}

					int locationRate = orderinfo.getLocationRate();
					int locationRateType = orderinfo.getLocationRateType();
					int locationTime = orderinfo.getLocationtime();
					int locationTimeType = orderinfo.getLocationtimetype();

					oinfo.setLocationRate(locationRate);
					oinfo.setLocationRateType(locationRateType);
					oinfo.setLocationtime(locationTime);
					oinfo.setLocationtimetype(locationTimeType);


					oinfo.setIslocated("1");
					oinfo.setLocationstarttime(new Date());
					oinfo.setUpdateDate(new Date());
					oinfo.setOrderno(orderinfo.getOrderno());
					oinfo.setId(orderinfo.getId());
					oinfo.setLocationpayway(orderinfo.getLocationpayway());
					oinfo.setLocationmobile(orderinfo.getLocationmobile());

					if (state == DataDic.RETURN_STATUS_NORMAL) {
						save(oinfo);
						updateJobList(oinfo, true);// 添加定时任务
					} else {
						state = DataDic.RETURN_STATUS_NORMAL;
						message = "开启定位失败";
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "开启定位失败";
		}
		return Tools.getMapResult(state, message, null);
	}

	/***
	 * 1如果定位表没有这个订单的定时任务，新增一条定时任务;当取消时删除job列表中对应的订单号
	 * @Description: TODO
     * @param @param pd
     * @param @param isAdd
     * @param @throws Exception   
	 * @return void
     * @throws
     * @author lqz
	 * @date 2015年8月23日
	 */
	@Transactional(readOnly = false)
	public void updateJobList(Orderinfo orderinfo, boolean isAdd) throws Exception {
		BscJob bscJob = new BscJob();
		bscJob.setJobcode(orderinfo.getOrderno());
		bscJob = jobBiz.findByCondition(bscJob);
		Orderinfo order = new Orderinfo();
		order.setOrderno(orderinfo.getOrderno());
		orderinfo = getOrderByNo(order);

        if (isAdd && orderinfo != null && Integer.parseInt(orderinfo.getOrderstatus()) <= Integer.parseInt(DataDic.ORDER_STATUS_TAKEGOODS)
				&& !DataDic.ORDER_STATUS_CANCEL.equals(orderinfo.getOrderstatus())) {

			if (bscJob == null) {
				bscJob = new BscJob();
			}

			if (Tools.IsNullOrWhiteSpace(bscJob.getId())) {
				int locationRateType = orderinfo.getLocationRateType();
				int locationRate = orderinfo.getLocationRate();
				bscJob.setJobcode(orderinfo.getOrderno());
				bscJob.setJobtype("1");// 采集任务
				bscJob.setJobclass("com.thinkgem.jeesite.common.quartz.StatisticsLBS");// 任务类
				bscJob.setExecycle("0");// 非表达式

				if ("2".equals(locationRateType)) {
					bscJob.setJobIntervalUnit("1");// 执行周期定位为小时
					bscJob.setIntervalhour(String.valueOf(locationRate));// 执行周期时长
				} else {
					bscJob.setJobIntervalUnit("0");// 执行周期定位为分
					bscJob.setIntervalminute(String.valueOf(locationRate));// 执行周期分长
				}
				bscJob.setJobdescription("定位订单号" + orderinfo.getOrderno());
				bscJob.setUserid(orderinfo.getSeller().getId());
				bscJob.setCreatetime(new Date());

				bscJob.setIslog(DataDic.YES);
				bscJob.setIsNewRecord(true);
				bscJob.setId(IdGen.uuid());

			}
			bscJob.setUpdatetime(new Date());
			if (DataDic.ORDER_STATUS_TAKEGOODS.equals(orderinfo.getOrderstatus())) {
				bscJob.setIsenable(DataDic.YES);// 启动任务
			} else {
				bscJob.setIsenable(DataDic.NO);// 不启动
			}
			jobBiz.save(bscJob);
		} else {
			if (bscJob != null) {
				jobBiz.delete(bscJob);
			}
		}
	}

	/**
	 * 获取用户今天的运单交易金额 、代付金额和已付金额 货主或物流企业
	 *
	 * @param userid
	 * @return
	 */
	public Map<String, Double> getGoodPriceNum(String userid) {
		return orderinfoService.getGoodPriceNum(userid);
	}

	/**
	 * 获取用户今天的运单交易金额 、代付金额和已付金额 车主
	 *
	 * @param userid
	 * @return
	 */
	public Map<String, Double> getCarUserPriceNum(String userid) {
		return orderinfoService.getCarUserPriceNum(userid);
	}

	/**
	 * 获取订单详情
	 *
     * @param orderno 订单orderno
     * @param user    当前登录用户ID
	 * @return
	 */
	public Orderinfo getDetailByOrderNo(String orderno, User user) {
		Orderinfo oinfo = new Orderinfo();
		oinfo.setOrderno(orderno);
		oinfo.setBuyer(user);
		/// 获取运单详情
		Orderinfo orderinfo = orderinfoService.getByOrderinfo(oinfo);
		return orderinfo;
	}

	/**
	 * 更新打印时间
	 *
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = false)
	public int updatePrintcount(String id) {
		if (Tools.IsNullOrWhiteSpace(id)) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		return orderinfoService.updatePrintcount(id);
	}

	/**
	 * 获取用户各状态的订单数目
	 *
	 * @return
	 */
	public Map<String, Object> getStatusNum() {
		Map<String, Object> resultMap = new HashMap<>();
		List<Dict> dicts = DictUtils.getDictList("order_status_ordercenter");
		List<Map<String, Object>> resultList = new ArrayList<>();
		User user = UserUtils.getUser();
		Orderinfo orderinfo = null;
		int totalNum = 0;
		Map<String, Object> result = null;
		for (int i = 0, j = dicts.size(); i < j; i++) {
			String statusValue = dicts.get(i).getValue();
			String statusLabel = dicts.get(i).getLabel();
			orderinfo = new Orderinfo();
			if ("7".equals(statusValue)) {
				orderinfo.setIscomment("1");
			} else {
				orderinfo.setOrderstatus(statusValue);
			}
			orderinfo.setSeller(user);
			int num = orderinfoService.getOrdersStatusNum(orderinfo);
			result = new HashMap<>();
			result.put("statusName", statusLabel);
			result.put("statusValue", statusValue);
			result.put("statusOrderNum", num);
			resultList.add(result);
			totalNum = totalNum + num;
		}

		resultMap.put("dataList", resultList);
		resultMap.put("totalNum", totalNum);
		return resultMap;
	}

	/**
	 * 获取订单详情
	 *
     * @param orderno 订单orderno
	 * @return
	 */
	public Orderinfo getOrderInfoByOrderNo(String orderno) {
		Orderinfo oinfo = new Orderinfo();
		oinfo.setOrderno(orderno);
		/// 获取运单详情
		Orderinfo orderinfo = orderinfoService.getByOrderinfo(oinfo);
		return orderinfo;
	}

	/***
	 * 运输监控获取分页信息
	 * @param page
	 * @param orderinfo
	 * @return
	 */
	public Page<Orderinfo> getCarAndTradeList(Page<Orderinfo> page, Orderinfo orderinfo, User user) {
		Quoteinfo quoteinfo = new Quoteinfo();
		quoteinfo.setUser(user);
		orderinfo.setQuoteinfo(quoteinfo);
		return orderinfoService.getCarAndTradeList(page, orderinfo);

	}
	/**
	 * 定时任务
	 * 调用自定义区域注册、订阅接口
	 */
	@Transactional(readOnly = false)
	public void regionRegistration() {
		Orderinfo orderinfoConf = new Orderinfo();
		orderinfoConf.setRailFlag(DataDic.RAILFLAG_ON);
		orderinfoConf.setRailfunctionFlag(DataDic.RAILSTATE_NORMAL);
		List<Orderinfo> list = orderinfoService.findInterfaceFlag(orderinfoConf);
		for (Orderinfo orderinfo : list) {
			int state = DataDic.RAIL_MSGERROR;
			String areaidin = "";
			String areaidout = "";
				if(orderinfo.getRailFlag().equals(DataDic.RAILFLAG_ON) && orderinfo.getRailfunctionFlag().equals(DataDic.RAILSTATE_NORMAL)){
				RailRegist railRegist = new RailRegist();
				// 进区域接口调用
				railRegist.setActionType(DataDic.RAIL_ALL);
				railRegist.setType(DataDic.THECAR);
				String orderinfoid = orderinfo.getId();
				railRegist.setOrderinfoId(orderinfoid);
				Quoteinfo quoteinfo = orderinfo.getQuoteinfo();
				Goods goods = quoteinfo.getGoods();
				Address address = goods.getShipAddress();
				String addr = address.getProvince() + address.getCity() + address.getDistrict();
				railRegist.setRailname(addr);
				// 获取经纬度
				Map<String, Double> lonlatConf = MapBaidu.getLngAndLat(addr);
				String lnglat = lonlatConf.get("lng") + "," + lonlatConf.get("lat");
					if (!Tools.IsNullOrWhiteSpace(lnglat)) {
						railRegist.setLonlat(lnglat);
					}
					railRegist.setRadius("30000");// 设置半径
					List<RailRegist> raillistIn = railRegistService.findByRailName(railRegist);
					if(raillistIn != null && raillistIn.size() > 0){
						RailRegist railRegistConf = raillistIn.get(0);
							areaidin = railRegistConf.getAreaid();
							state = DataDic.RAIL_SUCCESS;
					}else{
					Map<String, Object> mapin = railRegistBiz.save(railRegist);
					if (Integer.parseInt(mapin.get("state").toString()) == DataDic.RAIL_SUCCESS) {
						state = DataDic.RAIL_SUCCESS;
						VehicleInformation vehicleInformation = (VehicleInformation) mapin.get("data");
						areaidin = vehicleInformation.getAreaid();
					} else {
						state = Integer.parseInt(mapin.get("state").toString());
					}
				}
				// 出区域接口调用
				address = goods.getConsignAddress();
				addr = address.getProvince() + address.getCity() + address.getDistrict();
				// 获取经纬度
				lonlatConf = MapBaidu.getLngAndLat(addr);
				lnglat = lonlatConf.get("lng") + "," + lonlatConf.get("lat");
				railRegist.setRailname(addr);
				railRegist.setActionType(DataDic.RAIL_ALL);
				List<RailRegist> raillistOut = railRegistService.findByRailName(railRegist);
				if(raillistOut != null && raillistOut.size() > 0){
					RailRegist railRegistConf = raillistOut.get(0);
						areaidout = railRegistConf.getAreaid();
						state = DataDic.RAIL_SUCCESS;
				}else{

					Map<String, Object> mapout = railRegistBiz.save(railRegist);
					if(Integer.parseInt(mapout.get("state").toString()) == DataDic.RAIL_SUCCESS && state == DataDic.RAIL_SUCCESS){
						VehicleInformation vehicleInformation = (VehicleInformation)mapout.get("data");
						areaidout = vehicleInformation.getAreaid();

					} else {
						state = Integer.parseInt(mapout.get("state").toString());
					}
				}
				Car car = quoteinfo.getCar();
				if (car == null) {
					state = DataDic.RAIL_PARAMERROR;
				}
				if (state == DataDic.RAIL_SUCCESS) {
					String carNumber = car.getCarnumber() + "_2";// 默认黄色
					Map<String, Object> map = carSubscribeBiz.insert(areaidin, carNumber);
					state = Integer.parseInt(map.get("state").toString());
				}
				if (state == DataDic.RAIL_SUCCESS) {
					String carNumber = car.getCarnumber() + "_2";
					Map<String, Object> map = carSubscribeBiz.insert(areaidout, carNumber);
					state = Integer.parseInt(map.get("state").toString());
				}
				if (state == DataDic.RAIL_SUCCESS) {
					orderinfo.setRailfunctionFlag(DataDic.RAILSTATE_ON);
					orderinfoService.updateRailState(orderinfo);
				}
			}
		}
	}

	/**
     * 定时任务
     * 调用删除围栏、订阅接口
	 */
	@Transactional(readOnly = false)
	public void deleteInterface() {
		Orderinfo orderinfoConf = new Orderinfo();
		orderinfoConf.setRailFlag(DataDic.RAILFLAG_ON);
		orderinfoConf.setRailfunctionFlag(DataDic.RAILSTATE_ON);
		List<Orderinfo> list = orderinfoService.findInterfaceFlag(orderinfoConf);
		for (Orderinfo orderinfo : list) {
			if(orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_PAY) || orderinfo.getOrderstatus().equals(DataDic.ORDER_STATUS_CANCEL) && orderinfo.getRailfunctionFlag().equals(DataDic.RAILSTATE_ON)){
				int state = DataDic.RAIL_UNKNOWNERROR;

				RailRegist railRegistConf = new RailRegist();
				String orderinfoId = orderinfo.getId();
				railRegistConf.setOrderinfoId(orderinfoId);
				List<RailRegist> railList = railRegistService.findByOrderid(railRegistConf);
				for (RailRegist railRegist : railList) {
					Quoteinfo quoteinfo = orderinfo.getQuoteinfo();
					Car car = quoteinfo.getCar();
					String carNumber = car.getCarnumber();
					if (!Tools.IsNullOrWhiteSpace(carNumber)) {
						carNumber = carNumber+"_2";
						Map<String, Object> mapCar = carSubscribeBiz.delete(railRegist.getAreaid(), carNumber);
						state = Integer.parseInt(mapCar.get("state").toString());
					}
				}
				if (state == DataDic.RAIL_SUCCESS) {
					orderinfo.setRailfunctionFlag(DataDic.RAILSTATE_OFF);
					orderinfoService.updateRailState(orderinfo);
				}
			}
		}
	}

	/**
	 * 回调接口(中交兴路)
	 */
    public Map<String,Object> callbackInterface(String userflag,String vno,String plateColor,String areaId,String type,String utc){
		RailRegist railRegistConf = new RailRegist();
		railRegistConf.setAreaid(areaId);
		railRegistConf.setActionType(type);
		RailRegist railRegist = railRegistService.findByCallback(railRegistConf);
		int state = DataDic.RAIL_UNKNOWNERROR;
		String message = "";
		if (railRegist != null) {
			state = DataDic.RAIL_SUCCESS;
			message = "区域查询成功";
		}
		CarSubscribe carSubscribeConf = new CarSubscribe();
		carSubscribeConf.setAreaid(areaId);
		carSubscribeConf.setVnos(vno + "_" + plateColor);
		List<CarSubscribe> list = carSubscribeService.findByCallback(carSubscribeConf);
		for (CarSubscribe carSubscribe : list) {
			if (carSubscribe != null) {
				state = DataDic.RAIL_SUCCESS;
				message = "全部查询成功";
			}
		}
		return Tools.getMapResult(state, message, null);
	}


	/**
	 * 开启gps定位
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> openGps(Orderinfo orderinfo) {
		int state = DataDic.RAIL_SUCCESS;
		String message = "";
		if (state == DataDic.RAIL_SUCCESS) {
			orderinfo.setLocationFlag("1");
			orderinfoService.updateRailState(orderinfo);
			message = "开通成功";
		}
		return Tools.getMapResult(state, message, null);
	}



	private void messagePush(Goods goods, Orderinfo orderinfo) {
		new Thread() {
			@Override
			public void run() {
				try {
					Thread.sleep(30000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				//内容
				User buyer = UserUtils.getUserById(orderinfo.getBuyer().getId());// 获取用户信息
				String summary = goods.getShipAddress().getProvince() + goods.getShipAddress().getCity()
						+ goods.getShipAddress().getDistrict() + goods.getShipAddress().getAddress() + "到"
						+ goods.getConsignAddress().getProvince() + goods.getConsignAddress().getCity()
						+ goods.getConsignAddress().getDistrict() + goods.getConsignAddress().getAddress() + "有新的运单";
				Map<String, String> paramMap = new HashMap<>();
				paramMap.put("TITLE", "运单信息通知");
				paramMap.put("SOURCETYPE ", "4");
				paramMap.put("SUMMARY", summary);
				paramMap.put("SOURCEID ", goods.getId());
				paramMap.put("ORDERID  ", orderinfo.getId());
				MessagePushUtil.sendPush("运单信息通知", summary, buyer.getId(), paramMap);

				BscMessage message=new BscMessage();
				message.setTtile(DataDic.MESSAGE_TYPE_NEWORDER);
				message.setContent(summary);
				message.setSummary(summary);
				message.setContenttype(DataDic.MESSAGE_CONTENTTYPE_KEFU);
				message.setStatus(DataDic.MESSAGE_STATUS_YES);
				message.setSourceid(orderinfo.getId());
				message.setSendtype(DataDic.MESSAGE_SENDTYPE_USER);
				message.setSourcetype(DataDic.MESSAGE_SOURCETYPE_WAYBILL);
				message.setScantype(DataDic.MESSAGE_SCANTYPE_ANDROID);
				message.setUser(buyer);
				message.setId(IdGen.uuid());
				UserMessage userMessage=new UserMessage();
				userMessage.setMessage(message);
				userMessage.setStatus(DataDic.MESSAGE_IS_READ_NO);
				userMessage.setUser(buyer);
				bscMessageBiz.saveMessage(message,userMessage);//保存消息

			}
		}.start();
	}

	/**
	 * 获取运单信息
	 * @param orderNos
	 * @param newtime
	 * @param carNumber
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String,Object> getCarAndTradeInfo(String orderNos, String newtime, String carNumber) {
		List<Map<String, Object>> mapListJson = new ArrayList<>();
		List<Object> list = new ArrayList<>();
		List<GpsCarInfo> gpsCars = new ArrayList<>();
		Orderinfo oinfo = new Orderinfo();
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> mapl = new HashMap<>();
		int state=DataDic.YES_INT;
		String message="";
		if (!Tools.IsNullOrWhiteSpace(carNumber)) {
			if (!Tools.IsNullOrWhiteSpace(orderNos)) {                                   //运单是否为空都可以查询车辆位置信息的
				oinfo = getOrderInfoByOrderNo(orderNos);
				oinfo.setStatusStr(DictUtils.getDictLabel(oinfo.getOrderstatus(), "order_status", null));
				if (oinfo != null && null!=oinfo.getIslocated() && DataDic.YES.equals(oinfo.getIslocated()) ) {// 判断是否开通lbs定位服务
					List<String> gpslist = new ArrayList<>();
					gpslist.add(carNumber);
					gpsCars = carInfoService.findByGroup(gpslist.toArray(new String[gpslist.size()]));
					state=DataDic.NO_INT;
				}else {                                                                                    //没有开通定位服务就调用位置查询接口并收费
					int locCount= oinfo.getLocCount();
					oinfo.setLocCount(++locCount);
					orderinfoService.save(oinfo);
					map= locationBiz.vclnLocation(carNumber, newtime,DataDic.INFORMATION_YES);
					state=(int) map.get("state");
					if(state==DataDic.INFACESSOURCE_ZJXL_INT) {
						message=(String) map.get("message");
						mapl.put("LocationVcln",map.get("data"));
						
					}
					if(state==DataDic.INFACESSOURCE_LBS_INT) {
						Map<String,List> gpslist= (Map<String, List>) map.get("data");
						mapListJson= (List<Map<String, Object>>) gpslist.get("mapListJson");
					}
					
				}
			}else {                                                       //在地图轨迹页面没有运单信息有车牌号也可以查询
				map= locationBiz.vclnLocation(carNumber, newtime,DataDic.INFORMATION_YES);
				state=(int) map.get("state");
				if(state==DataDic.INFACESSOURCE_ZJXL_INT) {
					message=(String) map.get("message");
					mapl.put("LocationVcln",map.get("data"));
					
				}
				if(state==DataDic.INFACESSOURCE_LBS_INT) {
					Map<String,List> gpslist= (Map<String, List>) map.get("data");
					mapListJson= (List<Map<String, Object>>) gpslist.get("mapListJson");
				}
			}
		}
		
		
		list.add(mapListJson);
		list.add(oinfo);
		list.add(gpsCars);
		list.add(mapl);
		System.out.println(mapListJson);
		System.out.println(mapl);
		return Tools.getMapResult(state, message, list);
	}
	/**
	 * 查询车辆轨迹信息
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object getlCarGpsInfo(Orderinfo orderinfo,String orderNos, String carnumber, String beginTime,String endTime) {
		
		Map<String, Object> map = new HashMap<>();
		Orderinfo oinfo = new Orderinfo();
		List<String> gpslist = new ArrayList<>();
		List<GpsCarInfo> gpsCars = new ArrayList<>();
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null) {
			return new JSONPObject("callback", null);
		}
		if(!Tools.IsNullOrWhiteSpace(carnumber)){//车牌号不为空
			if(!Tools.IsNullOrWhiteSpace(orderNos)) {
				orderinfo.setOrderno(orderNos);
				oinfo = orderservice.getByOrderinfo(orderinfo);
				if (oinfo != null && null!=oinfo.getLocationFlag() &&DataDic.YES.equals(oinfo.getLocationFlag())) { // 判断是否开通lbs定位服务
					
					gpslist.add(carnumber);
					gpsCars = carInfoService.findByGroup(gpslist.toArray(new String[gpslist.size()]));
					return new JSONPObject("callback", gpsCars);
				}else {
					int trailCount= oinfo.getTrailCount();
					oinfo.setTrailCount(++trailCount);
					orderinfoService.save(oinfo);
					map=(Map<String, Object>) histrackBiz.vclnHist(carnumber, beginTime, endTime,DataDic.INFORMATION_YES);
					System.out.println(map);
					return new JSONPObject("callback", map);
				}
			}else {                                                     //运单号为空，车牌号不为空也可以查询轨迹
				map=(Map<String, Object>) histrackBiz.vclnHist(carnumber, beginTime, endTime,DataDic.INFORMATION_YES);
				return new JSONPObject("callback", map);
			}
		}
		
		return null;
		
	}
	/**
	 * 查询车辆轨迹信息副本
	 * 没有lbs定位判断的
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object getlCarGpsInfos(Orderinfo orderinfo,String orderNos, String carnumber, String beginTime,String endTime) {
		
		Map<String, Object> map = new HashMap<>();
		Orderinfo oinfo = new Orderinfo();
		List<String> gpslist = new ArrayList<>();
		List<GpsCarInfo> gpsCars = new ArrayList<>();
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null) {
			return new JSONPObject("callback", null);
		}
		if(!Tools.IsNullOrWhiteSpace(carnumber)){//车牌号不为空
			if(!Tools.IsNullOrWhiteSpace(orderNos)) {//运单号不为空 调用轨迹
				orderinfo.setOrderno(orderNos);
				oinfo = orderservice.getByOrderinfo(orderinfo);
				int trailCount= oinfo.getTrailCount();
				oinfo.setTrailCount(++trailCount);
				orderinfoService.save(oinfo);
				map=(Map<String, Object>) histrackBiz.vclnHist(carnumber, beginTime, endTime,DataDic.INFORMATION_YES);
				int state= (int) map.get("state");
				String message=(String) map.get("message");
				Map<String,Object>maplist= (Map<String, Object>) map.get("data");
				if(state==DataDic.INFACESSOURCE_LBS_INT) {
					List<Map<String, Object>> mapListJson= (List<Map<String, Object>>) maplist.get("mapListJson");
					return Tools.getMapResult(state, message, mapListJson);
				}
				if(state==DataDic.INFACESSOURCE_ZJXL_INT) {
					List<VehicleInformation> TrackVcl=(List<VehicleInformation>) maplist.get("TrackVcl");
					return Tools.getMapResult(state, message, TrackVcl);
				}
			}else {                                                     //运单号为空，车牌号不为空也可以查询轨迹
				map=(Map<String, Object>) histrackBiz.vclnHist(carnumber, beginTime, endTime,DataDic.INFORMATION_YES);
				int state= (int) map.get("state");
				String message=(String) map.get("message");
				Map<String,Object>maplist= (Map<String, Object>) map.get("data");
				if(state==DataDic.INFACESSOURCE_LBS_INT) {
					List<Map<String, Object>> mapListJson= (List<Map<String, Object>>) maplist.get("mapListJson");
					return Tools.getMapResult(state, message, mapListJson);
				}
				if(state==DataDic.INFACESSOURCE_ZJXL_INT) {
					List<VehicleInformation> TrackVcl=(List<VehicleInformation>) maplist.get("TrackVcl");
					return Tools.getMapResult(state, message, TrackVcl);
				}
			}
		}
		
		return null;
		
	}	
	
}