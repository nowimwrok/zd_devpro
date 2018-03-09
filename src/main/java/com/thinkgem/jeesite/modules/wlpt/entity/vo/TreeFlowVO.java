package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

public class TreeFlowVO extends DataEntity<TreeFlowVO>{

	private static final long serialVersionUID = 1L;
	
	private String flowId; 
	private String accountId;
	private String tradeType;
	private String amount;
	private String availableBalance;
	private String undeterminedBalance;
	private String freezeBalance;
	private String lockBalance;
	private String oppoAcctId;
	private String oppoAcctNo;
	private String oppoAcctName;
	private String oppoBankName;
	private String reversalId;
	private String flowStatus;
	private String dealTime;
	
	@ExcelField(type = 1, title = "二级流水ID", align = 2, sort = 0)
	public String getFlowId() {
		return flowId;
	}
	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}
	
	@ExcelField(type = 1, title = "二级账号Id", align = 2, sort = 1)
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
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
	
	@ExcelField(type = 1, title = "可用余额", align = 2, sort = 4)
	public String getAvailableBalance() {
		return availableBalance;
	}
	public void setAvailableBalance(String availableBalance) {
		this.availableBalance = availableBalance;
	}
	
	@ExcelField(type = 1, title = "在途金额", align = 2, sort = 5)
	public String getUndeterminedBalance() {
		return undeterminedBalance;
	}
	public void setUndeterminedBalance(String undeterminedBalance) {
		this.undeterminedBalance = undeterminedBalance;
	}
	
	@ExcelField(type = 1, title = "冻结金额", align = 2, sort = 6)
	public String getFreezeBalance() {
		return freezeBalance;
	}
	public void setFreezeBalance(String freezeBalance) {
		this.freezeBalance = freezeBalance;
	}

	@ExcelField(type = 1, title = "锁定金额", align = 2, sort = 7)
	public String getLockBalance() {
		return lockBalance;
	}
	public void setLockBalance(String lockBalance) {
		this.lockBalance = lockBalance;
	}
	
	@ExcelField(type = 1, title = "对方账户Id", align = 2, sort = 8)
	public String getOppoAcctId() {
		return oppoAcctId;
	}
	public void setOppoAcctId(String oppoAcctId) {
		this.oppoAcctId = oppoAcctId;
	}
	
	@ExcelField(type = 1, title = "对方账户号", align = 2, sort = 9)
	public String getOppoAcctNo() {
		return oppoAcctNo;
	}
	public void setOppoAcctNo(String oppoAcctNo) {
		this.oppoAcctNo = oppoAcctNo;
	}
	
	@ExcelField(type = 1, title = "对方账户名", align = 2, sort = 10)
	public String getOppoAcctName() {
		return oppoAcctName;
	}
	public void setOppoAcctName(String oppoAcctName) {
		this.oppoAcctName = oppoAcctName;
	}
	
	@ExcelField(type = 1, title = "对方银行", align = 2, sort = 11)
	public String getOppoBankName() {
		return oppoBankName;
	}
	public void setOppoBankName(String oppoBankName) {
		this.oppoBankName = oppoBankName;
	}
	
	@ExcelField(type = 1, title = "冲正ID", align = 2, sort = 12)
	public String getReversalId() {
		return reversalId;
	}
	public void setReversalId(String reversalId) {
		this.reversalId = reversalId;
	}
	
	@ExcelField(type = 1, title = "交易状态", align = 2, sort = 13,dictType = "tradeStatus")
	public String getFlowStatus() {
		return flowStatus;
	}
	public void setFlowStatus(String flowStatus) {
		this.flowStatus = flowStatus;
	}
	
	@ExcelField(type = 1, title = "交易时间", align = 2, sort = 14)
	public String getDealTime() {
		return dealTime;
	}
	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}

}
