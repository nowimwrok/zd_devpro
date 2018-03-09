/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 账户钱包统计管理Entity
 * 
 * @author fjc
 * @version 2016-07-24
 */
public class Account extends DataEntity<Account> {

	private static final long serialVersionUID = 1L;
    
	
	private Double balanace;// "0001";余额充值
	private Double coinbalanace;// "0002";卓币充值
	private Double guenalanace;// "0003";保证金充值

	private Double getconsume;// "0004";购买卓币系统收到服务费

	private Double forzenonline;// "0101";历史运费支出
	private Double newforzenonline;//"0101";最新运费支出
	private Double returnforzen;// "0102";运费返款
	private Double getpremoney;// "0103";运费收到预付
	private Double paypremoney;// "0104";运费预付支出
	private Double payonlienmoney;// "0105";运费余款支付
	private Double getonlinemoney;// "0106";运费收到余款
	private Double disputemoneyreturn;// "0107";运费争议退款
	private Double disputepaymoney;// "0108";争议余款支付
	private Double forzenonlinecoin;// "0109";累计卓币运费冻结
	private Double newforzenonlinecoin;// "0109";现有卓币运费冻结
	private Double payprecoin;// "0110";卓币运费预付
	private Double getprecoin;// "0111";卓币运费收到预付
	private Double payonliencoin;// "0112";卓币运费支付余款
	private Double getonlinecoin;// "0113";卓币运费收到余款
	private Double getforzenonline;// "0114";运费收到冻结
	private Double getforzenonlinecoin;// "0115";卓币收到冻结
	private Double printpay;// "0116";打印提货单缴费
	private Double getprintpay;// "0117";收到打印缴费
	private Double conrefound;// "0118";卓币收到冻结
	
	
	private Double lbspaycoin;// "0119"; 卓币支付运单LBS定位服务费
	private Double getlbspaycoin;// "0120";卓币收到运单LBS定位服务费
	private Double lbspaymoney;// "0121";余额支付运单LBS定位服务费
	private Double getlbspaymoney;// "0122";余额收到运单LBS定位服务费
	

	private Double settlepay;// "0201";招标结算支付
	private Double getsettle;// "0202";招标收到结算
	private Double settlecash;// "0203";招标结算提现
	private Double settlepaycoin;// "0204";招标结算卓币
	private Double getsettlecoin;// "0205";收到结算卓币

	private Double bidingpay;// "0301";缴纳竞标保证金
	private Double bidinggetpay;// "0302";收到竞标保证金
	private Double bidingreturn;// "0303";退还竞标保证金

	private Double cashmoney;// "0401";余额提现
	private Double getcashmoney;// "0402";收到余额提现
	private Double cashmoneyreturn;// "0403";余额提现 退款

	private Double accounttransfer;// "0501";余额转账
	private Double receivedtransfer;// "0502";余额收到转账
	
	private Double cointransfer;// "0503";卓币转账
	private Double getcointransfer;// "0504";卓币收到转账

	private Double coinrecharge;// "0601";卓币充值记录
	private Double coinbuypetrol;// "0602";卓币购买油气
	private Double getcoinconsume;// "0603";卓币消费

	private Double petrolrecharge;// "0701";油气充值记录
	private Double petrolconsume;// "0702";油气消费
	private Double paypetrolrecharge;// "0703";油气支付充值
	private Double getpetrolconsume;// "0704";油气收到消费
	
	private Double petrolgrant;// "0705";活动赠送油气
	private Double paypetrolgrant;// "0706";油气支付赠送
	
	private Double petrotransfer;// "0507";油气转账
	private Double receivedtransferpetro;// "0508";油气收到转账
	
	private Double petrolexchange;// 0707	油气支付兑换
	private Double receivedpetrolexchange;// 0708     油气收到兑换

	private Double gunerechage;// "0801";保证金充值
	private Double gunecash;// "0802";保证金提现
	
	private Double webbalance;//平台账户余额
	
	private Double webcoin;//Z币余额
	private Double availablecoin;//Z币可用余额
	private Double freezecoin;//Z币冻结

	private User user;// 钱包账户
	private boolean isBid;// 只统计竞标押金
	private boolean isAccount;// 只统计竞标结算
	private String monthParameter;// 对账单月份参数
	private Date beginCreateDate; // 开始 create_date
	private Date endCreateDate; // 结束 create_date

	private Double availableBalance;		//可用余额
	
	private String ismemberAccount;		//是否账号系统用户
	
	public Double getAvailableBalance() {
		return availableBalance;
	}

	public void setAvailableBalance(Double availableBalance) {
		this.availableBalance = availableBalance;
	}

	public Double getUndeterminedBalance() {
		return undeterminedBalance;
	}

	public void setUndeterminedBalance(Double undeterminedBalance) {
		this.undeterminedBalance = undeterminedBalance;
	}

	public Double getFreezeBalance() {
		return freezeBalance;
	}

	public void setFreezeBalance(Double freezeBalance) {
		this.freezeBalance = freezeBalance;
	}

	public Double getLockBalance() {
		return lockBalance;
	}

	public void setLockBalance(Double lockBalance) {
		this.lockBalance = lockBalance;
	}

	private Double undeterminedBalance;     //在途金额
	private Double freezeBalance;           //冻结金额
	private Double lockBalance;             //锁定金额
	
	//============================统计==========================
	private Double petrolrechargesum;// "0701+0703";油气充值记录+油气支付充值
	private Double petrolconsumesum;// "0702+0704";油气消费+油气收到消费
	private Double petrolgrantsum;// "0705+0706";活动赠送油气+油气支付赠送
	private Double petrolexchangesum;// 0707+0708	油气支付兑换+油气收到兑换
	
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public String getMonthParameter() {
		return monthParameter;
	}

	public void setMonthParameter(String monthParameter) {
		this.monthParameter = monthParameter;
	}

	public boolean isAccount() {
		return isAccount;
	}

	public void setAccount(boolean isAccount) {
		this.isAccount = isAccount;
	}

	public boolean isBid() {
		return isBid;
	}

	public void setBid(boolean isBid) {
		this.isBid = isBid;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ExcelField(title = "登录名", type = 1, align = 2, sort = 0)
	public String loginName() {
		return getUser().getLoginName();
	}

	@ExcelField(title = "用户名", type = 1, align = 2, sort = 1)
	public String Name() {
		return getUser().getName();
	}

	@ExcelField(title = "角色", type = 1, align = 2, sort = 2)
	public String Role() {
		return getUser().getRole().getName();
	}

	@ExcelField(title = "手机号码", type = 1, align = 2, sort = 3)
	public String Phone() {
		return getUser().getPhone();
	}

	@ExcelField(title = "余额充值", type = 1, align = 2, sort = 14)
	public Double getBalanace() {
		return balanace;
	}

	public void setBalanace(Double balanace) {
		this.balanace = balanace;
	}

	@ExcelField(title = "卓币充值", type = 1, align = 2, sort = 15)
	public Double getCoinbalanace() {
		return coinbalanace;
	}

	public void setCoinbalanace(Double coinbalanace) {
		this.coinbalanace = coinbalanace;
	}

	@ExcelField(title = "保证金充值", type = 1, align = 2, sort = 16)
	public Double getGuenalanace() {
		return guenalanace;
	}

	public void setGuenalanace(Double guenalanace) {
		this.guenalanace = guenalanace;
	}

	public Double getGetconsume() {
		return getconsume;
	}

	public void setGetconsume(Double getconsume) {
		this.getconsume = getconsume;
	}

	@ExcelField(title = "运费支出", type = 1, align = 2, sort = 17)
	public Double getForzenonline() {
		return forzenonline;
	}

	public void setForzenonline(Double forzenonline) {
		this.forzenonline = forzenonline;
	}

	@ExcelField(title = "运费返款", type = 1, align = 2, sort = 18)
	public Double getReturnforzen() {
		return returnforzen;
	}

	public void setReturnforzen(Double returnforzen) {
		this.returnforzen = returnforzen;
	}

	@ExcelField(title = "运费收到预付", type = 1, align = 2, sort = 19)
	public Double getGetpremoney() {
		return getpremoney;
	}

	public void setGetpremoney(Double getpremoney) {
		this.getpremoney = getpremoney;
	}

	@ExcelField(title = "运费预付支出", type = 1, align = 2, sort = 110)
	public Double getPaypremoney() {
		return paypremoney;
	}

	public void setPaypremoney(Double paypremoney) {
		this.paypremoney = paypremoney;
	}

	@ExcelField(title = "运费余款支付", type = 1, align = 2, sort = 111)
	public Double getPayonlienmoney() {
		return payonlienmoney;
	}

	public void setPayonlienmoney(Double payonlienmoney) {
		this.payonlienmoney = payonlienmoney;
	}

	@ExcelField(title = "运费收到余款", type = 1, align = 2, sort = 112)
	public Double getGetonlinemoney() {
		return getonlinemoney;
	}

	public void setGetonlinemoney(Double getonlinemoney) {
		this.getonlinemoney = getonlinemoney;
	}

	@ExcelField(title = "运费争议退款", type = 1, align = 2, sort = 113)
	public Double getDisputemoneyreturn() {
		return disputemoneyreturn;
	}

	public void setDisputemoneyreturn(Double disputemoneyreturn) {
		this.disputemoneyreturn = disputemoneyreturn;
	}

	@ExcelField(title = "争议余款支付", type = 1, align = 2, sort = 114)
	public Double getDisputepaymoney() {
		return disputepaymoney;
	}

	public void setDisputepaymoney(Double disputepaymoney) {
		this.disputepaymoney = disputepaymoney;
	}

	
	
	public Double getNewforzenonlinecoin() {
		return newforzenonlinecoin;
	}

	public void setNewforzenonlinecoin(Double newforzenonlinecoin) {
		this.newforzenonlinecoin = newforzenonlinecoin;
	}

	@ExcelField(title = "卓币运费冻结", type = 1, align = 2, sort = 115)
	public Double getForzenonlinecoin() {
		return forzenonlinecoin;
	}

	public void setForzenonlinecoin(Double forzenonlinecoin) {
		this.forzenonlinecoin = forzenonlinecoin;
	}

	@ExcelField(title = "卓币运费预付", type = 1, align = 2, sort = 116)
	public Double getPayprecoin() {
		return payprecoin;
	}

	public void setPayprecoin(Double payprecoin) {
		this.payprecoin = payprecoin;
	}

	@ExcelField(title = "卓币运费收到预付", type = 1, align = 2, sort = 117)
	public Double getGetprecoin() {
		return getprecoin;
	}

	public void setGetprecoin(Double getprecoin) {
		this.getprecoin = getprecoin;
	}

	@ExcelField(title = "卓币运费支付余款", type = 1, align = 2, sort = 118)
	public Double getPayonliencoin() {
		return payonliencoin;
	}

	public void setPayonliencoin(Double payonliencoin) {
		this.payonliencoin = payonliencoin;
	}

	@ExcelField(title = "卓币运费收到余款", type = 1, align = 2, sort = 119)
	public Double getGetonlinecoin() {
		return getonlinecoin;
	}

	public void setGetonlinecoin(Double getonlinecoin) {
		this.getonlinecoin = getonlinecoin;
	}

	@ExcelField(title = "运费收到冻结", type = 1, align = 2, sort = 120)
	public Double getGetforzenonline() {
		return getforzenonline;
	}

	public void setGetforzenonline(Double getforzenonline) {
		this.getforzenonline = getforzenonline;
	}

	@ExcelField(title = "卓币收到冻结", type = 1, align = 2, sort = 121)
	public Double getGetforzenonlinecoin() {
		return getforzenonlinecoin;
	}

	public void setGetforzenonlinecoin(Double getforzenonlinecoin) {
		this.getforzenonlinecoin = getforzenonlinecoin;
	}

	@ExcelField(title = "卓币解冻", type = 1, align = 2, sort = 122)
	public Double getConrefound() {
		return conrefound;
	}

	public void setConrefound(Double conrefound) {
		this.conrefound = conrefound;
	}

	@ExcelField(title = "打印提货单缴费", type = 1, align = 2, sort = 123)
	public Double getPrintpay() {
		return printpay;
	}

	public void setPrintpay(Double printpay) {
		this.printpay = printpay;
	}

	@ExcelField(title = "收到打印缴费", type = 1, align = 2, sort = 124)
	public Double getGetprintpay() {
		return getprintpay;
	}

	public void setGetprintpay(Double getprintpay) {
		this.getprintpay = getprintpay;
	}

	@ExcelField(title = "招标结算支付", type = 1, align = 2, sort = 125)
	public Double getSettlepay() {
		return settlepay;
	}

	public void setSettlepay(Double settlepay) {
		this.settlepay = settlepay;
	}

	@ExcelField(title = "招标收到结算", type = 1, align = 2, sort = 126)
	public Double getGetsettle() {
		return getsettle;
	}

	public void setGetsettle(Double getsettle) {
		this.getsettle = getsettle;
	}

	@ExcelField(title = "招标结算提现", type = 1, align = 2, sort = 127)
	public Double getSettlecash() {
		return settlecash;
	}

	public void setSettlecash(Double settlecash) {
		this.settlecash = settlecash;
	}

	@ExcelField(title = "招标结算卓币", type = 1, align = 2, sort = 128)
	public Double getSettlepaycoin() {
		return settlepaycoin;
	}

	public void setSettlepaycoin(Double settlepaycoin) {
		this.settlepaycoin = settlepaycoin;
	}

	@ExcelField(title = "收到结算卓币", type = 1, align = 2, sort = 129)
	public Double getGetsettlecoin() {
		return getsettlecoin;
	}

	public void setGetsettlecoin(Double getsettlecoin) {
		this.getsettlecoin = getsettlecoin;
	}

	@ExcelField(title = "缴纳竞标保证金", type = 1, align = 2, sort = 130)
	public Double getBidingpay() {
		return bidingpay;
	}

	public void setBidingpay(Double bidingpay) {
		this.bidingpay = bidingpay;
	}

	@ExcelField(title = "收到竞标保证金", type = 1, align = 2, sort = 131)
	public Double getBidinggetpay() {
		return bidinggetpay;
	}

	public void setBidinggetpay(Double bidinggetpay) {
		this.bidinggetpay = bidinggetpay;
	}

	@ExcelField(title = "退还竞标保证金", type = 1, align = 2, sort = 132)
	public Double getBidingreturn() {
		return bidingreturn;
	}

	public void setBidingreturn(Double bidingreturn) {
		this.bidingreturn = bidingreturn;
	}

	@ExcelField(title = "余额提现", type = 1, align = 2, sort = 133)
	public Double getCashmoney() {
		return cashmoney;
	}

	public void setCashmoney(Double cashmoney) {
		this.cashmoney = cashmoney;
	}

	@ExcelField(title = "收到余额提现", type = 1, align = 2, sort = 134)
	public Double getGetcashmoney() {
		return getcashmoney;
	}

	public void setGetcashmoney(Double getcashmoney) {
		this.getcashmoney = getcashmoney;
	}

	@ExcelField(title = "余额提现退款", type = 1, align = 2, sort = 135)
	public Double getCashmoneyreturn() {
		return cashmoneyreturn;
	}

	public void setCashmoneyreturn(Double cashmoneyreturn) {
		this.cashmoneyreturn = cashmoneyreturn;
	}

	@ExcelField(title = "余额转账", type = 1, align = 2, sort = 136)
	public Double getAccounttransfer() {
		return accounttransfer;
	}

	public void setAccounttransfer(Double accounttransfer) {
		this.accounttransfer = accounttransfer;
	}

	@ExcelField(title = "余额收到转账", type = 1, align = 2, sort = 137)
	public Double getReceivedtransfer() {
		return receivedtransfer;
	}

	public void setReceivedtransfer(Double receivedtransfer) {
		this.receivedtransfer = receivedtransfer;
	}

	@ExcelField(title = "卓币充值记录", type = 1, align = 2, sort = 138)
	public Double getCoinrecharge() {
		return coinrecharge;
	}

	public void setCoinrecharge(Double coinrecharge) {
		this.coinrecharge = coinrecharge;
	}

	@ExcelField(title = "卓币购买油气", type = 1, align = 2, sort = 139)
	public Double getCoinbuypetrol() {
		return coinbuypetrol;
	}

	public void setCoinbuypetrol(Double coinbuypetrol) {
		this.coinbuypetrol = coinbuypetrol;
	}

	@ExcelField(title = "卓币消费", type = 1, align = 2, sort = 140)
	public Double getGetcoinconsume() {
		return getcoinconsume;
	}

	public void setGetcoinconsume(Double getcoinconsume) {
		this.getcoinconsume = getcoinconsume;
	}

	@ExcelField(title = "油气充值记录", type = 1, align = 2, sort = 141)
	public Double getPetrolrecharge() {
		return petrolrecharge;
	}

	public void setPetrolrecharge(Double petrolrecharge) {
		this.petrolrecharge = petrolrecharge;
	}

	@ExcelField(title = "油气消费", type = 1, align = 2, sort = 142)
	public Double getPetrolconsume() {
		return petrolconsume;
	}

	public void setPetrolconsume(Double petrolconsume) {
		this.petrolconsume = petrolconsume;
	}

	@ExcelField(title = "油气支付充值", type = 1, align = 2, sort = 143)
	public Double getPaypetrolrecharge() {
		return paypetrolrecharge;
	}

	public void setPaypetrolrecharge(Double paypetrolrecharge) {
		this.paypetrolrecharge = paypetrolrecharge;
	}

	@ExcelField(title = "油气收到消费", type = 1, align = 2, sort = 144)
	public Double getGetpetrolconsume() {
		return getpetrolconsume;
	}

	public void setGetpetrolconsume(Double getpetrolconsume) {
		this.getpetrolconsume = getpetrolconsume;
	}

	@ExcelField(title = "保证金充值", type = 1, align = 2, sort = 145)
	public Double getGunerechage() {
		return gunerechage;
	}

	public void setGunerechage(Double gunerechage) {
		this.gunerechage = gunerechage;
	}

	@ExcelField(title = "保证金提现", type = 1, align = 2, sort = 146)
	public Double getGunecash() {
		return gunecash;
	}
	
	public void setGunecash(Double gunecash) {
		this.gunecash = gunecash;
	}
	
	@ExcelField(title = "卓币支付LBS定位", type = 1, align = 2, sort = 147)
	public Double getLbspaycoin() {
		return lbspaycoin;
	}

	public void setLbspaycoin(Double lbspaycoin) {
		this.lbspaycoin = lbspaycoin;
	}
	
	@ExcelField(title = "卓币收到LBS定位", type = 1, align = 2, sort = 148)
	public Double getGetlbspaycoin() {
		return getlbspaycoin;
	}

	public void setGetlbspaycoin(Double getlbspaycoin) {
		this.getlbspaycoin = getlbspaycoin;
	}

	
	@ExcelField(title = "余额支付LBS定位", type = 1, align = 2, sort = 149)
	public Double getLbspaymoney() {
		return lbspaymoney;
	}

	
	public void setLbspaymoney(Double lbspaymoney) {
		this.lbspaymoney = lbspaymoney;
	}

	
	
	@ExcelField(title = "余额收到LBS定位", type = 1, align = 2, sort = 150)
	public Double getGetlbspaymoney() {
		return getlbspaymoney;
	}

	public void setGetlbspaymoney(Double getlbspaymoney) {
		this.getlbspaymoney = getlbspaymoney;
	}

	
	
	public Double getPetrolgrant() {
		return petrolgrant;
	}

	public void setPetrolgrant(Double petrolgrant) {
		this.petrolgrant = petrolgrant;
	}

	public Double getPaypetrolgrant() {
		return paypetrolgrant;
	}

	public void setPaypetrolgrant(Double paypetrolgrant) {
		this.paypetrolgrant = paypetrolgrant;
	}

	@ExcelField(title = "账户余额", type = 1, align = 2, sort = 4)
	public Double getWebbalance() {
		return user.getUserPurse().getWebbalance()+user.getUserPurse().getFreezemoney();
	}

	
	
	public void setWebbalance(Double webbalance) {
		this.webbalance = webbalance;
	}

	@ExcelField(title = "可用余额", type = 1, align = 2, sort = 5)
	public Double getAvailablebalance() {
		return user.getUserPurse().getAvailablebalance();
	}

	@ExcelField(title = "油气余额", type = 1, align = 2, sort = 6)
	public Double getPetrolbalance() {

		return user.getUserPurse().getPetrolbalance();
	}

	@ExcelField(title = "担保金", type = 1, align = 2, sort = 7)
	public Double getGuaranteemone() {

		return user.getUserPurse().getGuaranteemone();
	}

	@ExcelField(title = "冻结资金", type = 1, align = 2, sort = 8)
	public Double getFreezemoney() {
		return user.getUserPurse().getFreezemoney();
	}

	@ExcelField(title = "竞标押金", type = 1, align = 2, sort = 9)
	public Double getBiddingmoney() {
		return user.getUserPurse().getBiddingmoney();
	}

	public Double getCointransfer() {
		return cointransfer;
	}

	public void setCointransfer(Double cointransfer) {
		this.cointransfer = cointransfer;
	}

	public Double getGetcointransfer() {
		return getcointransfer;
	}

	public void setGetcointransfer(Double getcointransfer) {
		this.getcointransfer = getcointransfer;
	}

	public Double getPetrotransfer() {
		return petrotransfer;
	}

	public void setPetrotransfer(Double petrotransfer) {
		this.petrotransfer = petrotransfer;
	}

	public Double getReceivedtransferpetro() {
		return receivedtransferpetro;
	}

	public void setReceivedtransferpetro(Double receivedtransferpetro) {
		this.receivedtransferpetro = receivedtransferpetro;
	}

	public Double getPetrolexchange() {
		return petrolexchange;
	}

	public void setPetrolexchange(Double petrolexchange) {
		this.petrolexchange = petrolexchange;
	}

	public Double getReceivedpetrolexchange() {
		return receivedpetrolexchange;
	}

	public void setReceivedpetrolexchange(Double receivedpetrolexchange) {
		this.receivedpetrolexchange = receivedpetrolexchange;
	}

	public Double getPetrolrechargesum() {
		return petrolrechargesum;
	}

	public void setPetrolrechargesum(Double petrolrechargesum) {
		this.petrolrechargesum = petrolrechargesum;
	}

	public Double getPetrolconsumesum() {
		return petrolconsumesum;
	}

	public void setPetrolconsumesum(Double petrolconsumesum) {
		this.petrolconsumesum = petrolconsumesum;
	}

	public Double getPetrolgrantsum() {
		return petrolgrantsum;
	}

	public void setPetrolgrantsum(Double petrolgrantsum) {
		this.petrolgrantsum = petrolgrantsum;
	}

	public Double getPetrolexchangesum() {
		return petrolexchangesum;
	}

	public void setPetrolexchangesum(Double petrolexchangesum) {
		this.petrolexchangesum = petrolexchangesum;
	}

	public String getIsmemberAccount() {
		return ismemberAccount;
	}

	public void setIsmemberAccount(String ismemberAccount) {
		this.ismemberAccount = ismemberAccount;
	}

	public Double getNewforzenonline() {
		return newforzenonline;
	}

	public void setNewforzenonline(Double newforzenonline) {
		this.newforzenonline = newforzenonline;
	}

	public Double getWebcoin() {
		return user.getUserPurse().getAvailablecoin()+user.getUserPurse().getFreezecoin();
	}

	public void setWebcoin(Double webcoin) {
		this.webcoin = webcoin;
	}

	public Double getAvailablecoin() {
		return user.getUserPurse().getAvailablecoin();
	}

	public void setAvailablecoin(Double availablecoin) {
		this.availablecoin = availablecoin;
	}

	public Double getFreezecoin() {
		return user.getUserPurse().getFreezecoin();
	}

	public void setFreezecoin(Double freezecoin) {
		this.freezecoin = freezecoin;
	}
	
	

}