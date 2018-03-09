package com.thinkgem.jeesite.modules.wlpt.entity.consume;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class AccountAmount extends DataEntity<AccountAmount>{
	private Double availableBalance;		//可用余额
	private Double undeterminedBalance;     //在途金额
	private Double freezeBalance;           //冻结金额
	private Double lockBalance;             //锁定金额
	
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

}
