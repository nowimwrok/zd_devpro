/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.integrity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 诚信积分Entity
 * @author 刘欣
 * @version 2016-09-13
 */
public class IntegrityRecord extends DataEntity<IntegrityRecord> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 会员ID
	private IntegrityStandarditems standarditems;		// 评分项
	private int integral;		// 评分项所得积分
	
	public IntegrityRecord() {
		super();
	}

	public IntegrityRecord(String id){
		super(id);
	}


	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public IntegrityStandarditems getStandarditems() {
		return standarditems;
	}

	public void setStandarditems(IntegrityStandarditems standarditems) {
		this.standarditems = standarditems;
	}

	public int getIntegral() {
		return integral;
	}

	public void setIntegral(int integral) {
		this.integral = integral;
	}
}