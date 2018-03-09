/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户账户系统会员管理Entity
 * @author zyj
 * @version 2017-05-17
 */
public class UserAccount extends DataEntity<UserAccount> {
	
	private static final long serialVersionUID = 1L;
	private String memberId;		// 会员id
	private String repaymentId;		// 还款户id
	private String borrowerId;		// 借款户id
	private String directpaymentId;		// 定向支付户id
	private String walletId;		// 电子钱包账户id
	private String supervisorId;		// 监管户
	private String internalId;		// 内部户
	
	public UserAccount() {
		super();
	}

	public UserAccount(String id){
		super(id);
	}

	@Length(min=1, max=64, message="会员id长度必须介于 1 和 64 之间")
	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	@Length(min=0, max=64, message="还款户id长度必须介于 0 和 64 之间")
	public String getRepaymentId() {
		return repaymentId;
	}

	public void setRepaymentId(String repaymentId) {
		this.repaymentId = repaymentId;
	}
	
	@Length(min=0, max=64, message="借款户id长度必须介于 0 和 64 之间")
	public String getBorrowerId() {
		return borrowerId;
	}

	public void setBorrowerId(String borrowerId) {
		this.borrowerId = borrowerId;
	}
	
	@Length(min=0, max=64, message="定向支付户id长度必须介于 0 和 64 之间")
	public String getDirectpaymentId() {
		return directpaymentId;
	}

	public void setDirectpaymentId(String directpaymentId) {
		this.directpaymentId = directpaymentId;
	}
	
	@Length(min=0, max=64, message="电子钱包账户id长度必须介于 0 和 64 之间")
	public String getWalletId() {
		return walletId;
	}

	public void setWalletId(String walletId) {
		this.walletId = walletId;
	}
	
	@Length(min=0, max=64, message="监管户长度必须介于 0 和 64 之间")
	public String getSupervisorId() {
		return supervisorId;
	}

	public void setSupervisorId(String supervisorId) {
		this.supervisorId = supervisorId;
	}
	
	@Length(min=0, max=64, message="内部户长度必须介于 0 和 64 之间")
	public String getInternalId() {
		return internalId;
	}

	public void setInternalId(String internalId) {
		this.internalId = internalId;
	}
	
}