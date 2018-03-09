package com.thinkgem.jeesite.modules.wlpt.entity.consume;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

public class Transfer extends DataEntity<Transfer>{

	private static final long serialVersionUID = 1L;
	private String consumemonyin;//收到转账总金额
	private String consumemonyout;//转账总金额
	private User user;//用户
	private String webbalance;//余额
	private String availablebalance;//可用余额
	private List<Consumerecod> list;//记录

	@ExcelField(type = 1, sort = 5, title = "账户转账总额", align = '2')
	public String getConsumemonyin() {
		return consumemonyin;
	}
	public void setConsumemonyin(String consumemonyin) {
		this.consumemonyin = consumemonyin;
	}
	@ExcelField(type = 1, sort = 6, title = "收到转账总额", align = '2')
	public String getConsumemonyout() {
		return consumemonyout;
	}
	public void setConsumemonyout(String consumemonyout) {
		this.consumemonyout = consumemonyout;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@ExcelField(type = 1, sort = 0, title = "登录名", align = '2', value = "user.loginName")
	public String getLoginName(){
		return this.getUser().getLoginName();
	}
	@ExcelField(type = 1, sort = 1, title = "姓名", align = '2', value = "user.name")
	public String getName(){
		return this.getUser().getName();
	}
	@ExcelField(type = 1, sort = 2, title = "手机", align = '2', value = "user.phone")
	public String getPhone(){
		return this.getUser().getPhone();
	}
	@ExcelField(type = 1, sort = 3, title = "账户余额", align = '2')
	public String getWebbalance() {
		return webbalance;
	}
	public void setWebbalance(String webbalance) {
		this.webbalance = webbalance;
	}
	@ExcelField(type = 1, sort = 4, title = "可用余额", align = '2')
	public String getAvailablebalance() {
		return availablebalance;
	}
	public void setAvailablebalance(String availablebalance) {
		this.availablebalance = availablebalance;
	}
	public List<Consumerecod> getList() {
		return list;
	}
	public void setList(List<Consumerecod> list) {
		this.list = list;
	}

}
