/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.goods;

import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 货源管理数据Entity
 * @author 饶江龙
 * @version 2016-07-25
 */
public class Goods extends DataEntity<Goods> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID,外键
	private String goodsname;		// 货物名称
	private String goodstype;		// 货物类型:0:轻货1:重货
	private String gsoddtype;		// 货源类型0:轻货，1成品，2原材料
	private String transportway;		// 运输方式
	private String cartype;		// 车型要求
	private String carlength;		// 车长
	private String lengthunit;		// 车长单位
	private String freightvolume;		// 货运量
	private String residualvolume;		// 剩余货运量
	private String freightunit;		// 货运单位:吨/方/平方米
	private String piecenumber;		// 件数
	private String stevedore;		// 搬运工
	private String packageway;		// 包装方式
	private String worth;		// 货物价值
	private String expectedprice;		// 期望价格
	private Date sendtime;		// 发货时间
	private Date arrivetime;     //到达时间
	private Date arrivetime_start;
	private Date arrivetime_end;// 到达时间
	private String tradestatus;		// 交易状态默认-1，未交易，其他与运单状态一致
	private String effectdays;		// 有效期
	private String datasource;		// 数据发布源:0:自发没有明细，1:明细发布，2:合同发布，3招标发布
	private String scannum;		// 浏览量
	private String praisenumber;		// 点赞量
	/*private String shipId;		// 发货地址信息;外键
	private String consignId;		// 收货地址信息*/
	private String quotecount;		// 报价次数
	private String beginFreightvolume;		// 开始 货运量
	private String endFreightvolume;		// 结束 货运量
	private String beginResidualvolume;		// 开始 剩余货运量
	private String endResidualvolume;		// 结束 剩余货运量
	private Date beginSendtime;		// 开始 发货时间
	private Date endSendtime;		// 结束 发货时间
	private String beginCarlength;        // 开始 车长
	private String endCarlength;        // 结束 车长

	private String addressStart;   //起点
	private String addressEnd;   ///终点

    private int status;//报价的状态

	private Address shipAddress;  //发货地址地址管理
	private Address consignAddress;  //收货地址
	
	///扩展字段
	private String ordernum;  //运单数量
	private String sumtotalcost;  //总运费
	private String sumoddloadweight;  //报价吨数
	private String istrading;//查询是否状态
	private String shipprocity;
	private String consprocity;
	private String nottradestatus;//本次不查询的状态
	
	//保险
	private String isinsur;  //是否购买保险：0不投保,1投保
	private String paypeople;//投保支付方：0货主支付，1司机支付

	private String ymdDate;   ///年月日时间
	private int searchType;

	private String issend;//是否指派
	private String quoteuserid;//当前报价用户id
	
	private List<BidBlinfo> blinfoList=new ArrayList<>();   ///提货单列表

	private List<Address> shipList = new ArrayList<>();

	public String getQuotecount() {
		return quotecount;
	}

	public void setQuotecount(String quotecount) {
		this.quotecount = quotecount;
	}

	@ExcelField(title = "登录名",align = 2,sort = 0,value = "user.loginName")
	public String name() {
		return getUser().getLoginName();
	}
	
	@ExcelField(title = "手机号码",align = 2,sort = 1,value = "user.phone")
	public String phone() {
		return getUser().getPhone();
	}
	public String getBeginCarlength() {
		return beginCarlength;
	}

	public void setBeginCarlength(String beginCarlength) {
		this.beginCarlength = beginCarlength;
	}

	public String getEndCarlength() {
		return endCarlength;
	}

	public void setEndCarlength(String endCarlength) {
		this.endCarlength = endCarlength;
	}

	public Goods() {
		super();
	}

	public Goods(String id){
		super(id);
	}

	public String getYmdDate() {
		return ymdDate;
	}

	public void setYmdDate(String ymdDate){
		this.ymdDate=ymdDate;
	}

	public List<BidBlinfo>  getBlinfoList(){
		return blinfoList;
	}

	public void setBlinfoList(List<BidBlinfo> blinfoList){
		this.blinfoList=blinfoList;
	}

	///收货地址
	public String getAddressStart() {
		return addressStart;
	}public void setAddressStart(String addressStart) {
		this.addressStart = addressStart;
	}public String getAddressEnd() {
		return addressEnd;
	}public void setAddressEnd(String addressEnd) {
		this.addressEnd = addressEnd;
	}
	@NotNull(message = "请选择收货地址")
	public Address getConsignAddress() {
		return consignAddress;
	}

	public void setConsignAddress(Address consignAddress) {
		this.consignAddress = consignAddress;
	}

	///发货地址
	@NotNull(message = "请选择发货地址")
	public Address getShipAddress() {
		return shipAddress;
	}

	public void setShipAddress(Address shipAddress) {
		this.shipAddress = shipAddress;
	}


	//@NotNull(message="用户ID,外键不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=64, message="货物名称长度必须介于 1 和 64 之间")
	public String getGoodsname() {
		return goodsname;
	}

	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}
	
	@Length(min=0, max=11, message="货物类型:0:轻货1:重货长度必须介于 0 和 11 之间")
	public String getGoodstype() {
		return goodstype;
	}

	public void setGoodstype(String goodstype) {
		this.goodstype = goodstype;
	}
	
	@Length(min=0, max=11, message="货源类型0:轻货，1成品，2原材料长度必须介于 0 和 11 之间")
	public String getGsoddtype() {
		return gsoddtype;
	}

	public void setGsoddtype(String gsoddtype) {
		this.gsoddtype = gsoddtype;
	}
	
	@Length(min=0, max=64, message="运输方式长度必须介于 0 和 64 之间")
	public String getTransportway() {
		return transportway;
	}

	public void setTransportway(String transportway) {
		this.transportway = transportway;
	}
	
	@Length(min=0, max=64, message="车型要求长度必须介于 0 和 64 之间")
	public String getCartype() {
		return cartype;
	}

	public void setCartype(String cartype) {
		this.cartype = cartype;
	}
	
	public String getCarlength() {
		return carlength;
	}

	public void setCarlength(String carlength) {
		this.carlength = carlength;
	}
	
	@Length(min=0, max=5, message="车长单位长度必须介于 0 和 5 之间")
	public String getLengthunit() {
		return lengthunit;
	}

	public void setLengthunit(String lengthunit) {
		this.lengthunit = lengthunit;
	}
	
	@ExcelField(title="货运量", align=2, sort=3)
	public String getFreightvolume() {
		return freightvolume;
	}

	public void setFreightvolume(String freightvolume) {
		this.freightvolume = freightvolume;
	}
	
	@ExcelField(title="剩余货运量", align=2, sort=4)
	public String getResidualvolume() {
		return residualvolume;
	}

	public void setResidualvolume(String residualvolume) {
		this.residualvolume = residualvolume;
	}
	
	@Length(min=0, max=10, message="货运单位:吨/方/平方米长度必须介于 0 和 10 之间")
	public String getFreightunit() {
		return freightunit;
	}

	public void setFreightunit(String freightunit) {
		this.freightunit = freightunit;
	}
	
	@Length(min=0, max=11, message="件数长度必须介于 0 和 11 之间")
	public String getPiecenumber() {
		return piecenumber;
	}

	public void setPiecenumber(String piecenumber) {
		this.piecenumber = piecenumber;
	}
	
	@Length(min=0, max=64, message="搬运工长度必须介于 0 和 64 之间")
	public String getStevedore() {
		return stevedore;
	}

	public void setStevedore(String stevedore) {
		this.stevedore = stevedore;
	}
	
	@Length(min=0, max=64, message="包装方式长度必须介于 0 和 64 之间")
	public String getPackageway() {
		return packageway;
	}

	public void setPackageway(String packageway) {
		this.packageway = packageway;
	}
	
	@ExcelField(title="货物价值", align=2, sort=5)
	public String getWorth() {
		return worth;
	}

	public void setWorth(String worth) {
		this.worth = worth;
	}
	
	public String getExpectedprice() {
		return expectedprice;
	}

	public void setExpectedprice(String expectedprice) {
		this.expectedprice = expectedprice;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getArrivetime() {
		return arrivetime;
	}

	public void setArrivetime(Date arrivetime) {
		this.arrivetime = arrivetime;
	}
	
/*	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getArrivetime() {
		return arrivetime;
	}

	public void setArrivetime(Date arrivetime) {
		this.arrivetime = arrivetime;
	}*/
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getArrivetime_start() {
		return arrivetime_start;
	}

	public void setArrivetime_start(Date arrivetime_start) {
		this.arrivetime_start = arrivetime_start;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getArrivetime_end() {
		return arrivetime_end;
	}

	public void setArrivetime_end(Date arrivetime_end) {
		this.arrivetime_end = arrivetime_end;
	}

	
	@Length(min=0, max=11, message="交易状态默认-1，未交易，其他与运单状态一致长度必须介于 0 和 11 之间")
	public String getTradestatus() {
		return tradestatus;
	}

	public void setTradestatus(String tradestatus) {
		this.tradestatus = tradestatus;
	}
	
	@Length(min=0, max=11, message="有效期长度必须介于 0 和 11 之间")
	public String getEffectdays() {
		return effectdays;
	}

	public void setEffectdays(String effectdays) {
		this.effectdays = effectdays;
	}
	
	@Length(min=0, max=11, message="数据发布源:0:自发没有明细，1:明细发布，2:合同发布，3招标发布长度必须介于 0 和 11 之间")
	public String getDatasource() {
		return datasource;
	}

	public void setDatasource(String datasource) {
		this.datasource = datasource;
	}
	
	@Length(min=0, max=11, message="浏览量长度必须介于 0 和 11 之间")
	public String getScannum() {
		return scannum;
	}

	public void setScannum(String scannum) {
		this.scannum = scannum;
	}
	
	@Length(min=0, max=11, message="点赞量长度必须介于 0 和 11 之间")
	public String getPraisenumber() {
		return praisenumber;
	}

	public void setPraisenumber(String praisenumber) {
		this.praisenumber = praisenumber;
	}
	
	/*@Length(min=0, max=64, message="发货地址信息;外键长度必须介于 0 和 64 之间")
	public String getShipId() {
		return shipId;
	}

	public void setShipId(String shipId) {
		this.shipId = shipId;
	}
	
	@Length(min=0, max=64, message="收货地址信息长度必须介于 0 和 64 之间")
	public String getConsignId() {
		return consignId;
	}

	public void setConsignId(String consignId) {
		this.consignId = consignId;
	}*/

	
	public String getBeginFreightvolume() {
		return beginFreightvolume;
	}

	public void setBeginFreightvolume(String beginFreightvolume) {
		this.beginFreightvolume = beginFreightvolume;
	}
	
	public String getEndFreightvolume() {
		return endFreightvolume;
	}

	public void setEndFreightvolume(String endFreightvolume) {
		this.endFreightvolume = endFreightvolume;
	}
		
	public String getBeginResidualvolume() {
		return beginResidualvolume;
	}

	public void setBeginResidualvolume(String beginResidualvolume) {
		this.beginResidualvolume = beginResidualvolume;
	}
	
	public String getEndResidualvolume() {
		return endResidualvolume;
	}

	public void setEndResidualvolume(String endResidualvolume) {
		this.endResidualvolume = endResidualvolume;
	}
		
	public Date getBeginSendtime() {
		return beginSendtime;
	}

	public void setBeginSendtime(Date beginSendtime) {
		this.beginSendtime = beginSendtime;
	}
	
	public Date getEndSendtime() {
		return endSendtime;
	}

	public void setEndSendtime(Date endSendtime) {
		this.endSendtime = endSendtime;
	}

	//运单数量
	@ExcelField(title="运单数量", align=2, sort=6)
	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	
	//总运费
	@ExcelField(title="总运费", align=2, sort=8)
	public String getSumtotalcost() {
		return sumtotalcost;
	}

	public void setSumtotalcost(String sumtotalcost) {
		this.sumtotalcost = sumtotalcost;
	}

	//总报价吨数
	@ExcelField(title="报价吨数", align=2, sort=7)
	public String getSumoddloadweight() {
		return sumoddloadweight;
	}

	public void setSumoddloadweight(String sumoddloadweight) {
		this.sumoddloadweight = sumoddloadweight;
	}

	//支付状态
	public String getIstrading() {
		return istrading;
	}

	public void setIstrading(String istrading) {
		this.istrading = istrading;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getSearchType() {
		return searchType;
	}

	public void setSearchType(int searchType) {
		this.searchType = searchType;
	}

	public String getIsinsur() {
		return isinsur;
	}

	public void setIsinsur(String isinsur) {
		this.isinsur = isinsur;
	}

	public String getPaypeople() {
		return paypeople;
	}

	public void setPaypeople(String paypeople) {
		this.paypeople = paypeople;
	}

	public String getIssend() {
		return issend;
	}

	public void setIssend(String issend) {
		this.issend = issend;
	}

	public String getQuoteuserid() {
		return quoteuserid;
	}

	public void setQuoteuserid(String quoteuserid) {
		this.quoteuserid = quoteuserid;
	}

	public String getNottradestatus() {
		return nottradestatus;
	}

	public void setNottradestatus(String nottradestatus) {
		this.nottradestatus = nottradestatus;
	}
	
}