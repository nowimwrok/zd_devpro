/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 卓币模块导出excel拓展Entity
 *
 * @author fjc
 * @version 2016-07-24
 */
public class CoinVO extends DataEntity<CoinVO> {

    private static final long serialVersionUID = 1L;



    private Double balanace;// "0001";余额充值
    private Double coinbalanace;// "0002";卓币充值
    private Double guenalanace;// "0003";保证金充值

    private Double getconsume;// "0004";购买卓币系统收到服务费

    private Double forzenonline;// "0101";运费支出
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

    private Double gunerechage;// "0801";保证金充值
    private Double gunecash;// "0802";保证金提现

    private User user;// 钱包账户
    private boolean isBid;// 只统计竞标押金
    private boolean isAccount;// 只统计竞标结算
    private String monthParameter;// 对账单月份参数
    private Date beginCreateDate; // 开始 create_date
    private Date endCreateDate; // 结束 create_date

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

    @ExcelField(title = "用户类型", type = 1, align = 2, sort = 0)
    public String Role() {
        return getUser().getRole().getName();
    }

    @ExcelField(title = "用户名", type = 1, align = 2, sort = 1)
    public String loginName() {
        return getUser().getLoginName();
    }

    public String Name() {
        return getUser().getName();
    }

    @ExcelField(title = "联系方式", type = 1, align = 2, sort = 2)
    public String Phone() {
        return getUser().getPhone();
    }

    @ExcelField(title = "Z币余额", type = 1, align = 2, sort = 3)
    public Double getWebcoin() {
        return user.getUserPurse().getAvailablecoin()+user.getUserPurse().getFreezecoin();
    }

    @ExcelField(title = "Z币可用余额", type = 1, align = 2, sort = 4)
    public Double getAvailablecoin() {
        return user.getUserPurse().getAvailablecoin();
    }

    @ExcelField(title = "Z币冻结", type = 1, align = 2, sort = 5)
    public Double getFreezecoin() {
        return user.getUserPurse().getFreezecoin();
    }


    @ExcelField(title = "Z币充值", type = 1, align = 2, sort = 6)
    public Double getCoinrecharge() {
        return coinrecharge;
    }

    public void setCoinrecharge(Double coinrecharge) {
        this.coinrecharge = coinrecharge;
    }

    @ExcelField(title = "Z币转账支出", type = 1, align = 2, sort = 7)
    public Double getCointransfer() {
        return cointransfer;
    }

    public void setCointransfer(Double cointransfer) {
        this.cointransfer = cointransfer;
    }

    @ExcelField(title = "Z币转账收入", type = 1, align = 2, sort = 8)
    public Double getGetcointransfer() {
        return getcointransfer;
    }

    public void setGetcointransfer(Double getcointransfer) {
        this.getcointransfer = getcointransfer;
    }

    @ExcelField(title = "Z币结算支出", type = 1, align = 2, sort = 9)
    public Double getSettlepaycoin() {
        return settlepaycoin;
    }

    public void setSettlepaycoin(Double settlepaycoin) {
        this.settlepaycoin = settlepaycoin;
    }

    @ExcelField(title = "Z币结算收入", type = 1, align = 2, sort = 10)
    public Double getGetsettlecoin() {
        return getsettlecoin;
    }

    public void setGetsettlecoin(Double getsettlecoin) {
        this.getsettlecoin = getsettlecoin;
    }

    
    @ExcelField(title = "现有运费冻结", type = 1, align = 2, sort = 11)
    public Double getNewforzenonlinecoin() {
		return newforzenonlinecoin;
	}

	public void setNewforzenonlinecoin(Double newforzenonlinecoin) {
		this.newforzenonlinecoin = newforzenonlinecoin;
	}

	@ExcelField(title = "累计运费冻结", type = 1, align = 2, sort = 12)
    public Double getForzenonlinecoin() {
        return forzenonlinecoin;
    }

    public void setForzenonlinecoin(Double forzenonlinecoin) {
        this.forzenonlinecoin = forzenonlinecoin;
    }

    @ExcelField(title = "运费预付", type = 1, align = 2, sort = 13)
    public Double getPayprecoin() {
        return payprecoin;
    }

    @ExcelField(title = "运费尾付", type = 1, align = 2, sort = 14)
    public Double getPayonliencoin() {
        return payonliencoin;
    }

    public void setPayonliencoin(Double payonliencoin) {
        this.payonliencoin = payonliencoin;
    }

    public void setPayprecoin(Double payprecoin) {
        this.payprecoin = payprecoin;
    }

    @ExcelField(title = "预付收入", type = 1, align = 2, sort = 15)
    public Double getGetprecoin() {
        return getprecoin;
    }

    public void setGetprecoin(Double getprecoin) {
        this.getprecoin = getprecoin;
    }



    @ExcelField(title = "尾款收入", type = 1, align = 2, sort = 16)
    public Double getGetonlinecoin() {
        return getonlinecoin;
    }

    public void setGetonlinecoin(Double getonlinecoin) {
        this.getonlinecoin = getonlinecoin;
    }

    @ExcelField(title = "消费支出", type = 1, align = 2, sort = 17)
    public Double getCoinbuypetrol() {
        return coinbuypetrol;
    }


    @ExcelField(title = "销售收入", type = 1, align = 2, sort = 18)
    public Double getGetcoinconsume() {
        return getcoinconsume;
    }



    public Double getGetforzenonlinecoin() {
        return getforzenonlinecoin;
    }

    public void setGetforzenonlinecoin(Double getforzenonlinecoin) {
        this.getforzenonlinecoin = getforzenonlinecoin;
    }


    //@ExcelField(title = "运单取消退款", type = 1, align = 2, sort = 53)
    public Double getConrefound() {
        return conrefound;
    }

    public void setConrefound(Double conrefound) {
        this.conrefound = conrefound;
    }





    public void setCoinbuypetrol(Double coinbuypetrol) {
        this.coinbuypetrol = coinbuypetrol;
    }



    public void setGetcoinconsume(Double getcoinconsume) {
        this.getcoinconsume = getcoinconsume;
    }

   public Double getWebbalance() {
        return user.getUserPurse().getWebbalance();
    }

    public Double getAvailablebalance() {
        return user.getUserPurse().getAvailablebalance();
    }

    public Double getPetrolbalance() {

        return user.getUserPurse().getPetrolbalance();
    }

    public Double getGuaranteemone() {

        return user.getUserPurse().getGuaranteemone();
    }

    public Double getFreezemoney() {
        return user.getUserPurse().getFreezemoney();
    }

    public Double getBiddingmoney() {
        return user.getUserPurse().getBiddingmoney();
    }


    public Double getBalanace() {
        return balanace;
    }

    public void setBalanace(Double balanace) {
        this.balanace = balanace;
    }

    public Double getCoinbalanace() {
        return coinbalanace;
    }

    public void setCoinbalanace(Double coinbalanace) {
        this.coinbalanace = coinbalanace;
    }

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

    public Double getForzenonline() {
        return forzenonline;
    }

    public void setForzenonline(Double forzenonline) {
        this.forzenonline = forzenonline;
    }

    public Double getReturnforzen() {
        return returnforzen;
    }

    public void setReturnforzen(Double returnforzen) {
        this.returnforzen = returnforzen;
    }

    public Double getGetpremoney() {
        return getpremoney;
    }

    public void setGetpremoney(Double getpremoney) {
        this.getpremoney = getpremoney;
    }

    public Double getPaypremoney() {
        return paypremoney;
    }

    public void setPaypremoney(Double paypremoney) {
        this.paypremoney = paypremoney;
    }

    public Double getPayonlienmoney() {
        return payonlienmoney;
    }

    public void setPayonlienmoney(Double payonlienmoney) {
        this.payonlienmoney = payonlienmoney;
    }

    public Double getGetonlinemoney() {
        return getonlinemoney;
    }

    public void setGetonlinemoney(Double getonlinemoney) {
        this.getonlinemoney = getonlinemoney;
    }

    public Double getDisputemoneyreturn() {
        return disputemoneyreturn;
    }

    public void setDisputemoneyreturn(Double disputemoneyreturn) {
        this.disputemoneyreturn = disputemoneyreturn;
    }

    public Double getDisputepaymoney() {
        return disputepaymoney;
    }

    public void setDisputepaymoney(Double disputepaymoney) {
        this.disputepaymoney = disputepaymoney;
    }

    public Double getGetforzenonline() {
        return getforzenonline;
    }

    public void setGetforzenonline(Double getforzenonline) {
        this.getforzenonline = getforzenonline;
    }

    public Double getPrintpay() {
        return printpay;
    }

    public void setPrintpay(Double printpay) {
        this.printpay = printpay;
    }

    public Double getGetprintpay() {
        return getprintpay;
    }

    public void setGetprintpay(Double getprintpay) {
        this.getprintpay = getprintpay;
    }

    public Double getSettlepay() {
        return settlepay;
    }

    public void setSettlepay(Double settlepay) {
        this.settlepay = settlepay;
    }

    public Double getGetsettle() {
        return getsettle;
    }

    public void setGetsettle(Double getsettle) {
        this.getsettle = getsettle;
    }

    public Double getSettlecash() {
        return settlecash;
    }

    public void setSettlecash(Double settlecash) {
        this.settlecash = settlecash;
    }

    public Double getBidingpay() {
        return bidingpay;
    }

    public void setBidingpay(Double bidingpay) {
        this.bidingpay = bidingpay;
    }

    public Double getBidinggetpay() {
        return bidinggetpay;
    }

    public void setBidinggetpay(Double bidinggetpay) {
        this.bidinggetpay = bidinggetpay;
    }

    public Double getBidingreturn() {
        return bidingreturn;
    }

    public void setBidingreturn(Double bidingreturn) {
        this.bidingreturn = bidingreturn;
    }

    public Double getCashmoney() {
        return cashmoney;
    }

    public void setCashmoney(Double cashmoney) {
        this.cashmoney = cashmoney;
    }

    public Double getGetcashmoney() {
        return getcashmoney;
    }

    public void setGetcashmoney(Double getcashmoney) {
        this.getcashmoney = getcashmoney;
    }

    public Double getCashmoneyreturn() {
        return cashmoneyreturn;
    }

    public void setCashmoneyreturn(Double cashmoneyreturn) {
        this.cashmoneyreturn = cashmoneyreturn;
    }

    public Double getAccounttransfer() {
        return accounttransfer;
    }

    public void setAccounttransfer(Double accounttransfer) {
        this.accounttransfer = accounttransfer;
    }

    public Double getReceivedtransfer() {
        return receivedtransfer;
    }

    public void setReceivedtransfer(Double receivedtransfer) {
        this.receivedtransfer = receivedtransfer;
    }

    public Double getPetrolrecharge() {
        return petrolrecharge;
    }

    public void setPetrolrecharge(Double petrolrecharge) {
        this.petrolrecharge = petrolrecharge;
    }

    public Double getPetrolconsume() {
        return petrolconsume;
    }

    public void setPetrolconsume(Double petrolconsume) {
        this.petrolconsume = petrolconsume;
    }

    public Double getPaypetrolrecharge() {
        return paypetrolrecharge;
    }

    public void setPaypetrolrecharge(Double paypetrolrecharge) {
        this.paypetrolrecharge = paypetrolrecharge;
    }

    public Double getGetpetrolconsume() {
        return getpetrolconsume;
    }

    public void setGetpetrolconsume(Double getpetrolconsume) {
        this.getpetrolconsume = getpetrolconsume;
    }

    public Double getGunerechage() {
        return gunerechage;
    }

    public void setGunerechage(Double gunerechage) {
        this.gunerechage = gunerechage;
    }

    public Double getGunecash() {
        return gunecash;
    }

    public void setGunecash(Double gunecash) {
        this.gunecash = gunecash;
    }
}