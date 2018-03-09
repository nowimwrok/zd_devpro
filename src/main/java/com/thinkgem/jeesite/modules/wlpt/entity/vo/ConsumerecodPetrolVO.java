/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;

import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.validation.constraints.NotNull;

/**
 * 用户交易流水信息表Entity
 *
 * @author 饶江龙
 * @version 2016-08-02
 */
public class ConsumerecodPetrolVO extends DataEntity<ConsumerecodPetrolVO> {

	private static final long serialVersionUID = 1L;
	private User account; // 资金流出账户ID
	private User target; // 目标用户:资金流入账户
	private Orderinfo orderinfo; // 运单ID,如果是运单业务
	private String consumecode; // 交易编号
	private String paycode; // 第三方支付交易流水号
	private String consumetype; // 交易类型：0:后台充值1:支付宝充值2:微信充值3:结算支付4:结算提现5:冻结线上支付运费6:支付预支付运费7：收到预支付运费8:支付余款运费9:收到余款运费10:冻结运费返款11:运费退费12:油气返现13:余额提现14:保证金提现
	private String consumeway; // 交易方式
	private String consumewaydesp; // 交易描述
	private String consumestatus; // 交易状态：0:交易中1:交易成功2:交易失败
	private String scantype; // 浏览方式：0:后台导入1平台2 安卓3 微信4 苹果
	private String consumemony; // 消费金额
	private String beforemony; // 消费前金额
	private String aftermony; // 消费后金额
	private String flowbefore; // 消费前金额
	private String flowafter; // 消费后金额
	private String trademodel; /// 交易模块TRADE_MODEL
	private String searchinfo; // 查询条件
	private String search;//查询条件
	private String issysrecode; /// 是否是系统账户记录
	private String isplus;		///是否是入账
	private String beforeAvliable;		///消费前的可用余额
	private String beforeFreeze;		///消费前的冻结余额
	private String afterAvliable;		///消费后的可用
	private String afterFreeze;		///消费后的冻结
    private UserBankinfo userBankinfo;///提现银行卡
	private String cashpassword; /// 支付密码

	private User sysaccount; // sysaccount_id
	private Date beginCreateDate; // 开始 创建时间-交易时间
	private Date endCreateDate; // 结束 创建时间-交易时间

	private Date createDateFormat;//创建时间 yyyy-MM-dd格式
	private String searchType; // 查询类型条件
	private String islimt;    ///是否限制条数
    private String timeFlag;//创建时间 yyyy-MM-dd格式

    //================一卡通列======================
    private String cardid; // 卡号
    private String billnumber; // 单据号
    private String meno; // 备注
    private String totalmoney; // 付应金额
    private String storename; // 操作店面
	private String useraccount; // 工号
    
	public String getIsplus() {
		return isplus;
	}

	public void setIsplus(String isplus) {
		this.isplus = isplus;
	}

	public String getBeforeAvliable() {
		return beforeAvliable;
	}

	public void setBeforeAvliable(String beforeAvliable) {
		this.beforeAvliable = beforeAvliable;
	}

	public String getBeforeFreeze() {
		return beforeFreeze;
	}

	public void setBeforeFreeze(String beforeFreeze) {
		this.beforeFreeze = beforeFreeze;
	}

	public String getAfterAvliable() {
		return afterAvliable;
	}

	public void setAfterAvliable(String afterAvliable) {
		this.afterAvliable = afterAvliable;
	}

	public String getAfterFreeze() {
		return afterFreeze;
	}

	public void setAfterFreeze(String afterFreeze) {
		this.afterFreeze = afterFreeze;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getCreateDateFormat() {
		return createDate;
	}

	public ConsumerecodPetrolVO() {
		super();
	}

	public ConsumerecodPetrolVO(String id) {
		super(id);
	}

	// 是否是系统账户
	public String getIssysrecode() {
		return issysrecode;
	}

	public void setIssysrecode(String issysrecode) {
		this.issysrecode = issysrecode;
	}

	// 提现支付密码
	public String getCashpassword() {
		return cashpassword;
	}

	public void setCashpassword(String cashpassword) {
		this.cashpassword = cashpassword;
	}

	//// 查询条件
	public String getSearchinfo() {
		return searchinfo;
	}

	public void setSearchinfo(String searchinfo) {
		this.searchinfo = searchinfo;
	}

	/// 交易模块
	@ExcelField(type = 1, title = "交易模块", align = 2, sort = 8, dictType = "consumerecode_model")
	public String getTrademodel() {
		return trademodel;
	}

	public void setTrademodel(String trademodel) {
		this.trademodel = trademodel;
	}

	@NotNull(message = "当前用户不允许为空")
	public User getAccount() {
		return account;
	}

	public void setAccount(User account) {
		this.account = account;
	}
	
	@NotNull(message = "当前用户不允许为空")
	@ExcelField(type = 1, title = "流入用户登陆名", align = 2, sort = 1)
	public String getAccountLoginName() {
		if(account!=null){
			return account.getLoginName();
		}
		return "";
	}
	@NotNull(message = "当前用户不允许为空")
	@ExcelField(type = 1, title = "流入用户手机号", align = 2, sort = 2)
	public String getAccountPhone() {
		if(account!=null){
			return account.getPhone();
		}
		return "";
	}

	@NotNull(message = "当前用户不允许为空")
	public User getTarget() {
		return target;
	}

	public void setTarget(User target) {
		this.target = target;
	}

	@NotNull(message = "当前用户不允许为空")
	@ExcelField(type = 1, title = "流入用户登陆名", align = 2, sort = 3)
	public String getTargetLoginName() {
		if(target!=null){
			return target.getLoginName();
		}
		return "";
	}
	@NotNull(message = "当前用户不允许为空")
	@ExcelField(type = 1, title = "流入用户手机号", align = 2, sort = 4)
	public String getTargetPhone() {
		if(target!=null){
			return target.getPhone();
		}
		return "";
	}
	
	// @Length(min = 0, max = 64, message = "运单ID,如果是运单业务长度必须介于 0 和 64 之间")
	//@ExcelField(type = 1, title = "运单号", align = 2, sort = 3, value = "orderinfo.orderno")
	public Orderinfo getOrderinfo() {
		return orderinfo;
	}

	public void setOrderinfo(Orderinfo orderinfo) {
		this.orderinfo = orderinfo;
	}

	@Length(min = 0, max = 64, message = "交易编号长度必须介于 0 和 64 之间")
	@ExcelField(type = 1, title = "交易编号", align = 2, sort = 0)
	public String getConsumecode() {
		return consumecode;
	}

	public void setConsumecode(String consumecode) {
		this.consumecode = consumecode;
	}

	@Length(min = 0, max = 64, message = "第三方支付交易流水号长度必须介于 0 和 64 之间")
	//@ExcelField(type = 1, title = "关联流水", align = 2, sort = 4)
	public String getPaycode() {
		return paycode;
	}

	public void setPaycode(String paycode) {
		this.paycode = paycode;
	}

	@Length(min = 0, max = 11, message = "交易类型：0:后台充值1:支付宝充值2:微信充值3:结算支付4:结算提现5:冻结线上支付运费6:支付预支付运费7：收到预支付运费8:支付余款运费9:收到余款运费10:冻结运费返款11:运费退费12:油气返现13:余额提现14:保证金提现长度必须介于 0 和 11 之间")
	@ExcelField(type = 1, title = "交易类型", align = 2, sort = 5, dictType = "consumerecode_type")
	public String getConsumetype() {
		return consumetype;
	}

	public void setConsumetype(String consumetype) {
		this.consumetype = consumetype;
	}

	@Length(min = 0, max = 11, message = "交易方式长度必须介于 0 和 11 之间")
	@ExcelField(type = 1, title = "交易方式", align = 2, sort = 6, dictType = "consumerecode_way")
	public String getConsumeway() {
		return consumeway;
	}

	public void setConsumeway(String consumeway) {
		this.consumeway = consumeway;
	}

	@Length(min = 0, max = 255, message = "交易描述长度必须介于 0 和 255 之间")
	@ExcelField(type = 1, title = "交易描述", align = 2, sort = 13)
	public String getConsumewaydesp() {
		return consumewaydesp;
	}

	public void setConsumewaydesp(String consumewaydesp) {
		this.consumewaydesp = consumewaydesp;
	}

	@Length(min = 0, max = 11, message = "交易状态：0:交易中1:交易成功2:交易失败长度必须介于 0 和 11 之间")
	@ExcelField(type = 1, title = "交易状态", align = 2, sort = 7, dictType = "consume_status")
	public String getConsumestatus() {
		return consumestatus;
	}

	public void setConsumestatus(String consumestatus) {
		this.consumestatus = consumestatus;
	}

	@Length(min = 0, max = 11, message = "浏览方式：0:后台导入1平台2 安卓3 微信4 苹果长度必须介于 0 和 11 之间")
	public String getScantype() {
		return scantype;
	}

	public void setScantype(String scantype) {
		this.scantype = scantype;
	}

	@NotNull(message = "请填写充值金额")
	@ExcelField(type = 1, title = "交易金额", align = 2, sort = 11)
	public String getConsumemony() {
		return consumemony;
	}

	@ExcelField(type = 1, title = "交易时间", align = 1, sort = 16)
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public Date getCreateDate() {
		return createDate;
	}

	public void setConsumemony(String consumemony) {
		this.consumemony = consumemony;
	}

	@ExcelField(type = 1, title = "交易前", align = 2, sort = 10)
	public String getBeforemony() {
		return beforemony;
	}

	public void setBeforemony(String beforemony) {
		this.beforemony = beforemony;
	}

	@ExcelField(type = 1, title = "交易后", align = 2, sort = 12)
	public String getAftermony() {
		return aftermony;
	}

	public void setAftermony(String aftermony) {
		this.aftermony = aftermony;
	}

	public String getFlowbefore() {
		return flowbefore;
	}

	public void setFlowbefore(String flowbefore) {
		this.flowbefore = flowbefore;
	}

	public String getFlowafter() {
		return flowafter;
	}

	public void setFlowafter(String flowafter) {
		this.flowafter = flowafter;
	}

	// @Length(min = 0, max = 64, message = "sysaccount_id长度必须介于 0 和 64 之间")
	public User getSysaccount() {
		return sysaccount;
	}

	public void setSysaccount(User sysaccount) {
		this.sysaccount = sysaccount;
	}

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

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getIslimt() {
		return islimt;
	}

	public void setIslimt(String islimt) {
		this.islimt = islimt;
	}

	public UserBankinfo getUserBankinfo() {
		return userBankinfo;
	}

	public void setUserBankinfo(UserBankinfo userBankinfo) {
		this.userBankinfo = userBankinfo;
	}

	public String getTimeFlag() {
		return timeFlag;
	}

	public void setTimeFlag(String timeFlag) {
		this.timeFlag = timeFlag;
	}

	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	@ExcelField(type = 1, title = "单据号", align = 2, sort = 9)
	public String getBillnumber() {
		return billnumber;
	}

	public void setBillnumber(String billnumber) {
		this.billnumber = billnumber;
	}

	public String getMeno() {
		return meno;
	}

	public void setMeno(String meno) {
		this.meno = meno;
	}

	public String getTotalmoney() {
		return totalmoney;
	}

	public void setTotalmoney(String totalmoney) {
		this.totalmoney = totalmoney;
	}

	@ExcelField(type = 1, title = "操作店面", align = 2, sort = 14)
	public String getStorename() {
		return storename;
	}

	public void setStorename(String storename) {
		this.storename = storename;
	}

	@ExcelField(type = 1, title = "工号", align = 2, sort = 15)
	public String getUseraccount() {
		return useraccount;
	}

	public void setUseraccount(String useraccount) {
		this.useraccount = useraccount;
	}

	public void setCreateDateFormat(Date createDateFormat) {
		this.createDateFormat = createDateFormat;
	}
	
}