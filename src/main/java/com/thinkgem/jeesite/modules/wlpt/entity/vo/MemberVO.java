package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

public class MemberVO extends DataEntity<MemberVO>{

	private static final long serialVersionUID = 1L;
	
	private String memberId;
	private String bankAccount;
	private String accountName;
	private String availableBalance;
	private String undeterminedBalance;
	private String freezeBalance;
	private String name;
	private String idCard;
	private String memberStatus;
	private String ruleType;
	private String createTime;
	
	@ExcelField(type = 1, title = "会员ID", align = 2, sort = 0)
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	@ExcelField(type = 1, title = "账户号", align = 2, sort = 1)
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	
	@ExcelField(type = 1, title = "账户名", align = 2, sort = 2)
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	
	@ExcelField(type = 1, title = "可用金额", align = 2, sort = 3)
	public String getAvailableBalance() {
		return availableBalance;
	}
	public void setAvailableBalance(String availableBalance) {
		this.availableBalance = availableBalance;
	}
	
	@ExcelField(type = 1, title = "在途金额", align = 2, sort = 4)
	public String getUndeterminedBalance() {
		return undeterminedBalance;
	}
	public void setUndeterminedBalance(String undeterminedBalance) {
		this.undeterminedBalance = undeterminedBalance;
	}
	
	@ExcelField(type = 1, title = "冻结金额", align = 2, sort = 5)
	public String getFreezeBalance() {
		return freezeBalance;
	}
	public void setFreezeBalance(String freezeBalance) {
		this.freezeBalance = freezeBalance;
	}
	
	@ExcelField(type = 1, title = "名称", align = 2, sort = 6)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@ExcelField(type = 1, title = "身份证号", align = 2, sort = 7)
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	
	@ExcelField(type = 1, title = "会员状态", align = 2, sort = 8, dictType = "memberStatus")
	public String getMemberStatus() {
		return memberStatus;
	}
	public void setMemberStatus(String memberStatus) {
		this.memberStatus = memberStatus;
	}
	
	@ExcelField(type = 1, title = "账户规则", align = 2, sort = 9, dictType = "rule_type")
	public String getRuleType() {
		return ruleType;
	}
	public void setRuleType(String ruleType) {
		this.ruleType = ruleType;
	}
	
	@ExcelField(type = 1, title = "创建时间", align = 2, sort = 10)
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
