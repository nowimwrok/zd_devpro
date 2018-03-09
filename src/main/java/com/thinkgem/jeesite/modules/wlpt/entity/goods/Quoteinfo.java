/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.goods;


import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

import javax.validation.constraints.NotNull;

/**
 * 货源报价管理Entity
 * @author 饶江龙
 * @version 2016-07-25
 */
public class Quoteinfo extends DataEntity<Quoteinfo> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;		// 货源id
	private User user;		// 用户id，
	private Car car;		// 报价车辆
	private String ooferprice;		// 报价
	private String quotestatus;		// 1:已报价状态,2报价通过状态3:报价未通过状态
	private String oddloadweight;		// 报价吨位
	private User driver;		// 司机ID
	private Date beginCreateDate;		// 开始 create_date
	private Date endCreateDate;		// 结束 create_date
	private Date beginUpdateDate;		// 开始 update_date
	private Date endUpdateDate;		// 结束 update_date
	private String statusStr; //状态中文名称；
	private String searchinfo;      /// 查找信息
	private String isreload;   ///是否重新配载
	private String actload;     ///实际配载吨位
	private String isassign;  //是否为指派报价
	private String ischange;  //是否更改信息

	private List<BidBlinfo> blinfoList=new ArrayList<>();   ///提货单列表







	public Quoteinfo() {
		super();
	}

	public Quoteinfo(String id){
		super(id);
	}

	public String getSearchinfo() {
		return searchinfo;
	}

	public void setSearchinfo(String searchinfo) {
		this.searchinfo = searchinfo;
	}

	public String getStatusStr() {
		return statusStr;
	}

	public void setStatusStr(String statusStr) {
		this.statusStr = statusStr;
	}

	@NotNull(message = "缺少货源信息")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@NotNull(message = "缺少车辆信息")
	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}
	
	public String getOoferprice() {
		return ooferprice;
	}

	public void setOoferprice(String ooferprice) {
		this.ooferprice = ooferprice;
	}
	
	@Length(min=0, max=2, message="1:已报价状态,2报价通过状态3:报价未通过状态长度必须介于 0 和 2 之间")
	public String getQuotestatus() {
		return quotestatus;
	}

	public void setQuotestatus(String quotestatus) {
		this.quotestatus = quotestatus;
	}
	
	@Length(min=0, max=16, message="报价吨位长度必须介于 0 和 16 之间")
	public String getOddloadweight() {
		return oddloadweight;
	}

	public void setOddloadweight(String oddloadweight) {
		this.oddloadweight = oddloadweight;
	}

	@NotNull(message = "请选择司机信息")
	public User getDriver() {
		return driver;
	}

	public void setDriver(User driver) {
		this.driver = driver;
	}
	@JsonFormat(pattern = "yyyy-MM-dd")
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
	@ExcelField(title = "更新时间",align = 2,sort = 92)
	public Date getBeginUpdateDate() {
		return beginUpdateDate;
	}

	public void setBeginUpdateDate(Date beginUpdateDate) {
		this.beginUpdateDate = beginUpdateDate;
	}
	
	
	public Date getEndUpdateDate() {
		return endUpdateDate;
	}

	public void setEndUpdateDate(Date endUpdateDate) {
		this.endUpdateDate = endUpdateDate;
	}


	public String getIsreload() {
		return isreload;
	}

	public void setIsreload(String isreload) {
		this.isreload = isreload;
	}

	public String getActload() {
		return actload;
	}

	public void setActload(String actload) {
		this.actload = actload;
	}

	public List<BidBlinfo> getBlinfoList() {
		return blinfoList;
	}

	public void setBlinfoList(List<BidBlinfo> blinfoList) {
		this.blinfoList = blinfoList;
	}

	public String getIsassign() {
		return isassign;
	}

	public void setIsassign(String isassign) {
		this.isassign = isassign;
	}

	public String getIschange() {
		return ischange;
	}

	public void setIschange(String ischange) {
		this.ischange = ischange;
	}
	
	
}