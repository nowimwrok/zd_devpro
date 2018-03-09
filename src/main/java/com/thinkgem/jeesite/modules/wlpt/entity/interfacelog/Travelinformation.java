/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.entity.interfacelog;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 存储信息Entity
 * 
 * @author qiao
 * @version 2017-09-29
 */
public class Travelinformation extends DataEntity<Travelinformation> {

	private static final long serialVersionUID = 1L;
	private String carid; // 车辆ID
	private String vclN; // 车牌号
	private String vclWnrNm; // 联系人
	private String vclWnrPhn; // 联系人手机
	private String areaName; // 车籍地
	private String vclTpNm; // 车辆类型
	private String vbrndCdNm; // 车辆品牌
	private String prdCdNm; // 车辆型号
	private String cmpNm; // 车主/业户
	private String vin; // 车辆识别代码/车架号
	private String vclTn; // 总质量
	private String ldTn; // 核定载重量
	private String vclDrwTn; // 准牵引总质量
	private String vclLng; // 外廓尺寸-长(mm)
	private String vclWdt; // 外廓尺寸-宽(mm)
	private String vclHgt; // 外廓尺寸-高(mm)
	private String boxLng; // 内廓尺寸-长(mm)
	private String boxWdt; // 内廓尺寸-宽(mm)
	private String boxHgt; // 内廓尺寸-高(mm)
	private String serviceName; // 服务商单位名称
	private String servicePhone; // 服务商联系电话

	public Travelinformation() {
		super();
	}

	public Travelinformation(String id) {
		super(id);
	}

	public String getCarid() {
		return carid;
	}

	public void setCarid(String carid) {
		this.carid = carid;
	}

	@Length(min = 1, max = 64, message = "车牌号长度必须介于 1 和 64 之间")
	public String getVclN() {
		return vclN;
	}

	public void setVclN(String vclN) {
		this.vclN = vclN;
	}

	@Length(min = 0, max = 255, message = "联系人长度必须介于 0 和 255 之间")
	public String getVclWnrNm() {
		return vclWnrNm;
	}

	public void setVclWnrNm(String vclWnrNm) {
		this.vclWnrNm = vclWnrNm;
	}

	@Length(min = 0, max = 255, message = "联系人手机长度必须介于 0 和 255 之间")
	public String getVclWnrPhn() {
		return vclWnrPhn;
	}

	public void setVclWnrPhn(String vclWnrPhn) {
		this.vclWnrPhn = vclWnrPhn;
	}

	@Length(min = 0, max = 255, message = "车籍地长度必须介于 0 和 255 之间")
	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	@Length(min = 0, max = 255, message = "车辆类型长度必须介于 0 和 255 之间")
	public String getVclTpNm() {
		return vclTpNm;
	}

	public void setVclTpNm(String vclTpNm) {
		this.vclTpNm = vclTpNm;
	}

	@Length(min = 0, max = 255, message = "车辆品牌长度必须介于 0 和 255 之间")
	public String getVbrndCdNm() {
		return vbrndCdNm;
	}

	public void setVbrndCdNm(String vbrndCdNm) {
		this.vbrndCdNm = vbrndCdNm;
	}

	@Length(min = 0, max = 255, message = "车辆型号长度必须介于 0 和 255 之间")
	public String getPrdCdNm() {
		return prdCdNm;
	}

	public void setPrdCdNm(String prdCdNm) {
		this.prdCdNm = prdCdNm;
	}

	@Length(min = 0, max = 255, message = "车主/业户长度必须介于 0 和 255 之间")
	public String getCmpNm() {
		return cmpNm;
	}

	public void setCmpNm(String cmpNm) {
		this.cmpNm = cmpNm;
	}

	@Length(min = 0, max = 255, message = "车辆识别代码/车架号长度必须介于 0 和 255 之间")
	public String getVin() {
		return vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	@Length(min = 0, max = 255, message = "总质量长度必须介于 0 和 255 之间")
	public String getVclTn() {
		return vclTn;
	}

	public void setVclTn(String vclTn) {
		this.vclTn = vclTn;
	}

	@Length(min = 0, max = 255, message = "核定载重量长度必须介于 0 和 255 之间")
	public String getLdTn() {
		return ldTn;
	}

	public void setLdTn(String ldTn) {
		this.ldTn = ldTn;
	}

	@Length(min = 0, max = 255, message = "准牵引总质量长度必须介于 0 和 255 之间")
	public String getVclDrwTn() {
		return vclDrwTn;
	}

	public void setVclDrwTn(String vclDrwTn) {
		this.vclDrwTn = vclDrwTn;
	}

	@Length(min = 0, max = 255, message = "外廓尺寸-长(mm)长度必须介于 0 和 255 之间")
	public String getVclLng() {
		return vclLng;
	}

	public void setVclLng(String vclLng) {
		this.vclLng = vclLng;
	}

	@Length(min = 0, max = 255, message = "外廓尺寸-宽(mm)长度必须介于 0 和 255 之间")
	public String getVclWdt() {
		return vclWdt;
	}

	public void setVclWdt(String vclWdt) {
		this.vclWdt = vclWdt;
	}

	@Length(min = 0, max = 255, message = "外廓尺寸-高(mm)长度必须介于 0 和 255 之间")
	public String getVclHgt() {
		return vclHgt;
	}

	public void setVclHgt(String vclHgt) {
		this.vclHgt = vclHgt;
	}

	@Length(min = 0, max = 255, message = "内廓尺寸-长(mm)长度必须介于 0 和 255 之间")
	public String getBoxLng() {
		return boxLng;
	}

	public void setBoxLng(String boxLng) {
		this.boxLng = boxLng;
	}

	@Length(min = 0, max = 255, message = "内廓尺寸-宽(mm)长度必须介于 0 和 255 之间")
	public String getBoxWdt() {
		return boxWdt;
	}

	public void setBoxWdt(String boxWdt) {
		this.boxWdt = boxWdt;
	}

	@Length(min = 0, max = 255, message = "内廓尺寸-高(mm)长度必须介于 0 和 255 之间")
	public String getBoxHgt() {
		return boxHgt;
	}

	public void setBoxHgt(String boxHgt) {
		this.boxHgt = boxHgt;
	}

	@Length(min = 0, max = 255, message = "服务商单位名称长度必须介于 0 和 255 之间")
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	@Length(min = 0, max = 255, message = "服务商联系电话长度必须介于 0 和 255 之间")
	public String getServicePhone() {
		return servicePhone;
	}

	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}

}