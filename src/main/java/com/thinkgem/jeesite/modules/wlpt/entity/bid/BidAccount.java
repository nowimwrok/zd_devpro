package com.thinkgem.jeesite.modules.wlpt.entity.bid;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
/**
 * @author lijintao
 * @deprecated 用于用户竞标结算信息导出Excel
 * @since 2016-8-29
 * 
 * */
public class BidAccount extends Account{
     
    /**
	 * 
	 */
	private static final long serialVersionUID = -5798215023357309597L;
	private Double jszf;//结算支付 
	private Double jstx;//结算提现 
	private Double sdjs;//收到结算 
	private User user;//钱包账户
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@ExcelField(title="登录名",type=1,align=2,sort=0)
	public String loginName(){
		return getUser().getLoginName();
	}
	@ExcelField(title="用户名",type=1,align=2,sort=1)
	public String Name(){
		return getUser().getName();
	}
	@ExcelField(title="角色",type=1,align=2,sort=2)
	public String Role(){
		return getUser().getRole().getName();
	}
	@ExcelField(title="手机号码",type=1,align=2,sort=3)
	public String Phone(){
		return getUser().getPhone();
	}
	@ExcelField(title="结算支付 ", type=1, align=2, sort=10)
	public Double getJszf() {
		return jszf;
	}
	public void setJszf(Double jszf) {
		this.jszf = jszf;
	}
	@ExcelField(title="结算提现 ", type=1, align=2, sort=11)
	public Double getJstx() {
		return jstx;
	}
	public void setJstx(Double jstx) {
		this.jstx = jstx;
	}
	@ExcelField(title="收到结算 ", type=1, align=2, sort=12)
	public Double getSdjs() {
		return sdjs;
	}
	public void setSdjs(Double sdjs) {
		this.sdjs = sdjs;
	}
}
