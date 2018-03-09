/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 注册统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsRegister extends DataEntity<StatisticsRegister> {
	
	private static final long serialVersionUID = 1L;
	private Long careverycount;		// 车主量
	private Long goodeverycount;		// 货主量
	private Long compeverycount;		// 物流企业量
	private Date createtime;		// 统计时间
	private Long allcount;		// 当前平台注册总量
	
	//扩展字段
	private String count;
	private String name;
	private String enname;
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	
	public StatisticsRegister() {
		super();
	}

	public StatisticsRegister(String id){
		super(id);
	}

	@ExcelField(title="车主量", align=2, sort=0)
	public Long getCareverycount() {
		return careverycount;
	}

	public void setCareverycount(Long careverycount) {
		this.careverycount = careverycount;
	}
	
	@ExcelField(title="货主量", align=2, sort=1)
	public Long getGoodeverycount() {
		return goodeverycount;
	}

	public void setGoodeverycount(Long goodeverycount) {
		this.goodeverycount = goodeverycount;
	}
	
	@ExcelField(title="物流企业量", align=2, sort=2)
	public Long getCompeverycount() {
		return compeverycount;
	}

	public void setCompeverycount(Long compeverycount) {
		this.compeverycount = compeverycount;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=4)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@ExcelField(title="当前平台注册总量", align=2, sort=3)
	public Long getAllcount() {
		return allcount;
	}

	public void setAllcount(Long allcount) {
		this.allcount = allcount;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getEnname() {
		return enname;
	}

	public void setEnname(String enname) {
		this.enname = enname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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