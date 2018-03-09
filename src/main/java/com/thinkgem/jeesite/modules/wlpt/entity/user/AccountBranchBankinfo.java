package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 账户系统支行信息列表
 * @author Administrator
 *
 */
public class AccountBranchBankinfo extends DataEntity<AccountBranchBankinfo>{
	
	private String lineNo;//联行号
	private String bankName;//银行名称
	private String fullName;//支行名称
	private String type;//类型 1：大小额；2：超级网银
	public String getLineNo() {
		return lineNo;
	}
	public void setLineNo(String lineNo) {
		this.lineNo = lineNo;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	

}
