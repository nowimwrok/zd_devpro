/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.freightrate;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 线路Entity
 * @author 曾煜佳
 * @version 2016-08-03
 */
public class FreightrateLine extends DataEntity<FreightrateLine> {
	
	private static final long serialVersionUID = 1L;
	private FreightratePriceinfo priceinfo;//历史运价
	private String frlineId;		// 主键
	private String startaddress;		// 起点
	private String startaremarks;		// 起点备注
	private String endaddress;		// 终点
	private String endremarks;		// 终点备注
	private String newpriceId;		// 最新的价格指数id
	private Date createtime;		// 创建时间
	private Date updatetime;		// 更新时间
	private Date timeStart;		// 开始时间
	private Date timeEnd;		// 结束时间
	public FreightratePriceinfo getPriceinfo() {
		return priceinfo;
	}

	public void setPriceinfo(FreightratePriceinfo priceinfo) {
		this.priceinfo = priceinfo;
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

	
	
	public FreightrateLine() {
		super();
	}

	public FreightrateLine(String id){
		super(id);
	}

	//@Length(min=1, max=32, message="主键长度必须介于 1 和 32 之间")
	public String getFrlineId() {
		return frlineId;
	}

	public void setFrlineId(String frlineId) {
		this.frlineId = frlineId;
	}
	
	@Length(min=0, max=20, message="起点长度必须介于 0 和 20 之间")
	public String getStartaddress() {
		return startaddress;
	}

	public void setStartaddress(String startaddress) {
		this.startaddress = startaddress;
	}
	
	@Length(min=0, max=50, message="起点备注长度必须介于 0 和 50 之间")
	public String getStartaremarks() {
		return startaremarks;
	}

	public void setStartaremarks(String startaremarks) {
		this.startaremarks = startaremarks;
	}
	
	@Length(min=0, max=20, message="终点长度必须介于 0 和 20 之间")
	public String getEndaddress() {
		return endaddress;
	}

	public void setEndaddress(String endaddress) {
		this.endaddress = endaddress;
	}
	
	@Length(min=0, max=50, message="终点备注长度必须介于 0 和 50 之间")
	public String getEndremarks() {
		return endremarks;
	}

	public void setEndremarks(String endremarks) {
		this.endremarks = endremarks;
	}
	
	//@Length(min=0, max=32, message="最新的价格指数id长度必须介于 0 和 32 之间")
	public String getNewpriceId() {
		return newpriceId;
	}

	public void setNewpriceId(String newpriceId) {
		this.newpriceId = newpriceId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
}