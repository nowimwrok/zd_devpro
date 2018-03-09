/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.OrderNumberUtil;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardCommonBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserPurseDao;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscAgreement;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumeaudit;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityAwardrecordService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscAgreementService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumeauditService;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;
import com.thinkgem.jeesite.modules.wlpt.service.consume.DeallogService;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradePayinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserPurseService;

/**
 * 用户交易流水信息表Service
 *
 * @author 饶江龙
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class ConsumeRecodBiz {

    @Autowired
    private ConsumerecodService consumeRecodService;

    @Autowired
    private UserPurseService userPurseService;

    @Autowired
    private OrderinfoService orderinfoService;

    @Autowired
    private BidOrderinfoService bidOrderinfoService;

    @Autowired
    private TradePayinfoService payinfoService;

    @Autowired
    private ConsumeauditService consumeauditService;

    @Autowired
    private DeallogService deallogService;
    
    @Autowired
    private MetroCardCommonBiz metroCardCommonBiz;
    
    @Autowired
    private BiddinginfoService biddinginfoService;
    
    @Autowired
    private AccountBiz accountBiz;
    
    @Autowired
    private UserBiz userBiz;
    
    @Autowired
    private UserPurseDao userPurseDao;
    
    @Autowired
	private UserInsuranceService userInsuranceService;
    
    @Autowired
	private BscAgreementService bscAgreementService;

    @Autowired
    private ActivityAwardrecordService activityAwardrecordService;
    

    private final ReentrantLock lock1=new ReentrantLock();
    private final ReentrantLock lock2=new ReentrantLock();
    private final ReentrantLock lock3=new ReentrantLock();
    private final ReentrantLock lock4=new ReentrantLock();
    private final ReentrantLock lock5=new ReentrantLock();
    private final ReentrantLock lock6=new ReentrantLock();
    private final ReentrantLock lock7=new ReentrantLock();
    private final ReentrantLock lock8=new ReentrantLock();
    private final ReentrantLock lock9=new ReentrantLock();
    private final ReentrantLock lock10=new ReentrantLock();
    private final ReentrantLock lock11=new ReentrantLock();

    public Consumerecod get(String id) {
        return consumeRecodService.get(id);
    }

    /**
     * 积分兑换卓币
     * @param user_id
     * @param integral  积分
     * @param service
     * @return
     */
    @Transactional(readOnly = false)
    public int integralExchange(String user_id,int integral,int integrityRate) {
    	lock11.lock();
         try {
        	 int result = DataDic.RETURN_STATUS_NORMAL;
             User curUser = new User();
             curUser.setId(user_id);
             curUser = UserUtils.findUser(curUser);
             User sysUser = UserUtils.getSysAccount();///系统账户
             //当前用户信息判断
             if (curUser == null || curUser.getUserPurse() == null || integral == 0) {
                 return DataDic.RETURN_STATUS_INFOBUG;
             }
             Userinfo userinfo= curUser.getUserinfo();
             ///当前可用积分
             if (integral > userinfo.getPoint()) {//输入兑换积分大于本身存在的积分，程序返回
                 return DataDic.RETURN_STATUS_MONEYBUG;
             }
             
            double coinNum=integral/integrityRate;
   
            String consumeWay=DataDic.CONSUMERECODE_WAY_INTEGRITY;
             ///id
         	String curUserid = IdGen.uuid();
             ///初始当前用户购买卓币消费金额
             Consumerecod curCode = this.setConsumeRecode(curUser, sysUser, 0.0,0.0, 0.00,
                     DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_ACCOUNTEXCHANGE,
                     consumeWay, DataDic.CONSUMERECODE_MODEL_ACCOUNT,
                     DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
             curCode.setConsumewaydesp("购买卓币" + coinNum + "币,共花费:" + integral + "积分");
             curCode.setPaycode(curCode.getConsumecode());
             curCode.setIsNewRecord(true);
             curCode.setId(curUserid);
             //系统账户
             Consumerecod sysCode = this.setConsumeRecode(sysUser, curUser, coinNum, coinNum, 0.0,
                     DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                     consumeWay, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                     DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
             sysCode.setConsumewaydesp("收到用户" + curUser.getLoginName() + "购买卓币" + coinNum + "币,共花费:" + integral + "积分");
             sysCode.setPaycode(curCode.getConsumecode());
             ///卓币购买记录
             Consumerecod curCoinCode = this.setConsumeRecode(curUser, sysUser, coinNum, coinNum, 0.00,
                     DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_COINRECHARGE,
                     DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_ACCOUNT,
                     DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
             curCoinCode.setConsumewaydesp("充值卓币" + coinNum + "币,共花费:" + integral + "积分");
             curCoinCode.setPaycode(curCode.getConsumecode());
             //系统账户
             Consumerecod sysCoinCode = this.setConsumeRecode(sysUser, curUser,-coinNum,-coinNum, 0.0,
                     DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                     DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                     DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
             sysCoinCode.setConsumewaydesp("向用户" + curUser.getLoginName() + "支付卓币" + coinNum + "币");
             sysCoinCode.setPaycode(curCode.getConsumecode());
	           userPurseService.edidBalanceWebCoin(curUser, 0.0, coinNum, DataDic.COUNT_WAY_PLUS);
	           userPurseService.edidBalanceWebCoin(sysUser, 0.0, coinNum, DataDic.COUNT_WAY_SUB);
             ///当前用户的资金账户流水记录
             //this.save(curCode);
             ///系统用户收到运费交易流水
             this.save(sysCode);
             ///当前用户充值卓币记录
             this.save(curCoinCode);
             /// 支付卓币
             this.save(sysCoinCode);

             //修改账户余额
//             userPurseService.editPureWebBalance(curUser, coinNum, DataDic.COUNT_WAY_PLUS);
//             userPurseService.editPureWebBalance(sysUser, coinNum, DataDic.COUNT_WAY_SUB);
             //扣除积分
//             userinfo.setPoint(userinfo.getPoint()-integral);
//             userinfoservice.save(userinfo);
             return result;
		} finally {
			lock11.unlock();
		}
         
    }
    
    
    
    
    
    /***
     * 保存GPS调用收取服务费用方法
     * @param user_id  用户ID
     * @param consumeMoney 支付金额
     * @param service  调用服务信息（例如：电子围栏服务、最新定位服务、轨迹查询服务）
     * @return
     */
    public int payGPSLocationBiz(String user_id, Double consumeMoney,String service){
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        User sysUser = UserUtils.getSysAccount();///系统账户
        //当前用户信息判断
        if (curUser == null || curUser.getUserPurse() == null || consumeMoney == 0) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///当前可用余额
        Double avaliv = Double.valueOf(curUser.getUserPurse().getAvailablebalance());
        if (consumeMoney > avaliv) {
            return DataDic.RETURN_STATUS_MONEYBUG;
        }
        ///支付定位服务费
        Consumerecod curCode = this.setConsumeRecode(curUser, sysUser, -consumeMoney, -consumeMoney, 0.00,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYGPSLOC,
                DataDic.CONSUMERECODE_WAY_BALANCE, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        curCode.setConsumewaydesp(service+"；支付服务费:" + consumeMoney + "元,共花费:" + consumeMoney + "元");
        curCode.setPaycode(curCode.getConsumecode());
        ///系统账户收到定位服务收费
        Consumerecod sysCode = this.setConsumeRecode(sysUser, curUser, consumeMoney, consumeMoney, 0.00,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETGPSLOC,
                DataDic.CONSUMERECODE_WAY_BALANCE, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_YES);
        sysCode.setConsumewaydesp("收到用户"+curUser.getLoginName()+service+"；收到服务费:" + consumeMoney + "元");
        sysCode.setPaycode(curCode.getConsumecode());
        ///修改账户的保证金金额
        userPurseService.editPureWebBalance(curUser, consumeMoney, DataDic.COUNT_WAY_SUB);
        userPurseService.editPureWebBalance(sysUser, consumeMoney, DataDic.COUNT_WAY_PLUS);

        this.save(curCode);
        this.save(sysCode);

        return result;
    }

    /****
     * 用户调用信息认证接口服务收费接口
     * @param user_id  使用用户ID
     * @param consumeMoney （调用服务总费用）
     * @param service  （调用那些服务：入网验证、车辆信息、道路许可证……）
     * @return
     */
    @Transactional(readOnly = false)
    public int payAuthInfoBiz(String user_id, Double consumeMoney,String service){
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        User sysUser = UserUtils.getSysAccount();///系统账户
        //当前用户信息判断
        if (curUser == null || curUser.getUserPurse() == null || consumeMoney == 0) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///当前可用余额
        Double avaliv = Double.valueOf(curUser.getUserPurse().getAvailablebalance());
        if (consumeMoney > avaliv) {
            return DataDic.RETURN_STATUS_MONEYBUG;
        }
        ///支付信息校验查询服务费
        Consumerecod curCode = this.setConsumeRecode(curUser, sysUser, -consumeMoney, -consumeMoney, 0.00,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYAUTHINFO,
                DataDic.CONSUMERECODE_WAY_BALANCE, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        curCode.setConsumewaydesp(service+"；支付服务费:" + consumeMoney + "元,共花费:" + consumeMoney + "元");
        curCode.setPaycode(curCode.getConsumecode());
        ///系统账户收到信息查询服务费
        Consumerecod sysCode = this.setConsumeRecode(sysUser, curUser, consumeMoney, consumeMoney, 0.00,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETAUTHINFO,
                DataDic.CONSUMERECODE_WAY_BALANCE, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_YES);
        sysCode.setConsumewaydesp("收到用户"+curUser.getLoginName()+service+"；收到服务费:" + consumeMoney + "元");
        sysCode.setPaycode(curCode.getConsumecode());
        ///修改账户的金额
        userPurseService.editPureWebBalance(curUser, consumeMoney, DataDic.COUNT_WAY_SUB);
        userPurseService.editPureWebBalance(sysUser, consumeMoney, DataDic.COUNT_WAY_PLUS);

        this.save(curCode);
        this.save(sysCode);

        return result;
    }


    /***
     * 充值保证金
     *
     * @param user_id      充值用户
     * @param consumeMoney 充值金额
     * @return 1:正常
     */
    /***
     * 充值保证金
     *
     * @param user_id      充值用户
     * @param consumeMoney 充值金额
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int rechargeGueanBiz(String user_id, Double consumeMoney) {
    	lock1.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            User curUser = new User();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);
            //当前用户信息判断
            if (curUser == null || curUser.getUserPurse() == null || consumeMoney == 0) {
                return DataDic.RETURN_STATUS_INFOBUG;
            }
//            if (!IsCommitData(user_id,
//                    DataDic.CONSUMERECODE_TYPE_GUNERECHAGE, DataDic.CONSUMERECODE_MODEL_GUEN, DataDic.CONSUMERECODE_WAY_BALANCE)) {
//                return DataDic.RETURN_STATUS_REMORE;
//            }
            ///当前可用余额
            Double avaliv = Double.valueOf(curUser.getUserPurse().getAvailablebalance());
            if (consumeMoney > avaliv) {
                return DataDic.RETURN_STATUS_MONEYBUG;
            }
            ///充值保证金金额记录
            Consumerecod curCode = this.setConsumeRecode(curUser, curUser, -consumeMoney, -consumeMoney, consumeMoney,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_GUNERECHAGE,
                    DataDic.CONSUMERECODE_WAY_BALANCE, DataDic.CONSUMERECODE_MODEL_GUEN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCode.setConsumewaydesp("充值保证金:" + consumeMoney + "元,共花费:" + consumeMoney + "元");
            curCode.setPaycode(curCode.getConsumecode());
            ///修改账户的保证金金额
            userPurseService.edidGeunWeb(curUser, consumeMoney, DataDic.COUNT_WAY_PLUS);
            this.save(curCode);

            return result;
    	}finally{
    		lock1.unlock();
    	}
    }

    
    
    
    
    
    
    /**
     * 保证金提现提现到账户余额
     *
     * @param user_id
     * @param consumeMoney
     * @return
     */
    @Transactional(readOnly = false)
    public int cashGueanBiz(String user_id, Double consumeMoney) {
    	lock2.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            User curUser = new User();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);
            //当前用户信息判断
            if (curUser == null || curUser.getUserPurse() == null || consumeMoney == 0) {
                return DataDic.RETURN_STATUS_INFOBUG;
            }
//            if (!IsCommitData(user_id,
//                    DataDic.CONSUMERECODE_TYPE_GUNECASH, DataDic.CONSUMERECODE_MODEL_GUEN, DataDic.CONSUMERECODE_WAY_GUEN)) {
//                return DataDic.RETURN_STATUS_REMORE;
//            }
            ///当前可用余额
            Double avaliv = Double.valueOf(curUser.getUserPurse().getAvailablebalance());
            if (consumeMoney > avaliv) {
                return DataDic.RETURN_STATUS_MONEYBUG;
            }
            ///充值保证金金额记录
            Consumerecod curCode = this.setConsumeRecode(curUser, curUser, consumeMoney, consumeMoney, -consumeMoney,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_GUNECASH,
                    DataDic.CONSUMERECODE_WAY_GUEN, DataDic.CONSUMERECODE_MODEL_GUEN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCode.setConsumewaydesp("提现保证金:" + consumeMoney + "元");
            curCode.setPaycode(curCode.getConsumecode());
            ///修改账户的保证金金额
            userPurseService.edidGeunWeb(curUser, consumeMoney, DataDic.COUNT_WAY_SUB);
            this.save(curCode);

            return result;
    	}finally{
    		lock2.unlock();
    	}
    }
    
    /***
     * 保险购买--处理中/冻结中
     *
     * @param user_id     充值用户ID
     * @param money    消费金额
     * @param paytype	    支付方式
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int buyInsurBiz(String insur_id,String user_id, Double money,String paytype,String awardno) {
    	lock11.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
    		if(!Tools.IsNullOrWhiteSpace(paytype)&&"1".equals(paytype)){
    			UserInsurance userInsurance=userInsuranceService.get(insur_id);
                userInsurance.setStatus("1");
                userInsurance.setPayway(paytype);
                userInsurance.setAwardno(awardno);
                userInsuranceService.save(userInsurance);
                return result;
    		}
            User curUser = new User();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);

            String worth = "";
            String describe = "";
            ActivityAwardrecord activityAwardrecord = new ActivityAwardrecord();
            //获取劵
            if(!Tools.IsNullOrWhiteSpace(awardno)){
                activityAwardrecord = activityAwardrecordService.getAwardlistInfoByAwardNo(awardno);
                if(activityAwardrecord!=null && !Tools.IsNullOrWhiteSpace(activityAwardrecord.getWxgift().getGiftworth())) {
                    worth = activityAwardrecord.getWxgift().getGiftworth();//获取礼物价值
                    double worthmoney =  Double.valueOf(worth);
                    money = money - Double.valueOf(worth);//应付金额减去礼物价值为本次话费金额
                    if(money<0){
                        worthmoney = worthmoney + money;
                        money = 0.0;

                    }
                    describe = "；本次使用的优惠劵优惠金额为"+worthmoney;
                }
            }


            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_BALANCE.equals(paytype)){//余额支付
    	        //账户可用余额是否足够
    	        if (curUser.getUserPurse() == null || curUser.getUserPurse().getAvailablebalance() < money) {
    	            return DataDic.RETURN_STATUS_MONEYBUG;
    	        }
            }
            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){//yinhang支付
    	        //账户可用余额是否足够
    	        if (accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE) < money) {
    	            return DataDic.RETURN_STATUS_MONEYBUG;
    	        }
            }
            
            //支付方式--余额
        	String payConsumeType = DataDic.CONSUMERECODE_TYPE_INSURBALANACE;//支付余额
        	String consumeWay = DataDic.CONSUMERECODE_WAY_BALANCE;//消费方式：余额支付
        	String title = "元";
        	if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
        		consumeWay = DataDic.CONSUMERECODE_WAY_ACCOUNT;
        	}
            ///初始当前用户购买bx消费金额
            ///购买保险购买记录
            Consumerecod curCoinCode = this.setConsumeRecode(curUser, curUser, -money, -money, 0.00,
                    DataDic.COUNT_WAY_SUB, 
                    payConsumeType,
                    consumeWay, 
                    DataDic.CONSUMERECODE_MODEL_INSUR,
                    DataDic.CONSUMERECODE_STATUS_FREEZING, DataDic.ISSYSRECODE_NO);
            curCoinCode.setConsumewaydesp("冻结保险:" + money + ",共花费:" + money + title+describe);
            curCoinCode.setPaycode(insur_id);
            curCoinCode.setRemarks(curUser.getLoginName() + "冻结保险费用" + money+describe );
            if(!Tools.IsNullOrWhiteSpace(paytype)&&(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype))){
                //金额等于0
                if(money >0){
                    AccountUtils accountUtils=new AccountUtils();
                    //冻结
                    int back=accountBiz.lockAccount(curUser,money.toString(),DataDic.TRANSFER_LOCK,accountUtils.getTradeSettlementId());
                    if(back!=DataDic.RETURN_STATUS_NORMAL){
                        return back;
                    }
                }

            }else{
            	result = userPurseService.editAvbFreeze(curUser, money, DataDic.COUNT_WAY_SUB);
            }
          ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                throw new RuntimeException("修改账户体系余额失败");
            }
            UserInsurance userInsurance=userInsuranceService.get(insur_id);
            userInsurance.setStatus("1");
            userInsurance.setPayway(consumeWay);
            userInsurance.setAwardno(awardno);
            userInsuranceService.save(userInsurance);
            curCoinCode.setAwardno(awardno);
            consumeRecodService.save(curCoinCode);
            return result;
    	}finally{
    		lock11.unlock();
    	}
    }
    /***
     * 保险购买--处理中/冻结中
     *
     * @param user_id     充值用户ID
     * @param money    消费金额
     * @param paytype	    支付方式
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int tradeBuyInsurBiz(String insur_id,String user_id, Double money,String paytype) {
    	lock11.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            User curUser = new User();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);

            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_BALANCE.equals(paytype)){//余额支付
    	        //账户可用余额是否足够
    	        if (curUser.getUserPurse() == null || curUser.getUserPurse().getAvailablebalance() < money) {
    	            return DataDic.RETURN_STATUS_MONEYBUG;
    	        }
            }
            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){//yinhang支付
    	        //账户可用余额是否足够
    	        if (accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE) < money) {
    	            return DataDic.RETURN_STATUS_MONEYBUG;
    	        }
            }
            
            //支付方式--余额
        	String payConsumeType = DataDic.CONSUMERECODE_TYPE_INSURBALANACE;//支付余额
        	String consumeWay = DataDic.CONSUMERECODE_WAY_BALANCE;//消费方式：余额支付
        	String title = "元";
        	if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
        		consumeWay = DataDic.CONSUMERECODE_WAY_ACCOUNT;
        	}
            ///初始当前用户购买bx消费金额
            ///购买保险购买记录
            Consumerecod curCoinCode = this.setConsumeRecode(curUser, curUser, -money, -money, 0.00,
                    DataDic.COUNT_WAY_SUB, 
                    payConsumeType,
                    consumeWay, 
                    DataDic.CONSUMERECODE_MODEL_INSUR,
                    DataDic.CONSUMERECODE_STATUS_FREEZING, DataDic.ISSYSRECODE_NO);
            curCoinCode.setConsumewaydesp("冻结保险:" + money + ",共花费:" + money + title);
            curCoinCode.setPaycode(insur_id);
            curCoinCode.setRemarks(curUser.getLoginName() + "冻结保险费用" + money );
            if(!Tools.IsNullOrWhiteSpace(paytype)&&(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype))){
            	//冻结
            	AccountUtils accountUtils=new AccountUtils();
            	//获取最新业务结算单号
            	String tradeSettlementId= accountUtils.getTradeSettlementId();

            	curCoinCode.setTradeSettlementId(tradeSettlementId);
            	
            	int back=accountBiz.lockAccount(curUser,money.toString(),DataDic.TRANSFER_LOCK,tradeSettlementId);
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }else{
            	result = userPurseService.editAvbFreeze(curUser, money, DataDic.COUNT_WAY_SUB);
            }
          ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                throw new RuntimeException("修改账户体系余额失败");
            }
            
            consumeRecodService.save(curCoinCode);
            return result;
    	}finally{
    		lock11.unlock();
    	}
    }
    /***
     * 受理保险业务--轮询
     * 
     * @param id
     * @param type
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int editInsurinfoBiz(String id ,int type){
    	int result = DataDic.RETURN_STATUS_NORMAL;
    	if(Tools.IsNullOrWhiteSpace(id)){
    		return DataDic.RETURN_STATUS_INFOBUG;
    	}
    	UserInsurance oldInsurance=userInsuranceService.get(id);
    	
    	if(oldInsurance==null){
    		return DataDic.RETURN_STATUS_INFOBUG;
    	}
    	
    	User curUser = new User();
        curUser.setId(oldInsurance.getUser().getId());
        curUser = UserUtils.findUser(curUser);
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(oldInsurance.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        Double money=Double.parseDouble(oldInsurance.getInsurancefeel());
    	if(type==2){
    		User sysUser = UserUtils.getSysAccount();
    		Consumerecod accountCode = this.setConsumeFrezRecode(curUser, sysUser, -money, 0.00, -money,
                        DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_INSURBALANACE,
                        consumeWay, DataDic.CONSUMERECODE_MODEL_INSUR,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            ///买家账户流水描述
            accountCode.setConsumewaydesp("保单号:" + oldInsurance.getInsuranceNO() + ";" + curUser.getLoginName() + "支付保险费用" + money + "元");
            accountCode.setRemarks(curUser.getLoginName() + "支付保险费用" + money + ";保单号:" + oldInsurance.getInsuranceNO());
            accountCode.setPaycode(accountCode.getConsumecode());
            
            ///托运方支付余付款:帐户余额不变、冻结资金变动
             Consumerecod sellerCode = this.setConsumeRecode(sysUser, curUser, money, money, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_INSUR,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            ///支付付款账户流水描述
            sellerCode.setConsumewaydesp("保单号:" + oldInsurance.getInsuranceNO() + " 收到" + curUser.getLoginName() + "保险费用:" + money + "元");
            sellerCode.setRemarks("收到" + curUser.getLoginName() + "保险费用" + money + ";保单号:" + oldInsurance.getInsuranceNO());
            sellerCode.setPaycode(sellerCode.getConsumecode());
           
            oldInsurance.setIspaystatus(DataDic.ORDER_APPLY_PAY);
            oldInsurance.setStatus("2");
            userInsuranceService.save(oldInsurance);
            consumeRecodService.save(sellerCode);
            consumeRecodService.save(accountCode);
            
    	}else{
    		Consumerecod consumerecod = new Consumerecod();
            consumerecod = this.setConsumeRecode(curUser, curUser, money, money, -money,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_REINSURBALANACE,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_INSUR,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            consumerecod.setConsumewaydesp("收到保险费用解冻" + money + "元");
            consumerecod.setRemarks("退还用户" + curUser.getLoginName() + "保险费用" + money + "元");
            ///修改卖家用户数据账户余额与可用余额增加;冻结余额减少
            if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(oldInsurance.getPayway())){
            	//解冻
            	AccountUtils accountUtils=new AccountUtils();
            	//获取最新业务结算单号
            	String tradeSettlementId= accountUtils.getTradeSettlementId();

            	consumerecod.setTradeSettlementId(tradeSettlementId);
            	int back=accountBiz.lockAccount(curUser,money.toString(),DataDic.TRANSFER_UNLOCK,tradeSettlementId);
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }
            oldInsurance.setStatus("3");
            userInsuranceService.save(oldInsurance);
            consumeRecodService.save(consumerecod);
    	}
    	return result;
    	
    }


    /***
     * 后台受理保险业务
     * 
     * @param userInsurance
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int editInsurBiz(UserInsurance userInsurance){
    	int result = DataDic.RETURN_STATUS_NORMAL;
    	if(Tools.IsNullOrWhiteSpace(userInsurance.getId())||Tools.IsNullOrWhiteSpace(userInsurance.getInsuranceNO())
    			||Tools.IsNullOrWhiteSpace(userInsurance.getVoucherimg())||Tools.IsNullOrWhiteSpace(userInsurance.getStatus())){
    		return DataDic.RETURN_STATUS_INFOBUG;
    	}
    	String curstatus=userInsurance.getStatus();
    	UserInsurance oldInsurance=userInsuranceService.get(userInsurance.getId());

    	if(!"1".equals(oldInsurance.getStatus())){
    		return DataDic.RETURN_STATUS_AUTHBUG;
    	}

        oldInsurance.setUnderwriting(userInsurance.getUnderwriting());
        oldInsurance.setVoucher(userInsurance.getVoucher());
        oldInsurance.setAgent(userInsurance.getAgent());
        oldInsurance.setSerialNumber(userInsurance.getSerialNumber());
        oldInsurance.setBelongs(userInsurance.getBelongs());
        oldInsurance.setMainHang(userInsurance.getMainHang());
        oldInsurance.setChargeTime(userInsurance.getChargeTime());
        oldInsurance.setInsuredTime(userInsurance.getInsuredTime());
        oldInsurance.setStartTime(userInsurance.getStartTime());
        oldInsurance.setEndTime(userInsurance.getEndTime());
        oldInsurance.setJqxstartTime(userInsurance.getJqxstartTime());
        oldInsurance.setJqxendTime(userInsurance.getJqxendTime());
        oldInsurance.setClaimsRecords(userInsurance.getClaimsRecords());

    	//线下支付
    	if("1".equals(oldInsurance.getPayway())){
    		if("2".equals(curstatus)){
    			oldInsurance.setStatus("2");
                oldInsurance.setInsuranceNO(userInsurance.getInsuranceNO());
                oldInsurance.setVoucherimg(userInsurance.getVoucherimg());
    		}else if("3".equals(curstatus)){
    			oldInsurance.setStatus("3");
                
    		}
    		userInsuranceService.save(oldInsurance);
    		return result;
    	}
    	User curUser = new User();
        curUser.setId(oldInsurance.getUser().getId());
        curUser = UserUtils.findUser(curUser);
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(oldInsurance.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        Double money=Double.parseDouble(oldInsurance.getInsurancefeel());
        Double coinNum = Double.parseDouble(oldInsurance.getInsurancefeel());
        String worth = "";
        String describe = "";
        String awardno =oldInsurance.getAwardno();
        ActivityAwardrecord activityAwardrecord = new ActivityAwardrecord();
        //获取劵
        if(!Tools.IsNullOrWhiteSpace(awardno)){
            activityAwardrecord = activityAwardrecordService.getAwardlistInfoByAwardNo(awardno);
            if(activityAwardrecord!=null && !Tools.IsNullOrWhiteSpace(activityAwardrecord.getWxgift().getGiftworth())) {
                worth = activityAwardrecord.getWxgift().getGiftworth();//获取礼物价值
                double worthmoney =  Double.valueOf(worth);
                coinNum = coinNum - Double.valueOf(worth);//应付金额减去礼物价值为本次话费金额
                if(coinNum<0){
                    worthmoney = worthmoney + coinNum;
                    coinNum = 0.0;

                }
                describe = "；本次使用的优惠劵优惠金额为"+worthmoney;
            }
        }



    	if("2".equals(curstatus)){
    		User sysUser = UserUtils.getSysAccount();
    		Consumerecod accountCode = this.setConsumeFrezRecode(curUser, sysUser, -coinNum, 0.00, -coinNum,
                        DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_INSURBALANACE,
                        consumeWay, DataDic.CONSUMERECODE_MODEL_INSUR,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            ///买家账户流水描述
            accountCode.setConsumewaydesp("保单号:" + userInsurance.getInsuranceNO() + ";" + curUser.getLoginName() + "支付保险费用" + coinNum + "元"+describe);
            accountCode.setRemarks(curUser.getLoginName() + "支付保险费用" + coinNum + ";保单号:" + userInsurance.getInsuranceNO()+describe);
            accountCode.setPaycode(accountCode.getConsumecode());
           
            ///托运方支付余付款:帐户余额不变、冻结资金变动
             Consumerecod sellerCode = this.setConsumeRecode(sysUser, curUser, coinNum, coinNum, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_INSUR,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            ///支付付款账户流水描述
            sellerCode.setConsumewaydesp("保单号:" + userInsurance.getInsuranceNO() + " 收到" + curUser.getLoginName() + "保险费用:" + coinNum + "元"+describe);
            sellerCode.setRemarks("收到" + curUser.getLoginName() + "保险费用" + coinNum + ";保单号:" + userInsurance.getInsuranceNO()+describe);
            sellerCode.setPaycode(sellerCode.getConsumecode());

            oldInsurance.setInsuranceNO(userInsurance.getInsuranceNO());
            oldInsurance.setVoucherimg(userInsurance.getVoucherimg());


            if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(oldInsurance.getPayway())){
            	AccountUtils accountUtils=new AccountUtils();
                //获取最新业务结算单号
            	String tradeSettlementId= accountUtils.getTradeSettlementId();
            	accountCode.setTradeSettlementId(tradeSettlementId);
            	sellerCode.setTradeSettlementId(tradeSettlementId);
            	
            	int back=accountBiz.freezeBalanceTransfer(curUser,sysUser,coinNum.toString(),DataDic.TRANSFER_OUTER,userInsurance.getId(),DataDic.CONSUMERECODE_MODEL_INSUR,tradeSettlementId,DataDic.YES);
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		//如果返回的状态为银行处理中
            		if(back!=DataDic.RETURN_STATUS_PAYBUG){
            			oldInsurance.setIspaystatus(DataDic.ORDER_APPLY_PAYIN);
                		oldInsurance.setStatus("2");

                        userInsuranceService.save(oldInsurance);
            		}
            		return back;
            	}
            }else{
            	///变动账户体系中的平台总余额
                result = userPurseService.editPureWebBalance(sysUser, coinNum, DataDic.COUNT_WAY_PLUS);
                ///如果保存信息异常
                if (DataDic.RETURN_STATUS_NORMAL != result) {
                    return result;
                }
                result = userPurseService.editFreeze(curUser, coinNum, DataDic.COUNT_WAY_SUB);
                ///如果保存信息异常
                if (DataDic.RETURN_STATUS_NORMAL != result) {
                    return result;
                }
            }
            oldInsurance.setIspaystatus(DataDic.ORDER_APPLY_PAY);
            oldInsurance.setStatus("2");

            userInsuranceService.save(oldInsurance);
            consumeRecodService.save(sellerCode);
            consumeRecodService.save(accountCode);
            
    	}else if("3".equals(curstatus)){
    		Consumerecod consumerecod = new Consumerecod();
            consumerecod = this.setConsumeRecode(curUser, curUser, coinNum, coinNum, -coinNum,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_REINSURBALANACE,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_INSUR,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            consumerecod.setConsumewaydesp("收到保险费用解冻" + coinNum + "元");
            consumerecod.setRemarks("退还用户" + curUser.getLoginName() + "保险费用" + coinNum + "元");
            ///修改卖家用户数据账户余额与可用余额增加;冻结余额减少
            if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(oldInsurance.getPayway())){
            	AccountUtils accountUtils=new AccountUtils();
                //获取最新业务结算单号
            	String tradeSettlementId= accountUtils.getTradeSettlementId();

            	consumerecod.setTradeSettlementId(tradeSettlementId);
            	//解冻
            	int back=accountBiz.lockAccount(curUser,coinNum.toString(),DataDic.TRANSFER_UNLOCK,tradeSettlementId);
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }else{
            	result = userPurseService.editAvbFreeze(curUser, coinNum, DataDic.COUNT_WAY_PLUS);
            	if (DataDic.RETURN_STATUS_NORMAL != result) {
                    return result;
                }
            }
            oldInsurance.setStatus("3");
            userInsuranceService.save(oldInsurance);
            consumeRecodService.save(consumerecod);
    	}else{
    		return DataDic.RETURN_STATUS_AUTHBUG;
    	}
    	return result;
    	
    }
    
    /***
     * 账户油气购买
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @param coinNum     卓币金额
     * @param paytype	    支付方式
     * @param awardno	    活动编号
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int rechargePetroBiz(String user_id, Double petrolMoney, Double coinNum,String paytype,String awardno) {
    	lock3.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            User curUser = new User();
            User sysUser = UserUtils.getSysAccount();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);

            String worth = "";
            String describe = "";
            ActivityAwardrecord activityAwardrecord = new ActivityAwardrecord();
            //获取劵
            if(!Tools.IsNullOrWhiteSpace(awardno)){
                activityAwardrecord = activityAwardrecordService.getAwardlistInfoByAwardNo(awardno);
                if(activityAwardrecord!=null && !Tools.IsNullOrWhiteSpace(activityAwardrecord.getWxgift().getGiftworth())) {
                    worth = activityAwardrecord.getWxgift().getGiftworth();//获取礼物价值
                    double worthmoney =  Double.valueOf(worth);
                    coinNum = coinNum - Double.valueOf(worth);//应付金额减去礼物价值为本次话费金额
                    if(coinNum<0){
                        worthmoney = worthmoney + coinNum;
                        coinNum = 0.0;

                    }
                    describe = "；本次使用的优惠劵优惠金额为"+worthmoney;
                }
            }

            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_COIN.equals(paytype)){//卓币支付
    	        //账户可用卓币余额是否足够
    	        if (curUser.getUserPurse() == null || curUser.getUserPurse().getAvailablecoin() < coinNum) {
    	            return DataDic.RETURN_STATUS_MONEYBUG;
    	        }
            }
            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_BALANCE.equals(paytype)){//余额支付
    	        //账户可用余额是否足够
    	        if (curUser.getUserPurse() == null || curUser.getUserPurse().getAvailablebalance() < coinNum) {
    	            return DataDic.RETURN_STATUS_MONEYBUG;
    	        }
            }
            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){//yinhang支付
    	        //账户可用余额是否足够
    	        if (accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE) < coinNum) {
    	            return DataDic.RETURN_STATUS_MONEYBUG;
    	        }
            }
            
            //支付方式--余额
            String getConsumeType = DataDic.CONSUMERECODE_TYPE_GETCONSUME;//收到余额消费
        	String payConsumeType = DataDic.CONSUMERECODE_TYPE_PETROLBALANACE;//支付余额
        	String consumeWay = DataDic.CONSUMERECODE_WAY_BALANCE;//消费方式：余额支付
        	String title = "元";
        	String typename = "余额";
        	if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
        		consumeWay = DataDic.CONSUMERECODE_WAY_ACCOUNT;
        	}
            //支付方式--卓币
            if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_COIN.equals(paytype)){//卓币支付
            	getConsumeType = DataDic.CONSUMERECODE_TYPE_GETCOINCONSUME;//收到卓币消费
            	payConsumeType = DataDic.CONSUMERECODE_TYPE_COINBUYPETROL;//这边支付
            	consumeWay = DataDic.CONSUMERECODE_WAY_COIN;//消费方式：卓币支付
            	title = "币";
            	typename = "卓币";
            }
            
//            if (!IsCommitData(user_id,
//            		payConsumeType, DataDic.CONSUMERECODE_MODEL_PETROL, paytype)) {
//                return DataDic.RETURN_STATUS_REMORE;
//            }
            ///初始当前用户购买油气消费金额
            ///购买油气购买记录
            Consumerecod curCoinCode = this.setConsumeRecode(curUser, sysUser, -coinNum, -coinNum, 0.00,
                    DataDic.COUNT_WAY_SUB, 
                    payConsumeType,
                    consumeWay, 
                    DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCoinCode.setConsumewaydesp("购买油气:" + petrolMoney + ",共花费:" + coinNum + title + describe);
            curCoinCode.setPaycode(curCoinCode.getConsumecode());
            ///系统账户
            Consumerecod sysCoinCode = this.setConsumeRecode(sysUser, curUser, coinNum, coinNum, 0.0,
                    DataDic.COUNT_WAY_PLUS, 
                    getConsumeType,
                    consumeWay,
                    DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysCoinCode.setConsumewaydesp("收到用户:" + curUser.getLoginName() + "购买油气" + petrolMoney + "支付"+typename + coinNum + title  + describe);
            sysCoinCode.setPaycode(curCoinCode.getConsumecode());
            ////油气记录
            Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, petrolMoney, 0.00, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_PETROLRECHARGE,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curPetrolCode.setConsumewaydesp("成功购买油气:" + petrolMoney + "元" + describe);
            curPetrolCode.setPaycode(curCoinCode.getConsumecode());
            ///系统账户油气记录
            Consumerecod sysPetrolCode = this.setConsumeRecode(sysUser, curUser, -petrolMoney, 0.00, 0.0,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYPETROLRECHARGE,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysPetrolCode.setConsumewaydesp("向用户:" + curUser.getLoginName() + "支付购买油气" + petrolMoney + "元" + describe);
            sysPetrolCode.setPaycode(curCoinCode.getConsumecode());

            Map<String, Object> map = metroCardCommonBiz.metroCardRecharge(curUser, petrolMoney);
            if (map != null) {
                String state = map.get("state").toString();
                if (state != null && Integer.parseInt(state) == DataDic.RETURN_STATUS_NORMAL) {
                	//支付方式--卓币
                    if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_COIN.equals(paytype)){//卓币支付
    	                /*userPurseService.edidPetrolWebCoin(curUser, petrolMoney, coinNum, DataDic.COUNT_WAY_PLUS);
    	                userPurseService.edidPetrolWebCoin(sysUser, petrolMoney, coinNum, DataDic.COUNT_WAY_SUB);*/
    	                userPurseService.edidPetrolWebCoin2(curUser, sysUser, petrolMoney, coinNum);
                    }else if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
                    	int back=userPurseService.edidPetrolWebBalance(curUser,sysUser, petrolMoney, coinNum,DataDic.CONSUMERECODE_WAY_ACCOUNT);
                    	if(back!=1){
                        	return back;
                        }
                    }else{
    	                userPurseService.edidPetrolWebBalance(curUser,sysUser, petrolMoney, coinNum,DataDic.CONSUMERECODE_WAY_BALANCE);
                    }
                    curCoinCode.setAwardno(awardno);
                    ///当前用户充值卓币记录
                    this.save(curCoinCode);

                    sysCoinCode.setAwardno(awardno);
                    /// 系统卓币
                    this.save(sysCoinCode);

                    curPetrolCode.setAwardno(awardno);
                    ///当前用户充值油气记录
                    this.save(curPetrolCode);

                    sysPetrolCode.setAwardno(awardno);
                    /// 系统油气
                    this.save(sysPetrolCode);
                } else {
                    result = -10;
                }
            }
            return result;
    	}finally{
    		lock3.unlock();
    	}
    }
    
    /***
     * 账户油气兑换余额
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @param coinNum     卓币金额
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int exchangePetroBiz(String user_id, Double petrolMoney, Double coinNum) {
    	lock4.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            User curUser = new User();
            User sysUser = UserUtils.getSysAccount();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);
            if (curUser.getUserPurse() == null || curUser.getUserPurse().getPetrolbalance() < petrolMoney) {
                return DataDic.RETURN_STATUS_MONEYBUG;
            }
//            if (!IsCommitData(user_id,
//            		DataDic.CONSUMERECODE_TYPE_PETROLBALANACE, DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL)) {
//                return DataDic.RETURN_STATUS_REMORE;
//            }
            ///初始当前用户购买油气消费金额
            ///油气兑换余额记录
            Consumerecod curCoinCode = this.setConsumeRecode(curUser, sysUser, -coinNum, -coinNum, 0.00,
                    DataDic.COUNT_WAY_SUB, 
                    DataDic.CONSUMERECODE_TYPE_PETROLEXCHANGE,
                    DataDic.CONSUMERECODE_WAY_PETROL, 
                    DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCoinCode.setConsumewaydesp("兑换余额:" + petrolMoney + "元,共花费:" + coinNum + "油气");
            curCoinCode.setPaycode(curCoinCode.getConsumecode());
            ///系统账户
            Consumerecod sysCoinCode = this.setConsumeRecode(sysUser, curUser, coinNum, coinNum, 0.0,
                    DataDic.COUNT_WAY_PLUS, 
                    DataDic.CONSUMERECODE_TYPE_RECEIVEDPETROLEXCHANGE,
                    DataDic.CONSUMERECODE_WAY_PETROL,
                    DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysCoinCode.setConsumewaydesp("收到用户:" + curUser.getLoginName() + "兑换余额" + petrolMoney + "支付"+"" + coinNum + "油气");
            sysCoinCode.setPaycode(curCoinCode.getConsumecode());
            ////余额记录
            Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, petrolMoney, 0.00, 0.00,
                    DataDic.COUNT_WAY_PLUS,
                    DataDic.CONSUMERECODE_TYPE_RECEIVEDEXCHANGE,
                    DataDic.CONSUMERECODE_WAY_BALANCE, 
                    DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curPetrolCode.setConsumewaydesp("成功兑换余额:" + petrolMoney + "元");
            curPetrolCode.setPaycode(curCoinCode.getConsumecode());
            ///系统账户余额记录
            Consumerecod sysPetrolCode = this.setConsumeRecode(sysUser, curUser, -petrolMoney, 0.00, 0.0,
                    DataDic.COUNT_WAY_SUB, 
                    DataDic.CONSUMERECODE_TYPE_ACCOUNTEXCHANGE,
                    DataDic.CONSUMERECODE_WAY_BALANCE,
                    DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysPetrolCode.setConsumewaydesp("向用户:" + curUser.getLoginName() + "支付兑换余额" + petrolMoney + "元");
            sysPetrolCode.setPaycode(curCoinCode.getConsumecode());

            
            userPurseService.edidPetrolWebBalance(curUser, petrolMoney, coinNum, DataDic.COUNT_WAY_SUB);//减少油气，增加余额
            userPurseService.edidPetrolWebBalance(sysUser, petrolMoney, coinNum, DataDic.COUNT_WAY_PLUS);//减少余额，增加油气
            
            ///当前用户充值卓币记录
            this.save(curCoinCode);
            /// 系统卓币
            this.save(sysCoinCode);
            ///当前用户充值油气记录
            this.save(curPetrolCode);
            /// 系统油气
            this.save(sysPetrolCode);
            return result;
    	}finally{
    		lock4.unlock();
    	}
    }
    
    
    /***
     * 收到油气消费
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @return 1:正常2:信息已存在
     */
    @Transactional(readOnly = false)
    public int receivedPetroBiz(String user_id, Double petrolMoney) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        User sysUser = UserUtils.getSysAccount();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        
        if (curUser != null) {                                                                                                 
            
        	///系统账户油气记录
            Consumerecod sysPetrolCode = this.setConsumeRecode(sysUser, curUser, -petrolMoney, 0.00, 0.0,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_GETPETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysPetrolCode.setConsumewaydesp("向用户:" + curUser.getLoginName() + "转入一卡通消费油气" + petrolMoney + "元");
            sysPetrolCode.setPaycode(sysPetrolCode.getConsumecode());
        	
            ////油气记录
            Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, petrolMoney, 0.00, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_PETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curPetrolCode.setConsumewaydesp("收到一卡通消费油气:" + petrolMoney + "元");
            curPetrolCode.setPaycode(curPetrolCode.getConsumecode());
            
            User suser = new User();
            suser.setId(sysUser.getId());
            User cuser = new User();
            cuser.setId(curUser.getId());
            userPurseService.consumePetrol(suser, petrolMoney, DataDic.COUNT_WAY_SUB);
            userPurseService.consumePetrol(cuser, petrolMoney, DataDic.COUNT_WAY_PLUS);

            curPetrolCode.setCreateBy(sysUser);
            curPetrolCode.setUpdateBy(sysUser);
            sysPetrolCode.setCreateBy(sysUser);
            sysPetrolCode.setUpdateBy(sysUser);
            curPetrolCode.setCreateDate(new Date());
            curPetrolCode.setUpdateDate(new Date());
            sysPetrolCode.setCreateDate(new Date());
            sysPetrolCode.setUpdateDate(new Date());
            curPetrolCode.setId(IdGen.uuid());
            sysPetrolCode.setId(IdGen.uuid());

            ///当前用户消费油气记录
            consumeRecodService.insertSave(curPetrolCode);
            /// 系统油气
            consumeRecodService.insertSave(sysPetrolCode);
        } else {
            return DataDic.RETURN_STATUS_INFOBUG;
        }

        return result;

    }

    /***
     * 收到油气消费
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @return 1:正常2:信息已存在
     */
    @Transactional(readOnly = false)
    public int receivedPetroinfo(String user_id, Double petrolMoney) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        User sysUser = UserUtils.getSysAccount();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        
        if (curUser != null && curUser.getUserPurse()!=null) {                                                                                                 
        	 User upUser = UserUtils.findUser(sysUser);
             if (upUser == null || upUser.getUserPurse() == null) {
                 return DataDic.RETURN_STATUS_INFOBUG;
             }
             
        	///系统账户油气记录
            Consumerecod sysPetrolCode = this.setConsumeRecode(sysUser, curUser, -petrolMoney, 0.00, 0.0,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_GETPETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysPetrolCode.setConsumewaydesp("向用户:" + curUser.getLoginName() + "转入一卡通消费油气" + petrolMoney + "元");
            sysPetrolCode.setPaycode(sysPetrolCode.getConsumecode());
        	
            ////油气记录
            Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, petrolMoney, 0.00, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_PETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curPetrolCode.setConsumewaydesp("收到一卡通消费油气:" + petrolMoney + "元");
            curPetrolCode.setPaycode(curPetrolCode.getConsumecode());
            
/*
            userPurseService.consumePetrol(sysUser, petrolMoney, DataDic.COUNT_WAY_SUB);
            
            userPurseService.consumePetrol(curUser, petrolMoney, DataDic.COUNT_WAY_PLUS);*/
            
           
            	
            ///更新前的平台系統账号油气余额
            Double old_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
            ///计算后的油气余额
            Double up_WebPetrol = 0.00;
            up_WebPetrol = PreciseCompute.sub(old_WebPetrol, petrolMoney);
            up_WebPetrol = PreciseCompute.round(up_WebPetrol, 2);
            UserPurse upUserPurse = userPurseService.get(upUser.getUserPurse());
            upUserPurse.setPetrolbalance(up_WebPetrol);
            userPurseDao.update(upUserPurse);//更新系统账号油气
            
            //更新平台用户账号油气余额
            Double curold_WebPetrol = Double.valueOf(curUser.getUserPurse().getPetrolbalance() != null ? curUser.getUserPurse().getPetrolbalance() : 0.00);
            ///计算后的油气余额
            Double cur_WebPetrol = 0.00;
            cur_WebPetrol = PreciseCompute.add(curold_WebPetrol, petrolMoney);
            cur_WebPetrol = PreciseCompute.round(cur_WebPetrol, 2);
            UserPurse curUserPurse = userPurseService.get(curUser.getUserPurse());
            curUserPurse.setPetrolbalance(cur_WebPetrol);
            userPurseDao.update(curUserPurse);//更新用户账号油气
            
 

            curPetrolCode.setCreateBy(sysUser);
            curPetrolCode.setUpdateBy(sysUser);
            sysPetrolCode.setCreateBy(sysUser);
            sysPetrolCode.setUpdateBy(sysUser);
            curPetrolCode.setCreateDate(new Date());
            curPetrolCode.setUpdateDate(new Date());
            sysPetrolCode.setCreateDate(new Date());
            sysPetrolCode.setUpdateDate(new Date());
            curPetrolCode.setId(IdGen.uuid());
            sysPetrolCode.setId(IdGen.uuid());

            ///当前用户消费油气记录
            consumeRecodService.insertSave(curPetrolCode);
            /// 系统油气
            consumeRecodService.insertSave(sysPetrolCode);
        } else {
            return DataDic.RETURN_STATUS_INFOBUG;
        }

        return result;

    }

    
    
    /***
     * 账户油气消费
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @param guid        油气刷卡唯一标识
     * @param consumeDate   交易时间
     * @return 1:正常2:信息已存在
     */
    @Transactional(readOnly = false)
    public int consumePetroinfo(String user_id, Double petrolMoney, String guid, Date consumeDate) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        User sysUser = UserUtils.getSysAccount();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        Consumerecod videCode = new Consumerecod();
        videCode.setPaycode(guid);
        List<Consumerecod> varList = findList(videCode);
        if (varList.size() > 0) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        if (curUser != null && curUser.getUserPurse()!=null) {                                                                                                 
          	 User upUser = UserUtils.findUser(sysUser);
               if (upUser == null || upUser.getUserPurse() == null) {
                   return DataDic.RETURN_STATUS_INFOBUG;
               }
        	if (!IsCommitData(user_id,
            		DataDic.CONSUMERECODE_TYPE_PETROLCONSUME, DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_WAY_PETROL)) {
                return DataDic.RETURN_STATUS_REMORE;
            }
            ////油气记录
            Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, -petrolMoney, 0.00, 0.00,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curPetrolCode.setConsumewaydesp("成功消费油气:" + petrolMoney + "元");
            curPetrolCode.setPaycode(guid);
            ///系统账户油气记录
            Consumerecod sysPetrolCode = this.setConsumeRecode(sysUser, curUser, petrolMoney, 0.00, 0.0,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETPETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysPetrolCode.setConsumewaydesp("收到用户:" + curUser.getLoginName() + "消费油气" + petrolMoney + "元");
            sysPetrolCode.setPaycode(guid);

            /*userPurseService.consumePetrol(curUser, petrolMoney, DataDic.COUNT_WAY_SUB);
            userPurseService.consumePetrol(sysUser, petrolMoney, DataDic.COUNT_WAY_PLUS);*/
            
          ///更新前的平台系統账号油气余额
            Double old_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
            ///计算后的油气余额
            Double up_WebPetrol = 0.00;
            up_WebPetrol = PreciseCompute.add(old_WebPetrol, petrolMoney);
            up_WebPetrol = PreciseCompute.round(up_WebPetrol, 2);
            UserPurse upUserPurse = userPurseService.get(upUser.getUserPurse());
            upUserPurse.setPetrolbalance(up_WebPetrol);
            userPurseDao.update(upUserPurse);//更新系统账号油气
            
            //更新平台用户账号油气余额
            Double curold_WebPetrol = Double.valueOf(curUser.getUserPurse().getPetrolbalance() != null ? curUser.getUserPurse().getPetrolbalance() : 0.00);
            ///计算后的油气余额
            Double cur_WebPetrol = 0.00;
            cur_WebPetrol = PreciseCompute.sub(curold_WebPetrol, petrolMoney);
            cur_WebPetrol = PreciseCompute.round(cur_WebPetrol, 2);
            UserPurse curUserPurse = userPurseService.get(curUser.getUserPurse());
            curUserPurse.setPetrolbalance(cur_WebPetrol);
            userPurseDao.update(curUserPurse);//更新用户账号油气

            curPetrolCode.setCreateBy(curUser);
            curPetrolCode.setUpdateBy(curUser);
            sysPetrolCode.setCreateBy(curUser);
            sysPetrolCode.setUpdateBy(curUser);
            curPetrolCode.setCreateDate(consumeDate);
            curPetrolCode.setUpdateDate(consumeDate);
            sysPetrolCode.setCreateDate(consumeDate);
            sysPetrolCode.setUpdateDate(consumeDate);
            curPetrolCode.setId(IdGen.uuid());
            sysPetrolCode.setId(IdGen.uuid());

            ///当前用户消费油气记录
            consumeRecodService.insertSave(curPetrolCode);
            /// 系统油气
            consumeRecodService.insertSave(sysPetrolCode);
        } else {
            return DataDic.RETURN_STATUS_INFOBUG;
        }

        return result;

    }

    
    /***
     * 账户油气消费
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @param guid        油气刷卡唯一标识
     * @param consumeDate   交易时间
     * @return 1:正常2:信息已存在
     */
    @Transactional(readOnly = false)
    public int addPOSPetroInfo(String user_id, Double petrolMoney, String guid, Date consumeDate,String posnum) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        User sysUser = UserUtils.getSysAccount();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        Consumerecod videCode = new Consumerecod();
        videCode.setPaycode(guid);
        List<Consumerecod> varList = findList(videCode);
        if (varList.size() > 0) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        if (curUser != null && curUser.getUserPurse()!=null) {                                                                                                 
          	 User upUser = UserUtils.findUser(sysUser);
               if (upUser == null || upUser.getUserPurse() == null) {
                   return DataDic.RETURN_STATUS_INFOBUG;
               }
        	if (!IsCommitData(user_id,
            		DataDic.CONSUMERECODE_TYPE_PETROLRECHARGEPOS, DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_WAY_PETROL)) {
                return DataDic.RETURN_STATUS_REMORE;
            }
            ////油气记录
            Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, petrolMoney, 0.00, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_PETROLRECHARGEPOS,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curPetrolCode.setConsumewaydesp("成功通过POS机号为："+posnum+",充值油气:" + petrolMoney + "元");
            curPetrolCode.setPaycode(guid);
           
            
            //更新平台用户账号油气余额
            Double curold_WebPetrol = Double.valueOf(curUser.getUserPurse().getPetrolbalance() != null ? curUser.getUserPurse().getPetrolbalance() : 0.00);
            ///计算后的油气余额
            Double cur_WebPetrol = 0.00;
            cur_WebPetrol = PreciseCompute.add(curold_WebPetrol, petrolMoney);
            cur_WebPetrol = PreciseCompute.round(cur_WebPetrol, 2);
            UserPurse curUserPurse = userPurseService.get(curUser.getUserPurse());
            curUserPurse.setPetrolbalance(cur_WebPetrol);
            userPurseDao.update(curUserPurse);//更新用户账号油气

            curPetrolCode.setCreateBy(curUser);
            curPetrolCode.setUpdateBy(curUser);
            curPetrolCode.setCreateDate(consumeDate);
            curPetrolCode.setUpdateDate(consumeDate);
            curPetrolCode.setId(IdGen.uuid());

            ///当前用户消费油气记录
            consumeRecodService.insertSave(curPetrolCode);
        } else {
            return DataDic.RETURN_STATUS_INFOBUG;
        }

        return result;

    }
    
    /***
     * 账户油气消费
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @param guid        油气刷卡唯一标识
     * @param consumeDate   交易时间
     * @return 1:正常2:信息已存在
     */
    @Transactional(readOnly = false)
    public int consumePetroBiz(String user_id, Double petrolMoney, String guid, Date consumeDate) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        User sysUser = UserUtils.getSysAccount();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        Consumerecod videCode = new Consumerecod();
        videCode.setPaycode(guid);
        List<Consumerecod> varList = findList(videCode);
        if (varList.size() > 0) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        if (curUser != null) {
        	if (!IsCommitData(user_id,
            		DataDic.CONSUMERECODE_TYPE_PETROLCONSUME, DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_WAY_PETROL)) {
                return DataDic.RETURN_STATUS_REMORE;
            }
            ////油气记录
            Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, -petrolMoney, 0.00, 0.00,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curPetrolCode.setConsumewaydesp("成功消费油气:" + petrolMoney + "元");
            curPetrolCode.setPaycode(guid);
            ///系统账户油气记录
            Consumerecod sysPetrolCode = this.setConsumeRecode(sysUser, curUser, petrolMoney, 0.00, 0.0,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETPETROLCONSUME,
                    DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysPetrolCode.setConsumewaydesp("收到用户:" + curUser.getLoginName() + "消费油气" + petrolMoney + "元");
            sysPetrolCode.setPaycode(guid);

            userPurseService.consumePetrol(curUser, petrolMoney, DataDic.COUNT_WAY_SUB);
            userPurseService.consumePetrol(sysUser, petrolMoney, DataDic.COUNT_WAY_PLUS);
            

            curPetrolCode.setCreateBy(curUser);
            curPetrolCode.setUpdateBy(curUser);
            sysPetrolCode.setCreateBy(curUser);
            sysPetrolCode.setUpdateBy(curUser);
            curPetrolCode.setCreateDate(consumeDate);
            curPetrolCode.setUpdateDate(consumeDate);
            sysPetrolCode.setCreateDate(consumeDate);
            sysPetrolCode.setUpdateDate(consumeDate);
            curPetrolCode.setId(IdGen.uuid());
            sysPetrolCode.setId(IdGen.uuid());

            ///当前用户消费油气记录
            consumeRecodService.insertSave(curPetrolCode);
            /// 系统油气
            consumeRecodService.insertSave(sysPetrolCode);
        } else {
            return DataDic.RETURN_STATUS_INFOBUG;
        }

        return result;

    }
    
    
    /**
     * 获取最新交易记录
     * @param user_id  用户ID
     * @param consumeType  交易类型
     * @param consumeMode  交易模块
     * @param consumeWay   交易方式
     * @return
     */
    @Transactional(readOnly = false)
    public Consumerecod getNewCodeBiz(String user_id, String consumeType,
                                   String consumeMode, String consumeWay) {
        Consumerecod consumerecod = new Consumerecod();
        consumerecod.setConsumetype(consumeType);
        consumerecod.setConsumeway(consumeWay);
        consumerecod.setTrademodel(consumeMode);
        User user = new User();
        user.setId(user_id);
        consumerecod.setAccount(user);
        consumerecod.setIslimt(DataDic.YES);
        List<Consumerecod> listVal = consumeRecodService.findList(consumerecod);
        if (listVal.size() > 0) {
            return listVal.get(0);
        } else
            return null;
    }

    
    /**
     * 操作是否在此时间区间 防止非法连续操作
     * @param user_id
     * @param consumeType
     * @param consumeMode
     * @param consumeWay
     * @return
     */
    public Boolean IsCommitData(String user_id, String consumeType,
            String consumeMode, String consumeWay){
    	Boolean result=false;
    	Consumerecod consumerecod=getNewCodeBiz(user_id, consumeType, consumeMode, consumeWay);
    	if(consumerecod==null){
    		result=true;
    	}else if(consumerecod!=null){
    		Date lastDateTime=consumerecod.getCreateDate();
    		Date nowDateTime=new Date();
    		Double time= DateUtil.getTimeDateMinus(nowDateTime,lastDateTime);
    		if(time>DataDic.DATATIMEDIFF){//大于此时间条件
    			result=true;
    		}
    	}
    	
    	return result;
    }
    
    /***
     * 账户卓币充值
     *
     * @param user_id      充值用户ID
     * @param consumeMoney 充值消费的钱
     * @param coinNum      卓币金额
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int rechargeCoinBiz(String user_id, Double consumeMoney, Double coinNum,String consumeway) {
    	lock5.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            User curUser = new User();
            User sysUser = UserUtils.getSysAccount();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);
            //账户可用余额是否足够
            if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
            	if(accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE)<consumeMoney){
            		return DataDic.RETURN_STATUS_MONEYBUG;
            	}
            }else{
            	if(curUser.getUserPurse()==null || curUser.getUserPurse().getAvailablebalance()<consumeMoney){
            		return DataDic.RETURN_STATUS_MONEYBUG;
            	}
            }
            
//            if (!IsCommitData(user_id,
//                    DataDic.CONSUMERECODE_TYPE_COINBALANACE, DataDic.CONSUMERECODE_MODEL_WEBCOIN, DataDic.CONSUMERECODE_WAY_BALANCE)) {
//                return DataDic.RETURN_STATUS_REMORE;
//            }
            String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
            if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
            	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
            }
            ///id
        	String curUserid = IdGen.uuid();
            ///初始当前用户购买卓币消费金额
            Consumerecod curCode = this.setConsumeRecode(curUser, sysUser, -consumeMoney, -consumeMoney, 0.00,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_COINBALANACE,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCode.setConsumewaydesp("购买卓币" + coinNum + "币,共花费:" + consumeMoney + "元");
            curCode.setPaycode(curCode.getConsumecode());
            curCode.setIsNewRecord(true);
            curCode.setId(curUserid);
            Consumerecod sysCode = this.setConsumeRecode(sysUser, curUser, consumeMoney, consumeMoney, 0.0,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysCode.setConsumewaydesp("收到用户" + curUser.getLoginName() + "购买卓币" + coinNum + "币,共花费:" + consumeMoney + "元");
            sysCode.setPaycode(curCode.getConsumecode());
            ///卓币购买记录
            Consumerecod curCoinCode = this.setConsumeRecode(curUser, sysUser, coinNum, coinNum, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_COINRECHARGE,
                    DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_ACCOUNT,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCoinCode.setConsumewaydesp("充值卓币" + coinNum + "币,共花费:" + consumeMoney + "元");
            curCoinCode.setPaycode(curCode.getConsumecode());
            Consumerecod sysCoinCode = this.setConsumeRecode(sysUser, curUser, consumeMoney, consumeMoney, 0.0,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                    DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysCoinCode.setConsumewaydesp("向用户" + curUser.getLoginName() + "支付卓币" + coinNum + "币");
            sysCoinCode.setPaycode(curCode.getConsumecode());
//            userPurseService.edidBalanceWebCoin(curUser, consumeMoney, coinNum, DataDic.COUNT_WAY_PLUS);
//            userPurseService.edidBalanceWebCoin(sysUser, consumeMoney, coinNum, DataDic.COUNT_WAY_SUB);
            int back=userPurseService.edidBalanceWebCoin(curUser, sysUser, consumeMoney, coinNum,consumeway,curUserid);
            if(back!=DataDic.RETURN_STATUS_NORMAL){
            	if(back==DataDic.RETURN_STATUS_PAYBUG){
            		///当前用户的资金账户流水记录
            		curCode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_CONING);
                    this.save(curCode);
            	}
            	return back;
            }

            ///当前用户的资金账户流水记录
            this.save(curCode);
            ///系统用户收到运费交易流水
            this.save(sysCode);
            ///当前用户充值卓币记录
            this.save(curCoinCode);
            /// 支付卓币
            this.save(sysCoinCode);

            return result;
    	}finally{
    		lock5.unlock();
    	}
    }
    
   /* 
    *//***
     * 账户卓币充值--轮询处理
     *
     * @param user_id      充值用户ID
     * @param consumeMoney 充值消费的钱
     * @param coinNum      卓币金额
     * @return 1:正常
     *//*
    @Transactional(readOnly = false)
    public int rechargeCoininfoBiz(String user_id, Double consumeMoney, Double coinNum,String consumeway) {
    	lock5.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            User curUser = new User();
            User sysUser = UserUtils.getSysAccount();
            curUser.setId(user_id);
            curUser = UserUtils.findUser(curUser);
            //账户可用余额是否足够
            if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
            	if(accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE)<consumeMoney){
            		return DataDic.RETURN_STATUS_MONEYBUG;
            	}
            }else{
            	if(curUser.getUserPurse()==null || curUser.getUserPurse().getAvailablebalance()<consumeMoney){
            		return DataDic.RETURN_STATUS_MONEYBUG;
            	}
            }
//            if (!IsCommitData(user_id,
//                    DataDic.CONSUMERECODE_TYPE_COINBALANACE, DataDic.CONSUMERECODE_MODEL_WEBCOIN, DataDic.CONSUMERECODE_WAY_BALANCE)) {
//                return DataDic.RETURN_STATUS_REMORE;
//            }
            String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
            if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
            	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
            }
            ///初始当前用户购买卓币消费金额
            Consumerecod curCode = this.setConsumeRecode(curUser, sysUser, -consumeMoney, -consumeMoney, 0.00,
                    DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_COINBALANACE,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCode.setConsumewaydesp("购买卓币" + coinNum + "币,共花费:" + consumeMoney + "元");
            curCode.setPaycode(curCode.getConsumecode());
            Consumerecod sysCode = this.setConsumeRecode(sysUser, curUser, consumeMoney, consumeMoney, 0.0,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysCode.setConsumewaydesp("收到用户" + curUser.getLoginName() + "购买卓币" + coinNum + "币,共花费:" + consumeMoney + "元");
            sysCode.setPaycode(curCode.getConsumecode());
            ///卓币购买记录
            Consumerecod curCoinCode = this.setConsumeRecode(curUser, sysUser, coinNum, coinNum, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_COINRECHARGE,
                    DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_ACCOUNT,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            curCoinCode.setConsumewaydesp("充值卓币" + coinNum + "币,共花费:" + consumeMoney + "元");
            curCoinCode.setPaycode(curCode.getConsumecode());
            Consumerecod sysCoinCode = this.setConsumeRecode(sysUser, curUser, consumeMoney, consumeMoney, 0.0,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETCONSUME,
                    DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_WEBCOIN,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            sysCoinCode.setConsumewaydesp("向用户" + curUser.getLoginName() + "支付卓币" + coinNum + "币");
            sysCoinCode.setPaycode(curCode.getConsumecode());
//            userPurseService.edidBalanceWebCoin(curUser, consumeMoney, coinNum, DataDic.COUNT_WAY_PLUS);
//            userPurseService.edidBalanceWebCoin(sysUser, consumeMoney, coinNum, DataDic.COUNT_WAY_SUB);
            int back=userPurseService.edidCoin(curUser, sysUser, consumeMoney, coinNum,consumeway);
            if(back!=DataDic.RETURN_STATUS_NORMAL){
            	return back;
            }

            ///当前用户的资金账户流水记录
            this.save(curCode);
            ///系统用户收到运费交易流水
            this.save(sysCode);
            ///当前用户充值卓币记录
            this.save(curCoinCode);
            /// 支付卓币
            this.save(sysCoinCode);

            return result;
    	}finally{
    		lock5.unlock();
    	}
    }
    */
    
    /***
     * 油气转账交易流水,修改油气账户资金
     *
     * @param account_id   转账用户
     * @param consumeMoney 转账金额
     * @param target_id    目标用户
     * @return 
     */
    @Transactional(readOnly = false)
    public int transferPetroBiz(String account_id, Double consumeMoney, String target_id) {
    	lock10.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            ///转账用户
            User account = new User();
            User target = new User();//转账目标用户
            account.setId(account_id);
            target.setId(target_id);
           //判断转账方是是否有绑定一卡通
            boolean accountfalg = metroCardCommonBiz.isBindMetroCard(account);
            if(!accountfalg){
            	return DataDic.RETURN_STATUS_BINDCARDBUG;
            }
            //判断接收方是是否有绑定一卡通
            boolean targetfalg = metroCardCommonBiz.isBindMetroCard(target);
            if(!targetfalg){
            	return DataDic.RETURN_STATUS_BINDCARDBUG;
            }
            ///获取用户信息--初始对象
            account = UserUtils.findUser(account);
            ///账户油气
            Double avlib = account.getUserPurse().getPetrolbalance();
            if (consumeMoney > avlib) {
                return DataDic.RETURN_STATUS_MONEYBUG;
            }

            //if (IsCommitData(account.getId(), DataDic.CONSUMERECODE_TYPE_COINTRANSFER, DataDic.CONSUMERECODE_MODEL_TRANCF, DataDic.CONSUMERECODE_WAY_COIN)) {
                target = UserUtils.findUser(target);
                ///转账用户记录
                Consumerecod accountCode = this.setConsumeRecode(account, target, -consumeMoney, -consumeMoney, 0.00,
                        DataDic.COUNT_WAY_SUB,
                        DataDic.CONSUMERECODE_TYPE_PETROTRANSFER,
                        DataDic.CONSUMERECODE_WAY_PETROL,
                        DataDic.CONSUMERECODE_MODEL_TRANCF,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
                accountCode.setConsumewaydesp("向" + target.getLoginName() + "油气转账" + consumeMoney + "元");
                accountCode.setRemarks(accountCode.getConsumewaydesp());
                accountCode.setPaycode(accountCode.getConsumecode());
                ///收到转账用户记录
                Consumerecod targetCode = this.setConsumeRecode(target, account, consumeMoney, consumeMoney, 0.00,
                        DataDic.COUNT_WAY_PLUS,
                        DataDic.CONSUMERECODE_TYPE_RECEIVEDTRANSFERPETRO,
                        DataDic.CONSUMERECODE_WAY_PETROL,
                        DataDic.CONSUMERECODE_MODEL_TRANCF,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
                targetCode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.MODEL_TRANCF));
                targetCode.setConsumewaydesp("收到用户:" + account.getLoginName() + "油气转账" + consumeMoney + "元");
                targetCode.setRemarks(targetCode.getConsumewaydesp());
                targetCode.setPaycode(accountCode.getConsumecode());
                Map<String, Object> consumemap = metroCardCommonBiz.metroCardConsume(account, consumeMoney);//转账
                
                if (consumemap != null) {
                    String state = consumemap.get("state").toString();
                    if (state != null && Integer.parseInt(state) == DataDic.RETURN_STATUS_NORMAL) {
                    	
                    	Map<String, Object> rechargemap = metroCardCommonBiz.metroCardRecharge(target, consumeMoney);//收到转账
                    	if (rechargemap != null) {
                            String consumestate = rechargemap.get("state").toString();
                            if (consumestate != null && Integer.parseInt(consumestate) == DataDic.RETURN_STATUS_NORMAL) {
		                    	///修改账户资金
		                        userPurseService.editPureWebPetro(account, consumeMoney, DataDic.COUNT_WAY_SUB);
		                        userPurseService.editPureWebPetro(target, consumeMoney, DataDic.COUNT_WAY_PLUS);
		                        ///保存交易流水
		                        consumeRecodService.save(accountCode);
		                        consumeRecodService.save(targetCode);
	                         }else{
	                        	 //把转出去的金额加回
	                         	 Map<String, Object> rmap = metroCardCommonBiz.metroCardRecharge(account, consumeMoney);
	                         }
                         }else{
                        	 //把转出去的金额加回
                        	 Map<String, Object> rmap = metroCardCommonBiz.metroCardRecharge(account, consumeMoney);
                         }
                    }else {
                        result = DataDic.RETURN_STATUS_SYSBUG;
                    }
                } else {
                    result = DataDic.RETURN_STATUS_SYSBUG;
                }
                
           // }
            return result;
    	}finally{
    		lock10.unlock();
    	}
    }

    /***
     * 油气转账交易流水,修改油气账户资金--用于app
     *
     * @param account_id   转账用户
     * @param consumeMoney 转账金额
     * @param target_id    目标用户
     * @return
     */
    @Transactional(readOnly = false)
    public Object transferPetroAppBiz(String account_id, Double consumeMoney, String target_id) {
        lock10.lock();
        try{
            Map<String, Object> map = new HashMap<String, Object>();
            int result = DataDic.RETURN_STATUS_NORMAL;
            String message = "转账成功";
            ///转账用户
            User account = new User();
            User target = new User();//转账目标用户
            account.setId(account_id);
            target.setId(target_id);
            //判断转账方是是否有绑定一卡通
            boolean accountfalg = metroCardCommonBiz.isBindMetroCard(account);
            if(!accountfalg){
                map.put("state", DataDic.RETURN_STATUS_BINDCARDBUG);
                map.put("message", "请先绑定一卡通号");
                return map;
            }
            //判断接收方是是否有绑定一卡通
            boolean targetfalg = metroCardCommonBiz.isBindMetroCard(target);
            if(!targetfalg){
                map.put("state", DataDic.RETURN_STATUS_MONEYBUG);
                map.put("message", "对方未绑定一卡通号");
                return map;
            }
            ///获取用户信息--初始对象
            account = UserUtils.findUser(account);
            ///账户油气
            Double avlib = account.getUserPurse().getPetrolbalance();
            if (consumeMoney > avlib) {
                map.put("state", DataDic.RETURN_STATUS_MONEYBUG);
                map.put("message", "转账金额不足");
                return map;
            }

            //if (IsCommitData(account.getId(), DataDic.CONSUMERECODE_TYPE_COINTRANSFER, DataDic.CONSUMERECODE_MODEL_TRANCF, DataDic.CONSUMERECODE_WAY_COIN)) {
            target = UserUtils.findUser(target);
            ///转账用户记录
            Consumerecod accountCode = this.setConsumeRecode(account, target, -consumeMoney, -consumeMoney, 0.00,
                    DataDic.COUNT_WAY_SUB,
                    DataDic.CONSUMERECODE_TYPE_PETROTRANSFER,
                    DataDic.CONSUMERECODE_WAY_PETROL,
                    DataDic.CONSUMERECODE_MODEL_TRANCF,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            accountCode.setConsumewaydesp("向" + target.getLoginName() + "油气转账" + consumeMoney + "元");
            accountCode.setRemarks(accountCode.getConsumewaydesp());
            accountCode.setPaycode(accountCode.getConsumecode());
            ///收到转账用户记录
            Consumerecod targetCode = this.setConsumeRecode(target, account, consumeMoney, consumeMoney, 0.00,
                    DataDic.COUNT_WAY_PLUS,
                    DataDic.CONSUMERECODE_TYPE_RECEIVEDTRANSFERPETRO,
                    DataDic.CONSUMERECODE_WAY_PETROL,
                    DataDic.CONSUMERECODE_MODEL_TRANCF,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            targetCode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.MODEL_TRANCF));
            targetCode.setConsumewaydesp("收到用户:" + account.getLoginName() + "油气转账" + consumeMoney + "元");
            targetCode.setRemarks(targetCode.getConsumewaydesp());
            targetCode.setPaycode(accountCode.getConsumecode());
            Map<String, Object> consumemap = metroCardCommonBiz.metroCardConsume(account, consumeMoney);//转账

            if (consumemap != null) {
                String state = consumemap.get("state").toString();
                message =consumemap.get("message").toString();
                if (state != null && Integer.parseInt(state) == DataDic.RETURN_STATUS_NORMAL) {

                    Map<String, Object> rechargemap = metroCardCommonBiz.metroCardRecharge(target, consumeMoney);//收到转账
                    if (rechargemap != null) {
                        String consumestate = rechargemap.get("state").toString();
                        if (consumestate != null && Integer.parseInt(consumestate) == DataDic.RETURN_STATUS_NORMAL) {
                            ///修改账户资金
                            userPurseService.editPureWebPetro(account, consumeMoney, DataDic.COUNT_WAY_SUB);
                            userPurseService.editPureWebPetro(target, consumeMoney, DataDic.COUNT_WAY_PLUS);
                            ///保存交易流水
                            consumeRecodService.save(accountCode);
                            consumeRecodService.save(targetCode);
                        }else{
                            //把转出去的金额加回
                            Map<String, Object> rmap = metroCardCommonBiz.metroCardRecharge(account, consumeMoney);
                        }
                    }else{
                        //把转出去的金额加回
                        Map<String, Object> rmap = metroCardCommonBiz.metroCardRecharge(account, consumeMoney);
                    }
                }else {
                    result = DataDic.RETURN_STATUS_SYSBUG;
                }
            } else {
                message = "转账失败";
                result = DataDic.RETURN_STATUS_SYSBUG;
            }

            // }
            map.put("state", result);
            map.put("message", message);
            return map;
        }finally{
            lock10.unlock();
        }
    }

    /***
     * 卓币转账交易流水,修改卓币账户资金
     *
     * @param account_id   转账用户
     * @param consumeMoney 转账金额
     * @param target_id    目标用户
     * @return result 1:正常,5:可用卓币余额不足
     */
    @Transactional(readOnly = false)
    public int transferCoinBiz(String account_id, Double consumeMoney, String target_id) {
    	lock6.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            ///转账用户
            User account = new User();
            User target = new User();//转账目标用户
            account.setId(account_id);
            target.setId(target_id);
            ///获取用户信息--初始对象
            account = UserUtils.findUser(account);
            ///账户可用卓币余额
            Double avlib = account.getUserPurse().getAvailablecoin();
            if (consumeMoney > avlib) {
                return DataDic.RETURN_STATUS_MONEYBUG;
            }

            //if (IsCommitData(account.getId(), DataDic.CONSUMERECODE_TYPE_COINTRANSFER, DataDic.CONSUMERECODE_MODEL_TRANCF, DataDic.CONSUMERECODE_WAY_COIN)) {
                target = UserUtils.findUser(target);
                ///转账用户记录
                Consumerecod accountCode = this.setConsumeRecode(account, target, -consumeMoney, -consumeMoney, 0.00,
                        DataDic.COUNT_WAY_SUB,
                        DataDic.CONSUMERECODE_TYPE_COINTRANSFER,
                        DataDic.CONSUMERECODE_WAY_COIN,
                        DataDic.CONSUMERECODE_MODEL_TRANCF,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
                accountCode.setConsumewaydesp("向" + target.getLoginName() + "卓币转账" + consumeMoney + "币");
                accountCode.setRemarks(accountCode.getConsumewaydesp());
                accountCode.setPaycode(accountCode.getConsumecode());
                ///收到转账用户记录
                Consumerecod targetCode = this.setConsumeRecode(target, account, consumeMoney, consumeMoney, 0.00,
                        DataDic.COUNT_WAY_PLUS,
                        DataDic.CONSUMERECODE_TYPE_RECEIVEDTRANSFERCOIN,
                        DataDic.CONSUMERECODE_WAY_COIN,
                        DataDic.CONSUMERECODE_MODEL_TRANCF,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
                targetCode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.MODEL_TRANCF));
                targetCode.setConsumewaydesp("收到用户:" + account.getLoginName() + "卓币转账" + consumeMoney + "币");
                targetCode.setRemarks(targetCode.getConsumewaydesp());
                targetCode.setPaycode(accountCode.getConsumecode());
                ///修改账户资金
                userPurseService.editPureWebCoin(account, consumeMoney, DataDic.COUNT_WAY_SUB);
                userPurseService.editPureWebCoin(target, consumeMoney, DataDic.COUNT_WAY_PLUS);
                ///保存交易流水
                consumeRecodService.save(accountCode);
                consumeRecodService.save(targetCode);
           // }
            return result;
    	}finally{
    		lock6.unlock();
    	}
    }

    /***
     * 转账交易流水,修改账户资金
     *
     * @param account_id   转账用户
     * @param consumeMoney 转账金额
     * @param target_id    目标用户
     * @return result 1:正常,5:可用余额不足
     */
    @Transactional(readOnly = false)
    public int transferBiz(String account_id, Double consumeMoney, String target_id,String payway) {
    	lock7.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            ///转账用户
            User account = new User();
            User target = new User();//转账目标用户
            account.setId(account_id);
            target.setId(target_id);
            ///获取用户信息--初始对象
            account = UserUtils.findUser(account);
            String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
            ///账户可用余额
            Double avlib = 0.00;
            if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(payway)){
            	avlib=accountBiz.getAmount(account,DataDic.AVAILABLE_BALANCE);
            	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
            }else{
            	avlib = account.getUserPurse().getAvailablebalance();
            }
            if (consumeMoney > avlib) {
                return DataDic.RETURN_STATUS_MONEYBUG;
            }
            
            //if (IsCommitData(account.getId(), DataDic.CONSUMERECODE_TYPE_ACCOUNTTRANSFER, DataDic.CONSUMERECODE_MODEL_TRANCF, DataDic.CONSUMERECODE_WAY_BALANCE)) {
            	target = UserUtils.findUser(target);
                ///转账用户记录
            	String accountid = IdGen.uuid();
                Consumerecod accountCode = this.setConsumeRecode(account, target, -consumeMoney, -consumeMoney, 0.00,
                        DataDic.COUNT_WAY_SUB,
                        DataDic.CONSUMERECODE_TYPE_ACCOUNTTRANSFER,
                        consumeWay,
                        DataDic.CONSUMERECODE_MODEL_TRANCF,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
                accountCode.setConsumewaydesp("向" + target.getLoginName() + "转账" + consumeMoney + "元");
                accountCode.setRemarks(accountCode.getConsumewaydesp());
                accountCode.setPaycode(accountCode.getConsumecode());
                accountCode.setIsNewRecord(true);
                accountCode.setId(accountid);
                ///收到转账用户记录
                Consumerecod targetCode = this.setConsumeRecode(target, account, consumeMoney, consumeMoney, 0.00,
                        DataDic.COUNT_WAY_PLUS,
                        DataDic.CONSUMERECODE_TYPE_RECEIVEDTRANSFER,
                        consumeWay,
                        DataDic.CONSUMERECODE_MODEL_TRANCF,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
                targetCode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.MODEL_TRANCF));
                targetCode.setConsumewaydesp("收到用户:" + account.getLoginName() + "转账" + consumeMoney + "元");
                targetCode.setRemarks(targetCode.getConsumewaydesp());
                targetCode.setPaycode(accountCode.getConsumecode());
                ///修改账户资金  
                if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(payway)){
                	AccountUtils accountUtils=new AccountUtils();
                	//获取最新业务结算单号
                	String tradeSettlementId= accountUtils.getTradeSettlementId();

                	accountCode.setTradeSettlementId(tradeSettlementId);
                	accountCode.setTradeSettlementId(tradeSettlementId);
                	
                	int back=accountBiz.virtAcctTransfer(account,target,accountCode.getConsumemony(),DataDic.TRANSFER_OUTER,accountid,DataDic.CONSUMERECODE_MODEL_TRANCF,tradeSettlementId);
        			if(DataDic.RETURN_STATUS_NORMAL!=back){
        				if(DataDic.RETURN_STATUS_PAYBUG == back){
        					///保存交易流水
        					///提现需要后台审核;当前状态为交易中;
        					accountCode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_CONING);
                            consumeRecodService.save(accountCode);
        				}
        				
        				return back;
        			}
                }else{
                	userPurseService.editPureWebBalance(account, consumeMoney, DataDic.COUNT_WAY_SUB);
                    userPurseService.editPureWebBalance(target, consumeMoney, DataDic.COUNT_WAY_PLUS);
                }
                
                ///保存交易流水
                consumeRecodService.save(accountCode);
                consumeRecodService.save(targetCode);
            //}
            
            return result;
    	}finally{
    		lock7.unlock();
    	}
    }
    
    
    /***
     * 转账交易流水,修改账户资金--账户体系轮询处理
     *
     * @param id   转账用户
     * @param type    目标用户
     * @return result 1:正常,5:可用余额不足
     */
    @Transactional(readOnly = false)
    public int transferinfoBiz(String id, int type) {
    	lock7.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
    		
    		
            ///交易流水信息
            Consumerecod accountCode = consumeRecodService.get(id);
            if (accountCode == null) {
                return DataDic.RETURN_STATUS_INFOBUG;
            }
            //转账失败
            if(type == -1){
            	accountCode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_FAILED);
            	consumeRecodService.save(accountCode);
            	return result;
            }
            ///转账用户
            User account = new User();
            User target = new User();//转账目标用户
            account.setId(accountCode.getAccount().getId());
            target.setId(accountCode.getTarget().getId());
            ///获取用户信息--初始对象
            account = UserUtils.findUser(account);
            String consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
            
            Double consumeMoney = Double.valueOf(accountCode.getConsumemony());
            
            //if (IsCommitData(account.getId(), DataDic.CONSUMERECODE_TYPE_ACCOUNTTRANSFER, DataDic.CONSUMERECODE_MODEL_TRANCF, DataDic.CONSUMERECODE_WAY_BALANCE)) {
            	target = UserUtils.findUser(target);
                ///转账用户记录
            	accountCode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_SUCCES);
                ///收到转账用户记录
                Consumerecod targetCode = this.setConsumeRecode(target, account, consumeMoney, consumeMoney, 0.00,
                        DataDic.COUNT_WAY_PLUS,
                        DataDic.CONSUMERECODE_TYPE_RECEIVEDTRANSFER,
                        consumeWay,
                        DataDic.CONSUMERECODE_MODEL_TRANCF,
                        DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
                targetCode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.MODEL_TRANCF));
                targetCode.setConsumewaydesp("收到用户:" + account.getLoginName() + "转账" + consumeMoney + "元");
                targetCode.setRemarks(targetCode.getConsumewaydesp());
                targetCode.setPaycode(accountCode.getConsumecode());
                
                
                ///保存交易流水
                consumeRecodService.save(accountCode);
                consumeRecodService.save(targetCode);
            //}
            
            return result;
    	}finally{
    		lock7.unlock();
    	}
    }
    

    /***
     * 打印提货单服务费用
     *
     * @param order_id
     * @param payMoney
     */
    @Transactional(readOnly = false)
    public int payPrintOrderBiz(String order_id, Double payMoney) {
    	int result=DataDic.RETURN_STATUS_NORMAL;
        ///获取运单ID
        Orderinfo orderinfo = orderinfoService.get(order_id);
        User seller = UserUtils.findUser(orderinfo.getSeller());
        User sysUser = UserUtils.getSysAccount();
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        Consumerecod consumerecod = this.setConsumeRecode(seller, sysUser, -payMoney, -payMoney, 0.00,
                DataDic.COUNT_WAY_SUB,
                DataDic.CONSUMERECODE_TYPE_PRINTPAY,
                consumeWay,
                DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        consumerecod.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + "向平台缴纳" + payMoney + "元打印服务费");
        consumerecod.setRemarks("向平台缴纳" + consumerecod.getConsumewaydesp());
        consumerecod.setPaycode(consumerecod.getConsumecode());

        ///系统交易记录
        Consumerecod sysCode = this.setConsumeRecode(sysUser, seller, payMoney, payMoney, 0.00,
                DataDic.COUNT_WAY_PLUS,
                DataDic.CONSUMERECODE_TYPE_GETPRINTPAY,
                consumeWay,
                DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        sysCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + "收到" + seller.getLoginName() + payMoney + "元打印服务费");
        sysCode.setRemarks("平台收到" + sysCode.getConsumewaydesp());
        sysCode.setPaycode(consumerecod.getConsumecode());
        consumerecod.setOrderinfo(orderinfo);
        sysCode.setOrderinfo(orderinfo);

        if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))){
        	AccountUtils accountUtils=new AccountUtils();
        	//获取最新业务结算单号
        	String tradeSettlementId= accountUtils.getTradeSettlementId();

        	consumerecod.setTradeSettlementId(tradeSettlementId);
        	sysCode.setTradeSettlementId(tradeSettlementId);
        	
        	
        	int back=accountBiz.virtAcctTransfer(seller,sysUser,consumerecod.getConsumemony(),DataDic.TRANSFER_OUTER,null,null,tradeSettlementId);
        	if(DataDic.RETURN_STATUS_NORMAL!=back){
				return back;
			}
        }else{
        	userPurseService.editPureWebBalance(seller, payMoney, DataDic.COUNT_WAY_SUB);
            userPurseService.editPureWebBalance(sysUser, payMoney, DataDic.COUNT_WAY_PLUS);
        }

        ///保存交易流水
        consumeRecodService.save(consumerecod);
        consumeRecodService.save(sysCode);
        return result;
    }


    /**
     * 支付招标结算运费--竞标用户收到运费
     *
     * @param bidOrder_id
     * @return
     */
    @Transactional(readOnly = false)
    public int payBidFerightMoney(String bidOrder_id) {
    	int result=DataDic.RETURN_STATUS_NORMAL;
    	int back=DataDic.RETURN_STATUS_NORMAL;
        BidOrderinfo bidOrder = bidOrderinfoService.get(bidOrder_id);
        User bidUser = UserUtils.findUser(bidOrder.getBiduser());///招标用户
        User bidingUser = UserUtils.findUser(bidOrder.getBiddinguser());//竞标用户
        Double totalMoeny = bidOrder.getContracttotal().doubleValue();  ///结算运费
        //实际支付现金部分
        Double webAmount = Double.valueOf(bidOrder.getWebamount() != null ? bidOrder.getWebamount() : 0.00);
        ///实际支付卓币部分
        Double coinAmount = Double.valueOf(bidOrder.getCoinamount() != null ? bidOrder.getCoinamount() : 0.00);
        String settlestatus = bidOrder.getSettlestatus();   ///支付状态

        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if("2".equals(bidOrder.getIsAccount())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///招标用户交易记录信息
        Consumerecod bidUserCode = this.setConsumeRecode(bidUser, bidingUser, -webAmount, -webAmount, 0.00,
                DataDic.COUNT_WAY_SUB,
                DataDic.CONSUMERECODE_TYPE_SETTLEPAY, consumeWay,
                DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        bidUserCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "向竞标用户支付运费:" + webAmount + "元");
        bidUserCode.setPaycode(bidUserCode.getConsumecode());
        bidUserCode.setRemarks(bidUser.getLoginName() + "向" + bidingUser.getLoginName() + "支付结算运费" + webAmount + "元,合同号:" + bidOrder.getContractno());

        ///竞标用户交易记录信息
        Consumerecod bidingUserCode = this.setConsumeRecode(bidingUser, bidUser, webAmount, webAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS,
                    DataDic.CONSUMERECODE_TYPE_GETSETTLE, consumeWay,
                    DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        bidingUserCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "收到" + bidUser.getLoginName() + "支付运费:" + webAmount + "元");
        ///交易编码
        bidingUserCode.setPaycode(bidUserCode.getConsumecode());
        bidingUserCode.setRemarks(bidingUser.getLoginName() + "收到" + bidUser.getLoginName() + "结算运费" + webAmount + "元,合同号:" + bidOrder.getContractno());

        
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(bidOrder.getIsAccount())){
        	AccountUtils accountUtils=new AccountUtils();
        	//获取最新业务结算单号
        	String tradeSettlementId= accountUtils.getTradeSettlementId();
        	bidUserCode.setTradeSettlementId(tradeSettlementId);
        	bidingUserCode.setTradeSettlementId(tradeSettlementId);
        	
        	
        	if(!Tools.IsNullOrWhiteSpace(bidUser.getMemberId())&&Tools.IsNullOrWhiteSpace(bidingUser.getMemberId())){
        	    back=accountBiz.virtAcctTransfer(bidUser,bidingUser,webAmount.toString(),DataDic.TRANSFER_OUTER_BANK,bidOrder_id,DataDic.CONSUMERECODE_MODEL_SETTLEORDER,tradeSettlementId);
        		if(DataDic.RETURN_STATUS_NORMAL!=back){
    				return back;
    			}
        	}else if(Tools.IsNullOrWhiteSpace(bidUser.getMemberId())&&!Tools.IsNullOrWhiteSpace(bidingUser.getMemberId())){
        		return -1;
        	}else{
        		back=accountBiz.virtAcctTransfer(bidUser,bidingUser,webAmount.toString(),DataDic.TRANSFER_OUTER,bidOrder_id,DataDic.CONSUMERECODE_MODEL_SETTLEORDER,tradeSettlementId);
    			if(DataDic.RETURN_STATUS_NORMAL!=back){
    				return back;
    			}
        	}
        }else{
        	///支付运费
          userPurseService.editPureWebBalance(bidUser, webAmount, DataDic.COUNT_WAY_SUB);
          ///竞标用户收到运费
          userPurseService.editPureWebBalance(bidingUser, webAmount, DataDic.COUNT_WAY_PLUS);
        }
        if (back == DataDic.RETURN_STATUS_NORMAL && DataDic.YES.equals(bidOrder.getIspaycoin())) {
            ///招标用户卓币交易记录信息
            Consumerecod bidUserCoinCode = this.setConsumeRecode(bidUser, bidingUser, -coinAmount, -coinAmount, 0.00,
                    DataDic.COUNT_WAY_SUB,
                    DataDic.CONSUMERECODE_TYPE_SETTLEPAYCOIN, DataDic.CONSUMERECODE_WAY_COIN,
                    DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            bidUserCoinCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "向竞标用户支付卓币运费:" + coinAmount + "元");
            bidUserCoinCode.setPaycode(bidUserCode.getConsumecode());
            bidUserCoinCode.setRemarks(bidUser.getLoginName() + "向" + bidingUser.getLoginName() + "支付结算卓币运费" + coinAmount + "元,合同号:" + bidOrder.getContractno());

            ///招标用户卓币交易记录信息
            Consumerecod bidingUserCoinCode = this.setConsumeRecode(bidingUser, bidUser, coinAmount, coinAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS,
                    DataDic.CONSUMERECODE_TYPE_GETSETTLECOIN, DataDic.CONSUMERECODE_WAY_COIN,
                    DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            bidingUserCoinCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "收到" + bidUser.getLoginName() + "支付卓币运费:" + coinAmount + "元");
            ///交易编码
            bidingUserCoinCode.setPaycode(bidUserCode.getConsumecode());
            bidingUserCoinCode.setRemarks(bidingUser.getLoginName() + "收到" + bidUser.getLoginName() + "结算卓币运费" + coinAmount + "元,合同号:" + bidOrder.getContractno());
            ///支付运费
            userPurseService.editPureWebCoin(bidUser, coinAmount, DataDic.COUNT_WAY_SUB);
            ///竞标用户收到运费
            userPurseService.editPureWebCoin(bidingUser, coinAmount, DataDic.COUNT_WAY_PLUS);
            ///保存发标用户交易流水记录
            consumeRecodService.save(bidUserCoinCode);
            ////竞标用户流水
            consumeRecodService.save(bidingUserCoinCode);
        }
        ///保存发标用户交易流水记录
        consumeRecodService.save(bidUserCode);
        ////竞标用户流水
        consumeRecodService.save(bidingUserCode);
        return result;
    }

    /**
     * 支付招标结算运费--竞标用户收到运费--账户体系支付轮询
     *
     * @param bidOrder_id
     * @return
     */
    @Transactional(readOnly = false)
    public int payBidMoney(String bidOrder_id) {
    	int result=DataDic.RETURN_STATUS_NORMAL;
    	int back=DataDic.RETURN_STATUS_NORMAL;
        BidOrderinfo bidOrder = bidOrderinfoService.get(bidOrder_id);
        User bidUser = UserUtils.findUser(bidOrder.getBiduser());///招标用户
        User bidingUser = UserUtils.findUser(bidOrder.getBiddinguser());//竞标用户
        Double totalMoeny = bidOrder.getContracttotal().doubleValue();  ///结算运费
        //实际支付现金部分
        Double webAmount = Double.valueOf(bidOrder.getWebamount() != null ? bidOrder.getWebamount() : 0.00);
        ///实际支付卓币部分
        Double coinAmount = Double.valueOf(bidOrder.getCoinamount() != null ? bidOrder.getCoinamount() : 0.00);
        String settlestatus = bidOrder.getSettlestatus();   ///支付状态

        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if("2".equals(bidOrder.getIsAccount())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///招标用户交易记录信息
        Consumerecod bidUserCode = this.setConsumeRecode(bidUser, bidingUser, -webAmount, -webAmount, 0.00,
                DataDic.COUNT_WAY_SUB,
                DataDic.CONSUMERECODE_TYPE_SETTLEPAY, consumeWay,
                DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        bidUserCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "向竞标用户支付运费:" + webAmount + "元");
        bidUserCode.setPaycode(bidUserCode.getConsumecode());
        bidUserCode.setRemarks(bidUser.getLoginName() + "向" + bidingUser.getLoginName() + "支付结算运费" + webAmount + "元,合同号:" + bidOrder.getContractno());

        ///竞标用户交易记录信息
        Consumerecod bidingUserCode = this.setConsumeRecode(bidingUser, bidUser, webAmount, webAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS,
                    DataDic.CONSUMERECODE_TYPE_GETSETTLE, consumeWay,
                    DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        bidingUserCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "收到" + bidUser.getLoginName() + "支付运费:" + webAmount + "元");
        ///交易编码
        bidingUserCode.setPaycode(bidUserCode.getConsumecode());
        bidingUserCode.setRemarks(bidingUser.getLoginName() + "收到" + bidUser.getLoginName() + "结算运费" + webAmount + "元,合同号:" + bidOrder.getContractno());

        if (DataDic.YES.equals(bidOrder.getIspaycoin())) {
            ///招标用户卓币交易记录信息
            Consumerecod bidUserCoinCode = this.setConsumeRecode(bidUser, bidingUser, -coinAmount, -coinAmount, 0.00,
                    DataDic.COUNT_WAY_SUB,
                    DataDic.CONSUMERECODE_TYPE_SETTLEPAYCOIN, DataDic.CONSUMERECODE_WAY_COIN,
                    DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            bidUserCoinCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "向竞标用户支付卓币运费:" + coinAmount + "元");
            bidUserCoinCode.setPaycode(bidUserCode.getConsumecode());
            bidUserCoinCode.setRemarks(bidUser.getLoginName() + "向" + bidingUser.getLoginName() + "支付结算卓币运费" + coinAmount + "元,合同号:" + bidOrder.getContractno());

            ///招标用户卓币交易记录信息
            Consumerecod bidingUserCoinCode = this.setConsumeRecode(bidingUser, bidUser, coinAmount, coinAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS,
                    DataDic.CONSUMERECODE_TYPE_GETSETTLECOIN, DataDic.CONSUMERECODE_WAY_COIN,
                    DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
            bidingUserCoinCode.setConsumewaydesp("招标文号:" + bidOrder.getBidinfo().getBidcode() + "收到" + bidUser.getLoginName() + "支付卓币运费:" + coinAmount + "元");
            ///交易编码
            bidingUserCoinCode.setPaycode(bidUserCode.getConsumecode());
            bidingUserCoinCode.setRemarks(bidingUser.getLoginName() + "收到" + bidUser.getLoginName() + "结算卓币运费" + coinAmount + "元,合同号:" + bidOrder.getContractno());
            ///支付运费
            userPurseService.editPureWebCoin(bidUser, coinAmount, DataDic.COUNT_WAY_SUB);
            ///竞标用户收到运费
            userPurseService.editPureWebCoin(bidingUser, coinAmount, DataDic.COUNT_WAY_PLUS);
            ///保存发标用户交易流水记录
            consumeRecodService.save(bidUserCoinCode);
            ////竞标用户流水
            consumeRecodService.save(bidingUserCoinCode);
        }
        ///保存发标用户交易流水记录
        consumeRecodService.save(bidUserCode);
        ////竞标用户流水
        consumeRecodService.save(bidingUserCode);
        return result;
    }

    
    
    /***
     * 退还竞标押金交易流水并变动金额
     *
     * @param biddinginfo
     * @return result
     */
    @Transactional(readOnly = false)
    public int biddingReturnPayRecodeBiz(Biddinginfo biddinginfo) {
    	lock8.lock();
    	try{
    		int result = DataDic.RETURN_STATUS_NORMAL;
            if (biddinginfo == null || biddinginfo.getBiddinguser() == null) {
                return DataDic.RETURN_STATUS_INFOBUG;
            }
            if(DataDic.BIDDING_GURAN_RETURN.equals(biddinginfo.getGuarantee())){
            	return DataDic.RETURN_STATUS_OVERCONTROLBUG;
            }

            ///查找竞标用户信息
            User biddingUser = UserUtils.findUser(biddinginfo.getBiddinguser());
            Double biddingMargin = Double.parseDouble(biddinginfo.getBiddingmargin() != null ? biddinginfo.getBiddingmargin() : "0");

            if (DataDic.YES.equals(biddinginfo.getIsderate())) {
                ////缴纳的保证金
                biddingMargin = 0.0;
            }

            String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
            if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(biddinginfo.getIsGuaAccount())){
            	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
            }
            Consumerecod biddingCode = new Consumerecod();
            ///用户交易流水记录--竞标押金退款
            biddingCode = this.setConsumeRecode(biddingUser, biddingUser, biddingMargin, biddingMargin, -biddingMargin,
                    DataDic.COUNT_WAY_PLUS,
                    DataDic.CONSUMERECODE_TYPE_BIDINGRETURN,
                    consumeWay,
                    DataDic.CONSUMERECODE_MODEL_BIDDING,
                    DataDic.CONSUMERECODE_STATUS_SUCCES,
                    DataDic.ISSYSRECODE_NO);
            biddingCode.setPaycode(biddingCode.getConsumecode());
            biddingCode.setConsumewaydesp("竞标编号:" + biddinginfo.getBiddingcode() + ";退还押金:" + biddingMargin + "元");
            biddingCode.setRemarks("竞标编号" + biddinginfo.getBiddingcode() + (biddingUser.getLoginName() + "收到退还" + biddingMargin + "元竞标押金"));

            if(DataDic.ORDER_PAYWAY_BALANCE.equals(biddinginfo.getIsGuaAccount())){
            	userPurseService.editAvbFreeze(biddingUser, biddingMargin, DataDic.COUNT_WAY_PLUS);
            }else{
            	//解冻
            	AccountUtils accountUtils=new AccountUtils();
            	//获取最新业务结算单号
            	String tradeSettlementId= accountUtils.getTradeSettlementId();
            	int back=0;
            	if(DataDic.YES.equals(biddinginfo.getIsLockWay())){
            		back=accountBiz.lockAccount(biddingUser,biddingMargin.toString(),DataDic.TRANSFER_UNLOCK,tradeSettlementId);
            	}else{
            		back=accountBiz.freezeAccount(biddingUser,biddingMargin.toString(),DataDic.TRANSFER_UNFREEZE,tradeSettlementId);
            	}
            	
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }
            
            ////缴纳竞标押金,账户的竞标押金减少
            userPurseService.editBidingMoney(biddingUser, biddingMargin, DataDic.COUNT_WAY_SUB);
            consumeRecodService.save(biddingCode);


            return result;
    	}finally{
    		lock8.unlock();
    	}
    }

    /***
     * 保存竞标押金交易流水并变动金额
     *
     * @param biddinginfo
     * @return
     */
    @Transactional(readOnly = false)
    public int biddingPayRecodeBiz(Biddinginfo biddinginfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        if (biddinginfo == null || biddinginfo.getBiddinguser() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///查找竞标用户信息
        User biddingUser = UserUtils.findUser(biddinginfo.getBiddinguser());
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        Double available = biddingUser.getUserPurse().getAvailablebalance().doubleValue();
        if(!Tools.IsNullOrWhiteSpace(biddingUser.getMemberId())){
        	available=accountBiz.getAmount(biddingUser,DataDic.AVAILABLE_BALANCE);
        	if(available<DataDic.BIDGUARANTEE){
        		available = biddingUser.getUserPurse().getAvailablebalance().doubleValue();
        	}else{
        		consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
                biddinginfo.setIsGuaAccount(DataDic.ORDER_PAYWAY_ACCOUNT);
        	}
        }
    	
        Double biddingMargin = Double.parseDouble(biddinginfo.getBiddingmargin() != null ? biddinginfo.getBiddingmargin() : "0");
        ///如果可用资金少于竞标押金,资金不足,如果是减免保证金
        if (biddinginfo.getIsderate().equals(DataDic.YES) || available < biddingMargin) {
            return DataDic.RETURN_STATUS_MONEYBUG;
        }
        Consumerecod biddingCode = new Consumerecod();
        ///用户交易流水记录--竞标押金
        biddingCode = this.setConsumeRecode(biddingUser, biddingUser, -biddingMargin, -biddingMargin, biddingMargin,
                DataDic.COUNT_WAY_SUB,
                DataDic.CONSUMERECODE_TYPE_BIDINGPAY,
                consumeWay,
                DataDic.CONSUMERECODE_MODEL_BIDDING,
                DataDic.CONSUMERECODE_STATUS_SUCCES,
                DataDic.ISSYSRECODE_NO);
        ////竞标交易code
        biddingCode.setPaycode(biddingCode.getConsumecode());
        biddingCode.setConsumewaydesp("竞标编号:" + biddinginfo.getBiddingcode() + "缴纳竞标保证金:" + biddingMargin + "元");
        biddingCode.setRemarks("竞标编号" + biddinginfo.getBiddingcode() + ";" + biddingUser.getLoginName() + "冻结" + biddingMargin + "元竞标押金");

        if(Tools.IsNullOrWhiteSpace(biddingUser.getMemberId())||DataDic.ORDER_PAYWAY_BALANCE.equals(biddinginfo.getIsGuaAccount())){
        	userPurseService.editAvbFreeze(biddingUser, biddingMargin, DataDic.COUNT_WAY_SUB);
        }else{
        	//冻结
        	AccountUtils accountUtils=new AccountUtils();
        	//获取最新业务结算单号
        	String tradeSettlementId= accountUtils.getTradeSettlementId();
        	biddingCode.setTradeSettlementId(tradeSettlementId);
        	int back= 0;
        	if(DataDic.YES.equals(biddinginfo.getIsLockWay())){
        		back=accountBiz.lockAccount(biddingUser,biddingMargin.toString(),DataDic.TRANSFER_LOCK,tradeSettlementId);
        	}else{
        		back=accountBiz.freezeAccount(biddingUser,biddingMargin.toString(),DataDic.TRANSFER_FREEZE,tradeSettlementId);
        	}
        	
        	if(back!=DataDic.RETURN_STATUS_NORMAL){
        		return back;
        	}
        }
        
        ////缴纳竞标押金,账户的竞标押金增加
        userPurseService.editBidingMoney(biddingUser, biddingMargin, DataDic.COUNT_WAY_PLUS);
        consumeRecodService.save(biddingCode);
        biddinginfoService.save(biddinginfo);
        return result;
    }

    /***
     * 退还预冻结资金
     *
     * @param order_id
     * @return
     */
    @Transactional(readOnly = false)
    public int orderRefundCodeBiz(String order_id) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///运单信息
        Orderinfo orderinfo = new Orderinfo();
        orderinfo = orderinfoService.get(order_id);
        ///如果运单信息不完整,数据异常返回
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        String payStatus = orderinfo.getPaystatus();
        ///判断运单状态支付状态不等于冻结状态,则无需退款,
        if (!DataDic.ORDER_PAY_FORZEN.equals(payStatus)&&!DataDic.ORDER_STATUS_DISPUTE.equals(orderinfo.getOrderstatus())) {
            return DataDic.RETURN_STATUS_OVERCONTROLBUG;
        }
        ///运单交易支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        User sellerUser = UserUtils.findUser(orderinfo.getSeller());
        
        ///退款前的账户可用余额
        Double old_available = sellerUser.getUserPurse().getAvailablebalance();
        ///退款前的冻结资金
        Double old_freeze = sellerUser.getUserPurse().getFreezemoney();
        ///线上退款金额
        Double onlineAmount = Double.parseDouble(payinfo.getOnlineamount());
        ///退款后的余额
        Double cur_available = old_available + onlineAmount;
        ///退款后的冻结资金
        Double cur_freeze = old_freeze - onlineAmount;
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(!Tools.IsNullOrWhiteSpace(sellerUser.getMemberId())&&(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))){
        	old_available=accountBiz.getAmount(sellerUser,DataDic.AVAILABLE_BALANCE);
        	old_freeze=accountBiz.getAmount(sellerUser,DataDic.FREEZE_BALANCE);
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }else{
        	old_available = sellerUser.getUserPurse().getAvailablebalance();
        	old_freeze = sellerUser.getUserPurse().getFreezemoney();
        }

        Consumerecod consumerecod = new Consumerecod();
        //consumerecod.preInsert();

        ///预冻结运费返款
        consumerecod = this.setConsumeRecode(sellerUser, sellerUser, onlineAmount, onlineAmount, -onlineAmount,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_RETURNFORZEN,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        consumerecod.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";收到解冻" + onlineAmount + "元运费");
        consumerecod.setRemarks("退还用户" + sellerUser.getLoginName() + "线上运费" + onlineAmount + "元");
        ///修改卖家用户数据账户余额与可用余额增加;冻结余额减少
        if(!Tools.IsNullOrWhiteSpace(sellerUser.getMemberId())&&(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))){
        	//解冻
        	AccountUtils accountUtils=new AccountUtils();
        	//获取最新业务结算单号
        	String tradeSettlementId= accountUtils.getTradeSettlementId();
        	consumerecod.setTradeSettlementId(tradeSettlementId);
        	int back= 0;
        	if(DataDic.YES.equals(orderinfo.getIsLockWay())){
        		back=accountBiz.lockAccount(sellerUser,consumerecod.getConsumemony(),DataDic.TRANSFER_UNLOCK,tradeSettlementId);
        	}else{
        		back=accountBiz.freezeAccount(sellerUser,consumerecod.getConsumemony(),DataDic.TRANSFER_UNFREEZE,tradeSettlementId);
        	}
        	if(back!=DataDic.RETURN_STATUS_NORMAL){
        		return back;
        	}
        }else{
        	result = userPurseService.editAvbFreeze(sellerUser, onlineAmount, DataDic.COUNT_WAY_PLUS);
        	if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
        }

        
        consumeRecodService.save(consumerecod);

        return result;
    }

    /***
     * 退还冻结卓币资金
     *
     * @param order_id
     * @return
     */
    @Transactional(readOnly = false)
    public int orderRefundCoinCodeBiz(String order_id) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///运单信息
        Orderinfo orderinfo = new Orderinfo();
        orderinfo = orderinfoService.get(order_id);
        ///如果运单信息不完整,数据异常返回
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        String payStatus = orderinfo.getPaystatus();
        ///判断运单状态支付状态不等于冻结状态,则无需退款,
        if (!DataDic.ORDER_PAY_FORZEN.equals(payStatus)&&!DataDic.ORDER_STATUS_DISPUTE.equals(orderinfo.getOrderstatus())) {
            return DataDic.RETURN_STATUS_OVERCONTROLBUG;
        }
        ///运单交易支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        User sellerUser = UserUtils.findUser(orderinfo.getSeller());

        ///线上退款金额
        Double onlineAmount = Double.parseDouble(payinfo.getCoinamount());

        Consumerecod consumerecod = new Consumerecod();
        ///预冻结运费返款
        consumerecod = this.setConsumeRecode(sellerUser, sellerUser, onlineAmount, onlineAmount, -onlineAmount,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_CONREFOUND,
                DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        consumerecod.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";收到卓币解冻" + onlineAmount + "元运费");
        consumerecod.setRemarks("退还用户" + sellerUser.getLoginName() + "线上运费" + onlineAmount + "元");
        ///修改卖家用户数据账户余额与可用余额增加;冻结余额减少
        result = userPurseService.editPureWebCoin(sellerUser, onlineAmount, DataDic.COUNT_WAY_PLUS);
        //退还卓币部分
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            return result;
        }
        consumeRecodService.save(consumerecod);

        return result;
    }


    /**
     * 争议处理支付余款--付款到司机
     *
     * @param order_id 运单id
     * @return
     */
    @Transactional(readOnly = false)
    public int orderDisputePayRecodeBiz(String order_id) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///运单信息
        Orderinfo orderinfo = orderinfoService.get(order_id);
        ///当前用户信息
        User curUser = UserUtils.getUser();
        ///判断运单信息是否完整
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } else if (curUser == null) {//判断用户是否登录;未登录则权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        ///如果当前登录用户是否是运单的买卖双方用户
        if (!curUser.getId().equals(buyer.getId()) && !curUser.getId().equals(seller.getId())) {
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取当前运单的状态
        String orderStatus = orderinfo.getOrderstatus();
        String isonlinepay = orderinfo.getIsonlinepay();
        ///判断运单是否是同意运输,是否是在线支付运单
        if (!DataDic.ORDER_ONLINEPAY.equals(isonlinepay)) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///线上支付余款
        Double onlineBalnce = Double.parseDouble(payinfo.getOnlinebalance() != null ? payinfo.getOnlinebalance() : "0");
        //线上支付实际余款金额
        Double actualAmount = Double.parseDouble(payinfo.getActualamount() != null ? payinfo.getActualamount() : "0");
        ///获取争议金额
        Double disputeAmount = Double.parseDouble(payinfo.getDisputeamount() != null ? payinfo.getDisputeamount() : "0");

        ////判断争议处理金额是否正常
        Double sum = PreciseCompute.add(actualAmount, disputeAmount);
        sum=PreciseCompute.round(sum, 2);
        if (onlineBalnce.doubleValue() != sum.doubleValue()) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///当前买家用户的消费记录
        Consumerecod buyerCode = new Consumerecod();
        ///当前卖家用户的消费记录
        Consumerecod sellerCode = new Consumerecod();

        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前买家收到余款运费
        buyerCode = this.setConsumeRecode(buyer, seller, actualAmount, actualAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETONLINEMONEY,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        ///买家账户流水描述
        buyerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";" + buyer.getLoginName() + "收到运费" + seller.getLoginName() + ":" + actualAmount + "元;争议:" + disputeAmount + "元");
        buyerCode.setRemarks(buyer.getLoginName() + "收到余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        buyerCode.setPaycode(buyerCode.getConsumecode());
        //涉及的用运单信息
        buyerCode.setOrderinfo(orderinfo);

        ///卖家收到争议退费资金
        sellerCode = this.setConsumeRecode(seller, seller, disputeAmount, disputeAmount, -disputeAmount,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_DISPUTEMONEYRETURN,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);

        ////系统账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";收到退还争议运费" + disputeAmount + "元");
        sellerCode.setRemarks(sellerCode.getConsumewaydesp());
        sellerCode.setPaycode(buyerCode.getConsumecode());
        sellerCode.setOrderinfo(orderinfo);
        
      ///托运方支付余款运费部分记录
        Consumerecod sellerPayCode = new Consumerecod();
        ///托运方支付余付款:帐户余额不变、冻结资金变动
        sellerPayCode = this.setConsumeFrezRecode(seller, buyer, -actualAmount, 0.00, -actualAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付付款账户流水描述
        sellerPayCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "支付余款运费:" + actualAmount + "元");
        sellerPayCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "支付余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        sellerPayCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerPayCode.setOrderinfo(orderinfo);

        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	AccountUtils accountUtils=new AccountUtils();
        	//获取新的业务结算单号
        	String tradeSettlementId= accountUtils.getTradeSettlementId();
        	//保存业务结算单号
        	buyerCode.setTradeSettlementId(tradeSettlementId);
        	sellerCode.setTradeSettlementId(tradeSettlementId);
        	sellerPayCode.setTradeSettlementId(tradeSettlementId);
        	
        	if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
        		
            	//冻结金额转账
            	int back=accountBiz.freezeBalanceTransfer(seller,buyer,payinfo.getActualamount(),DataDic.TRANSFER_OUTER,orderinfo.getOrderno(),DataDic.CONSUMERECODE_MODEL_TRADEORDER,tradeSettlementId,orderinfo.getIsLockWay());
            	
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
                //解冻--争议退费
            	int back1 = 0;
            	if(DataDic.YES.equals(orderinfo.getIsLockWay())){
            		back1=accountBiz.lockAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNLOCK,accountUtils.getTradeSettlementId());
            	}else{
            		back1=accountBiz.freezeAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNFREEZE,accountUtils.getTradeSettlementId());
            	}
                
                if(back1!=DataDic.RETURN_STATUS_NORMAL){
                	return back1;
                }
                
            }else if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	
            	int back=accountBiz.freezeBalanceTransfer(seller,buyer,actualAmount.toString(),DataDic.TRANSFER_OUTER_BANK,orderinfo.getOrderno(),DataDic.CONSUMERECODE_MODEL_TRADEORDER,tradeSettlementId,orderinfo.getIsLockWay());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
                //解冻
            	int back1 = 0;
            	if(DataDic.YES.equals(orderinfo.getIsLockWay())){
            		back1=accountBiz.lockAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNLOCK,accountUtils.getTradeSettlementId());
            	}else{
            		back1=accountBiz.freezeAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNFREEZE,accountUtils.getTradeSettlementId());
            	}
                
                if(back1!=DataDic.RETURN_STATUS_NORMAL){
                	return back1;
                }
            }else if(Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	return DataDic.RETURN_STATUS_SYSBUG;
            }
        }else{
        	///变动账户体系中的平台总余额
            result = userPurseService.editPureWebBalance(buyer, actualAmount, DataDic.COUNT_WAY_PLUS);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
            ///卖家账户的冻结资金变动--所有的线上支付余额冻结部分减少
            result = userPurseService.editFreeze(seller, onlineBalnce, DataDic.COUNT_WAY_SUB);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
            ///卖家收到争议退费
            result = userPurseService.editPureWebBalance(seller, disputeAmount, DataDic.COUNT_WAY_PLUS);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
        }
        consumeRecodService.save(buyerCode);
        consumeRecodService.save(sellerCode);
        consumeRecodService.save(sellerPayCode);
        String[] keyword = {"争议运费:" + disputeAmount.toString()};
        SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_RECHARGE, seller.getLoginName(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsRechargeSuccess);

        return result;
    }

    /**
     * 争议处理支付余款--付款到司机--添加流水
     *
     * @param order_id 运单id
     * @return
     */
    @Transactional(readOnly = false)
    public int orderDisputePayConsumeRecod(String order_id) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///运单信息
        Orderinfo orderinfo = orderinfoService.get(order_id);
        ///判断运单信息是否完整
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        
        //获取当前运单的状态
        String orderStatus = orderinfo.getOrderstatus();
        String isonlinepay = orderinfo.getIsonlinepay();
        ///判断运单是否是同意运输,是否是在线支付运单
        if (!DataDic.ORDER_ONLINEPAY.equals(isonlinepay)) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///线上支付余款
        Double onlineBalnce = Double.parseDouble(payinfo.getOnlinebalance() != null ? payinfo.getOnlinebalance() : "0");
        //线上支付实际余款金额
        Double actualAmount = Double.parseDouble(payinfo.getActualamount() != null ? payinfo.getActualamount() : "0");
        ///获取争议金额
        Double disputeAmount = Double.parseDouble(payinfo.getDisputeamount() != null ? payinfo.getDisputeamount() : "0");

        ////判断争议处理金额是否正常
        Double sum = PreciseCompute.add(actualAmount, disputeAmount);
        sum=PreciseCompute.round(sum, 2);
        if (onlineBalnce.doubleValue() != sum.doubleValue()) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///当前买家用户的消费记录
        Consumerecod buyerCode = new Consumerecod();
        ///当前卖家用户的消费记录
        Consumerecod sellerCode = new Consumerecod();

        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前买家收到余款运费
        buyerCode = this.setConsumeRecode(buyer, seller, actualAmount, actualAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETONLINEMONEY,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        ///买家账户流水描述
        buyerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";" + buyer.getLoginName() + "收到运费" + seller.getLoginName() + ":" + actualAmount + "元;争议:" + disputeAmount + "元");
        buyerCode.setRemarks(buyer.getLoginName() + "收到余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        buyerCode.setPaycode(buyerCode.getConsumecode());
        //涉及的用运单信息
        buyerCode.setOrderinfo(orderinfo);

        ///卖家收到争议退费资金
        sellerCode = this.setConsumeRecode(seller, seller, disputeAmount, disputeAmount, -disputeAmount,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_DISPUTEMONEYRETURN,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);

        ////系统账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";收到退还争议运费" + disputeAmount + "元");
        sellerCode.setRemarks(sellerCode.getConsumewaydesp());
        sellerCode.setPaycode(buyerCode.getConsumecode());
        sellerCode.setOrderinfo(orderinfo);
        
      ///托运方支付余款运费部分记录
        Consumerecod sellerPayCode = new Consumerecod();
        ///托运方支付余付款:帐户余额不变、冻结资金变动
        sellerPayCode = this.setConsumeFrezRecode(seller, buyer, -actualAmount, 0.00, -actualAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付付款账户流水描述
        sellerPayCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "支付余款运费:" + actualAmount + "元");
        sellerPayCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "支付余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        sellerPayCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerPayCode.setOrderinfo(orderinfo);

       
        consumeRecodService.save(buyerCode);
        consumeRecodService.save(sellerCode);
        consumeRecodService.save(sellerPayCode);
        String[] keyword = {"争议运费:" + disputeAmount.toString()};
        SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_RECHARGE, seller.getLoginName(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsRechargeSuccess);

        return result;
    }
    
    /**
     * 争议处理支付余款--付款到司机--到达司机的 余款需要审核
     *
     * @param order_id 运单id
     * @return
     */
    @Transactional(readOnly = false)
    public int orderDisputePayRecode2Biz(String order_id) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///运单信息
        Orderinfo orderinfo = orderinfoService.get(order_id);
        ///当前用户信息
        User curUser = UserUtils.getUser();
        ///判断运单信息是否完整
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } else if (curUser == null) {//判断用户是否登录;未登录则权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        ///如果当前登录用户是否是运单的买卖双方用户
        if (!curUser.getId().equals(buyer.getId()) && !curUser.getId().equals(seller.getId())) {
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取当前运单的状态
        String orderStatus = orderinfo.getOrderstatus();
        String isonlinepay = orderinfo.getIsonlinepay();
        ///判断运单是否是同意运输,是否是在线支付运单
        if (!DataDic.ORDER_ONLINEPAY.equals(isonlinepay)) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///线上支付余款
        Double onlineBalnce = Double.parseDouble(payinfo.getOnlinebalance() != null ? payinfo.getOnlinebalance() : "0");
        //线上支付实际余款金额
        Double actualAmount = Double.parseDouble(payinfo.getActualamount() != null ? payinfo.getActualamount() : "0");
        ///获取争议金额
        Double disputeAmount = Double.parseDouble(payinfo.getDisputeamount() != null ? payinfo.getDisputeamount() : "0");

        ////判断争议处理金额是否正常
        Double sum = PreciseCompute.add(actualAmount, disputeAmount);
        sum=PreciseCompute.round(sum, 2);
        if (onlineBalnce.doubleValue() != sum.doubleValue()) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///当前买家用户的消费记录
        Consumerecod buyerCode = new Consumerecod();
        ///当前卖家用户的消费记录
        Consumerecod sellerCode = new Consumerecod();

        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前买家收到余款运费
        buyerCode = this.setConsumeRecode(buyer, seller, actualAmount, actualAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETONLINEMONEY,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        ///买家账户流水描述
        buyerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";" + buyer.getLoginName() + "收到运费" + seller.getLoginName() + ":" + actualAmount + "元;争议:" + disputeAmount + "元");
        buyerCode.setRemarks(buyer.getLoginName() + "收到余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        buyerCode.setPaycode(buyerCode.getConsumecode());
        //涉及的用运单信息
        buyerCode.setOrderinfo(orderinfo);

        ///卖家收到争议退费资金
        sellerCode = this.setConsumeRecode(seller, seller, disputeAmount, disputeAmount, -disputeAmount,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_DISPUTEMONEYRETURN,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);

        ////系统账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";收到退还争议运费" + disputeAmount + "元");
        sellerCode.setRemarks(sellerCode.getConsumewaydesp());
        sellerCode.setPaycode(buyerCode.getConsumecode());
        sellerCode.setOrderinfo(orderinfo);
        
      ///托运方支付余款运费部分记录
        Consumerecod sellerPayCode = new Consumerecod();
        ///托运方支付余付款:帐户余额不变、冻结资金变动
        sellerPayCode = this.setConsumeFrezRecode(seller, buyer, -actualAmount, 0.00, -actualAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付付款账户流水描述
        sellerPayCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "支付余款运费:" + actualAmount + "元");
        sellerPayCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "支付余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        sellerPayCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerPayCode.setOrderinfo(orderinfo);

        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	AccountUtils accountUtils=new AccountUtils();
        	//获取最新业务结算单号
        	String tradeSettlementId= accountUtils.getTradeSettlementId();

        	sellerCode.setTradeSettlementId(tradeSettlementId);
        	buyerCode.setTradeSettlementId(tradeSettlementId);
        	sellerPayCode.setTradeSettlementId(tradeSettlementId);
        	
        	if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	//冻结金额转账
            	int back=accountBiz.freezeBalanceTransfer(seller,buyer,payinfo.getActualamount(),DataDic.TRANSFER_OUTER,orderinfo.getOrderno(),DataDic.CONSUMERECODE_MODEL_TRADEORDER,tradeSettlementId,orderinfo.getIsLockWay());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
                //解冻--争议退费
            	int back1= 0;
            	if(DataDic.YES.equals(orderinfo.getIsLockWay())){
            		back1=accountBiz.lockAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNLOCK,accountUtils.getTradeSettlementId());
            	}else{
            		back1=accountBiz.freezeAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNFREEZE,accountUtils.getTradeSettlementId());
            	}
                if(back1!=DataDic.RETURN_STATUS_NORMAL){
                	return back1;
                }
            }else if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	//int back=accountBiz.freezeBalanceTransfer(seller,buyer,actualAmount.toString(),DataDic.TRANSFER_OUTER_BANK);
            	/*if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}*/
            	
            	result = DataDic.RETURN_STATUS_OREDERAPPLYPAY;
                //解冻
                int back1= 0;
            	if(DataDic.YES.equals(orderinfo.getIsLockWay())){
            		back1=accountBiz.lockAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNLOCK,accountUtils.getTradeSettlementId());
            	}else{
            		back1=accountBiz.freezeAccount(seller, disputeAmount.toString(), DataDic.TRANSFER_UNFREEZE,accountUtils.getTradeSettlementId());
            	}
                if(back1!=DataDic.RETURN_STATUS_NORMAL){
                	return back1;
                }
            }else if(Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	return DataDic.RETURN_STATUS_SYSBUG;
            }
        }else{
        	///变动账户体系中的平台总余额
            result = userPurseService.editPureWebBalance(buyer, actualAmount, DataDic.COUNT_WAY_PLUS);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
            ///卖家账户的冻结资金变动--所有的线上支付余额冻结部分减少
            result = userPurseService.editFreeze(seller, onlineBalnce, DataDic.COUNT_WAY_SUB);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
            ///卖家收到争议退费
            result = userPurseService.editPureWebBalance(seller, disputeAmount, DataDic.COUNT_WAY_PLUS);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
        }
        consumeRecodService.save(buyerCode);
        consumeRecodService.save(sellerCode);
        consumeRecodService.save(sellerPayCode);
        String[] keyword = {"争议运费:" + disputeAmount.toString()};
        SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_RECHARGE, seller.getLoginName(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsRechargeSuccess);

        return result;
    }

    
    /**
     * 支付余款--付款到司机
     *
     * @param orderinfo
     * @return
     */
    @Transactional(readOnly = false)
    public int orderBalancePayRecodeBiz(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;

        ///运单信息
        orderinfo = orderinfoService.get(orderinfo.getId());
        ///当前用户信息
        User curUser = UserUtils.getUser();

        ///判断运单信息是否完整
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } else if (curUser == null) {//判断用户是否登录;未登录则权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        ///如果当前登录用户是否是运单的卖用户
        if (!curUser.getId().equals(seller.getId())) {
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取当前运单的状态
        String orderStatus = orderinfo.getOrderstatus();
        String payStatus = orderinfo.getPaystatus();
        String isonlinepay = orderinfo.getIsonlinepay();
        ///判断运单是否是同意运输,是否是在线支付运单,运单修改状态前的运单支付状态为冻结状态或者预支付状态
        if (!DataDic.ORDER_ONLINEPAY.equals(isonlinepay) && (!DataDic.ORDER_PAY_PAYPREMONEY.equals(payStatus) && !DataDic.ORDER_PAY_FORZEN.equals(payStatus))) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上支付实际余款金额
        Double actualAmount = Double.parseDouble(payinfo.getActualamount() != null ? payinfo.getActualamount() : "0");

        ///当前买家用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前买家收到余款运费
        accountCode = this.setConsumeRecode(buyer, seller, actualAmount, actualAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETONLINEMONEY,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        ///买家账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";" + buyer.getLoginName() + "收到" + seller.getLoginName() + "支付余款运费:" + actualAmount + "元");
        accountCode.setRemarks(buyer.getLoginName() + "收到余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        accountCode.setPaycode(accountCode.getConsumecode());
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        
      ///托运方支付余款运费部分记录
        Consumerecod sellerCode = new Consumerecod();
        ///托运方支付余付款:帐户余额不变、冻结资金变动
        sellerCode = this.setConsumeFrezRecode(seller, buyer, -actualAmount, 0.00, -actualAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付付款账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "支付余款运费:" + actualAmount + "元");
        sellerCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "支付余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        sellerCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerCode.setOrderinfo(orderinfo);

        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	AccountUtils accountUtils=new AccountUtils();
        	//获取最新业务结算单号
        	String tradeSettlementId= accountUtils.getTradeSettlementId();
    		sellerCode.setTradeSettlementId(tradeSettlementId);
    		accountCode.setTradeSettlementId(tradeSettlementId);
    		
        	if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
        		
        		int back=accountBiz.freezeBalanceTransfer(seller,buyer,actualAmount.toString(),DataDic.TRANSFER_OUTER,orderinfo.getOrderno(),DataDic.CONSUMERECODE_MODEL_TRADEORDER,tradeSettlementId,orderinfo.getIsLockWay());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }else if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
        		
            	int back=accountBiz.freezeBalanceTransfer(seller,buyer,actualAmount.toString(),DataDic.TRANSFER_OUTER_BANK,orderinfo.getOrderno(),DataDic.CONSUMERECODE_MODEL_TRADEORDER,tradeSettlementId,orderinfo.getIsLockWay());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }else if(Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	return DataDic.RETURN_STATUS_SYSBUG;
            }
        }else{
        	///变动账户体系中的平台总余额
            result = userPurseService.editPureWebBalance(buyer, actualAmount, DataDic.COUNT_WAY_PLUS);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }

            ///卖家账户的冻结资金变动
            result = userPurseService.editFreeze(seller, actualAmount, DataDic.COUNT_WAY_SUB);

            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
        }
        consumeRecodService.save(sellerCode);
        consumeRecodService.save(accountCode);
        return result;
    }

    /**
     * 支付余款--付款到司机--非争议添加流水
     *
     * @param orderinfo
     * @return
     */
    @Transactional(readOnly = false)
    public int orderPayConsumeRecode(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;

        ///运单信息
        orderinfo = orderinfoService.get(orderinfo.getId());

        ///判断运单信息是否完整
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } 
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());

        //获取当前运单的状态
        String orderStatus = orderinfo.getOrderstatus();
        String payStatus = orderinfo.getPaystatus();
        String isonlinepay = orderinfo.getIsonlinepay();
        ///判断运单是否是同意运输,是否是在线支付运单,运单修改状态前的运单支付状态为冻结状态或者预支付状态
        if (!DataDic.ORDER_ONLINEPAY.equals(isonlinepay) && (!DataDic.ORDER_PAY_PAYPREMONEY.equals(payStatus) && !DataDic.ORDER_PAY_FORZEN.equals(payStatus))) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上支付实际余款金额
        Double actualAmount = Double.parseDouble(payinfo.getActualamount() != null ? payinfo.getActualamount() : "0");

        ///当前买家用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前买家收到余款运费
        accountCode = this.setConsumeRecode(buyer, seller, actualAmount, actualAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETONLINEMONEY,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        ///买家账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";" + buyer.getLoginName() + "收到" + seller.getLoginName() + "支付余款运费:" + actualAmount + "元");
        accountCode.setRemarks(buyer.getLoginName() + "收到余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        accountCode.setPaycode(accountCode.getConsumecode());
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        
      ///托运方支付余款运费部分记录
        Consumerecod sellerCode = new Consumerecod();
        ///托运方支付余付款:帐户余额不变、冻结资金变动
        sellerCode = this.setConsumeFrezRecode(seller, buyer, -actualAmount, 0.00, -actualAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付付款账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "支付余款运费:" + actualAmount + "元");
        sellerCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "支付余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        sellerCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerCode.setOrderinfo(orderinfo);

        
        consumeRecodService.save(sellerCode);
        consumeRecodService.save(accountCode);
        return result;
    }

    
    /**
     * 支付余款--付款到司机--到达司机的余款需审核
     *
     * @param orderinfo
     * @return
     */
    @Transactional(readOnly = false)
    public int orderBalancePayRecode2Biz(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;

        ///运单信息
        orderinfo = orderinfoService.get(orderinfo.getId());
        ///当前用户信息
        User curUser = UserUtils.getUser();

        ///判断运单信息是否完整
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } else if (curUser == null) {//判断用户是否登录;未登录则权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        ///如果当前登录用户是否是运单的卖用户
        if (!curUser.getId().equals(seller.getId())) {
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取当前运单的状态
        String orderStatus = orderinfo.getOrderstatus();
        String payStatus = orderinfo.getPaystatus();
        String isonlinepay = orderinfo.getIsonlinepay();
        ///判断运单是否是同意运输,是否是在线支付运单,运单修改状态前的运单支付状态为冻结状态或者预支付状态
        if (!DataDic.ORDER_ONLINEPAY.equals(isonlinepay) && (!DataDic.ORDER_PAY_PAYPREMONEY.equals(payStatus) && !DataDic.ORDER_PAY_FORZEN.equals(payStatus))) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上支付实际余款金额
        Double actualAmount = Double.parseDouble(payinfo.getActualamount() != null ? payinfo.getActualamount() : "0");

        ///当前买家用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前买家收到余款运费
        accountCode = this.setConsumeRecode(buyer, seller, actualAmount, actualAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETONLINEMONEY,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        ///买家账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";" + buyer.getLoginName() + "收到" + seller.getLoginName() + "支付余款运费:" + actualAmount + "元");
        accountCode.setRemarks(buyer.getLoginName() + "收到余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        accountCode.setPaycode(accountCode.getConsumecode());
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        
      ///托运方支付余款运费部分记录
        Consumerecod sellerCode = new Consumerecod();
        ///托运方支付余付款:帐户余额不变、冻结资金变动
        sellerCode = this.setConsumeFrezRecode(seller, buyer, -actualAmount, 0.00, -actualAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYONLIENMONEY,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付付款账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "支付余款运费:" + actualAmount + "元");
        sellerCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "支付余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        sellerCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerCode.setOrderinfo(orderinfo);

        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
        		AccountUtils accountUtils=new AccountUtils();
        		//获取最新业务结算单号
        		String tradeSettlementId= accountUtils.getTradeSettlementId();

        		sellerCode.setTradeSettlementId(tradeSettlementId);
        		accountCode.setTradeSettlementId(tradeSettlementId);
        		
        		int back=accountBiz.freezeBalanceTransfer(seller,buyer,actualAmount.toString(),DataDic.TRANSFER_OUTER,orderinfo.getOrderno(),DataDic.CONSUMERECODE_MODEL_TRADEORDER,tradeSettlementId,orderinfo.getIsLockWay());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }else if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	/*int back=accountBiz.freezeBalanceTransfer(seller,buyer,actualAmount.toString(),DataDic.TRANSFER_OUTER_BANK);
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}*/
            	result = DataDic.RETURN_STATUS_OREDERAPPLYPAY;
            }else if(Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	return DataDic.RETURN_STATUS_SYSBUG;
            }
        }else{
        	///变动账户体系中的平台总余额
            result = userPurseService.editPureWebBalance(buyer, actualAmount, DataDic.COUNT_WAY_PLUS);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }

            ///卖家账户的冻结资金变动
            result = userPurseService.editFreeze(seller, actualAmount, DataDic.COUNT_WAY_SUB);

            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                return result;
            }
        }
        consumeRecodService.save(sellerCode);
        consumeRecodService.save(accountCode);
        return result;
    }

    /**
     * 支付卓币余款--付款到司机
     *
     * @param orderinfo
     * @return
     */
    @Transactional(readOnly = false)
    public int orderCoinPayRecodeBiz(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;

        ///运单信息
        orderinfo = orderinfoService.get(orderinfo.getId());
        ///当前用户信息
        User curUser = UserUtils.getUser();

        ///判断运单信息是否完整
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } else if (curUser == null) {//判断用户是否登录;未登录则权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        ///如果当前登录用户是否是运单的卖用户
        if (!curUser.getId().equals(seller.getId())) {
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取当前运单的状态
        String orderStatus = orderinfo.getOrderstatus();
        String payStatus = orderinfo.getPaystatus();
        String isonlinepay = orderinfo.getIspaycoin();
        ///判断运单是否是同意运输,是否是在线支付运单,运单修改状态前的运单支付状态为冻结状态或者预支付状态
        if (!DataDic.ORDER_ONLINEPAY.equals(isonlinepay)) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上支付实际余款金额
        Double actualAmount = Double.parseDouble(payinfo.getCoinactualpay() != null ? payinfo.getCoinactualpay() : "0");

        ///当前买家用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        ///当前买家收到余款运费
        accountCode = this.setConsumeRecode(buyer, seller, actualAmount, actualAmount, 0.00,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETONLINECOIN,
                DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///买家账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + ";" + buyer.getLoginName() + "收到" + seller.getLoginName() + "卓币余款运费:" + actualAmount + "元");
        accountCode.setRemarks(buyer.getLoginName() + "收到卓币余款运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        accountCode.setPaycode(accountCode.getConsumecode());
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        ///托运方支付预付运费部分记录
        Consumerecod sellerCode = new Consumerecod();
        ///托运方支付预付款:帐户余额不变、冻结资金变动
        sellerCode = this.setConsumeFrezRecode(seller, buyer, -actualAmount,0.00 , -actualAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYONLIENCOIN,
                DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付预付款账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "支付余款卓币运费:" + actualAmount + "币");
        sellerCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "支付余款卓币运费" + actualAmount + ";运单号:" + orderinfo.getOrderno());
        sellerCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerCode.setOrderinfo(orderinfo);
        ///变动账户体系中的平台总余额
        result = userPurseService.editPureWebCoin(buyer, actualAmount, DataDic.COUNT_WAY_PLUS);
        ///如果保存信息异常
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            return result;
        }
        ///卖家账户的冻结资金变动
        result = userPurseService.editCoinFreeze(seller, actualAmount, DataDic.COUNT_WAY_SUB);

        ///如果保存信息异常
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            return result;
        }
        consumeRecodService.save(sellerCode);
        consumeRecodService.save(accountCode);
        return result;
    }


    /**
     * 预付款到司机
     *
     * @param orderinfo
     * @return
     */
    @Transactional(readOnly = false)
    public int orderPrePayRecodeBiz(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///当前用户信息
        User curUser = UserUtils.getUser();
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } else if (curUser == null) {//判断用户是否登录;未登录则权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        ///如果当前登录用户是否是运单的买方用户
        if (!curUser.getId().equals(buyer.getId())) {
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取当前运单的状态
        String payStatus = orderinfo.getPaystatus();
        String isPrePay = orderinfo.getIsprepay();
        ///判断运单是否是在线支付运单,修改运单支付状态前支付状态是否为冻结状态
        if (!DataDic.ORDER_PREPAY.equals(isPrePay) && !DataDic.ORDER_PAY_FORZEN.equals(payStatus)) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上预支付金额
        Double prepayAmount = Double.parseDouble(payinfo.getPreamount());

        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        ///当前买家收到预付运费
        accountCode = this.setConsumeRecode(buyer, seller, prepayAmount, prepayAmount, 0.00,
                    DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETPREMONEY,
                    consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                    DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        
        ///买家账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 收到" + seller.getLoginName() + "预付款:" + prepayAmount + "元");
        accountCode.setRemarks(buyer.getLoginName() + "收到" + seller.getLoginName() + "预付运费" + prepayAmount + ";运单号:" + orderinfo.getOrderno());
        ///交易编号
        accountCode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.MODEL_TRADEORDER));
        accountCode.setPaycode(accountCode.getConsumecode());
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        
      ///托运方支付预付运费部分记录
        Consumerecod sellerCode = new Consumerecod();
        ///托运方支付预付款:帐户余额不变、冻结资金变动
        sellerCode = this.setConsumeFrezRecode(seller, buyer, -prepayAmount, 0.00, -prepayAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYPREMONEY,
                consumeWay, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付预付款账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "预付运费:" + prepayAmount + "元");
        sellerCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "预付运费" + prepayAmount + ";运单号:" + orderinfo.getOrderno());
        sellerCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerCode.setOrderinfo(orderinfo);

        if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
        	AccountUtils accountUtils=new AccountUtils();
        	if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
        		//获取最新业务结算单号
        		String tradeSettlementId= accountUtils.getTradeSettlementId();
        		sellerCode.setTradeSettlementId(tradeSettlementId);
        		accountCode.setTradeSettlementId(tradeSettlementId);
        		
            	int back=accountBiz.freezeBalanceTransfer(seller,buyer,prepayAmount.toString(),DataDic.TRANSFER_OUTER,null,null,tradeSettlementId,orderinfo.getIsLockWay());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }else if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	//获取最新业务结算单号
            	String tradeSettlementId= accountUtils.getTradeSettlementId();
            	sellerCode.setTradeSettlementId(tradeSettlementId);
        		accountCode.setTradeSettlementId(tradeSettlementId);
        		
            	int back=accountBiz.freezeBalanceTransfer(seller,buyer,prepayAmount.toString(),DataDic.TRANSFER_OUTER_BANK,null,null,tradeSettlementId,orderinfo.getIsLockWay());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
            }else if(Tools.IsNullOrWhiteSpace(seller.getMemberId())&&!Tools.IsNullOrWhiteSpace(buyer.getMemberId())){
            	return DataDic.RETURN_STATUS_SYSBUG;
            }
        }else{
        	///变动账户体系中的平台总余额
            result = userPurseService.editPureWebBalance(buyer, prepayAmount, DataDic.COUNT_WAY_PLUS);
            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                throw new RuntimeException("修改账户体系余额失败");
            }
            ///卖家账户的冻结资金变动
            result = userPurseService.editFreeze(seller, prepayAmount, DataDic.COUNT_WAY_SUB);

            ///如果保存信息异常
            if (DataDic.RETURN_STATUS_NORMAL != result) {
                throw new RuntimeException("修改账户体系余额失败");
            }
        }

        consumeRecodService.save(sellerCode);
        consumeRecodService.save(accountCode);
        return result;
    }

    /**
     * 预付款到司机
     *
     * @param orderinfo
     * @return
     */
    @Transactional(readOnly = false)
    public int orderPrePayCoinRecodeBiz(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///当前用户信息
        User curUser = UserUtils.getUser();
        ///运单支付信息是否完整
        if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null || orderinfo.getPayinfo() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        } else if (curUser == null) {//判断用户是否登录;未登录则权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());
        ///如果当前登录用户是否是运单的买方用户
        if (!curUser.getId().equals(buyer.getId())) {
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        //获取当前运单的状态
        String payStatus = orderinfo.getPaystatus();
        ///是否预付卓币
        String isPrePay = orderinfo.getIsprecoin();
        ///判断运单是否是在线支付运单,修改运单支付状态前支付状态是否为冻结状态
        if (!DataDic.ORDER_PREPAY.equals(isPrePay) && !DataDic.ORDER_PAY_FORZEN.equals(payStatus)) {
            ///如果不是新运单或者运单不是在线支付--则没有支付权限
            return DataDic.RETURN_STATUS_AUTHBUG;
        }
        ///获取支付信息
        TradePayinfo payinfo = payinfoService.get(orderinfo.getPayinfo().getId());
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上预支付金额
        Double prepayAmount = Double.parseDouble(payinfo.getCoinpreamount());

        ///托运方支付预付卓币部分记录
        Consumerecod sellerCode = new Consumerecod();
        ///托运方支付预付款:帐户余额不变、冻结资金变动
        sellerCode = this.setConsumeFrezRecode(seller, buyer, -prepayAmount, 0.00, -prepayAmount,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYPRECOIN,
                DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///支付预付款账户流水描述
        sellerCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 向" + buyer.getLoginName() + "预付卓币:" + prepayAmount + "币");
        sellerCode.setRemarks(seller.getLoginName() + "向" + buyer.getLoginName() + "预付卓币运费" + prepayAmount + ";运单号:" + orderinfo.getOrderno());
        sellerCode.setPaycode(sellerCode.getConsumecode());
        //涉及的用运单信息
        sellerCode.setOrderinfo(orderinfo);
        ///承运方用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        ///当前承运方家收到预付运费
        accountCode = this.setConsumeRecode(buyer, seller, prepayAmount, prepayAmount, 0.00,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_GETPRECOIN,
                DataDic.CONSUMERECODE_WAY_COIN, DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        ///买家账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 收到" + seller.getLoginName() + "卓币预付款:" + prepayAmount + "币");
        accountCode.setRemarks(buyer.getLoginName() + "收到" + seller.getLoginName() + "卓币预付运费" + prepayAmount + ";运单号:" + orderinfo.getOrderno());
        accountCode.setPaycode(accountCode.getConsumecode());
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        ///变动账户体系中的平台总余额
        result = userPurseService.editPureWebCoin(buyer, prepayAmount, DataDic.COUNT_WAY_PLUS);
        ///如果保存信息异常
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            throw new RuntimeException("修改账户体系余额失败");
        }
        ///卖家账户的冻结卓币资金变动
        result = userPurseService.editCoinFreeze(seller, prepayAmount, DataDic.COUNT_WAY_SUB);

        ///如果保存信息异常
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            throw new RuntimeException("修改账户体系余额失败");
        }

        consumeRecodService.save(sellerCode);
        consumeRecodService.save(accountCode);

        return result;
    }

    /***
     * 冻结线上运费
     *
     * @param orderinfo 完整的运单信息、订单ID、运单支付信息
     * @return
     */
    @Transactional(readOnly = false)
    public int orderOnlineFreezeRecodeBiz(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///运单信息
        //orderinfo = orderinfoService.get(orderinfo.getId());

        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());

        ///获取支付信息
        TradePayinfo payinfo = orderinfo.getPayinfo();
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上支付金额--预冻结运费资金
        Double onlineAmount = Double.parseDouble(payinfo.getOnlineamount());
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
        if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))){
        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
        }
        ///当前用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        accountCode = this.setConsumeRecode(seller, buyer, -onlineAmount, -onlineAmount, onlineAmount, DataDic.COUNT_WAY_SUB,
                DataDic.CONSUMERECODE_TYPE_FORZENONLINE, consumeWay,
                DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_STATUS_FREEZING,
                DataDic.ISSYSRECODE_NO);
        ///账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 冻结运费" + onlineAmount + "元");
        accountCode.setRemarks(seller.getLoginName() + "冻结线上支付运费" + onlineAmount + ";运单号:" + orderinfo.getOrderno());
        ///交易编号
        accountCode.setPaycode(accountCode.getConsumecode());
        //accountCode.preInsert();
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        ///变动账户体系中的平台总余额
        if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))){
        	AccountUtils accountUtils=new AccountUtils();
        	String tradeSettlementId = accountUtils.getTradeSettlementId();
        	accountCode.setTradeSettlementId(tradeSettlementId);
        	//冻结
        	int back= 0;
        	back=accountBiz.lockAccount(seller,payinfo.getOnlineamount(),DataDic.TRANSFER_LOCK,tradeSettlementId);
        	
        	if(back!=DataDic.RETURN_STATUS_NORMAL){
        		return back;
        	}
        }else{
        	result = userPurseService.editAvbFreeze(seller, onlineAmount, DataDic.COUNT_WAY_SUB);
        }
        
        ///如果保存信息异常
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            throw new RuntimeException("修改账户体系余额失败");
        }
        consumeRecodService.save(accountCode);
        return result;
    }

    /**
     * 运单卓币冻结资金
     *
     * @param orderinfo 完整的运单信息、订单ID、运单支付信息
     * @return
     */
    @Transactional(readOnly = false)
    public int orderCoinFreezeRecodeBiz(Orderinfo orderinfo) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///运单信息
        //获取买卖家的信息
        User buyer = UserUtils.findUser(orderinfo.getBuyer());
        User seller = UserUtils.findUser(orderinfo.getSeller());

        ///获取支付信息
        TradePayinfo payinfo = orderinfo.getPayinfo();
        if (payinfo == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //线上支付金额--冻结运费卓币资金
        Double onlineAmount = Double.parseDouble(payinfo.getCoinamount());

        ///当前用户的消费记录
        Consumerecod accountCode = new Consumerecod();
        accountCode = this.setConsumeRecode(seller, buyer, -onlineAmount, -onlineAmount, onlineAmount, DataDic.COUNT_WAY_SUB,
                DataDic.CONSUMERECODE_TYPE_FORZENONLINECOIN, DataDic.CONSUMERECODE_WAY_COIN,
                DataDic.CONSUMERECODE_MODEL_TRADEORDER, DataDic.CONSUMERECODE_STATUS_FREEZING,
                DataDic.ISSYSRECODE_NO);
        ///账户流水描述
        accountCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + " 冻结卓币运费" + onlineAmount + "元");
        accountCode.setRemarks(seller.getLoginName() + "冻结线上支付卓币" + onlineAmount + ";运单号:" + orderinfo.getOrderno());
        ///交易编号
        accountCode.setPaycode(accountCode.getConsumecode());
        //accountCode.preInsert();
        //涉及的用运单信息
        accountCode.setOrderinfo(orderinfo);
        ///变动账户体系中的平台卓币总余额
        result = userPurseService.editPureWebCoin(seller, onlineAmount, DataDic.COUNT_WAY_SUB);
        ///如果保存信息异常
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            throw new RuntimeException("修改账户体系余额失败");
        }
        ///冻结资金增加
        result = userPurseService.editCoinFreeze(seller, onlineAmount, DataDic.COUNT_WAY_PLUS);

        ///如果保存信息异常
        if (DataDic.RETURN_STATUS_NORMAL != result) {
            throw new RuntimeException("修改账户体系余额失败");
        }
        consumeRecodService.save(accountCode);
        return result;
    }

    /***
     * 后台充值审核通过
     *
     * @param consumeaudit
     * @return
     */
    @Transactional(readOnly = false)
    public int backAuditRechargeRecode(Consumeaudit consumeaudit) {
        int resultStatus = 1;
        if (consumeaudit == null) {
            return 2;
        }
        Consumerecod consumerecod = consumeRecodService.get(consumeaudit.getConsume().getId());
        if (consumerecod == null) {
            return 2;
        }
        String auditStatus = consumeaudit.getAuditstatus();
        ////new 一个新的修改流水记录对象
        Consumerecod upcode = new Consumerecod();
        if (DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(auditStatus)) {
            consumerecod.setConsumestatus(DataDic.CONSUMERECODE_STATUS_SUCCES);
            consumerecod.preUpdate();
            ///审核通过修改充值账户金额也就是目标账户
            userPurseService.editPureWebBalance(consumerecod.getTarget(), Double.parseDouble(consumerecod.getConsumemony()), DataDic.COUNT_WAY_PLUS);

            ///修改记录流水交易成功
            upcode.setId(consumerecod.getId());
            upcode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_SUCCES);
            upcode.preUpdate();
            consumeRecodService.save(upcode);
            String[] keyword = {consumerecod.getConsumemony()};

            SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_RECHARGE, consumerecod.getTarget().getLoginName(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsRechargeSuccess);

        } else if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(auditStatus)) {
            ////充值驳回,记录为删除状态,充值状态为充值失败
            upcode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_FAILED);
            upcode.setDelFlag(DataDic.DEL_FLAG_DELETE);
            upcode.preUpdate();
            consumeRecodService.save(upcode);
        }

        return resultStatus;
    }

    /***
     * 后台提现记录流水修改状态
     *
     * @param consumeaudit 交易ID
     * @return
     */
    @Transactional(readOnly = false)
    public int backAuditCashRecodeBiz(Consumeaudit consumeaudit) {
        int resultStatus = 1;
        if (consumeaudit == null) {
            return 2;
        }
        ///交易流水信息
        Consumerecod consumerecod = consumeRecodService.get(consumeaudit.getConsume().getId());
        if (consumerecod == null) {
            return 2;
        }
        //审核状态
        String auditStatus = consumeaudit.getAuditstatus();
        ////new 一个新的修改流水记录对象
        Consumerecod upcode = new Consumerecod();
        upcode.setId(consumerecod.getId());
        ///提现用户
        User cashUser = UserUtils.findUser(consumerecod.getAccount());
        ///如果终审通过
        if ((DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(auditStatus)&&!DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway()))||(DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(auditStatus)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway()))) {
            ///审核通过冻结资金减少
        	if(!Tools.IsNullOrWhiteSpace(cashUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway())){
        		if(Tools.IsNullOrWhiteSpace(consumerecod.getUserBankinfo().getId())){
        			return DataDic.RETURN_STATUS_INFOBUG;
        		}
        		AccountUtils accountUtils=new AccountUtils();
        		//获取最新业务结算单号
        		String tradeSettlementId= accountUtils.getTradeSettlementId();
        		upcode.setTradeSettlementId(tradeSettlementId);
        		int back=accountBiz.accountCash(cashUser,consumerecod.getConsumemony(),consumerecod.getUserBankinfo().getId(),consumerecod.getId(),DataDic.CONSUMERECODE_MODEL_CASH,tradeSettlementId,DataDic.YES);
        		if(back!=DataDic.RETURN_STATUS_NORMAL){
        			return back;
        		}
        	}else{
        		userPurseService.editFreeze(cashUser, Double.valueOf(consumerecod.getConsumemony()), DataDic.COUNT_WAY_SUB);
        	}

            ///修改记录流水交易成功
            upcode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_SUCCES);
            upcode.preUpdate();
            ///通过交易流水编号修改
            consumeRecodService.updateByConsumeStatus(upcode);
            String[] keyword = {consumerecod.getConsumemony()};

            SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_CASH, consumerecod.getTarget().getLoginName(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsCash);

        } else if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(auditStatus)) {///审核驳回

            ///交易流水编号
            //upcode.setConsumecode(consumerecod.getConsumecode());
            ///提现失败;提现用户账户资金转回,冻结资金减少
        	if(!Tools.IsNullOrWhiteSpace(cashUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway())){
        		//解冻
        		AccountUtils accountUtils=new AccountUtils();
        		//获取最新业务结算单号
        		String tradeSettlementId= accountUtils.getTradeSettlementId();
        		upcode.setTradeSettlementId(tradeSettlementId);
        		
        		int back=accountBiz.lockAccount(cashUser,consumerecod.getConsumemony(),DataDic.TRANSFER_UNLOCK,tradeSettlementId);
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
        	}else{
        		userPurseService.editPureWebBalance(cashUser, Double.parseDouble(consumerecod.getConsumemony()), DataDic.COUNT_WAY_PLUS);
                userPurseService.editFreeze(cashUser, Double.parseDouble(consumerecod.getConsumemony()), DataDic.COUNT_WAY_SUB);
        	}
            
            ///提现和转账流水交易失败
            upcode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_FAILED);
            upcode.preUpdate();
            ///通过交易流水编号修改
            consumeRecodService.updateByConsumeStatus(upcode);
        }

        return resultStatus;
    }

    /***
     * 后台提现记录流水修改状态
     *
     * @param id 交易ID
     * @return
     */
    @Transactional(readOnly = false)
    public int backCashRecodeBiz(String id,int type) {
        int resultStatus = 1;
        if (Tools.IsNullOrWhiteSpace(id)) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        Consumeaudit oldConsumaudit = consumeauditService.get(id);
        if(oldConsumaudit==null){
        	 return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///交易流水信息
        Consumerecod consumerecod = consumeRecodService.get(oldConsumaudit.getConsume().getId());
        if (consumerecod == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        //审核状态
        String auditStatus = String.valueOf(type);
        ////new 一个新的修改流水记录对象
        Consumerecod upcode = new Consumerecod();
        upcode.setId(consumerecod.getId());
        ///提现用户
        User cashUser = UserUtils.findUser(consumerecod.getAccount());
        ///如果终审通过
        if ((DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(auditStatus)&&!DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway()))||(DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(auditStatus)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway()))) {
            
            ///修改记录流水交易成功
            upcode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_SUCCES);
            upcode.preUpdate();
            ///通过交易流水编号修改
            consumeRecodService.updateByConsumeStatus(upcode);
            
            ///修改数据
            Consumeaudit updata = oldConsumaudit;
            updata.preUpdate();
            updata.setId(oldConsumaudit.getId());
            updata.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_TOREVIEW);
            updata.setRemarks("提现成功");
            consumeauditService.save(updata);
            updata.setConsume(oldConsumaudit.getConsume());
            deallogService.saveDealLog(updata);

            
            String[] keyword = {consumerecod.getConsumemony()};

            SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_CASH, consumerecod.getTarget().getLoginName(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsCash);

        } else if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(auditStatus)) {///审核驳回

            ///交易流水编号
            //upcode.setConsumecode(consumerecod.getConsumecode());
            ///提现失败;提现用户账户资金转回,冻结资金减少
        	if(!Tools.IsNullOrWhiteSpace(cashUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway())){
        		//解冻
        		AccountUtils accountUtils=new AccountUtils();
        		int back=accountBiz.lockAccount(cashUser,consumerecod.getConsumemony(),DataDic.TRANSFER_UNLOCK,accountUtils.getTradeSettlementId());
            	if(back!=DataDic.RETURN_STATUS_NORMAL){
            		return back;
            	}
        	}
            
            ///提现和转账流水交易失败
            upcode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_FAILED);
            upcode.preUpdate();
            ///通过交易流水编号修改
            consumeRecodService.updateByConsumeStatus(upcode);
            oldConsumaudit.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_FAILED);
			oldConsumaudit.setRemarks("提现失败,资金已经返回");
			consumeauditService.save(oldConsumaudit);
        }

        return resultStatus;
    }
    
    /***
     * 审核状态修改
     *
     * @param consumeaudit
     * @return
     */
    @Transactional(readOnly = false)
    public int consumeAuditStatus(Consumeaudit consumeaudit) {
        ///成功
        int resultStatus = 1;
        ///即将修改的审核信息
        Consumeaudit oldConsumaudit = consumeauditService.get(consumeaudit.getId());
        if (oldConsumaudit == null) {
            return 2;
        }
        ///修改的状态
        String upStatus = consumeaudit.getAuditstatus();
        //原来的状态
        String oldStatus = oldConsumaudit.getAuditstatus();
        ///如果修改的状态为审核通过
        if (DataDic.CONSUMEAUDIT_STATUS_TRIAL.equals(upStatus)) {
        	String[] rols = {DataDic.ROLE_AUDITCLERK, DataDic.ROLE_POS_FINANCIAL};
            if (!UserUtils.vialedRole(rols) || (!DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT.equals(oldStatus) && !DataDic.CONSUMEAUDIT_STATUS_UPTECP.equals(oldStatus))) {
                //权限不足
                return resultStatus = 0;
            } else if (DataDic.CONSUMEAUDIT_STATUS_TRIAL.equals(oldStatus)) {///是否一审核
                return resultStatus = 3;
            }
        } else if (DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(upStatus)) {////修改终审
            ///判断权限问题和是否到达终审
            if (!UserUtils.vialedRole(DataDic.ROLE_FINALCLERK) || !DataDic.CONSUMEAUDIT_STATUS_TRIAL.equals(oldStatus)) {
                //权限不足
                return resultStatus = 0;
            } else if (DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(oldStatus)) {///是否已经终审审核
                return resultStatus = 3;
            }
        } else if (DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(upStatus)) {
            if (!UserUtils.vialedRole(DataDic.ROLE_AUDITCLERK) || !DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(oldStatus)) {
                //权限不足
                return resultStatus = 0;
            } else if (DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(oldStatus)) {///是否已经终审审核
                return resultStatus = 3;
            }
        } else if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(upStatus)) {///是否驳回
            String[] rols = {DataDic.ROLE_FINALCLERK, DataDic.ROLE_FINANCEOFFICER, DataDic.ROLE_SYSADMIN};
            if (!UserUtils.vialedRole(rols) || DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(oldStatus) || DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(oldStatus)) {
                return 0;
            } else if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(oldStatus)) {///是否已经驳回审核
                return resultStatus = 3;
            }
        } else if (DataDic.CONSUMEAUDIT_ACCOUNTCASH.equals(oldConsumaudit.getType()) && DataDic.CONSUMEAUDIT_STATUS_UPTECP.equals(upStatus)) {///如果是提现,需要审核通过后上传凭据
            if (!UserUtils.vialedRole(DataDic.ROLE_FINANCEOFFICER) || (!DataDic.CONSUMEAUDIT_STATUS_TRIAL.equals(oldStatus) && !DataDic.CONSUMEAUDIT_STATUS_UPTECP.equals(oldStatus))) {
                //权限不足
                return resultStatus = 0;
            }
        } else {
            return 0;
        }
        ///修改数据
        Consumeaudit updata = oldConsumaudit;
        updata.preUpdate();
        updata.setId(oldConsumaudit.getId());
        updata.setAuditstatus(upStatus);
        updata.setRemarks(consumeaudit.getRemarks());
        updata.setConsumeImg(consumeaudit.getConsumeImg());
        ///账户资金变动
        if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(upStatus) || DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(upStatus)) {
            ///如果是账户充值,则在终审的时候账户资金变动
            if (DataDic.CONSUMEAUDIT_ACCOUNTRECHARGE.equals(oldConsumaudit.getType())) {

                resultStatus = this.backAuditRechargeRecode(updata);

            } else if (DataDic.CONSUMEAUDIT_ACCOUNTCASH.equals(oldConsumaudit.getType())) {///如果是账户提现
                resultStatus = this.backAuditCashRecodeBiz(updata);
            }
            if (resultStatus != 1) {
                return resultStatus;
            }
        }
        consumeauditService.save(updata);
        updata.setConsume(oldConsumaudit.getConsume());
        deallogService.saveDealLog(updata);

        return resultStatus;
    }
    
    /***
     * 提现审核方法--账户系统
     * @param consumeaudit
     * @return
     */
    @Transactional(readOnly = false)
    public int consumeCashAuditStatus(Consumeaudit consumeaudit) {
        ///成功
        int resultStatus = 1;
        ///即将修改的审核信息
        Consumeaudit oldConsumaudit = consumeauditService.get(consumeaudit.getId());
        if (oldConsumaudit == null) {
            return 2;
        }
        ///修改的状态
        String upStatus = consumeaudit.getAuditstatus();
        //原来的状态
        String oldStatus = oldConsumaudit.getAuditstatus();
        ///如果修改的状态为复合通过
        if (DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(upStatus)) {
            if (!UserUtils.vialedRole(DataDic.ROLE_FINANCEOFFICER) || !DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT.equals(oldStatus)) {
                //权限不足
                return resultStatus = 0;
            } else if (DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(oldStatus)) {///是否已经终审审核
                return resultStatus = 3;
            }
        } else if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(upStatus)) {///是否驳回
            String[] rols = {DataDic.ROLE_FINALCLERK, DataDic.ROLE_FINANCEOFFICER, DataDic.ROLE_SYSADMIN};
            if (!UserUtils.vialedRole(rols) || DataDic.CONSUMEAUDIT_STATUS_FINALJUDG.equals(oldStatus) || DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(oldStatus)) {
                return 0;
            } else if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(oldStatus)) {///是否已经驳回审核
                return resultStatus = 3;
            }
        }else {
            return 0;
        }
        ///修改数据
        Consumeaudit updata = oldConsumaudit;
        updata.preUpdate();
        updata.setId(oldConsumaudit.getId());
        updata.setAuditstatus(upStatus);
        updata.setRemarks(consumeaudit.getRemarks());
        updata.setConsumeImg(consumeaudit.getConsumeImg());
        ///账户资金变动
        if (DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(upStatus) || DataDic.CONSUMEAUDIT_STATUS_TOREVIEW.equals(upStatus)) {
            if (DataDic.CONSUMEAUDIT_ACCOUNTCASH.equals(oldConsumaudit.getType())) {///如果是账户提现
                resultStatus = this.backAuditCashRecodeBiz(updata);
            }
            if (resultStatus != 1) {
                return resultStatus;
            }
        }
        consumeauditService.save(updata);
        updata.setConsume(oldConsumaudit.getConsume());
        deallogService.saveDealLog(updata);

        return resultStatus;
    }
    
    @Transactional(readOnly = false)
    public int auditStatus(Consumeaudit consumeaudit){
    	Consumeaudit oldConsumaudit = consumeauditService.get(consumeaudit.getId());
    	Consumerecod consumerecod = consumeRecodService.get(oldConsumaudit.getConsume().getId());
    	if (DataDic.CONSUMEAUDIT_ACCOUNTCASH.equals(consumeaudit.getType())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway())){
			return consumeCashAuditStatus(consumeaudit);
		}else{
			return consumeAuditStatus(consumeaudit);
		}
    }


    /***
     * 保存提现申请
     *
     * @param consumerecod
     * @return
     */
    @Transactional(readOnly = false)
    public int saveCashAudit(Consumerecod consumerecod) {

        Consumeaudit consumeaudit = new Consumeaudit();
        //申请提现用户
        User account = consumerecod.getAccount();
        if (account == null || consumerecod == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        consumeaudit.setUser(account);
        consumeaudit.setConsume(consumerecod);
        ///用户提现
        consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTCASH);
        ///用户提现经过审核
        consumeaudit.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT);
        consumeaudit.setRemarks(consumerecod.getConsumewaydesp());
        //consumeaudit.preInsert();
        ///保存审核信息和申请日志
        consumeauditService.save(consumeaudit);
        deallogService.saveDealLog(consumeaudit);
        ///返回正常
        int result = DataDic.RETURN_STATUS_NORMAL;
        return result;
    }


    /**
     * 获取交易对象信息详细资料
     *
     * @param consumeaudit
     * @return
     */
    public Consumeaudit getConsumeAudit(Consumeaudit consumeaudit) {
        if (consumeaudit == null) {
            return null;
        }
        consumeaudit = consumeauditService.get(consumeaudit.getId());
        UserBankinfo userBankinfo=consumeaudit.getUser().getBankinfo();
        ///获取充值用户的全部信息
        consumeaudit.setUser(UserUtils.findUser(consumeaudit.getUser()));
        if(userBankinfo==null){
        	consumeaudit.getUser().setBankinfo(userBiz.getUserBankInfo(consumeaudit.getUser()));
        }else{
        	consumeaudit.getUser().setBankinfo(userBankinfo);
        }
        ///获取交易信息的所有数据
        consumeaudit.setConsume(consumeRecodService.get(consumeaudit.getConsume()));
        return consumeaudit;
    }

    /***
     * 后台充值
     *
     * @param consumeaudit
     */
    @Transactional(readOnly = false)
    public Boolean recharge(Consumeaudit consumeaudit, Model model) {
        /////获取充值用户信息
        User account = consumeaudit.getUser();
        account = UserUtils.getUserBySearch(account.getPhone());
        if (account == null || Tools.IsNullOrWhiteSpace(account.getPhone())) {
            model.addAttribute("message", "充值用户信息不存在");
            return false;
        } else if (Tools.IsNullOrWhiteSpace(consumeaudit.getConsume().getConsumemony()) || Double.valueOf(consumeaudit.getConsume().getConsumemony()) < 0) {
            model.addAttribute("message", "充值金额必须大于0元");
            return false;
        }
//        if(!Tools.IsNullOrWhiteSpace(account.getMemberId())){
//        	model.addAttribute("message", "暂不支持账户系统后台充值");
//        	return false;
//        }
        consumeaudit.setUser(account);

        accountRechargeBiz(consumeaudit);
        return true;

    }


    /***
     * 保存提现记录流水
     *
     * @param consumerecod 必须包含提现密码,提现金额
     * @return
     */
    @Transactional(readOnly = false)
    public int chashConsumeCodesBiz(Consumerecod consumerecod) {
    	lock9.lock();
    	try{
    		int resultStatus = DataDic.RETURN_STATUS_NORMAL;
            if (consumerecod == null || UserUtils.getUser() == null) {
                ///信息缺失
                return DataDic.RETURN_STATUS_INFOBUG;
            }
            if (consumerecod.getUserBankinfo()==null||Tools.IsNullOrWhiteSpace(consumerecod.getUserBankinfo().getId())) {
                ///信息缺失
                return DataDic.RETURN_STATUS_INFOBUG;
            }
            if (Tools.IsNullOrWhiteSpace(consumerecod.getConsumemony()) || Tools.IsNullOrWhiteSpace(consumerecod.getCashpassword())) {
                ///信息缺失
                return DataDic.RETURN_STATUS_INFOBUG;
            }
            
            String cashPwd = consumerecod.getCashpassword();
            ///获取当前用户基本信息
            User curUser = UserUtils.findUser(UserUtils.getUser());

            ///获取系统账户信息
            /*User sysAccount = UserUtils.getSysAccount();*/

            ///验证支付密码是否相等
            if (!Tools.validatePassword(cashPwd, curUser.getUserinfo().getCashpassword())) {
                return DataDic.RETURN_STATUS_PAYPWDBUG;
            }
            ///本次提现交易金额
            Double consumeMoney = Double.parseDouble(consumerecod.getConsumemony());

            //原来的平台可用余额 
            Double old_available = 0.00;
            String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
            if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway())){
                old_available=accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE);
                consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
            }else{
            	old_available = curUser.getUserPurse().getAvailablebalance();
            }

            ///判断当前账户的可用余额是否可提现
            if (old_available - consumeMoney < 0) {
                return DataDic.RETURN_STATUS_MONEYBUG;
            }
            if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway())){
            	int check=accountBiz.checkRule(curUser,consumerecod.getConsumemony(),true);
                if(check!=DataDic.RETURN_STATUS_NORMAL){
                	return check;
                }
            }

            //if(IsCommitData(curUser.getId(),DataDic.CONSUMERECODE_TYPE_CASHMONEY, DataDic.CONSUMERECODE_MODEL_CASH, DataDic.CONSUMERECODE_WAY_BALANCE)){
                ///当前用户的交易流水--提现流水
                /**
                 * 用户申请提现:提现用户向卓大物流平台提现
                 * account=curUser消费对象为当前提现用户
                 * 提现状态为冻结状态
                 */
                Consumerecod accountRecode = this.setConsumeRecode(curUser, curUser, -consumeMoney, -consumeMoney, consumeMoney,
                        DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_CASHMONEY, consumeWay,
                        DataDic.CONSUMERECODE_MODEL_CASH, DataDic.CONSUMERECODE_STATUS_FREEZING, DataDic.ISSYSRECODE_NO
                );
                accountRecode.setUserBankinfo(consumerecod.getUserBankinfo());
                //支付流水为交易编号
                accountRecode.setPaycode(accountRecode.getConsumecode());
                ///交易描述
                accountRecode.setRemarks(curUser.getLoginName() + "提现" + consumeMoney + "元");
                accountRecode.setConsumewaydesp(accountRecode.getRemarks());

                Consumeaudit cashAudit = new Consumeaudit();
                cashAudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTCASH);
                cashAudit.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT);
                cashAudit.setUser(curUser);///申请用户
                ////初始用户交易主键
                accountRecode.setIsNewRecord(true);
                accountRecode.setId(IdGen.uuid());
                cashAudit.setConsume(accountRecode);
                cashAudit.setCreateDate(new Date());

                ///提现用户资金变动:提现用户资金减少,冻结资金增加
                if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumerecod.getConsumeway())){
                	//冻结
                	AccountUtils accountUtils=new AccountUtils();
                    int back=accountBiz.lockAccount(curUser,consumerecod.getConsumemony(),DataDic.TRANSFER_LOCK,accountUtils.getTradeSettlementId());
                    if(back!=DataDic.RETURN_STATUS_NORMAL){
                    	return back;
                    }
                }else{
                	userPurseService.editPureWebBalance(curUser, consumeMoney, DataDic.COUNT_WAY_SUB);
                    userPurseService.editFreeze(curUser, consumeMoney, DataDic.COUNT_WAY_PLUS);
                }
                consumeauditService.save(cashAudit);
                consumeRecodService.save(accountRecode);
                //pos用户发短信
                if(curUser.getIsposuser().equals("1")){
                	BscAgreement bscAgreement = new BscAgreement();
                	bscAgreement.setCode("applyPhone");
                	List<BscAgreement> list=bscAgreementService.findList(bscAgreement);
            		if(list.size()>0){
            			
            			bscAgreement = list.get(0);
            			if(bscAgreement!=null && !Tools.IsNullOrWhiteSpace(bscAgreement.getParentid())){
            				String[] config = bscAgreement.getParentid().split(",");
            				if(config.length>0){
            					for (int i = 0; i < config.length; i++) {
	            					String[] keyword = {curUser.getLoginName(),curUser.getPhone(),String.valueOf(consumeMoney)};
	        	                    SmsUtil.sendSmsMesge(null, DataDic.UserWithdraw,config[i], Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_AUTHEN, keyword, null, null, true,SmsConfig.smsUserWithdraw);
								}
            				}else{
            					String[] keyword = {curUser.getLoginName(),curUser.getPhone()};
        	                    SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_Apply, bscAgreement.getParentid(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_AUTHEN, keyword, null, null, true,SmsConfig.smsUserapply);
            				}
            				
            			}
	                	
            		}
            	}
                
//            }else{
//            	resultStatus=DataDic.RETURN_STATUS_REMORE;
//            }
            
            return resultStatus;
    	}finally{
    		lock9.unlock();
    	}
    }


    /***
     * 后台账户充值新增记录----新记录不做状态修改,不做资金的变动
     *
     * @param consumeaudit
     */
    @Transactional(readOnly = false)
    public void accountRechargeBiz(Consumeaudit consumeaudit) {
        ////充值用户
        User account = consumeaudit.getUser();

        ///当前充值金额
        Double rechargeMoney = Double.parseDouble(consumeaudit.getConsume().getConsumemony());
        ///充值账户的交易记录
        Consumerecod accountrecode = new Consumerecod();
        accountrecode = this.setConsumeRecode(account, account, rechargeMoney, rechargeMoney, 0.00, DataDic.COUNT_WAY_PLUS,
                DataDic.CONSUMERECODE_TYPE_BALANACE, DataDic.CONSUMERECODE_WAY_BALANCE,
                DataDic.CONSUMERECODE_MODEL_ACCOUNT, DataDic.CONSUMERECODE_STATUS_CONING, DataDic.ISSYSRECODE_NO);
        accountrecode.setPaycode(accountrecode.getConsumecode());
        ///赋值主键-创建者
        accountrecode.preInsert();
        ///新增记录
        accountrecode.setIsNewRecord(true);
        ///交易描述
        accountrecode.setConsumewaydesp("充值:" + rechargeMoney + "元");
        accountrecode.setScantype(DataDic.SCANTYPE_BACK);

        ///后台充值审核记录
        consumeaudit.preInsert();
        consumeaudit.setIsNewRecord(true);

        ///新的审核信息
        consumeaudit.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT);
        ///对应的交易流水
        consumeaudit.setConsume(accountrecode);
        ///后台用户充值
        consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTRECHARGE);
        consumeaudit.setRemarks(UserUtils.getUser().getLoginName() + "充值:" + rechargeMoney + "元");

        ////交易流水记录
        this.save(accountrecode);
        ///审核记录
        consumeauditService.save(consumeaudit);
        deallogService.saveDealLog(consumeaudit);


    }


    /**
     * 我的提现记录列表
     *
     * @param page
     * @param consumerecod
     * @return
     */
    public Page<Consumerecod> cashListFindPage(Page<Consumerecod> page, Consumerecod consumerecod) {
        User user = UserUtils.getUser();
        consumerecod.setAccount(user);
        consumerecod.setConsumetype(DataDic.CONSUMERECODE_TYPE_CASHMONEY);
        return consumeRecodService.findPage(page, consumerecod);
    }

    /**
     * 用户交易流水统计
     *
     * @param page
     * @param account
     * @return
     */
    public Page<Account> findUserAccount(Page<Account> page, Account account) {
        User user = new User();
        user.setId(UserUtils.getUser().getId());
        account.setUser(user);
        if (account.getMonthParameter().equals(DataDic.ACCOUNT_MONTH_THIS)) {//本月
            account.setEndCreateDate(DateUtil.getMonthDate(0));
        } else if (account.getMonthParameter().equals(DataDic.ACCOUNT_MONTH_LAST)) {//上月
            account.setEndCreateDate(DateUtil.getMonthDate(1));
        } else if (account.getMonthParameter().equals(DataDic.ACCOUNT_MONTH_LASTTWO)) {//上上月
            account.setEndCreateDate(DateUtil.getMonthDate(2));
        }
        return consumeRecodService.findUserAccount(page, account);
    }

    /**
     * 获取用户本月充值金额
     *
     * @param userid
     * @return
     */
    public Double rechargeUserAccountByMonth(String userid) {
        Double rechargeMoney = 0.0;
        User user = UserUtils.get(userid);
        if (userid != null && user.getId() != null) {
            Consumerecod consumerecod = new Consumerecod();
            consumerecod.setAccount(user);
            Account account = consumeRecodService.rechargeUserAccountByMonth(consumerecod);//查询用户充值金额

            BigDecimal balanace = new BigDecimal((account!=null&&account.getBalanace()!=null?account.getBalanace():0.0));//余额充值金额
            rechargeMoney = (balanace).doubleValue();
        }
        return rechargeMoney;
    }

    /**
     * 是否有资格减免投标保证金
     *
     * @param userid
     * @return true 有 false无
     */
    public Boolean isDerateBidGuarantee(String userid) {
        Boolean result = false;
        if (userid != null) {
            Double rechargeMoney = rechargeUserAccountByMonth(userid);//充值的金额
            if (rechargeMoney > DataDic.RECHARGETOTAL || rechargeMoney == DataDic.RECHARGETOTAL) {
                result = true;
            }
        }
        return result;
    }

    /***
     * 对交易流水信息表赋值
     *
     * @param curUser       当前消费对象
     * @param consumeMoney  消费金额
     * @param curCountWay   当前消费对象账户余额运算方式:加、减
     * @param sysCountWay   系统用户对象余额变动的运算方式
     * @param consumeType   消费类型
     * @param consumeWay    消费方式
     * @param consumeModel  消费模块
     * @param consumeStatus 交易状态
     * @param issysrecode   是否是系统记录
     *                      <p>
     *                      流水
     *                      还需对交易描述赋值
     *                      <p>
     *                      交易编号和支付流水赋值
     */
    public Consumerecod setConsume(User curUser, User targetUser, Double consumeMoney, String curCountWay,
                                   String sysCountWay, String consumeType, String consumeWay,
                                   String consumeModel, String consumeStatus, String issysrecode
    ) {

        ///new一个交易记录
        Consumerecod consumerecod = new Consumerecod();
        ///系统对象
        User sysAccount = UserUtils.getSysAccount();
        /**
         * 当前交易账户:curUser
         * old_webBalance:当前账户消费前的交易金额
         * old_available:当前账户消费前的可用余额
         * old_freezen : 当前账户的冻结金额
         * cur_webBalance :当前用户消费后的平台余额
         * cur_available :当前用户消费后的可用余额
         * cur_freezen  :当前用户消费后的冻结金额
         * old_sysWebBalance: 系统账户消费前的余额
         * cur_sysWebBalance:系统账户消费后的金额
         */
        ///原来的平台余额
        Double old_webBalance = curUser.getUserPurse().getWebbalance();

        ///当前交易后的平台余额
        Double cur_webBalance = 0.00;
        ///当前消费的交易金额的运算方式
        if (DataDic.COUNT_WAY_PLUS.equals(curCountWay)) {
            cur_webBalance = PreciseCompute.add(old_webBalance, consumeMoney);
        } else {
            cur_webBalance = PreciseCompute.sub(old_webBalance, consumeMoney);
        }
        ///系统账户平台余额
        Double old_sysWebBalance = sysAccount.getUserPurse().getWebbalance();
        //账户提现:系统账户资金增加
        Double cur_sysWebBalance = 0.00;
        ///系统资金的运算方式
        if (DataDic.COUNT_WAY_PLUS.equals(sysCountWay)) {
            cur_sysWebBalance = PreciseCompute.add(old_sysWebBalance, consumeMoney);
        } else {
            cur_sysWebBalance = PreciseCompute.sub(old_sysWebBalance, consumeMoney);
        }
        ///消费对象为当前用户
        consumerecod.setAccount(curUser);
        consumerecod.setSysaccount(sysAccount);
        consumerecod.setTarget(targetUser);

        /*
        * //赋值当前提现记录的提现金额
        * 当前用户消费前后的数据金额
        * */
        consumerecod.setConsumemony(consumeMoney.toString());
        consumerecod.setBeforemony(old_webBalance.toString());
        consumerecod.setAftermony(cur_webBalance.toString());
        /*赋值流动账户的消费前后金额--系统账户*/
        consumerecod.setFlowafter(cur_sysWebBalance.toString());
        consumerecod.setFlowbefore(old_sysWebBalance.toString());
        ///提现需要后台审核;当前状态为交易中;
        consumerecod.setConsumestatus(consumeStatus);
        //账户余额提现
        consumerecod.setConsumeway(consumeWay);
        //交易模块:账户体系
        consumerecod.setTrademodel(consumeModel);
        //交易类型
        consumerecod.setConsumetype(consumeType);
        consumerecod.setIssysrecode(issysrecode);

        return consumerecod;
    }

    /***
     * 交易记录
     *
     * @param curUser         当前消费用户
     * @param targetUser      目标用户
     * @param consumeMoney    交易金额,加+;负数就是减
     * @param consumeAvailabe 交易可用金额
     * @param consumeFreeze   交易冻结资金
     * @param curCountWay     当前是否入账
     * @param consumeType     当前消费类型
     * @param consumeWay      当前消费方式:余额、卓币、油气、保证金、竞标保证金
     * @param consumeModel    消费模块
     * @param consumeStatus   消费状态
     * @param issysrecode     是否是系统记录
     * @return 返回交易记录
     */
    public Consumerecod setConsumeRecode(User curUser, User targetUser, Double consumeMoney,
                                         Double consumeAvailabe, Double consumeFreeze,
                                         String curCountWay, String consumeType, String consumeWay,
                                         String consumeModel, String consumeStatus, String issysrecode
    ) {

        ///new一个交易记录
        Consumerecod consumerecod = new Consumerecod();
        /**
         * 当前交易账户:curUser
         * old_webBalance:当前账户消费前的交易金额
         * old_available:当前账户消费前的可用余额
         * old_freezen : 当前账户的冻结金额
         * cur_webBalance :当前用户消费后的平台余额
         * cur_available :当前用户消费后的可用余额
         * cur_freezen  :当前用户消费后的冻结金额
         * old_sysWebBalance: 系统账户消费前的余额
         * cur_sysWebBalance:系统账户消费后的金额
         */
        ///原来的平台余额
        Double old_webBalance = 0.00;
        ///交易前的可用余额
        Double old_availabe = 0.00;
        ///交易前的冻结余额
        Double old_freeze = 0.00;
        //账户余额交易
        if (DataDic.CONSUMERECODE_WAY_BALANCE.equals(consumeWay)||DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeWay)) {
            
            if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeWay)){
            	old_availabe=accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE);
            	old_freeze=accountBiz.getAmount(curUser, DataDic.FREEZE_BALANCE);
            	old_webBalance=old_availabe+old_freeze+accountBiz.getAmount(curUser, DataDic.LOCK_BALANCE)+accountBiz.getAmount(curUser, DataDic.UNDETERMINED_BALANCE);
            }else{
            	///原来的平台余额
                old_webBalance = Double.valueOf(curUser.getUserPurse().getWebbalance() != null ? curUser.getUserPurse().getWebbalance() : 0.00);
                ///交易前的可用余额
                old_availabe = Double.valueOf(curUser.getUserPurse().getAvailablebalance() != null ? curUser.getUserPurse().getAvailablebalance() : 0.00);
                ///交易前的冻结余额
                old_freeze = Double.valueOf(curUser.getUserPurse().getFreezemoney() != null ? curUser.getUserPurse().getFreezemoney() : 0.00);
            }
            
        } else if (DataDic.CONSUMERECODE_WAY_COIN.equals(consumeWay)) {///账户卓币交易
            ///原来的卓币余额
            old_webBalance = Double.valueOf(curUser.getUserPurse().getWebcoin() != null ? curUser.getUserPurse().getWebcoin() : 0.00);
            ///交易前的卓币余额
            old_availabe = Double.valueOf(curUser.getUserPurse().getAvailablecoin() != null ? curUser.getUserPurse().getAvailablecoin() : 0.00);
            ///交易前的卓币冻结余额
            old_freeze = Double.valueOf(curUser.getUserPurse().getFreezecoin() != null ? curUser.getUserPurse().getFreezecoin() : 0.00);

        } else if (DataDic.CONSUMERECODE_WAY_PETROL.equals(consumeWay)) {///账户卓币交易
            ///原来的油气余额
            old_webBalance = Double.valueOf(curUser.getUserPurse().getPetrolbalance() != null ? curUser.getUserPurse().getPetrolbalance() : 0.00);
            old_availabe = 0.00;
            old_freeze = 0.00;
        }

        ///当前交易后的平台余额
        Double cur_webBalance = 0.00;
        ///当前交易后的平台余额
        Double cur_availabe = 0.00;
        ///当前交易后的平台余额
        Double cur_freeze = 0.00;
        ///当前消费的交易金额的运算方式
        if(Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&!Tools.IsNullOrWhiteSpace(targetUser.getMemberId())&&curCountWay.equals("0")&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeWay)){
        	cur_webBalance = PreciseCompute.add(old_webBalance, 0.00);
            cur_availabe = PreciseCompute.add(old_availabe, 0.00);
            cur_freeze = PreciseCompute.add(old_freeze, 0.00);
        }else{
        	cur_webBalance = PreciseCompute.add(old_webBalance, consumeMoney);
            cur_availabe = PreciseCompute.add(old_availabe, consumeAvailabe);
            cur_freeze = PreciseCompute.add(old_freeze, consumeFreeze);
        }

        ///消费对象为当前用户
        consumerecod.setAccount(curUser);
        consumerecod.setSysaccount(targetUser);
        consumerecod.setTarget(targetUser);
        ///是否是入账:0:是1:否
        consumerecod.setIsplus(curCountWay);

        /*
        * //赋值当前提现记录的提现金额
        * 当前用户消费前后的数据金额
        * */

        if (consumeMoney < 0) {
            consumeMoney = consumeMoney * -1;
        }
        consumerecod.setConsumemony(consumeMoney.toString());
        consumerecod.setBeforemony(old_webBalance.toString());
        consumerecod.setBeforeAvliable(old_availabe.toString());
        consumerecod.setBeforeFreeze(old_freeze.toString());
        consumerecod.setAftermony(cur_webBalance.toString());
        consumerecod.setAfterAvliable(cur_availabe.toString());
        consumerecod.setAfterFreeze(cur_freeze.toString());

        ///提现需要后台审核;当前状态为交易中;
        consumerecod.setConsumestatus(consumeStatus);
        //账户交易方式
        consumerecod.setConsumeway(consumeWay);

        //交易模块:账户体系
        consumerecod.setTrademodel(consumeModel);
        //交易类型
        consumerecod.setConsumetype(consumeType);
        consumerecod.setIssysrecode(issysrecode);
        //交易编号
        consumerecod.setConsumecode(OrderNumberUtil.getOrderNo(consumeType));

        return consumerecod;
    }
    
    /***
     * 交易记录
     *
     * @param curUser         当前消费用户
     * @param targetUser      目标用户
     * @param consumeMoney    交易金额,加+;负数就是减
     * @param consumeAvailabe 交易可用金额
     * @param consumeFreeze   交易冻结资金
     * @param curCountWay     当前是否入账
     * @param consumeType     当前消费类型
     * @param consumeWay      当前消费方式:余额、卓币、油气、保证金、竞标保证金
     * @param consumeModel    消费模块
     * @param consumeStatus   消费状态
     * @param issysrecode     是否是系统记录
     * @return 返回交易记录
     */
    public Consumerecod setConsumeFrezRecode(User curUser, User targetUser, Double consumeMoney,
                                         Double consumeAvailabe, Double consumeFreeze,
                                         String curCountWay, String consumeType, String consumeWay,
                                         String consumeModel, String consumeStatus, String issysrecode
    ) {

        ///new一个交易记录
        Consumerecod consumerecod = new Consumerecod();
        /**
         * 当前交易账户:curUser
         * old_webBalance:当前账户消费前的交易金额
         * old_available:当前账户消费前的可用余额
         * old_freezen : 当前账户的冻结金额
         * cur_webBalance :当前用户消费后的平台余额
         * cur_available :当前用户消费后的可用余额
         * cur_freezen  :当前用户消费后的冻结金额
         * old_sysWebBalance: 系统账户消费前的余额
         * cur_sysWebBalance:系统账户消费后的金额
         */
        ///原来的平台余额
        Double old_webBalance = 0.00;
        ///交易前的可用余额
        Double old_availabe = 0.00;
        ///交易前的冻结余额
        Double old_freeze = 0.00;
        if (curUser != null) {
            //账户余额交易
        	if (DataDic.CONSUMERECODE_WAY_BALANCE.equals(consumeWay)||DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeWay)) {
                
                if(!Tools.IsNullOrWhiteSpace(curUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeWay)){
                	old_availabe=accountBiz.getAmount(curUser, DataDic.AVAILABLE_BALANCE);
                	old_freeze=accountBiz.getAmount(curUser, DataDic.FREEZE_BALANCE);
                	old_webBalance=old_availabe+old_freeze+accountBiz.getAmount(curUser, DataDic.LOCK_BALANCE)+accountBiz.getAmount(curUser, DataDic.UNDETERMINED_BALANCE);
                }else{
                	///原来的平台余额
                    old_webBalance = Double.valueOf(curUser.getUserPurse().getWebbalance() != null ? curUser.getUserPurse().getWebbalance() : 0.00);
                    ///交易前的可用余额
                    old_availabe = Double.valueOf(curUser.getUserPurse().getAvailablebalance() != null ? curUser.getUserPurse().getAvailablebalance() : 0.00);
                    ///交易前的冻结余额
                    old_freeze = Double.valueOf(curUser.getUserPurse().getFreezemoney() != null ? curUser.getUserPurse().getFreezemoney() : 0.00);
                }
            } else if (DataDic.CONSUMERECODE_WAY_COIN.equals(consumeWay)) {///账户卓币交易
                ///原来的卓币余额
                old_webBalance = Double.valueOf(curUser.getUserPurse().getWebcoin() != null ? curUser.getUserPurse().getWebcoin() : 0.00);
                ///交易前的卓币余额
                old_availabe = Double.valueOf(curUser.getUserPurse().getAvailablecoin() != null ? curUser.getUserPurse().getAvailablecoin() : 0.00);
                ///交易前的卓币冻结余额
                old_freeze = Double.valueOf(curUser.getUserPurse().getFreezecoin() != null ? curUser.getUserPurse().getFreezecoin() : 0.00);

            } else if (DataDic.CONSUMERECODE_WAY_PETROL.equals(consumeWay)) {///账户卓币交易
                ///原来的油气余额
                old_webBalance = Double.valueOf(curUser.getUserPurse().getPetrolbalance() != null ? curUser.getUserPurse().getPetrolbalance() : 0.00);
                old_availabe = 0.00;
                old_freeze = 0.00;
            }
        }

        ///当前交易后的平台余额
        Double cur_webBalance = 0.00;
        ///当前交易后的平台余额
        Double cur_availabe = 0.00;
        ///当前交易后的平台余额
        Double cur_freeze = 0.00;
        ///当前消费的交易金额的运算方式
        cur_webBalance = PreciseCompute.add(old_webBalance, consumeMoney);
        cur_availabe = PreciseCompute.add(old_availabe, consumeAvailabe);
        cur_freeze = PreciseCompute.add(old_freeze, consumeFreeze);

        ///消费对象为当前用户
        consumerecod.setAccount(curUser);
        consumerecod.setSysaccount(targetUser);
        consumerecod.setTarget(targetUser);
        ///是否是入账:0:是1:否
        consumerecod.setIsplus(curCountWay);

        /*
        * //赋值当前提现记录的提现金额
        * 当前用户消费前后的数据金额
        * */

        if (consumeMoney < 0) {
            consumeMoney = consumeMoney * -1;
        }
        consumerecod.setConsumemony(consumeMoney.toString());
        consumerecod.setBeforeAvliable(old_availabe.toString());
        consumerecod.setBeforeFreeze(old_freeze.toString());
        consumerecod.setAfterAvliable(cur_availabe.toString());
        consumerecod.setAfterFreeze(cur_freeze.toString());
        consumerecod.setBeforemony(old_freeze.toString());
        consumerecod.setAftermony(cur_freeze.toString());
        ///提现需要后台审核;当前状态为交易中;
        consumerecod.setConsumestatus(consumeStatus);
        //账户交易方式
        consumerecod.setConsumeway(consumeWay);

        //交易模块:账户体系
        consumerecod.setTrademodel(consumeModel);
        //交易类型
        consumerecod.setConsumetype(consumeType);
        consumerecod.setIssysrecode(issysrecode);
        //交易编号
        consumerecod.setConsumecode(OrderNumberUtil.getOrderNo(consumeType));

        return consumerecod;
    }
    
    /***
     * 刷新钱包
     * @param userPurse 
     * @return 
     */
    @Transactional(readOnly = false)
    public int flushWeb(UserPurse userPurse){
    	User user=UserUtils.getUser();
    	int result=userPurseService.flushWeb(user, userPurse);
    	return result;
    }


    /***
     * 运单定位缴费
     *
     * @param order_id
     * @param iscoin 是否卓币支付
     * @param payMoney
     */
    @Transactional(readOnly = false)
    public int payOrderLbsBiz(String order_id,String iscoin, Double payMoney) {
    	int result=DataDic.RETURN_STATUS_NORMAL;
    	///获取运单ID
        Orderinfo orderinfo = orderinfoService.get(order_id);
    	String getConsumeType = DataDic.CONSUMERECODE_TYPE_GETLBSMONEY;//收到余额
    	String payConsumeType = DataDic.CONSUMERECODE_TYPE_PAYLBSMONEY;//支付余额
    	String consumeWay = DataDic.CONSUMERECODE_WAY_BALANCE;//消费方式：余额支付
    	if(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway())){
    		consumeWay = DataDic.CONSUMERECODE_WAY_ACCOUNT;
    	}
    	String title = "元";
    	if(DataDic.YES.equals(iscoin)){
    		getConsumeType = DataDic.CONSUMERECODE_TYPE_GETLBSCOIN;//收到卓币
        	payConsumeType = DataDic.CONSUMERECODE_TYPE_PAYLBSCOIN;//支付卓币
        	consumeWay = DataDic.CONSUMERECODE_WAY_COIN;//消费方式：卓币支付
        	title = "卓币";
    	}
    	
        User seller = UserUtils.findUser(orderinfo.getSeller());
        if(seller.getUserPurse().getWebbalance() < payMoney){
        	return  DataDic.RETURN_STATUS_MONEYBUG;
        }
        User sysUser = UserUtils.getSysAccount();
        Consumerecod consumerecod = this.setConsumeRecode(seller, sysUser, -payMoney, -payMoney, 0.00,
                DataDic.COUNT_WAY_SUB,
                payConsumeType,
                consumeWay,
                DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        consumerecod.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + "向平台缴纳" + payMoney + title + "运单LBS定位服务费");
        consumerecod.setRemarks("向平台缴纳" + consumerecod.getConsumewaydesp());
        consumerecod.setPaycode(consumerecod.getConsumecode());

        ///系统交易记录
        Consumerecod sysCode = this.setConsumeRecode(sysUser, seller, payMoney, payMoney, 0.00,
                DataDic.COUNT_WAY_PLUS,
                getConsumeType,
                consumeWay,
                DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        sysCode.setConsumewaydesp("运单号:" + orderinfo.getOrderno() + "收到" + seller.getLoginName() + payMoney + title +"运单LBS定位服务费");
        sysCode.setRemarks("平台收到" + sysCode.getConsumewaydesp());
        sysCode.setPaycode(sysCode.getConsumecode());
        consumerecod.setOrderinfo(orderinfo);
        sysCode.setOrderinfo(orderinfo);
        if(DataDic.YES.equals(iscoin)){
        	userPurseService.editPureWebCoin(seller, payMoney, DataDic.COUNT_WAY_SUB);
            userPurseService.editPureWebCoin(sysUser, payMoney, DataDic.COUNT_WAY_PLUS);
        }else{
//        	if(!Tools.IsNullOrWhiteSpace(seller.getMemberId())&&(DataDic.ORDER_PAYWAY_ACCOUNT.equals(orderinfo.getPayway())||DataDic.ORDER_PAYWAY_ACCOUNTCOIN.equals(orderinfo.getPayway()))){
//        		int back=accountBiz.virtAcctTransfer(seller,sysUser,payMoney.toString(),DataDic.TRANSFER_OUTER);
//    			if(DataDic.RETURN_STATUS_NORMAL!=back){
//    				return back;
//    			}
//        	}else{
        		userPurseService.editPureWebBalance(seller, payMoney, DataDic.COUNT_WAY_SUB);
                userPurseService.editPureWebBalance(sysUser, payMoney, DataDic.COUNT_WAY_PLUS);
        	//}
        	
        }
        
        ///保存交易流水
        consumeRecodService.save(consumerecod);
        consumeRecodService.save(sysCode);
        return result;
    }

   
    /***
     * 保存一卡通换卡缴费交易流水并变动金额
     *
     * @param user
     * @return
     */
    @Transactional(readOnly = false)
    public int metroCradLossPayRecodeBiz(User user) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        if (user == null ) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///查找缴费用户信息
        User payUser = UserUtils.findUser(user);
        Double available = payUser.getUserPurse().getAvailablebalance();
        String consumeWay=DataDic.CONSUMERECODE_WAY_BALANCE;
//        if(!Tools.IsNullOrWhiteSpace(payUser.getMemberId())){
//        	available=accountBiz.getAmount(payUser, DataDic.AVAILABLE_BALANCE);
//        	consumeWay=DataDic.CONSUMERECODE_WAY_ACCOUNT;
//        }
        Double payMoney = Double.parseDouble(DataDic.METRO_LOSS_MONEY);//换卡缴费费用
        ///如果可用资金少于缴费金额
        if ( available < payMoney) {
            return DataDic.RETURN_STATUS_MONEYBUG;
        }
        Consumerecod consumerecod = new Consumerecod();
        ///用户交易流水记录--一卡通换卡缴费
        consumerecod = this.setConsumeRecode(payUser, payUser, -payMoney, -payMoney, payMoney,
                DataDic.COUNT_WAY_SUB,
                DataDic.CONSUMERECODE_TYPE_CARDLOSS,
                consumeWay,
                DataDic.CONSUMERECODE_MODEL_SETTLEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES,
                DataDic.ISSYSRECODE_NO);
        ////竞标交易code
        consumerecod.setPaycode(consumerecod.getConsumecode());
        consumerecod.setConsumewaydesp("一卡通换卡缴纳费用:" + payMoney + "元");
        consumerecod.setRemarks(payUser.getLoginName() + "缴纳" + payMoney + "元换卡费用");

          
        User sysUser = UserUtils.getSysAccount();
        ///系统交易记录
        Consumerecod sysCode = this.setConsumeRecode(sysUser, payUser, payMoney, payMoney, 0.00,
                DataDic.COUNT_WAY_PLUS,
                DataDic.CONSUMERECODE_TYPE_GETCARDLOSS,
                consumeWay,
                DataDic.CONSUMERECODE_MODEL_TRADEORDER,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        sysCode.setConsumewaydesp("收到" + payUser.getLoginName() + payMoney  +"一卡通换卡缴费");
        sysCode.setRemarks("平台收到" + sysCode.getConsumewaydesp());
        sysCode.setPaycode(consumerecod.getConsumecode());
        
        //金额变动
//        if(Tools.IsNullOrWhiteSpace(payUser.getMemberId())){
        	userPurseService.editPureWebBalance(payUser, payMoney, DataDic.COUNT_WAY_SUB);
            userPurseService.editPureWebBalance(sysUser, payMoney, DataDic.COUNT_WAY_PLUS);
//        }else{
//        	int back=accountBiz.virtAcctTransfer(payUser,sysUser,consumerecod.getConsumemony(),DataDic.TRANSFER_OUTER);
//			if(DataDic.RETURN_STATUS_NORMAL!=back){
//				return back;
//			}
//        }
        
        ////缴纳费用
        consumeRecodService.save(consumerecod);
        consumeRecodService.save(sysCode);
        return result;
    }
    
    
    /***
     * 账户油气赠送
     *
     * @param user_id     充值用户ID
     * @param petrolMoney 充值油气
     * @return 1:正常
     */
    @Transactional(readOnly = false)
    public int activityRecodeBiz(String user_id, Double petrolMoney) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        User curUser = new User();
        User sysUser = UserUtils.getSysAccount();
        curUser.setId(user_id);
        curUser = UserUtils.findUser(curUser);
        if (!IsCommitData(user_id,
                DataDic.CONSUMERECODE_TYPE_PETROLGRANT, DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_WAY_PETROL)) {
            return DataDic.RETURN_STATUS_REMORE;
        }
        ///初始当前用户购买油气消费金额
        
        
        ////油气记录
        Consumerecod curPetrolCode = this.setConsumeRecode(curUser, sysUser, petrolMoney, 0.00, 0.00,
                DataDic.COUNT_WAY_PLUS, DataDic.CONSUMERECODE_TYPE_PETROLGRANT,
                DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        curPetrolCode.setConsumewaydesp("首次成功购买油气赠送油气:" + petrolMoney + "元");
        curPetrolCode.setPaycode(curPetrolCode.getConsumecode());
        ///系统账户油气记录
        Consumerecod sysPetrolCode = this.setConsumeRecode(sysUser, curUser, -petrolMoney, 0.00, 0.0,
                DataDic.COUNT_WAY_SUB, DataDic.CONSUMERECODE_TYPE_PAYPETROLGRANT,
                DataDic.CONSUMERECODE_WAY_PETROL, DataDic.CONSUMERECODE_MODEL_PETROL,
                DataDic.CONSUMERECODE_STATUS_SUCCES, DataDic.ISSYSRECODE_NO);
        sysPetrolCode.setConsumewaydesp("首次成功购买油气向用户:" + curUser.getLoginName() + "支付赠送油气" + petrolMoney + "元");
        sysPetrolCode.setPaycode(sysPetrolCode.getConsumecode());
        
       
        userPurseService.consumePetrol(curUser, petrolMoney, DataDic.COUNT_WAY_PLUS);
        userPurseService.consumePetrol(sysUser, petrolMoney, DataDic.COUNT_WAY_SUB);
        Map<String, Object> map = metroCardCommonBiz.metroCardRecharge(curUser, petrolMoney);
        
        ///当前用户充值油气记录
        this.save(curPetrolCode);
        /// 系统油气
        this.save(sysPetrolCode);
            


        return result;

    }

    
    public List<Consumerecod> findList(Consumerecod consumerecod) {
        return consumeRecodService.findList(consumerecod);
    }

    public Page<Consumerecod> findPage(Page<Consumerecod> page, Consumerecod consumerecod) {
        return consumeRecodService.findPage(page, consumerecod);
    }

    @Transactional(readOnly = false)
    public void save(Consumerecod consumerecod) {
        consumeRecodService.save(consumerecod);
    }

    @Transactional(readOnly = false)
    public void delete(Consumerecod consumerecod) {
        consumeRecodService.delete(consumerecod);
    }
}