/**
 * 
 */
package com.thinkgem.jeesite.modules.sms.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 消息发送日志Entity
 * @author 饶江龙
 * @version 2016-07-20
 */
public class SendLog extends DataEntity<SendLog> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID
	private String module;		// 系统模块
	private String function;		// 功能
	private String mobiles;		// 手机号码
	private String smsContent;		// 短信内容
	private String cost;		// 扣费
	private String sendTime;		// 发送时间
	
	public SendLog() {
		super();
	}

	public SendLog(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=255, message="系统模块长度必须介于 0 和 255 之间")
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}
	
	@Length(min=0, max=255, message="功能长度必须介于 0 和 255 之间")
	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}
	
	@Length(min=0, max=255, message="手机号码长度必须介于 0 和 255 之间")
	public String getMobiles() {
		return mobiles;
	}

	public void setMobiles(String mobiles) {
		this.mobiles = mobiles;
	}
	
	@Length(min=0, max=255, message="短信内容长度必须介于 0 和 255 之间")
	public String getSmsContent() {
		return smsContent;
	}

	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}
	
	@Length(min=1, max=11, message="扣费长度必须介于 1 和 11 之间")
	public String getCost() {
		if (cost==null || "".equals(cost))
			cost="0";
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}
	
	@Length(min=0, max=255, message="发送时间长度必须介于 0 和 255 之间")
	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	
}