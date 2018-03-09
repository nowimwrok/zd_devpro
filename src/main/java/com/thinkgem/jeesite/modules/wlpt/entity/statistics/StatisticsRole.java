/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 角色会员总量统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsRole extends DataEntity<StatisticsRole> {
	
	private static final long serialVersionUID = 1L;
	private Long entprisecount;		// 物流企业总数
	private Long goodsownerscount;		// 货主总数
	private Long carownercount;		// 车主总数
	private Long allcount;		// 总数
	private Date createtime;		// 统计时间
	
	//扩展字段
	private String timeflg;
	private String cretime;
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	public StatisticsRole() {
		super();
	}

	public StatisticsRole(String id){
		super(id);
	}

	@ExcelField(title="物流企业总数", align=2, sort=0)
	public Long getEntprisecount() {
		return entprisecount;
	}

	public void setEntprisecount(Long entprisecount) {
		this.entprisecount = entprisecount;
	}
	
	@ExcelField(title="货主总数", align=2, sort=1)
	public Long getGoodsownerscount() {
		return goodsownerscount;
	}

	public void setGoodsownerscount(Long goodsownerscount) {
		this.goodsownerscount = goodsownerscount;
	}
	
	@ExcelField(title="车主总数", align=2, sort=2)
	public Long getCarownercount() {
		return carownercount;
	}

	public void setCarownercount(Long carownercount) {
		this.carownercount = carownercount;
	}
	
	@ExcelField(title="总数", align=2, sort=3)
	public Long getAllcount() {
		return allcount;
	}

	public void setAllcount(Long allcount) {
		this.allcount = allcount;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=4)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getTimeflg() {
		return timeflg;
	}

	public void setTimeflg(String timeflg) {
		this.timeflg = timeflg;
	}

	public String getCretime() {
		return cretime;
	}

	public void setCretime(String cretime) {
		this.cretime = cretime;
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