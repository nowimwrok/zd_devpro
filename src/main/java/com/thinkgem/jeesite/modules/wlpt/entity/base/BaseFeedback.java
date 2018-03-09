/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 意见反馈Entity
 * @author 王铸
 * @version 2016-08-09
 */
public class BaseFeedback extends DataEntity<BaseFeedback> {
	
	private static final long serialVersionUID = 1L;
	private String feedbackId;		// 意见反馈ID
	private String content;		// 反馈内容
	private String phone;		// 反馈用户的手机号码
	private Date createtime;		// 反馈时间
	private String scantype;		// 反馈系统类型1.平台2android3webchat4ios
	private String responsecontent;		// 应答内容
	private Date responsetime;		// 应答时间
	private String responseuserid;		// 应答用户id
	private String responseusername;    // 应答用户login name
	
	public BaseFeedback() {
		super();
	}

	public BaseFeedback(String id){
		super(id);
	}

	@Length(min=1, max=32, message="意见反馈ID长度必须介于 1 和 32 之间")
	public String getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(String feedbackId) {
		this.feedbackId = feedbackId;
	}
	
	@Length(min=0, max=255, message="反馈内容长度必须介于 0 和 255 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=0, max=11, message="反馈用户的手机号码长度必须介于 0 和 11 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	public String getScantype() {
		return scantype;
	}

	public void setScantype(String scantype) {
		this.scantype = scantype;
	}
	
	@Length(min=0, max=255, message="应答内容长度必须介于 0 和 255 之间")
	public String getResponsecontent() {
		return responsecontent;
	}

	public void setResponsecontent(String responsecontent) {
		this.responsecontent = responsecontent;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getResponsetime() {
		return responsetime;
	}

	public void setResponsetime(Date responsetime) {
		this.responsetime = responsetime;
	}
	
	@Length(min=0, max=32, message="反馈用户id长度必须介于 0 和 32 之间")
	public String getResponseuserid() {
		return responseuserid;
	}

	public void setResponseuserid(String responseuserid) {
		this.responseuserid = responseuserid;
		this.responseusername = UserUtils.getUser().getLoginName();
	}

	public String getResponseusername() {
		return responseusername;
	}

	public void setResponseusername(String responseusername) {
		this.responseusername = responseusername;
	}
	
}