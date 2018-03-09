/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 用户认证统计表Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsAuthen extends DataEntity<StatisticsAuthen> {
	
	private static final long serialVersionUID = 1L;
	private Long authening;		// 认证中
	private Long authened;		// 已认证
	private Long authenfailed;		// 认证不通过
	private Long applyauthen;		// 申请认证
	private Date createtime;		// createtime
	private Long allauthen;		// 所有认证数
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	
	public StatisticsAuthen() {
		super();
	}

	public StatisticsAuthen(String id){
		super(id);
	}
	
	@ExcelField(title="认证中", align=2, sort=0)
	public Long getAuthening() {
		return authening;
	}

	public void setAuthening(Long authening) {
		this.authening = authening;
	}
	
	@ExcelField(title="已认证", align=2, sort=1)
	public Long getAuthened() {
		return authened;
	}

	public void setAuthened(Long authened) {
		this.authened = authened;
	}
	
	@ExcelField(title="认证不通过", align=2, sort=2)
	public Long getAuthenfailed() {
		return authenfailed;
	}

	public void setAuthenfailed(Long authenfailed) {
		this.authenfailed = authenfailed;
	}
	
	@ExcelField(title="申请认证", align=2, sort=3)
	public Long getApplyauthen() {
		return applyauthen;
	}

	public void setApplyauthen(Long applyauthen) {
		this.applyauthen = applyauthen;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="创建时间", align=2, sort=5)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@ExcelField(title=" 所有认证数", align=2, sort=4)
	public Long getAllauthen() {
		return allauthen;
	}

	public void setAllauthen(Long allauthen) {
		this.allauthen = allauthen;
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