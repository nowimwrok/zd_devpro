/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.insur;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 保险险种记录Entity
 * @author zyj
 * @version 2017-11-17
 */
public class UserInsuranceInfo extends DataEntity<UserInsuranceInfo> {
	
	private static final long serialVersionUID = 1L;
	private UserInsurance insurance;		// 用户保险主表
	private String name;		// 承包险种
	private String insuredamount;		// 保险金额
	private String insurancepremium;		// 保险费用
	private String isfranchise;		// 是否免赔
	private String subtotal;		// 小计
	
	public UserInsuranceInfo() {
		super();
	}

	public UserInsuranceInfo(String id){
		super(id);
	}

	public UserInsurance getInsurance() {
		return insurance;
	}

	public void setInsurance(UserInsurance insurance) {
		this.insurance = insurance;
	}

	@Length(min=0, max=50, message="承包险种长度必须介于 0 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=50, message="保险金额长度必须介于 0 和 50 之间")
	public String getInsuredamount() {
		return insuredamount;
	}

	public void setInsuredamount(String insuredamount) {
		this.insuredamount = insuredamount;
	}
	
	@Length(min=0, max=50, message="保险费用长度必须介于 0 和 50 之间")
	public String getInsurancepremium() {
		return insurancepremium;
	}

	public void setInsurancepremium(String insurancepremium) {
		this.insurancepremium = insurancepremium;
	}
	
	@Length(min=0, max=10, message="是否免赔长度必须介于 0 和 10 之间")
	public String getIsfranchise() {
		return isfranchise;
	}

	public void setIsfranchise(String isfranchise) {
		this.isfranchise = isfranchise;
	}
	
	@Length(min=0, max=50, message="小计长度必须介于 0 和 50 之间")
	public String getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(String subtotal) {
		this.subtotal = subtotal;
	}
	
}