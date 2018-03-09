/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.insur;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 保险品种管理Entity
 * @author zyj
 * @version 2017-03-09
 */
public class UserInsurancelist extends DataEntity<UserInsurancelist> {
	
	private static final long serialVersionUID = 1L;
	private String insurName;		// 保险名称
	private String suitableCrowd;		// 适用人群
	private String validityTerm;		// 保障期限
	private String productFeatures;		// 产品特点
	private String maxAmount;		// 高金额
	private String minAmount;		// 低金额
	private String payType;		// 支付方式
	private String insurAmount;		// 卓大直购价
	private String insurProject;		// 保障项目
	private String insurRange;		// 保障范围
	private String insurPhone;		// 官网电话
	private String insurCompanyname;		// 保险公司简称
	private String claimPeriod;		// 理赔期限
	private String clauseCode;		// 保险条款编号
	private String insurLogo;		// 保险logo
	private String remarks;    // 保险公司简介
	private String insurImg;   // 保险图片
	private String claimService;   // 理赔服务
	private String claimNotice;   // 理赔需知
	private String insuranceway;   // 保险填写内容种类--用于选择填写页面0：有货物页面1：行驶证页面
	private String type;   // 保险分类
	private String subtype; //保险附属类型
	private String ismeasure; //是否需测试0：否 ，1：是
	private String isenable; //是否启用0：否，1是
	public UserInsurancelist() {
		super();
	}

	public UserInsurancelist(String id){
		super(id);
	}

	@Length(min=0, max=50, message="保险名称长度必须介于 0 和 50 之间")
	public String getInsurName() {
		return insurName;
	}

	public void setInsurName(String insurName) {
		this.insurName = insurName;
	}
	
	@Length(min=0, max=50, message="适用人群长度必须介于 0 和 50 之间")
	public String getSuitableCrowd() {
		return suitableCrowd;
	}

	public void setSuitableCrowd(String suitableCrowd) {
		this.suitableCrowd = suitableCrowd;
	}
	
	@Length(min=0, max=50, message="保障期限长度必须介于 0 和 50 之间")
	public String getValidityTerm() {
		return validityTerm;
	}

	public void setValidityTerm(String validityTerm) {
		this.validityTerm = validityTerm;
	}
	
	@Length(min=0, max=50, message="产品特点长度必须介于 0 和 50 之间")
	public String getProductFeatures() {
		return productFeatures;
	}

	public void setProductFeatures(String productFeatures) {
		this.productFeatures = productFeatures;
	}
	
	@Length(min=0, max=20, message="高金额长度必须介于 0 和 20 之间")
	public String getMaxAmount() {
		return maxAmount;
	}

	public void setMaxAmount(String maxAmount) {
		this.maxAmount = maxAmount;
	}
	
	@Length(min=0, max=20, message="低金额长度必须介于 0 和 20 之间")
	public String getMinAmount() {
		return minAmount;
	}

	public void setMinAmount(String minAmount) {
		this.minAmount = minAmount;
	}
	
	@Length(min=0, max=20, message="支付方式长度必须介于 0 和 20 之间")
	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}
	
	@Length(min=0, max=20, message="卓大直购价长度必须介于 0 和 20 之间")
	public String getInsurAmount() {
		return insurAmount;
	}

	public void setInsurAmount(String insurAmount) {
		this.insurAmount = insurAmount;
	}
	
	@Length(min=0, max=100, message="保障项目长度必须介于 0 和 100 之间")
	public String getInsurProject() {
		return insurProject;
	}

	public void setInsurProject(String insurProject) {
		this.insurProject = insurProject;
	}
	
	@Length(min=0, max=500, message="保障范围长度必须介于 0 和 500 之间")
	public String getInsurRange() {
		return insurRange;
	}

	public void setInsurRange(String insurRange) {
		this.insurRange = insurRange;
	}
	
	@Length(min=0, max=20, message="官网电话长度必须介于 0 和 20 之间")
	public String getInsurPhone() {
		return insurPhone;
	}

	public void setInsurPhone(String insurPhone) {
		this.insurPhone = insurPhone;
	}
	
	@Length(min=0, max=50, message="保险公司简称长度必须介于 0 和 50 之间")
	public String getInsurCompanyname() {
		return insurCompanyname;
	}

	public void setInsurCompanyname(String insurCompanyname) {
		this.insurCompanyname = insurCompanyname;
	}
	
	@Length(min=0, max=20, message="理赔期限长度必须介于 0 和 20 之间")
	public String getClaimPeriod() {
		return claimPeriod;
	}

	public void setClaimPeriod(String claimPeriod) {
		this.claimPeriod = claimPeriod;
	}
	
	@Length(min=0, max=50, message="保险条款编号长度必须介于 0 和 50 之间")
	public String getClauseCode() {
		return clauseCode;
	}

	public void setClauseCode(String clauseCode) {
		this.clauseCode = clauseCode;
	}
	
	@Length(min=0, max=200, message="保险logo长度必须介于 0 和 200 之间")
	public String getInsurLogo() {
		return insurLogo;
	}

	public void setInsurLogo(String insurLogo) {
		this.insurLogo = insurLogo;
	}
	
	@Length(min = 0, max = 500)
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	@Length(min=0, max=200, message="保险介绍图片长度必须介于 0 和 200 之间")
	public String getInsurImg() {
		return insurImg;
	}

	public void setInsurImg(String insurImg) {
		this.insurImg = insurImg;
	}

	@Length(min=0, max=1000, message="理赔服务长度必须介于 0 和 1000 之间")
	public String getClaimService() {
		return claimService;
	}

	public void setClaimService(String claimService) {
		this.claimService = claimService;
	}

	@Length(min=0, max=500, message="理赔需知长度必须介于 0 和 500 之间")
	public String getClaimNotice() {
		return claimNotice;
	}

	public void setClaimNotice(String claimNotice) {
		this.claimNotice = claimNotice;
	}

	public String getInsuranceway() {
		return insuranceway;
	}

	public void setInsuranceway(String insuranceway) {
		this.insuranceway = insuranceway;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=500, message="保险附属类型长度必须介于 0 和 500 之间")
	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}

	public String getIsmeasure() {
		return ismeasure;
	}

	public void setIsmeasure(String ismeasure) {
		this.ismeasure = ismeasure;
	}

	public String getIsenable() {
		return isenable;
	}

	public void setIsenable(String isenable) {
		this.isenable = isenable;
	}
	
}