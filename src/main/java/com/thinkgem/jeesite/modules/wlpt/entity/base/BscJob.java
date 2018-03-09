/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 任务Entity
 * @author 王铸
 * @version 2016-09-07
 */
public class BscJob extends DataEntity<BscJob> {
	
	private static final long serialVersionUID = 1L;
	private String jobcode;		// 任务执行代码
	private String jobtype;		// 任务类型:0统计任务1采集信息
	private String jobclass;		// 任务类
	private String execycle;		// 执行方式(0非表达式 1cron表达式)
	private String dayOfMonth;		// 每月的哪天
	private String dayOfWeek;		// 周几
	private String hour;		// 小时
	private String minute;		// 分钟
	private String intervalhour;		// 间隔小时
	private String intervalminute;		// 间隔分钟
	private String jobIntervalUnit;		// 任务间隔单位：0分钟1小时2日3周4月
	private String cronexpression;		// 规则表达式
	private String jobdescription;		// 任务说明
	private String userid;		// 创建者Id
	private Date createtime;		// 创建时间
	private Date updatetime;		// 修改时间
	private String isenable;		// 是否启用：0否1是
	private String islog;		// 是否做日志记录
	
	public BscJob() {
		super();
	}

	public BscJob(String id){
		super(id);
	}

	@Length(min=0, max=32, message="任务执行代码长度必须介于 0 和 32 之间")
	public String getJobcode() {
		return jobcode;
	}

	public void setJobcode(String jobcode) {
		this.jobcode = jobcode;
	}
	
	@Length(min=0, max=11, message="任务类型:0统计任务1采集信息长度必须介于 0 和 11 之间")
	public String getJobtype() {
		return jobtype;
	}

	public void setJobtype(String jobtype) {
		this.jobtype = jobtype;
	}
	
	@Length(min=0, max=255, message="任务类长度必须介于 0 和 255 之间")
	public String getJobclass() {
		return jobclass;
	}

	public void setJobclass(String jobclass) {
		this.jobclass = jobclass;
	}
	
	@Length(min=0, max=4, message="执行方式(0非表达式 1cron表达式)长度必须介于 0 和 4 之间")
	public String getExecycle() {
		return execycle;
	}

	public void setExecycle(String execycle) {
		this.execycle = execycle;
	}
	
	@Length(min=0, max=11, message="每月的哪天长度必须介于 0 和 11 之间")
	public String getDayOfMonth() {
		return dayOfMonth;
	}

	public void setDayOfMonth(String dayOfMonth) {
		this.dayOfMonth = dayOfMonth;
	}
	
	@Length(min=0, max=4, message="周几长度必须介于 0 和 4 之间")
	public String getDayOfWeek() {
		return dayOfWeek;
	}

	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	
	@Length(min=0, max=11, message="小时长度必须介于 0 和 11 之间")
	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}
	
	@Length(min=0, max=11, message="分钟长度必须介于 0 和 11 之间")
	public String getMinute() {
		return minute;
	}

	public void setMinute(String minute) {
		this.minute = minute;
	}
	
	@Length(min=0, max=11, message="间隔小时长度必须介于 0 和 11 之间")
	public String getIntervalhour() {
		return intervalhour;
	}

	public void setIntervalhour(String intervalhour) {
		this.intervalhour = intervalhour;
	}
	
	@Length(min=0, max=11, message="间隔分钟长度必须介于 0 和 11 之间")
	public String getIntervalminute() {
		return intervalminute;
	}

	public void setIntervalminute(String intervalminute) {
		this.intervalminute = intervalminute;
	}
	
	@Length(min=0, max=4, message="任务间隔单位：0分钟1小时2日3周4月长度必须介于 0 和 4 之间")
	public String getJobIntervalUnit() {
		return jobIntervalUnit;
	}

	public void setJobIntervalUnit(String jobIntervalUnit) {
		this.jobIntervalUnit = jobIntervalUnit;
	}
	
	@Length(min=0, max=255, message="规则表达式长度必须介于 0 和 255 之间")
	public String getCronexpression() {
		return cronexpression;
	}

	public void setCronexpression(String cronexpression) {
		this.cronexpression = cronexpression;
	}
	
	@Length(min=0, max=255, message="任务说明长度必须介于 0 和 255 之间")
	public String getJobdescription() {
		return jobdescription;
	}

	public void setJobdescription(String jobdescription) {
		this.jobdescription = jobdescription;
	}
	
	@Length(min=0, max=32, message="创建者Id长度必须介于 0 和 32 之间")
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
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
	
	@Length(min=0, max=11, message="是否启用：0否1是长度必须介于 0 和 11 之间")
	public String getIsenable() {
		return isenable;
	}

	public void setIsenable(String isenable) {
		this.isenable = isenable;
	}
	
	@Length(min=0, max=11, message="是否做日志记录长度必须介于 0 和 11 之间")
	public String getIslog() {
		return islog;
	}

	public void setIslog(String islog) {
		this.islog = islog;
	}
	
}