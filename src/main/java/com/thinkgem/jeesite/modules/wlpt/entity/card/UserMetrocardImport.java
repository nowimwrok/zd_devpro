package com.thinkgem.jeesite.modules.wlpt.entity.card;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

public class UserMetrocardImport {
	private String billnumber;
	private String paidmoney;		// 实付金额

	public UserMetrocardImport() {
	}
	
	public UserMetrocardImport(String billnumber,String paidmoney) {
		this();
		this.billnumber = billnumber;
		this.paidmoney = paidmoney;
	}
	
	@ExcelField(title = "单据号", type = 0, align = 2, sort = 0)
	public String getBillnumber() {
		return billnumber;
	}

	public void setBillnumber(String billnumber) {
		this.billnumber = billnumber;
	}

	@ExcelField(title = "实付金额", type = 0, align = 2, sort = 6)
	public String getPaidmoney() {
		return paidmoney;
	}

	public void setPaidmoney(String paidmoney) {
		this.paidmoney = paidmoney;
	}
	
}
