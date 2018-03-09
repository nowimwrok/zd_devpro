/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.card;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 一卡通pos机绑定记录Entity
 * @author zyj
 * @version 2016-12-22
 */
public class UserMetroPosRecord extends DataEntity<UserMetroPosRecord> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 本次绑定的用户
	private String useraccount;		// pos机工号
	private String type;		// 类型：1绑定，2解绑
	
	public UserMetroPosRecord() {
		super();
	}

	public UserMetroPosRecord(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=32, message="pos机工号长度必须介于 0 和 32 之间")
	public String getUseraccount() {
		return useraccount;
	}

	public void setUseraccount(String useraccount) {
		this.useraccount = useraccount;
	}
	
	@Length(min=0, max=1, message="类型：1绑定，2解绑长度必须介于 0 和 1 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}