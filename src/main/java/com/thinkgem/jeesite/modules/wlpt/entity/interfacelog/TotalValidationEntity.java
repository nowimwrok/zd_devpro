package com.thinkgem.jeesite.modules.wlpt.entity.interfacelog;

public class TotalValidationEntity {

	private String vclN;// 车牌号
	private String name;// 车主姓名
	private String phone;// 车主电话
	private String area;// 区县
	private String vco;// 车牌颜色 车牌颜色，1：蓝色；2：黄色
	private String rtcNo;// 道路运输证号码
	private String[] regist; // 页面选中调用的服务

	public String[] getRegist() {
		return regist;
	}

	public void setRegist(String[] regist) {
		this.regist = regist;
	}

	public String getVclN() {
		return vclN;
	}

	public void setVclN(String vclN) {
		this.vclN = vclN;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getVco() {
		return vco;
	}

	public void setVco(String vco) {
		this.vco = vco;
	}

	public String getRtcNo() {
		return rtcNo;
	}

	public void setRtcNo(String rtcNo) {
		this.rtcNo = rtcNo;
	}

}
