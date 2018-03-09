/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.freightrate;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 历史运价Entity
 * @author 曾煜佳
 * @version 2016-08-03
 */
public class FreightratePriceinfo extends DataEntity<FreightratePriceinfo> {
	
	private static final long serialVersionUID = 1L;
	private String frpriceId;		// 主键
	private String goodstype;		// 货源类型
	private String newprice;		// 最新价
	private String averageprice;		// 平均价格
	private Date createtime;		// 创建时间
	private Date updatetime;		// 更新时间
	private String modetranspor;		// 运输方式
	private String carlength;		// 车辆长度(对应车型)
	private String address;		// 路线
	private String frlineId;		// 线路id
	private Date timeStart;		// 开始时间
	private Date timeEnd;		// 结束时间
	private String pagetype; //页面类型-用于记录前一个页面
	private String avgprice;//只用于海图的平均记录
	private String endAddress;
	private String startAddress;
	private String createtimeFormat;
	public String getPagetype() {
		return pagetype;
	}

	public void setPagetype(String pagetype) {
		this.pagetype = pagetype;
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

	public FreightratePriceinfo() {
		super();
	}

	public FreightratePriceinfo(String id){
		super(id);
	}

	//@Length(min=1, max=32, message="主键长度必须介于 1 和 32 之间")
	public String getFrpriceId() {
		return frpriceId;
	}

	public void setFrpriceId(String frpriceId) {
		this.frpriceId = frpriceId;
	}
	
	@Length(min=0, max=2, message="货源类型长度必须介于 0 和 2 之间")
	public String getGoodstype() {
		return goodstype;
	}

	public void setGoodstype(String goodstype) {
		this.goodstype = goodstype;
	}
	
	public String getNewprice() {
		return newprice;
	}

	public void setNewprice(String newprice) {
		this.newprice = newprice;
	}
	
	public String getAverageprice() {
		return averageprice;
	}

	public void setAverageprice(String averageprice) {
		this.averageprice = averageprice;
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
	
	@Length(min=0, max=20, message="运输方式长度必须介于 0 和 20 之间")
	public String getModetranspor() {
		return modetranspor;
	}

	public void setModetranspor(String modetranspor) {
		this.modetranspor = modetranspor;
	}
	
	public String getCarlength() {
		return carlength;
	}

	public void setCarlength(String carlength) {
		this.carlength = carlength;
	}
	
	@Length(min=0, max=255, message="路线长度必须介于 0 和 255 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	//@Length(min=0, max=32, message="线路id长度必须介于 0 和 32 之间")
	public String getFrlineId() {
		return frlineId;
	}

	public void setFrlineId(String frlineId) {
		this.frlineId = frlineId;
	}

	public String getAvgprice() {
		return avgprice;
	}

	public void setAvgprice(String avgprice) {
		this.avgprice = avgprice;
	}

	public String getEndAddress() {
		return endAddress;
	}

	public void setEndAddress(String endAddress) {
		this.endAddress = endAddress;
	}

	public String getStartAddress() {
		return startAddress;
	}

	public void setStartAddress(String startAddress) {
		this.startAddress = startAddress;
	}

	public String getCreatetimeFormat() {
		return createtimeFormat;
	}

	public void setCreatetimeFormat(String createtimeFormat) {
		this.createtimeFormat = createtimeFormat;
	}
	
}