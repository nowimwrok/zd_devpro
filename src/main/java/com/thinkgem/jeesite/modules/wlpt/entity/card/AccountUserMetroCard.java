/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.card;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 一卡通消费统计Entity
 * 
 * @author fjc
 * @version 2016-09-29
 */
public class AccountUserMetroCard extends DataEntity<AccountUserMetroCard> {

	private static final long serialVersionUID = 1L;

	private String totalmoneyAccount; // 付应金额
	private String totalpaidAccount; // 实付金额
	private String paidmoneyAccount; // 现金支付
	private String paidvalueAccount; // 储值支付
	private String paidpointAccount; // 积分支付
	private String pointAccount; // 获得积分
	private User user; // 所属用户
	private String cardid; // 卡号
	private String truename; // 会员姓名
	private String useraccount; // useraccount
	private String status;
	private String way;
	private String type;

	private Date beginOperateDate; // 开始 交易时间时间-
	private Date endOperateDate; // 结束 交易时间-

	public AccountUserMetroCard() {
		super();
	}

	public AccountUserMetroCard(String id) {
		super(id);
	}
	@ExcelField(title = "应付金额", align = 2, sort = 7)
	public String getTotalmoneyAccount() {
		return totalmoneyAccount;
	}

	public void setTotalmoneyAccount(String totalmoneyAccount) {
		this.totalmoneyAccount = totalmoneyAccount;
	}
	@ExcelField(title = "实付金额", align = 2, sort = 8)
	public String getTotalpaidAccount() {
		return totalpaidAccount;
	}

	public void setTotalpaidAccount(String totalpaidAccount) {
		this.totalpaidAccount = totalpaidAccount;
	}
	@ExcelField(title = "现金支付", align = 2, sort = 9)
	public String getPaidmoneyAccount() {
		return paidmoneyAccount;
	}

	public void setPaidmoneyAccount(String paidmoneyAccount) {
		this.paidmoneyAccount = paidmoneyAccount;
	}
	@ExcelField(title = "储值支付", align = 2, sort = 10)
	public String getPaidvalueAccount() {
		return paidvalueAccount;
	}

	public void setPaidvalueAccount(String paidvalueAccount) {
		this.paidvalueAccount = paidvalueAccount;
	}
	@ExcelField(title = "积分支付", align = 2, sort = 11)
	public String getPaidpointAccount() {
		return paidpointAccount;
	}

	public void setPaidpointAccount(String paidpointAccount) {
		this.paidpointAccount = paidpointAccount;
	}
	@ExcelField(title = "获得积分", align = 2, sort = 12)
	public String getPointAccount() {
		return pointAccount;
	}

	public void setPointAccount(String pointAccount) {
		this.pointAccount = pointAccount;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getBeginOperateDate() {
		return beginOperateDate;
	}

	public void setBeginOperateDate(Date beginOperateDate) {
		this.beginOperateDate = beginOperateDate;
	}

	public Date getEndOperateDate() {
		return endOperateDate;
	}

	public void setEndOperateDate(Date endOperateDate) {
		this.endOperateDate = endOperateDate;
	}
	@ExcelField(title = "卡号", align = 2, sort = 3)
	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	@ExcelField(title = "会员姓名", align = 2, sort = 6)
	public String getTruename() {
		return truename;
	}

	public void setTruename(String truename) {
		this.truename = truename;
	}
	@ExcelField(title = "工号", align = 2, sort = 4)
	public String getUseraccount() {
		return useraccount;
	}

	public void setUseraccount(String useraccount) {
		this.useraccount = useraccount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}