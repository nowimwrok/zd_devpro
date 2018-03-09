package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 货物运输业务Entity
 * @author zyj
 * @version 2017-11-22
 */
public class StatisticsBusinessVO extends DataEntity<StatisticsBusinessVO> {

	private static final long serialVersionUID = 1L;
	private String sellerCompayName;		// 货主公司名称
	private String sellerName;		// 货主名称
	private String sellerUserId;		// 货主用户id
	private String sellerPhone;		// 货主手机号码
	private String buyersName;		// 司机名称
	private String buyersUserId;		// 司机用户id
	private String buyersPhone;		// 司机手机号码


	private String startProvince;		// 始发省
	private String startCity;		// 始发市
	private String startDistrict;		// 始发区
	private String startAddress;		// 始发地

	private String endProvince;		// 目的省
	private String endCity;		// 目的市
	private String endDistrict;		// 目的区
	private String endAddress;		// 目的地

	private String carNumber; //	 车牌号码
	private String cartype;		// 车辆类型
	private String carlength;		// 车辆长度
	private Date startaTime;		// 始发时间
	private Date returnTime;		// 回程时间
	private Date estimateReturnTime;		// 预计回程时间
	private String locationInfo;		// 当前车辆位置
	private String datasetType;		// 数据来源类型：1：卓大数据库
	private String datasetName;		// 所属平台名称
	private String goodsType;     //货源类型
	private String goodsName;     //货物名称
	private String goodsWeight;     //货物重量
	private String ooferprice; 	  //报价金额
	private String totalMoney;     //货物运费总价
	private String orderNo; 		//运单号
	private String orderId;		//运单id
	private String orderStatus;
	private Date orderCreateDate; //运单创建时间


	private Date beginCreateDate; // 开始 create_date
	private Date endCreateDate; // 结束 create_date

	//扩展字段
	private Long everycount;		// 数量
	private List<StatisticsBusinessVO> businessList = new ArrayList<>();

	public StatisticsBusinessVO() {
		super();
	}

	public StatisticsBusinessVO(String id){
		super(id);
	}

	public String getSellerCompayName() {
		return sellerCompayName;
	}

	public void setSellerCompayName(String sellerCompayName) {
		this.sellerCompayName = sellerCompayName;
	}

	@Length(min=0, max=20, message="货主名称长度必须介于 0 和 20 之间")
	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	
	@Length(min=0, max=50, message="货主用户id长度必须介于 0 和 50 之间")
	public String getSellerUserId() {
		return sellerUserId;
	}

	public void setSellerUserId(String sellerUserId) {
		this.sellerUserId = sellerUserId;
	}
	
	@Length(min=0, max=20, message="货主手机号码长度必须介于 0 和 20 之间")
	public String getSellerPhone() {
		return sellerPhone;
	}

	public void setSellerPhone(String sellerPhone) {
		this.sellerPhone = sellerPhone;
	}
	
	@Length(min=0, max=20, message="司机名称长度必须介于 0 和 20 之间")
	public String getBuyersName() {
		return buyersName;
	}

	public void setBuyersName(String buyersName) {
		this.buyersName = buyersName;
	}
	
	@Length(min=0, max=50, message="司机用户id长度必须介于 0 和 50 之间")
	public String getBuyersUserId() {
		return buyersUserId;
	}

	public void setBuyersUserId(String buyersUserId) {
		this.buyersUserId = buyersUserId;
	}
	
	@Length(min=0, max=20, message="司机手机号码长度必须介于 0 和 20 之间")
	public String getBuyersPhone() {
		return buyersPhone;
	}

	public void setBuyersPhone(String buyersPhone) {
		this.buyersPhone = buyersPhone;
	}

	public String getStartProvince() {
		return startProvince;
	}

	public void setStartProvince(String startProvince) {
		this.startProvince = startProvince;
	}

	public String getStartCity() {
		return startCity;
	}

	public void setStartCity(String startCity) {
		this.startCity = startCity;
	}

	public String getStartDistrict() {
		return startDistrict;
	}

	public void setStartDistrict(String startDistrict) {
		this.startDistrict = startDistrict;
	}

	@Length(min=0, max=64, message="始发地长度必须介于 0 和 64 之间")
	public String getStartAddress() {
		return startAddress;
	}

	public void setStartAddress(String startAddress) {
		this.startAddress = startAddress;
	}

	public String getEndProvince() {
		return endProvince;
	}

	public void setEndProvince(String endProvince) {
		this.endProvince = endProvince;
	}

	public String getEndCity() {
		return endCity;
	}

	public void setEndCity(String endCity) {
		this.endCity = endCity;
	}

	public String getEndDistrict() {
		return endDistrict;
	}

	public void setEndDistrict(String endDistrict) {
		this.endDistrict = endDistrict;
	}

	@Length(min=0, max=64, message="目的地长度必须介于 0 和 64 之间")
	public String getEndAddress() {
		return endAddress;
	}

	public void setEndAddress(String endAddress) {
		this.endAddress = endAddress;
	}

	public String getCarNumber() {
		return carNumber;
	}

	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}

	@Length(min=0, max=30, message="车辆类型长度必须介于 0 和 30 之间")
	public String getCartype() {
		return cartype;
	}

	public void setCartype(String cartype) {
		this.cartype = cartype;
	}
	
	@Length(min=0, max=10, message="车辆长度长度必须介于 0 和 10 之间")
	public String getCarlength() {
		return carlength;
	}

	public void setCarlength(String carlength) {
		this.carlength = carlength;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartaTime() {
		return startaTime;
	}

	public void setStartaTime(Date startaTime) {
		this.startaTime = startaTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEstimateReturnTime() {
		return estimateReturnTime;
	}

	public void setEstimateReturnTime(Date estimateReturnTime) {
		this.estimateReturnTime = estimateReturnTime;
	}
	
	@Length(min=0, max=200, message="当前车辆位置长度必须介于 0 和 200 之间")
	public String getLocationInfo() {
		return locationInfo;
	}

	public void setLocationInfo(String locationInfo) {
		this.locationInfo = locationInfo;
	}
	
	@Length(min=0, max=2, message="数据来源类型：1：卓大数据库长度必须介于 0 和 2 之间")
	public String getDatasetType() {
		return datasetType;
	}

	public void setDatasetType(String datasetType) {
		this.datasetType = datasetType;
	}
	
	@Length(min=0, max=50, message="所属平台名称长度必须介于 0 和 50 之间")
	public String getDatasetName() {
		return datasetName;
	}

	public void setDatasetName(String datasetName) {
		this.datasetName = datasetName;
	}


	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getGoodsWeight() {
		return goodsWeight;
	}

	public void setGoodsWeight(String goodsWeight) {
		this.goodsWeight = goodsWeight;
	}

	public String getOoferprice() {
		return ooferprice;
	}

	public void setOoferprice(String ooferprice) {
		this.ooferprice = ooferprice;
	}

	public String getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(String totalMoney) {
		this.totalMoney = totalMoney;
	}

	public Long getEverycount() {
		return everycount;
	}

	public void setEverycount(Long everycount) {
		this.everycount = everycount;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public List<StatisticsBusinessVO> getBusinessList() {
		return businessList;
	}

	public void setBusinessList(List<StatisticsBusinessVO> businessList) {
		this.businessList = businessList;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOrderCreateDate() {
		return orderCreateDate;
	}

	public void setOrderCreateDate(Date orderCreateDate) {
		this.orderCreateDate = orderCreateDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
}