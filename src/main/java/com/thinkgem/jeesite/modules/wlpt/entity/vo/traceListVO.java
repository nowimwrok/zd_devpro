package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

public class traceListVO  extends DataEntity<traceListVO>{

	private static final long serialVersionUID = 1L;
	
	private String tradeSettlementId;
	private String memberId;
	private String tradeType;
	private String amount;
	private String outAmount;
	private String fromAccountId;
	private String fromAccountNo;
	private String fromAccountName;
	private String toAccountId;
	private String toAccountNo;
	private String toAccountName;
	private String toBankName;
	private String tradeStatus;
	private String tradeStatusTime;
	private String remark;
	
	@ExcelField(type = 1, title = "结算单ID", align = 2, sort = 0)
	public String getTradeSettlementId() {
		return tradeSettlementId;
	}
	public void setTradeSettlementId(String tradeSettlementId) {
		this.tradeSettlementId = tradeSettlementId;
	}
	
	@ExcelField(type = 1, title = "会员ID", align = 2, sort = 1)
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	@ExcelField(type = 1, title = "交易类型", align = 2, sort = 2,dictType = "tradeType")
	public String getTradeType() {
		return tradeType;
	}
	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	
	@ExcelField(type = 1, title = "交易金额", align = 2, sort = 3)
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	@ExcelField(type = 1, title = "实际转出金额", align = 2, sort = 4)
	public String getOutAmount() {
		return outAmount;
	}
	public void setOutAmount(String outAmount) {
		this.outAmount = outAmount;
	}
	
	@ExcelField(type = 1, title = "付款账户ID", align = 2, sort = 5)
	public String getFromAccountId() {
		return fromAccountId;
	}
	public void setFromAccountId(String fromAccountId) {
		this.fromAccountId = fromAccountId;
	}
	
	@ExcelField(type = 1, title = "付款账户号", align = 2, sort = 6)
	public String getFromAccountNo() {
		return fromAccountNo;
	}
	public void setFromAccountNo(String fromAccountNo) {
		this.fromAccountNo = fromAccountNo;
	}
	
	@ExcelField(type = 1, title = "付款账户名", align = 2, sort = 7)
	public String getFromAccountName() {
		return fromAccountName;
	}
	public void setFromAccountName(String fromAccountName) {
		this.fromAccountName = fromAccountName;
	}
	
	@ExcelField(type = 1, title = "收款账户ID", align = 2, sort = 8)
	public String getToAccountId() {
		return toAccountId;
	}
	public void setToAccountId(String toAccountId) {
		this.toAccountId = toAccountId;
	}
	
	@ExcelField(type = 1, title = "收款账户号", align = 2, sort = 9)
	public String getToAccountNo() {
		return toAccountNo;
	}
	public void setToAccountNo(String toAccountNo) {
		this.toAccountNo = toAccountNo;
	}
	
	@ExcelField(type = 1, title = "收款账户名", align = 2, sort = 10)
	public String getToAccountName() {
		return toAccountName;
	}
	public void setToAccountName(String toAccountName) {
		this.toAccountName = toAccountName;
	}
	
	@ExcelField(type = 1, title = "收款银行", align = 2, sort = 11)
	public String getToBankName() {
		return toBankName;
	}
	public void setToBankName(String toBankName) {
		this.toBankName = toBankName;
	}
	
	@ExcelField(type = 1, title = "交易状态", align = 2, sort = 12,dictType = "tradeStatus")
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}
	
	@ExcelField(type = 1, title = "交易时间", align = 2, sort = 13)
	public String getTradeStatusTime() {
		return tradeStatusTime;
	}
	public void setTradeStatusTime(String tradeStatusTime) {
		this.tradeStatusTime = tradeStatusTime;
	}
	
	@ExcelField(type = 1, title = "备注", align = 2, sort = 14)
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
