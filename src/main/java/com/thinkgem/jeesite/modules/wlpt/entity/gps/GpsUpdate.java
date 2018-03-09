/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.entity.gps;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 这是个测试类Entity
 * @author leifeng
 * @version 2017-09-05
 */
public class GpsUpdate extends DataEntity<GpsUpdate> {
	
	private static final long serialVersionUID = 1L;
	private String carNumber;		// 车牌号码
	private String railType;		// 类型
	private String railName;		// 围栏名称
	private Long railStoptime;		// 围栏停留时间
	private Date railTime;		// 围栏时间
	private Date railLeaveTime; 	//出围时间
	private String userword;	//用户名&密码
	private String receivePerson;		// 接受消息人
	private String receivePhone;		// 接受消息手机号码
	private String pushFlag;		// 是否已推送
	private String pushType;		// 推送类型
	private String modelCode;		// 消息模板编码
	private String readFlag;		// 是否已读
	private String image;		// 消息内容

	public GpsUpdate() {
		super();
	}

	public Date getRailLeaveTime() {
		return railLeaveTime;
	}
	
	public void setRailLeaveTime(Date railLeaveTime) {
		this.railLeaveTime = railLeaveTime;
	}
	
	public String getUserword() {
		return userword;
	}

	public void setUserword(String userword) {
		this.userword = userword;
	}

	public GpsUpdate(String id){
		super(id);
	}

	@Length(min=0, max=255, message="车牌号码长度必须介于 0 和 255 之间")
	public String getCarNumber() {
		return carNumber;
	}

	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}
	
	@Length(min=0, max=255, message="类型长度必须介于 0 和 255 之间")
	public String getRailType() {
		return railType;
	}

	public void setRailType(String railType) {
		this.railType = railType;
	}
	
	@Length(min=0, max=255, message="围栏名称长度必须介于 0 和 255 之间")
	public String getRailName() {
		return railName;
	}

	public void setRailName(String railName) {
		this.railName = railName;
	}
	
	public Long getRailStoptime() {
		return railStoptime;
	}

	public void setRailStoptime(Long railStoptime) {
		this.railStoptime = railStoptime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRailTime() {
		return railTime;
	}

	public void setRailTime(Date railTime) {
		this.railTime = railTime;
	}
	
	@Length(min=0, max=255, message="接受消息人长度必须介于 0 和 255 之间")
	public String getReceivePerson() {
		return receivePerson;
	}

	public void setReceivePerson(String receivePerson) {
		this.receivePerson = receivePerson;
	}
	
	@Length(min=0, max=255, message="接受消息手机号码长度必须介于 0 和 255 之间")
	public String getReceivePhone() {
		return receivePhone;
	}

	public void setReceivePhone(String receivePhone) {
		this.receivePhone = receivePhone;
	}
	
	@Length(min=1, max=1, message="是否已推送长度必须介于 1 和 1 之间")
	public String getPushFlag() {
		return pushFlag;
	}

	public void setPushFlag(String pushFlag) {
		this.pushFlag = pushFlag;
	}
	
	@Length(min=0, max=1, message="推送类型长度必须介于 0 和 1 之间")
	public String getPushType() {
		return pushType;
	}

	public void setPushType(String pushType) {
		this.pushType = pushType;
	}
	
	@Length(min=0, max=255, message="消息模板编码长度必须介于 0 和 255 之间")
	public String getModelCode() {
		return modelCode;
	}

	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}
	
	@Length(min=1, max=1, message="是否已读长度必须介于 1 和 1 之间")
	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	
	@Length(min=0, max=255, message="消息内容长度必须介于 0 和 255 之间")
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
}