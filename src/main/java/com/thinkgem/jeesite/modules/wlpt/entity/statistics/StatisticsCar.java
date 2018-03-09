/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 平台车辆统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsCar extends DataEntity<StatisticsCar> {
	
	private static final long serialVersionUID = 1L;
	private Long everycount;		// 车辆数
	private Long allcount;		// allcount
	private Date createtime;		// 创建时间
	
	//扩展字段
	private String cretime;
	private String timeflg;
	private String carType;
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	public StatisticsCar() {
		super();
	}

	public StatisticsCar(String id){
		super(id);
	}

	@ExcelField(title="每天车辆数", align=2, sort=0)
	public Long getEverycount() {
		return everycount;
	}

	public void setEverycount(Long everycount) {
		this.everycount = everycount;
	}
	
	@ExcelField(title="当前平台车辆总数", align=2, sort=1)
	public Long getAllcount() {
		return allcount;
	}

	public void setAllcount(Long allcount) {
		this.allcount = allcount;
	}
	
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=2)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getCretime() {
		return cretime;
	}

	public void setCretime(String cretime) {
		this.cretime = cretime;
	}

	public String getTimeflg() {
		return timeflg;
	}

	public void setTimeflg(String timeflg) {
		this.timeflg = timeflg;
	}

	public String getCarType() {
		return carType;
	}

	public void setCarType(String carType) {
		this.carType = carType;
	}

	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
	
}