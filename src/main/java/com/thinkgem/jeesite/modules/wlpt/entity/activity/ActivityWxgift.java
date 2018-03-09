/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.activity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 奖品列表Entity
 * @author 曾煜佳
 * @version 2016-08-04
 */
public class ActivityWxgift extends DataEntity<ActivityWxgift> {
	
	private static final long serialVersionUID = 1L;
	private ActivityWxinfo wxinfo;		// 活动信息
	/*private String giftId;		// 奖品ID主键*/
	private String giftname;		// 礼物名称
	private String giftcontent;		// 活动说明
	private String giftnum;		// 奖品数量
	private String giftdaynum;		// 每天奖品最多数量
	private Date createtime;		// 创建时间
	private Date updatetime;		// 修改时间
	private String isdelete;		// 是否删除0:未删除；1已删除
	private String giftworth;		// 礼物价值
	private String surplusnum;		// 礼物剩余多少个
	private String gifttype;		// 奖品类型：0现金，1礼物，2谢谢参与
	private String winnum;		// winnum
	private String chance;		// chance
	private String pagetype; //页面类型-用于记录前一个页面
	private String searchcondition;//用于查询
	private Date timeStart;		// 开始时间
	private Date timeEnd;		// 结束时间
	private Date currenttime;   //当前时间
	private Date starttime;		// 开始时间
	private Date endtime;		// 结束时间

	
	public ActivityWxgift() {
		super();
	}

	public ActivityWxgift(String id){
		super(id);
	}
	
	
	
	public Date getCurrenttime() {
		return currenttime;
	}

	public void setCurrenttime(Date currenttime) {
		this.currenttime = currenttime;
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

	public String getPagetype() {
		return pagetype;
	}

	public void setPagetype(String pagetype) {
		this.pagetype = pagetype;
	}

	public ActivityWxinfo getWxinfo() {
		return wxinfo;
	}

	public void setWxinfo(ActivityWxinfo wxinfo) {
		this.wxinfo = wxinfo;
	}
	/*@Length(min=1, max=32, message="奖品ID主键长度必须介于 1 和 32 之间")
	public String getGiftId() {
		return giftId;
	}

	public void setGiftId(String giftId) {
		this.giftId = giftId;
	}*/
	
	
	
	@Length(min=0, max=32, message="礼物名称长度必须介于 0 和 32 之间")
	public String getGiftname() {
		return giftname;
	}

	public void setGiftname(String giftname) {
		this.giftname = giftname;
	}
	
	@Length(min=0, max=250, message="活动说明长度必须介于 0 和 250 之间")
	public String getGiftcontent() {
		return giftcontent;
	}

	public void setGiftcontent(String giftcontent) {
		this.giftcontent = giftcontent;
	}
	
	@Length(min=0, max=11, message="奖品数量长度必须介于 0 和 11 之间")
	public String getGiftnum() {
		return giftnum;
	}

	public void setGiftnum(String giftnum) {
		this.giftnum = giftnum;
	}
	
	@Length(min=0, max=11, message="每天奖品最多数量长度必须介于 0 和 11 之间")
	public String getGiftdaynum() {
		return giftdaynum;
	}

	public void setGiftdaynum(String giftdaynum) {
		this.giftdaynum = giftdaynum;
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
	
	@Length(min=0, max=11, message="是否删除0:未删除；1已删除长度必须介于 0 和 11 之间")
	public String getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(String isdelete) {
		this.isdelete = isdelete;
	}
	
	public String getGiftworth() {
		return giftworth;
	}

	public void setGiftworth(String giftworth) {
		this.giftworth = giftworth;
	}
	
	@Length(min=0, max=11, message="礼物剩余多少个长度必须介于 0 和 11 之间")
	public String getSurplusnum() {
		return surplusnum;
	}

	public void setSurplusnum(String surplusnum) {
		this.surplusnum = surplusnum;
	}
	
	@Length(min=0, max=11, message="奖品类型：0现金，1礼物，2谢谢参与长度必须介于 0 和 11 之间")
	public String getGifttype() {
		return gifttype;
	}

	public void setGifttype(String gifttype) {
		this.gifttype = gifttype;
	}
	
	@Length(min=0, max=11, message="winnum长度必须介于 0 和 11 之间")
	public String getWinnum() {
		return winnum;
	}

	public void setWinnum(String winnum) {
		this.winnum = winnum;
	}
	
	public String getChance() {
		return chance;
	}

	public void setChance(String chance) {
		this.chance = chance;
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