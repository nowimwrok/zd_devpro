/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.contacts;

import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 常用联系人Entity
 * @author zyj
 * @version 2017-04-11
 */
public class UserCommonContacts extends DataEntity<UserCommonContacts> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 所属用户id
	private User target;		// 目标id
	private String targetType;		// 目标类型
	protected Date createDate;    // 创建日期
	public UserCommonContacts() {
		super();
	}

	public UserCommonContacts(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public User getTarget() {
		return target;
	}

	public void setTarget(User target) {
		this.target = target;
	}

	@Length(min=0, max=2, message="目标类型长度必须介于 0 和 2 之间")
	public String getTargetType() {
		return targetType;
	}

	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}