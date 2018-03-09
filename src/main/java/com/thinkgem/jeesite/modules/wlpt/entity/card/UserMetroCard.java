/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.card;

import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户一卡通Entity
 * @author 刘欣
 * @version 2016-09-18
 */
public class UserMetroCard extends DataEntity<UserMetroCard> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID
	private Address address;		// 联系地址
	private String openid;		// 一卡通OPENID
	private String cardid;		// 一卡通卡号
	private String password;		// 一卡通卡密码
	private String status;		// 状态：0 申请中 1申请通过 2申请不通过 3注销
	private String userAccount;//一卡通工号
	private String trueName;//一卡通姓名
	private String mobile;//一卡通电话
	private String idcard;//一卡通身份证
	private String sex;//一卡通性别
	private String birth;//一卡通生日
	private String cardAddress;//一卡通地址
	
	private Date beginCreateDate; // 开始 创建时间-
	private Date endCreateDate; // 结束 创建时间-
	private String ispayment;//是否收取挂失费用--扩展字段
	private String oldcardid;//当次挂失的旧卡号--扩展字段
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getTrueName() {
		return trueName;
	}

	public void setTrueName(String trueName) {
		this.trueName = trueName;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getCardAddress() {
		return cardAddress;
	}

	public void setCardAddress(String cardAddress) {
		this.cardAddress = cardAddress;
	}

	public UserMetroCard() {
		super();
	}

	public UserMetroCard(String id){
		super(id);
	}

	@NotNull(message="用户ID不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	@Length(min=0, max=32, message="一卡通OPENID长度必须介于 0 和 32 之间")
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	@Length(min=0, max=32, message="卡号长度必须介于 0 和 32 之间")
	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIspayment() {
		return ispayment;
	}

	public void setIspayment(String ispayment) {
		this.ispayment = ispayment;
	}

	public String getOldcardid() {
		return oldcardid;
	}

	public void setOldcardid(String oldcardid) {
		this.oldcardid = oldcardid;
	}
	
}