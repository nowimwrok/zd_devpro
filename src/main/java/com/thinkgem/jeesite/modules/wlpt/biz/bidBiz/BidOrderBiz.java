package com.thinkgem.jeesite.modules.wlpt.biz.bidBiz;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJobAccount;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import java.math.BigDecimal;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by ForHeart on 16/8/19.
 */
@Service
@Transactional(readOnly = true)
public class BidOrderBiz {

    @Autowired
    private BidOrderinfoService bidOrderinfoService;

    @Autowired
    private ConsumeRecodBiz consumeRecodBiz;

    @Autowired
    private BiddinginfoService biddinginfoService;

    @Autowired
    private BidinfoService bidinfoService;
    
    @Autowired
    private AccountBiz accountBiz;
    
    private final ReentrantLock lock=new ReentrantLock();


    /***
     * 获取招标合同信息列表
     *
     * @param page         分页信息
     * @param bidOrderinfo 合同
     * @param user         用户数据,如果用户存在,则去判断是否是招标用户
     * @return
     */
    public Page<BidOrderinfo> getBidOrderList(Page<BidOrderinfo> page, BidOrderinfo bidOrderinfo, User user) {
        Page<BidOrderinfo> pg = bidOrderinfoService.findPage(page, bidOrderinfo);
        for (BidOrderinfo var : pg.getList()) {
            var.setBidinfo(bidinfoService.get(var.getBidinfo().getId()));
            ///获取货物类型,合同状态、结算状态
            var.getBidinfo().getGoods().setGsoddtype(DictUtils.getDictLabel(var.getBidinfo().getGoods().getGsoddtype(), "gsoddtype", null));
            var.setSetttleStr(DictUtils.getDictLabel(var.getSettlestatus(), "bidOrder_settleStatus", null));
            var.setContractStr(DictUtils.getDictLabel(var.getContractstatus(), "bidOrder_status", null));
            if (user != null) {
                ///是否是招标用户
                if (user.getId().equals(var.getBiduser().getId())) {
                    var.setIsBidUser(true);
                } else {
                    var.setIsBidUser(false);
                }
            }
        }
        return pg;
    }


    /***
     * 修改合同的交易状态
     *
     * @param id     合同ID
     * @param user   当前用户
     * @param status 修改的状态
     * @return
     */
    @Transactional(readOnly = false)
    public Object editBidTradeStatus(String id, User user, String status) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        BidOrderinfo bidOrder = bidOrderinfoService.get(id);
        if (bidOrder == null || user == null || Tools.IsNullOrWhiteSpace(status)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "合同信息有误";
            return Tools.getMapResult(state, message, null);
        }
        User bidUser = UserUtils.findUser(bidOrder.getBiduser());///招标用户
        User bidingUser = UserUtils.findUser(bidOrder.getBiddinguser());//
        ///是否缴纳保证金
        String bingGuarn = bidOrder.getBiddinginfo().getGuarantee();
        ///运输合同状态
        String contStatus = bidOrder.getContractstatus();
        ///如果修改状态为申请运输完成:则只有竞标用户发起,并且申请前的状态为交易中或者驳回状态
        if (DataDic.BIDORDER_STATUS_APLAY.equals(status)) {
            if ((!DataDic.BIDORDER_STATUS_TRADING.equals(contStatus) && !DataDic.BIDORDER_STATUS_FILED.equals(contStatus)) || DataDic.BIDORDER_STATUS_APLAY.equals(contStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "请勿重复操作";
            } else if (!bidingUser.getId().equals(user.getId())) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            }
        } else if (DataDic.BIDORDER_STATUS_SUCCESS.equals(status)) {
            if (!DataDic.BIDORDER_STATUS_APLAY.equals(contStatus) || DataDic.BIDORDER_STATUS_SUCCESS.equals(contStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "请勿重复操作";
            } else if (!bidUser.getId().equals(user.getId())) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            }
        } else if (DataDic.BIDORDER_STATUS_FILED.equals(status)) {
            if (!DataDic.BIDORDER_STATUS_APLAY.equals(contStatus) || DataDic.BIDORDER_STATUS_FILED.equals(contStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "请勿重复操作";
            } else if (!bidUser.getId().equals(user.getId())) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            }
        } else {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "对不起,您无权限操作";
        }
        if (!consumeRecodBiz.IsCommitData(user.getId(),
                DataDic.CONSUMERECODE_TYPE_BIDINGRETURN, DataDic.CONSUMERECODE_MODEL_BIDDING, DataDic.CONSUMERECODE_WAY_BALANCE)) {
            state= DataDic.RETURN_STATUS_REMORE;
            message="请稍后再试";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            BidOrderinfo upOrder = new BidOrderinfo();
            upOrder.setId(bidOrder.getId());
            upOrder.setContractstatus(status);
            ///如果招标同意运输完成,竞标押金退还,并且判断是否缴纳保证金(是否减免)
            if (DataDic.BIDORDER_STATUS_SUCCESS.equals(status) && DataDic.BIDDING_GURAN_PAY.equals(bingGuarn) && DataDic.NO.equals(bidOrder.getBiddinginfo().getIsderate())) {
                ///退还用户的竞标押金
                consumeRecodBiz.biddingReturnPayRecodeBiz(biddinginfoService.get(bidOrder.getBiddinginfo().getId()));
                Biddinginfo biddinginfo = new Biddinginfo();
                biddinginfo.setId(bidOrder.getBiddinginfo().getId());
                biddinginfo.setGuarantee(DataDic.BIDDING_GURAN_RETURN);
                biddinginfoService.save(biddinginfo);
            }
            bidOrderinfoService.save(upOrder);///修改交易状态
        }
        return Tools.getMapResult(state, message, null);
    }


    /***
     * 修改 合同的结算状态
     *
     * @param id
     * @param user
     * @param status
     * @return
     */
    @Transactional(readOnly = false)
    public Object editBidSettleStatus(String id, User user, String status) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        BidOrderinfo bidOrder = bidOrderinfoService.get(id);
        if (bidOrder == null || user == null || Tools.IsNullOrWhiteSpace(status)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "合同信息有误";
            return Tools.getMapResult(state, message, null);
        }
        User bidUser = UserUtils.findUser(bidOrder.getBiduser());///招标用户
        User bidingUser = UserUtils.findUser(bidOrder.getBiddinguser());//竞标用户
        ///结算状态
        String oldStatus = bidOrder.getSettlestatus();
        ///如果传入的修改状态为申请结算状态则需判断
        if (DataDic.BID_SETTLE_APLAY.equals(status)) {
            if ((!DataDic.BID_SETTLE_NOMER.equals(oldStatus) && !DataDic.BID_SETTLE_FILED.equals(oldStatus)) || DataDic.BID_SETTLE_APLAY.equals(oldStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "请勿重复操作";
            } else if (!bidingUser.getId().equals(user.getId())) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            } else {
                String[] keyword = {bidOrder.getBidinfo().getBidcode()};
                SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_BIDORDEREND, bidUser.getPhone(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_BIDOD, keyword, null, null, true, SmsConfig.smsOrderEnd);
            }

        } else if (DataDic.BID_SETTLE_AGREE.equals(status)) {///如果是结算状态为通过状态
            ////判断修改前的状态是否为申请状态,如果不是则无法操作
            if (!DataDic.BID_SETTLE_APLAY.equals(oldStatus) || DataDic.BID_SETTLE_AGREE.equals(oldStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "请勿重复操作";
            } else if (!bidUser.getId().equals(user.getId())) {///是否是发标用户,只有发标用户才有权限操作同意
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            }
        } else if (DataDic.BID_SETTLE_FILED.equals(status)) {///如果是结算状态为驳回
            ////判断修改前的状态是否为申请状态,如果不是则无法操作
            if (!DataDic.BID_SETTLE_APLAY.equals(oldStatus) || DataDic.BID_SETTLE_FILED.equals(oldStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "请勿重复操作";
            } else if (!bidUser.getId().equals(user.getId())) {///是否是发标用户,只有发标用户才有权限操作同意
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            }
        } else if (DataDic.BID_SETTLE_SURE.equals(status)) {///如果是结算状态为确认
            ////判断修改前的状态是否为已支付状态,如果不是则无法操作
            if (!DataDic.BID_SETTLE_PAYED.equals(oldStatus) || DataDic.BID_SETTLE_SURE.equals(oldStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "请勿重复操作";
            } else if (!bidingUser.getId().equals(user.getId())) {///是否是发标用户,只有发标用户才有权限操作同意
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            }
        } else {
            ///如果是其他状态则无权操作
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "对不起,您无权限操作";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            BidOrderinfo upOrder = new BidOrderinfo();
            upOrder.setId(bidOrder.getId());
            upOrder.setSettlestatus(status);
            bidOrderinfoService.save(upOrder);///修改支付结算状态
        }

        return Tools.getMapResult(state, message, null);
    }

    /**
     * 支付运费给竞标用户
     *
     * @param id      合同ID
     * @param user_id 当前用户
     * @return
     */
    @Transactional(readOnly = false)
    public Object payBidOrderMoneyBiz(String id, String user_id, String ispayCoin, Double coinAmount, String isOnlinePay, Double webAmount,String isAccount) {
        lock.lock();
        try{
        	int state = DataDic.RETURN_STATUS_NORMAL;
            String message = "支付失败";
            User user = new User();
            user.setId(user_id);
            ///获取用户信息
            user = UserUtils.findUser(user);
            BidOrderinfo bidOrder = bidOrderinfoService.get(id);
            if (bidOrder == null || user == null) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "合同信息有误";
                return Tools.getMapResult(state, message, null);
            }
            ///结算状态
            String settleStatus = bidOrder.getSettlestatus();
            if (!DataDic.BID_SETTLE_AGREE.equals(settleStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "操作无效,等待结算申请";
                return Tools.getMapResult(state, message, null);
            } else if (DataDic.BID_SETTLE_PAYED.equals(settleStatus)) {
                state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
                message = "已支付,请勿重复操作";
                return Tools.getMapResult(state, message, null);
            }
            Double orderTotal = Double.valueOf(bidOrder.getContracttotal() != null ? bidOrder.getContracttotal().doubleValue() : 0.00);
            orderTotal = PreciseCompute.round(orderTotal, 2);
            webAmount = PreciseCompute.round(webAmount, 2);
            if (webAmount + coinAmount > orderTotal) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "对不起,支付金额不可高于总运费";
            }
            ///获取招标用户
            User bidUser = UserUtils.findUser(bidOrder.getBiduser());
            Double avaliv=bidUser.getUserPurse().getAvailablebalance();
            if(!Tools.IsNullOrWhiteSpace(bidUser.getMemberId())&&DataDic.ORDER_PAYWAY_ACCOUNT.equals(isAccount)){
            	avaliv=accountBiz.getAmount(bidUser, DataDic.AVAILABLE_BALANCE);
            }
            if (!bidUser.getId().equals(user.getId())) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "对不起,您无权限操作";
            } else if (DataDic.YES.equals(isOnlinePay)) {
                if (webAmount > avaliv) {
                    state = DataDic.RETURN_STATUS_MONEYBUG;
                    message = "对不起,账户余额不足,及时充值";
                } else if (webAmount < 0) {
                    state = DataDic.RETURN_STATUS_MONEYBUG;
                    message = "支付金额不能低于0元";
                }
            } else if (DataDic.YES.equals(ispayCoin)) {
                if (coinAmount > bidUser.getUserPurse().getAvailablecoin()) {
                    state = DataDic.RETURN_STATUS_MONEYBUG;
                    message = "对不起,卓币余额不足,及时充值";
                } else if (coinAmount < 0) {
                    state = DataDic.RETURN_STATUS_MONEYBUG;
                    message = "卓币金额不能低于0元";
                }

            } 
//            if("2".equals(isAccount)){
//            	if (!consumeRecodBiz.IsCommitData(user.getId(),
//                        DataDic.CONSUMERECODE_TYPE_SETTLEPAY, DataDic.CONSUMERECODE_MODEL_SETTLEORDER, DataDic.CONSUMERECODE_WAY_ACCOUNT)) {
//                    state= DataDic.RETURN_STATUS_REMORE;
//                    message="请稍后再试";
//                }
//            }else{
//            	if (!consumeRecodBiz.IsCommitData(user.getId(),
//                        DataDic.CONSUMERECODE_TYPE_SETTLEPAY, DataDic.CONSUMERECODE_MODEL_SETTLEORDER, DataDic.CONSUMERECODE_WAY_BALANCE)) {
//                    state= DataDic.RETURN_STATUS_REMORE;
//                    message="请稍后再试";
//                }
//            }
            
            if (state == DataDic.RETURN_STATUS_NORMAL) {
                BidOrderinfo upBidOrder = new BidOrderinfo();
                upBidOrder.setId(id);
                ///更改为支付状态
                upBidOrder.setSettlestatus(DataDic.BID_SETTLE_PAYED);
                ///是否支付卓币
                if (DataDic.YES.equals(ispayCoin)) {
                    //卓币金额
                    upBidOrder.setIspaycoin(ispayCoin);
                    upBidOrder.setCoinamount(coinAmount);
                    upBidOrder.setWebamount(webAmount);
                } else {
                    upBidOrder.setWebamount(webAmount);
                }
                ///线下支付金额
                Double lineAmount = orderTotal - webAmount - coinAmount;
                lineAmount = PreciseCompute.round(lineAmount, 2);
                upBidOrder.setLineAmount(lineAmount);
                upBidOrder.setIsOnlinePay(isOnlinePay);
                upBidOrder.setIspaycoin(ispayCoin);
                upBidOrder.setIsAccount(isAccount);
                bidOrderinfoService.save(upBidOrder);
                ///如果是线上支付则支付运费
                if (DataDic.YES.equals(isOnlinePay)) {
                   int back= consumeRecodBiz.payBidFerightMoney(id);
                   if(back!=1){
                      if(state==8){
       				      message = "提现金额大于单笔交易最高限额";
       			      }else if(state==10){
       				      message = "电子钱包最低留存额度不足";
       			      }else if(state==11){
       			          message = "提现金额大于单日交易最高限额";
       			      }else if(state==12){
       				      message = "提现金额大于单日累计提现限额";
       			      }else if(state==-1){
       				      message = "账户系统异常";
       			      }else if(back==DataDic.RETURN_STATUS_PAYBUG){
       			    	  message = "等待银行处理";
       			    	  return Tools.getMapResult(state, message, null);
       			      }else if(back==DataDic.RETURN_STATUS_PAYBUG){
       			    	  message = "银行卡信息错误，请收款方核对默认银行卡信息";
       			    	  return Tools.getMapResult(state, message, null);
       			      }
                      upBidOrder.setCoinamount(0.0);
                      upBidOrder.setWebamount(0.0);
                      
                      ///线下支付金额
                      upBidOrder.setLineAmount(0.0);
                      upBidOrder.setIsOnlinePay("0");
                      upBidOrder.setIspaycoin("0");
                      upBidOrder.setIsAccount("0");
                      bidOrderinfoService.save(upBidOrder);
                	  return Tools.getMapResult(state, message, null);
                   }
                }

                Bidinfo upbid = new Bidinfo();
                upbid.setBidstatus(DataDic.BID_STATUS_JYWC);
                upbid.setId(bidOrder.getBidinfo().getId());
                bidinfoService.save(upbid);///修改招标状态为交易完成
                message = "支付成功";
            }

            return Tools.getMapResult(state, message, null);
        }finally{
        	lock.unlock();
        }
    }

    /**
     * 支付运费给竞标用户
     *
     * @param bscJobAccount
     * @param type
     * @return
     */
    @Transactional(readOnly = false)
    public int payBidOrderMoneyBiz(BscJobAccount bscJobAccount ,int type) {
        lock.lock();
        try{
        	int state = DataDic.RETURN_STATUS_NORMAL;
            BidOrderinfo bidOrder = bidOrderinfoService.get(bscJobAccount.getTargetid());
            if (bidOrder == null) {
                return DataDic.RETURN_STATUS_INFOBUG;
            }
            ///结算状态
            String settleStatus = bidOrder.getSettlestatus();
            if (DataDic.BID_SETTLE_PAYED.equals(settleStatus)) {
            	return DataDic.RETURN_STATUS_INFOBUG;
            }
           //处理支付失败
    		if(type==-1){
    			BidOrderinfo upBidOrder = new BidOrderinfo();
    			upBidOrder.setId(bscJobAccount.getTargetid());
                ///更改为支付状态
                upBidOrder.setSettlestatus(DataDic.BID_SETTLE_AGREE);
                upBidOrder.setCoinamount(0.0);
                upBidOrder.setWebamount(0.0);
                
                ///线下支付金额
                upBidOrder.setLineAmount(0.0);
                upBidOrder.setIsOnlinePay("0");
                upBidOrder.setIspaycoin("0");
                upBidOrder.setIsAccount("0");
                bidOrderinfoService.save(upBidOrder);
                return state;
    		}
            
            if (state == DataDic.RETURN_STATUS_NORMAL) {
                
                ///如果是线上支付则支付运费
                if (DataDic.YES.equals(bidOrder.getIsOnlinePay())) {
                   int back= consumeRecodBiz.payBidMoney(bscJobAccount.getTargetid());
                   if(back!=1){
                      
                	   return DataDic.RETURN_STATUS_INFOBUG;
                   }
                }
                BidOrderinfo upBidOrder = new BidOrderinfo();
                upBidOrder.setId(bscJobAccount.getTargetid());
                ///更改为支付状态
                upBidOrder.setSettlestatus(DataDic.BID_SETTLE_PAYED);
                bidOrderinfoService.save(upBidOrder);
                Bidinfo upbid = new Bidinfo();
                upbid.setBidstatus(DataDic.BID_STATUS_JYWC);
                upbid.setId(bidOrder.getBidinfo().getId());
                bidinfoService.save(upbid);///修改招标状态为交易完成
            }

            return state;
        }finally{
        	lock.unlock();
        }
    }
    
    
    /**
     * 统计招标结算金额
     *
     * @param bidOrderinfo
     * @return
     */
    public BidOrderinfo sumBidOrderinfo(BidOrderinfo bidOrderinfo) {
        User user = UserUtils.getUser();

        BidOrderinfo bidOrderinfoAll = new BidOrderinfo();
        bidOrderinfo.setBiddinguser(user);
        bidOrderinfoAll = bidOrderinfoService.sumBidOrderinfo(bidOrderinfo);

        BidOrderinfo neworderinfo = new BidOrderinfo();
        bidOrderinfo.setEndCreateDate(DateUtil.getCurrentDayTimeDate());
        neworderinfo = bidOrderinfoService.sumBidOrderinfo(bidOrderinfo);
        if (bidOrderinfo != null && neworderinfo != null) {
            BigDecimal allTotal = new BigDecimal((bidOrderinfoAll.getSumcontracttotal() != null ? bidOrderinfoAll.getSumcontracttotal() : "0").toString());
            BigDecimal dayTotal = new BigDecimal((neworderinfo.getSumcontracttotal() != null ? neworderinfo.getSumcontracttotal() : "0").toString());
            bidOrderinfo.setSumcontracttotal((allTotal.subtract(dayTotal)).toString());
        } else {
            bidOrderinfo.setSumcontracttotal("0");
        }
        return bidOrderinfo;
    }

    /**
     * 统计已招标结算金额
     *
     * @param bidOrderinfo
     * @return
     */
    public BidOrderinfo sumBidOrderinfoTotalEnd(BidOrderinfo bidOrderinfo) {
        bidOrderinfo.setSetttleSearch(DataDic.BID_SUMTOTAL_END);//已结算
        return sumBidOrderinfo(bidOrderinfo);
    }

    /**
     * 统计未招标结算金额
     *
     * @param bidOrderinfo
     * @return
     */
    public BidOrderinfo sumBidOrderinfoTotalNo(BidOrderinfo bidOrderinfo) {
        bidOrderinfo.setSetttleSearch(DataDic.BID_SUMTOTAL_NO);//未结算
        return sumBidOrderinfo(bidOrderinfo);
    }
    
    /**
	 * 获取当前用户今天的竞标金额 
	 * @param userid
	 * @return
	 */
	public double getContracttotalNum(String userid){
		return bidOrderinfoService.getContracttotalNum(userid);
	}
	
	/**
	 * 获取当前用户今天的竞标待结算金额 
	 * @param userid
	 * @return
	 */
	public double getWeiNum(String userid){
		return bidOrderinfoService.getWeiNum(userid);
	}
	
	/**
	 * 获取当前用户今天的竞标已结算金额 
	 * @param userid
	 * @return
	 */
	public double getYiNum(String userid){
		return bidOrderinfoService.getYiNum(userid);
	}
	
	/**
	 * 获取当前用户今天的待运输总吨数 
	 * @param userid
	 * @return
	 */
	public double getDaiNum(String userid){
		return bidOrderinfoService.getDaiNum(userid);
	}
	
	/**
	 * 获取当前用户今天的已运输总吨数 
	 * @param userid
	 * @return
	 */
	public double getYunNum(String userid){
		return bidOrderinfoService.getYunNum(userid);
	}
}
