package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

public class CarUser {
	private String billnumber;

	@ExcelField(title = "单据号", type = 0, align = 2, sort = 0)
	public String getBillnumber() {
		return billnumber;
	}

	public void setBillnumber(String billnumber) {
		this.billnumber = billnumber;
	}
	
	
	
	
}

