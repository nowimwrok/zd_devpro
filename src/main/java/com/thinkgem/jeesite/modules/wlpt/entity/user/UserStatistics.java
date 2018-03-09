/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 用户统计功能Entity
 * @author 曾煜佳
 * @version 2016-08-31
 */
public class UserStatistics extends DataEntity<UserStatistics> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 外键（用户ID）
	private String accruelogincount;		// 累计登录天数
	private String continuelogincount;		// 连续登录天数
	private String tradeordercount;		// 交易接单总数
	private String successtrade;		// 成功交易多少单，默认为0
	private String canceltrade;		// 取消交易多少单
	private String judgetrade;		// 已评价多少单
	private String goodjudge;		// 好评
	private String middlejudge;		// 中评
	private String badjudge;		// 差评
	private String rechargemoney;		// 累计充值金额
	private String pubgodscount;		// 发布货源量
	private String quotecount;		// 报价次数
	private String cancelgodscount;		// 取消或删除货源量
	private String addcarcount;		// 添加车数据量
	private String pubbidcount;		// 发布招标量
	private String cancelbidcount;		// 废标次数
	private String biddingcount;		// 成功竞标量
	private Role role;     ///角色
	
	private String guaranteemone;    ///保证金--扩展字段
	private String authenSucces;    ///认证--扩展字段
	private String shopmone;    ///商城消费--扩展字段
	private String settlemone;    ///结算消费--扩展字段
	private String notLogged;    //登陆状态--扩展字段
	private String daysWithoutLogin;//累计未登录的天数--扩展字段
	
	private Userinfo userinfo;     ///用户信息
	
	private Date createtime;

	
	

	public String getNotLogged() {
		return notLogged;
	}

	public void setNotLogged(String notLogged) {
		this.notLogged = notLogged;
	}

	public String getDaysWithoutLogin() {
		return daysWithoutLogin;
	}

	public void setDaysWithoutLogin(String daysWithoutLogin) {
		this.daysWithoutLogin = daysWithoutLogin;
	}

	public UserStatistics() {
		super();
	}

	public UserStatistics(String id){
		super(id);
	}

	@NotNull(message="外键（用户ID）不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@ExcelField(title = "登录名",align = 2,sort = 0,value = "user.loginName")
	public String name() {
		return getUser().getLoginName();
	}
	
	@ExcelField(title = "手机号码",align = 2,sort = 1,value = "user.phone")
	public String phone() {
		return getUser().getPhone();
	}
	
	
	
	@Length(min=0, max=11, message="累计登录天数长度必须介于 0 和 11 之间")
	@ExcelField(title="累计登录天数", align=2, sort=3)
	public String getAccruelogincount() {
		return accruelogincount;
	}

	public void setAccruelogincount(String accruelogincount) {
		this.accruelogincount = accruelogincount;
	}
	
	@Length(min=0, max=11, message="连续登录天数长度必须介于 0 和 11 之间")
	@ExcelField(title="连续登录天数", align=2, sort=4)
	public String getContinuelogincount() {
		return continuelogincount;
	}

	public void setContinuelogincount(String continuelogincount) {
		this.continuelogincount = continuelogincount;
	}
	
	@Length(min=0, max=11, message="交易接单总数长度必须介于 0 和 11 之间")
	@ExcelField(title="交易接单总数", align=2, sort=5)
	public String getTradeordercount() {
		return tradeordercount;
	}

	public void setTradeordercount(String tradeordercount) {
		this.tradeordercount = tradeordercount;
	}
	
	@Length(min=0, max=11, message="成功交易多少单，默认为0长度必须介于 0 和 11 之间")
	@ExcelField(title="成功交易单数", align=2, sort=6)
	public String getSuccesstrade() {
		return successtrade;
	}

	public void setSuccesstrade(String successtrade) {
		this.successtrade = successtrade;
	}
	
	@Length(min=0, max=11, message="取消交易多少单长度必须介于 0 和 11 之间")
	@ExcelField(title="取消交易单数", align=2, sort=7)
	public String getCanceltrade() {
		return canceltrade;
	}

	public void setCanceltrade(String canceltrade) {
		this.canceltrade = canceltrade;
	}
	
	@Length(min=0, max=11, message="已评价多少单长度必须介于 0 和 11 之间")
	@ExcelField(title="已评价单数", align=2, sort=8)
	public String getJudgetrade() {
		return judgetrade;
	}

	public void setJudgetrade(String judgetrade) {
		this.judgetrade = judgetrade;
	}
	
	@Length(min=0, max=11, message="好评长度必须介于 0 和 11 之间")
	@ExcelField(title="好评", align=2, sort=9)
	public String getGoodjudge() {
		return goodjudge;
	}

	public void setGoodjudge(String goodjudge) {
		this.goodjudge = goodjudge;
	}
	
	@Length(min=0, max=11, message="中评长度必须介于 0 和 11 之间")
	@ExcelField(title="中评", align=2, sort=10)
	public String getMiddlejudge() {
		return middlejudge;
	}

	public void setMiddlejudge(String middlejudge) {
		this.middlejudge = middlejudge;
	}
	
	@Length(min=0, max=11, message="差评长度必须介于 0 和 11 之间")
	@ExcelField(title="差评", align=2, sort=11)
	public String getBadjudge() {
		return badjudge;
	}

	public void setBadjudge(String badjudge) {
		this.badjudge = badjudge;
	}
	
	//累计充值金额
	@ExcelField(title="累计充值金额(元)", align=2, sort=12)
	public String getRechargemoney() {
		return rechargemoney;
	}

	public void setRechargemoney(String rechargemoney) {
		this.rechargemoney = rechargemoney;
	}
	
	@Length(min=0, max=11, message="发布货源量长度必须介于 0 和 11 之间")
	@ExcelField(title="发布货源次数", align=2, sort=13)
	public String getPubgodscount() {
		return pubgodscount;
	}

	public void setPubgodscount(String pubgodscount) {
		this.pubgodscount = pubgodscount;
	}
	
	@Length(min=0, max=11, message="报价次数长度必须介于 0 和 11 之间")
	@ExcelField(title="报价次数", align=2, sort=14)
	public String getQuotecount() {
		return quotecount;
	}

	public void setQuotecount(String quotecount) {
		this.quotecount = quotecount;
	}
	
	@Length(min=0, max=11, message="取消或删除货源量长度必须介于 0 和 11 之间")
	@ExcelField(title="取消或删除货源次数", align=2, sort=15)
	public String getCancelgodscount() {
		return cancelgodscount;
	}

	public void setCancelgodscount(String cancelgodscount) {
		this.cancelgodscount = cancelgodscount;
	}
	
	@Length(min=0, max=11, message="添加车数据量长度必须介于 0 和 11 之间")
	@ExcelField(title="添加车次数", align=2, sort=16)
	public String getAddcarcount() {
		return addcarcount;
	}

	public void setAddcarcount(String addcarcount) {
		this.addcarcount = addcarcount;
	}
	
	@Length(min=0, max=11, message="发布招标量长度必须介于 0 和 11 之间")
	@ExcelField(title="发布招标次数", align=2, sort=17)
	public String getPubbidcount() {
		return pubbidcount;
	}

	public void setPubbidcount(String pubbidcount) {
		this.pubbidcount = pubbidcount;
	}
	
	@Length(min=0, max=11, message="废标次数长度必须介于 0 和 11 之间")
	@ExcelField(title="废标次数", align=2, sort=18)
	public String getCancelbidcount() {
		return cancelbidcount;
	}

	public void setCancelbidcount(String cancelbidcount) {
		this.cancelbidcount = cancelbidcount;
	}
	
	@Length(min=0, max=11, message="成功竞标量长度必须介于 0 和 11 之间")
	@ExcelField(title="成功竞标次数", align=2, sort=19)
	public String getBiddingcount() {
		return biddingcount;
	}

	public void setBiddingcount(String biddingcount) {
		this.biddingcount = biddingcount;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getGuaranteemone() {
		return guaranteemone;
	}

	public void setGuaranteemone(String guaranteemone) {
		this.guaranteemone = guaranteemone;
	}

	public Userinfo getUserinfo() {
		return userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getAuthenSucces() {
		return authenSucces;
	}

	public void setAuthenSucces(String authenSucces) {
		this.authenSucces = authenSucces;
	}

	public String getShopmone() {
		return shopmone;
	}

	public void setShopmone(String shopmone) {
		this.shopmone = shopmone;
	}

	public String getSettlemone() {
		return settlemone;
	}

	public void setSettlemone(String settlemone) {
		this.settlemone = settlemone;
	}
	
	
}