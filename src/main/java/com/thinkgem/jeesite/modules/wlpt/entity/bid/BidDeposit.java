package com.thinkgem.jeesite.modules.wlpt.entity.bid;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
/**
 * @author lijintao
 * @deprecated 用于用户竞标押金信息导出Excel
 * @since 2016-8-29
 * 
 * */
public class BidDeposit extends Account{
     
    /**
	 * 
	 */
	private static final long serialVersionUID = -5798215023357309597L;
	private Double jnjbyj;//缴纳竞标押金 
	private Double sdjbyj;//收到竞标押金 
	private Double jbyjhk;//竞标押金还款 
	private Double sdjbhk;//收到竞标还款 
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
    @ExcelField(title="缴纳竞标押金 ", type=1, align=2, sort=27)
	public Double getJnjbyj() {
		return jnjbyj;
	}
	public void setJnjbyj(Double jnjbyj) {
		this.jnjbyj = jnjbyj;
	}
	@ExcelField(title="收到竞标押金  ", type=1, align=2, sort=28)
	public Double getSdjbyj() {
		return sdjbyj;
	}
	public void setSdjbyj(Double sdjbyj) {
		this.sdjbyj = sdjbyj;
	}
	@ExcelField(title="竞标押金还款  ", type=1, align=2, sort=29)
	public Double getJbyjhk() {
		return jbyjhk;
	}
	public void setJbyjhk(Double jbyjhk) {
		this.jbyjhk = jbyjhk;
	}
	@ExcelField(title="收到竞标还款  ", type=1, align=2, sort=30)
	public Double getSdjbhk() {
		return sdjbhk;
	}
	public void setSdjbhk(Double sdjbhk) {
		this.sdjbhk = sdjbhk;
	}
}
