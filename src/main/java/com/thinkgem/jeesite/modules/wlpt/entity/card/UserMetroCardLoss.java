/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.card;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;

/**
 * 一卡通挂失Entity
 * 
 * @author fjc
 * @version 2016-10-20
 */
public class UserMetroCardLoss extends DataEntity<UserMetroCardLoss> {

	private static final long serialVersionUID = 1L;
	private User user; // 请申挂失用户ID
	private Address address; // 联系地址
	private String cardid; // 卡号
	private String status; // 状态：0申请挂失 1处理中 2处理完毕
	private String useraccount; // 一卡通工号
	private String truename; // 一卡通姓名
	private String mobile; // 一卡通电话
	private String ispayment;//是否收取挂失费用
	private String newcardid;//当次挂失后更换的新卡号
	
	private Date beginCreateDate; // 开始 创建时间-
	private Date endCreateDate; // 结束 创建时间-

	public UserMetroCardLoss() {
		super();
	}

	public UserMetroCardLoss(String id) {
		super(id);
	}

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

	@Length(min = 0, max = 32, message = "卡号长度必须介于 0 和 32 之间")
	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	@Length(min = 0, max = 2, message = "状态：0申请挂失 1处理中 2处理完毕长度必须介于 0 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min = 0, max = 32, message = "一卡通工号长度必须介于 0 和 32 之间")
	public String getUseraccount() {
		return useraccount;
	}

	public void setUseraccount(String useraccount) {
		this.useraccount = useraccount;
	}

	@Length(min = 0, max = 32, message = "一卡通姓名长度必须介于 0 和 32 之间")
	public String getTruename() {
		return truename;
	}

	public void setTruename(String truename) {
		this.truename = truename;
	}

	@Length(min = 0, max = 32, message = "一卡通电话长度必须介于 0 和 32 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

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

	public String getIspayment() {
		return ispayment;
	}

	public void setIspayment(String ispayment) {
		this.ispayment = ispayment;
	}

	public String getNewcardid() {
		return newcardid;
	}

	public void setNewcardid(String newcardid) {
		this.newcardid = newcardid;
	}

}