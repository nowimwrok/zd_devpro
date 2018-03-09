package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class ShopVO extends DataEntity<ShopVO> {

	private static final long serialVersionUID = 1L;
	
	private String shotName;
	private String name;
	private String price;
	private String total;
	private String num;
	private String insurid;
	public String getShotName() {
		return shotName;
	}
	public void setShotName(String shotName) {
		this.shotName = shotName;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getInsurid() {
		return insurid;
	}
	public void setInsurid(String insurid) {
		this.insurid = insurid;
	}

}
