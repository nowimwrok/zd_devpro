/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.card;

import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 一卡通POS机列表Entity
 * @author 曾煜佳
 * @version 2016-11-30
 */
public class UserMetroPos extends DataEntity<UserMetroPos> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// POS机所属用户
	private String memberName;		// 会员姓名
	private String storeName;		// 店铺名称
	private String useraccount;		// POS机工号
	private Date beginOperateDate; // 开始 pos机绑定时间-
	private Date endOperateDate; // 结束 pos机绑定时间-
	
	private String olduseraccount; //扩展字段---久的pos机工号
	
	public UserMetroPos() {
		super();
	}

	public UserMetroPos(String id){
		super(id);
	}

	@NotNull(message="POS机所属用户不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=20, message="会员姓名长度必须介于 0 和 20 之间")
	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
	@Length(min=0, max=255, message="店铺名称长度必须介于 0 和 255 之间")
	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	
	@Length(min=0, max=32, message="POS机工号长度必须介于 0 和 32 之间")
	public String getUseraccount() {
		return useraccount;
	}

	public void setUseraccount(String useraccount) {
		this.useraccount = useraccount;
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

	public String getOlduseraccount() {
		return olduseraccount;
	}

	public void setOlduseraccount(String olduseraccount) {
		this.olduseraccount = olduseraccount;
	}
	
	
}