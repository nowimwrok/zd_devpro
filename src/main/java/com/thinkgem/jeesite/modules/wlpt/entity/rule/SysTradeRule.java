/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.rule;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 规则管理Entity
 * 
 * @author fjc
 * @version 2016-10-12
 */
public class SysTradeRule extends DataEntity<SysTradeRule> {

	private static final long serialVersionUID = 1L;
	private String type; // 规则分类 1：A, 2：B,3：C
	private String tradeQuota; // 交易限额 单笔交易最高限额
	private String tradeCommission; // 交易佣金 单笔交易佣金
	private String cashQuota; // 提现限额 单个账户单日累计提现限额
	private String cashQuotaUnit; // 提现限额单位 0：% ,1 ：元
	private String lowestAmount; // 最低留存额度 电子钱包最低留存额度
	private String tradeQuotaDay; // 单日交易最高限额 单日非同名交易最高限额

	public SysTradeRule() {
		super();
	}

	public SysTradeRule(String id) {
		super(id);
	}

	@Length(min = 0, max = 2, message = "规则分类 1：A, 2：B,3：C长度必须介于 0 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTradeQuota() {
		return tradeQuota;
	}

	public void setTradeQuota(String tradeQuota) {
		this.tradeQuota = tradeQuota;
	}

	public String getTradeCommission() {
		return tradeCommission;
	}

	public void setTradeCommission(String tradeCommission) {
		this.tradeCommission = tradeCommission;
	}

	public String getCashQuota() {
		return cashQuota;
	}

	public void setCashQuota(String cashQuota) {
		this.cashQuota = cashQuota;
	}

	@Length(min = 0, max = 2, message = "提现限额单位 0：%  ,1 ：元长度必须介于 0 和 2 之间")
	public String getCashQuotaUnit() {
		return cashQuotaUnit;
	}

	public void setCashQuotaUnit(String cashQuotaUnit) {
		this.cashQuotaUnit = cashQuotaUnit;
	}

	public String getLowestAmount() {
		return lowestAmount;
	}

	public void setLowestAmount(String lowestAmount) {
		this.lowestAmount = lowestAmount;
	}

	public String getTradeQuotaDay() {
		return tradeQuotaDay;
	}

	public void setTradeQuotaDay(String tradeQuotaDay) {
		this.tradeQuotaDay = tradeQuotaDay;
	}

}