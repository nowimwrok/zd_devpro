/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.activity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 中奖记录Entity
 * @author 曾煜佳
 * @version 2016-08-04
 */
public class ActivityAwardrecord extends DataEntity<ActivityAwardrecord> {
	
	private static final long serialVersionUID = 1L;
	private ActivityWxinfo wxinfo;		// 活动信息
	private ActivityWxgift wxgift;		// 奖品列表
	private String awardno;		// 获奖编号
	private User user;		// 用户ID
	private String issue;		// 是否发放：0未发放，1已发放2作废3已使用
	private Date createtime;		// 创建时间－获奖时间
	private Date updatetime;		// 更新时间
	private String searchcondition;//用于查询
	private Date timeStart;		// 开始时间
	private Date timeEnd;		// 结束时间
	private String gifttypename;//活动类型名称
	private String issuename;		// 是否发放中文：0未发放，1已发放2作废3已使用
	private String phone;
	private Date starttime;		// 有效期-开始时间
	private Date endtime;		// 有效期-结束时间

	public ActivityAwardrecord() {
		super();
	}

	public ActivityAwardrecord(String id){
		super(id);
	}

	public String getGifttypename() {
		return gifttypename;
	}

	public void setGifttypename(String gifttypename) {
		this.gifttypename = gifttypename;
	}

	public String getIssuename() {
		return issuename;
	}

	public void setIssuename(String issuename) {
		this.issuename = issuename;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(Date timeStart) {
		this.timeStart = timeStart;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(Date timeEnd) {
		this.timeEnd = timeEnd;
	}

	public String getSearchcondition() {
		return searchcondition;
	}

	public void setSearchcondition(String searchcondition) {
		this.searchcondition = searchcondition;
	}

	public ActivityWxinfo getWxinfo() {
		return wxinfo;
	}

	public void setWxinfo(ActivityWxinfo wxinfo) {
		this.wxinfo = wxinfo;
	}

	public ActivityWxgift getWxgift() {
		return wxgift;
	}

	public void setWxgift(ActivityWxgift wxgift) {
		this.wxgift = wxgift;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=11, message="是否发放：0未发放，1已发放2作废长度必须介于 0 和 11 之间")
	public String getIssue() {
		return issue;
	}

	public void setIssue(String issue) {
		this.issue = issue;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getAwardno() {
		return awardno;
	}

	public void setAwardno(String awardno) {
		this.awardno = awardno;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
}