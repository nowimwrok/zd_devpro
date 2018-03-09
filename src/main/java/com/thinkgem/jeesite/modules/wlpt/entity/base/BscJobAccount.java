/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 轮询任务数据管理Entity
 * @author zyj
 * @version 2017-03-21
 */
public class BscJobAccount extends DataEntity<BscJobAccount> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// 类型
	private String targetid;		// 目标数据
	private String tradesettlementid;		// 返回的业务结算单号
	private String status;		// 状态
	private User user;		// 所属用户
	
	public BscJobAccount() {
		super();
	}

	public BscJobAccount(String id){
		super(id);
	}

	@Length(min=0, max=2, message="类型长度必须介于 0 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=50, message="目标数据长度必须介于 0 和 50 之间")
	public String getTargetid() {
		return targetid;
	}

	public void setTargetid(String targetid) {
		this.targetid = targetid;
	}
	
	@Length(min=0, max=50, message="返回的业务结算单号长度必须介于 0 和 50 之间")
	public String getTradesettlementid() {
		return tradesettlementid;
	}

	public void setTradesettlementid(String tradesettlementid) {
		this.tradesettlementid = tradesettlementid;
	}
	
	@Length(min=0, max=2, message="状态长度必须介于 0 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	
}