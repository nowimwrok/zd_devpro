package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class UserFlow extends DataEntity<UserFlow>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String flowId;
	private String content;
	public String getFlowId() {
		return flowId;
	}
	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	

}
