/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.activity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 活动信息Entity
 * @author 曾煜佳
 * @version 2016-08-04
 */
public class ActivityWxinfo extends DataEntity<ActivityWxinfo> {
	
	private static final long serialVersionUID = 1L;
	/*private String activityId;		// 主键
*/	private String activityName;		// 活动名称
	private String activityContent;		// 活动内容说明
	private Date starttime;		// 开始时间
	private Date endtime;		// 结束时间
	private String iseffective;		// 是否有效，0:新建；1:开启；2失效，不可用
	private String scannum;		// 浏览量
	private String isdelete;		// 是否删除，0未删除1已删除
	private String winnum;		// 中奖量
	private Date createtime;		// createtime
	private Date updatetime;		// updatetime
	private String roletype;		// roletype
	private String type;          ///活动类型
	private String searchcondition;//用于查询
	//扩展字段
	private Date timeStart;		// 开始时间
	private Date timeEnd;		// 结束时间
	private Date activitytime;		// 活动时间用于获取最新的活动信息
	
	public ActivityWxinfo() {
		super();
	}

	public ActivityWxinfo(String id){
		super(id);
	}

	/*@Length(min=1, max=32, message="主键长度必须介于 1 和 32 之间")
	public String getActivityId() {
		return activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}*/
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getActivitytime() {
		return activitytime;
	}

	public void setActivitytime(Date activitytime) {
		this.activitytime = activitytime;
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
	
	@Length(min=0, max=32, message="活动名称长度必须介于 0 和 32 之间")
	public String getActivityName() {
		return activityName;
	}
	
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	
	@Length(min=0, max=250, message="活动内容说明长度必须介于 0 和 250 之间")
	public String getActivityContent() {
		return activityContent;
	}

	public void setActivityContent(String activityContent) {
		this.activityContent = activityContent;
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
	
	@Length(min=0, max=11, message="是否有效，0:新建；1:开启；2失效，不可用长度必须介于 0 和 11 之间")
	public String getIseffective() {
		return iseffective;
	}

	public void setIseffective(String iseffective) {
		this.iseffective = iseffective;
	}
	
	@Length(min=0, max=11, message="浏览量长度必须介于 0 和 11 之间")
	public String getScannum() {
		return scannum;
	}

	public void setScannum(String scannum) {
		this.scannum = scannum;
	}
	
	@Length(min=0, max=11, message="是否删除，0未删除1已删除长度必须介于 0 和 11 之间")
	public String getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(String isdelete) {
		this.isdelete = isdelete;
	}
	
	@Length(min=0, max=11, message="中奖量长度必须介于 0 和 11 之间")
	public String getWinnum() {
		return winnum;
	}

	public void setWinnum(String winnum) {
		this.winnum = winnum;
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
	
	@Length(min=0, max=100, message="roletype长度必须介于 0 和 100 之间")
	public String getRoletype() {
		return roletype;
	}

	public void setRoletype(String roletype) {
		this.roletype = roletype;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}