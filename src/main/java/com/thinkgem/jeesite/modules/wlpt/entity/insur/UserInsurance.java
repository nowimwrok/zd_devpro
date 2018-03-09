/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.insur;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 保险Entity
 * @author 保险
 * @version 2016-12-19
 */
public class UserInsurance extends DataEntity<UserInsurance> {
	
	private static final long serialVersionUID = 1L;
	private String applicant;		// 投保人姓名
	private User user;		// 购买者
	private String goodsname;		// 被保货物名称
	private String goodstype;		// 货物类型
	private String worth;		// 货物价值
	private String carnumber;		// 车牌号
	private String cartype;		// 车辆类型
	private String carmodel;		// 厂牌型号
	private String totalweight;		// 总重量
	private String carweight;		// 车辆核对重量
	private String insurancetype;		// 保险品种
	private String insuranceamount;		// 理赔保险金额
	private String insurancefeel;		// 保险购买费用
	private String status;		// 保单状态
	private String orderno;		// 运单号
	private String insuranceNO; //保单号
	private String voucherimg; //保单电子凭证图片
	private String payway;//支付方式
	private String ispaystatus;//支付状态
	private Date sendtime;    // 起运时间(登记日期)
	private String cardNo;//身份证（组织机构代码证）
	private String usecharacter;//使用性质
	private String vin;//识别代码(车架号)
	private String engineNo;//发动机号码
	private String passengersnum;//核定载客
	private String insuranceway;// 保险填写内容种类--用于选择填写页面0：有货物页面1：行驶证页面
	private String subtype; //保险附属类型
	private String measurestatus;//测算状态；0：未测试，1：已测算
	private String awardno;		// 获奖编号

	//新字段
	private Date startTime;    // 保险开始时间
	private Date endTime;    // 保险结束时间
	private String belongs;		//车辆所属
	private String mainHang;		//主挂信息
	private String idCardImg;		//营业执照或身份证
	private String vehicleLicenseImg;		//行驶证
	private String qualifiedImg;		//合格证
	private String invoiceImg;		//发票照片
	private String applicantUnit;		//投保单位
	private String insured;		//被保险人
	private String insuredCard;		//被保险人身份证（组织机构）
	private String insuredAddress;		//被保险人地址
	private String insuredLink;		//被保险人联系方式
	private String underwriting;		//核保人信息(姓名／电话／日期)
	private String voucher;		//制单人（姓名／电话／日期）
	private String agent;		//经办人(姓名／电话／日期)
	private String serialNumber;		//银行流水号
	private Date chargeTime;		//收费确认时间
	private Date insuredTime;		//投保时间
	private Date printTime;		//打印时间
	private String solution;		//解决方式
	private String ClaimsRecords;		//理赔记录备注

	private String syxinsurancefeel; //商业险总计
	private String jqxinsurancefeel; //交强险总计
	private String taxfeel; //车船税总计
	private Date jqxstartTime;    // 交强险开始时间
	private Date jqxendTime;    // 交强险结束时间


	private UserInsurancelist insurlist;//保险险种列表
	
	private Address shipAddress;  //发货地址地址管理
	private Address consignAddress;  //收货地址
	private Address applicantAddress;  //// 联系地址
	private long dueTime; ///到期
	private String searchtype;///时间查询类型
	private Date beginCreateDate; // 开始
	private Date endCreateDate; // 结束

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

	public String getSearchtype() {

		return searchtype;
	}

	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}

	public long getDueTime() {
		return dueTime;
	}

	public void setDueTime(long dueTime) {
		this.dueTime = dueTime;
	}

	private int statusInt;

	private List<UserInsuranceInfo> infoList  = new ArrayList<>();

	public UserInsurance() {
		super();
	}

	public UserInsurance(String id){
		super(id);
	}

	@Length(min=0, max=32, message="投保人姓名长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "投保人姓名", align = 2, sort = 0)
	public String getApplicant() {
		return applicant;
	}
	
	@ExcelField(type = 1, title = "联系人电话", align = 2, sort = 1)
	public String getAppPhone(){
		if(getApplicantAddress()==null){
			return "";
		}
		return getApplicantAddress().getLinkmobile();
	}
	@ExcelField(type = 1, title = "投保单位", align = 2, sort = 2)
	public String getApplicantUnit() {
		return applicantUnit;
	}

	public void setApplicantUnit(String applicantUnit) {
		this.applicantUnit = applicantUnit;
	}

	@ExcelField(type = 1, title = "联系人地址", align = 2, sort = 2)
	public String getApp(){
		if(getApplicantAddress()==null){
			return "";
		}
		return getApplicantAddress().getProvince()+getApplicantAddress().getCity()+getApplicantAddress().getDistrict();
	}
	@ExcelField(type = 1, title = "详细地址", align = 2, sort = 3)
	public String getAppDetail(){
		if(getApplicantAddress()==null){
			return "";
		}
		return getApplicantAddress().getAddress();
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	/*
	@Length(min=0, max=32, message="被保货物名称长度必须介于 0 和 32 之间")*/
	@ExcelField(type = 1, title = "被保货物名称", align = 2, sort = 4)
	public String getGoodsname() {
		return goodsname;
	}

	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}
	
	@Length(min=0, max=32, message="货物类型长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "货物类型", align = 2, sort = 5)
	public String getGoodstype() {
		return goodstype;
	}

	public void setGoodstype(String goodstype) {
		this.goodstype = goodstype;
	}
	
	@Length(min=0, max=32, message="货物价值长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "货物价值", align = 2, sort = 6)
	public String getWorth() {
		return worth;
	}

	public void setWorth(String worth) {
		this.worth = worth;
	}
	
	@Length(min=0, max=32, message="车牌号长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "车牌号", align = 2, sort = 7)
	public String getCarnumber() {
		return carnumber;
	}

	public void setCarnumber(String carnumber) {
		this.carnumber = carnumber;
	}
	
	@Length(min=0, max=32, message="车辆类型长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "车辆类型", align = 2, sort = 8)
	public String getCartype() {
		return cartype;
	}

	public void setCartype(String cartype) {
		this.cartype = cartype;
	}
	
	@Length(min=0, max=32, message="厂牌型号长度必须介于 0 和 32 之间")
	public String getCarmodel() {
		return carmodel;
	}

	public void setCarmodel(String carmodel) {
		this.carmodel = carmodel;
	}
	
	@Length(min=0, max=32, message="总重量长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "货物总重量", align = 2, sort = 9)
	public String getTotalweight() {
		return totalweight;
	}

	public void setTotalweight(String totalweight) {
		this.totalweight = totalweight;
	}
	
	@Length(min=0, max=32, message="车辆核对重量长度必须介于 0 和 32 之间")
	public String getCarweight() {
		return carweight;
	}

	public void setCarweight(String carweight) {
		this.carweight = carweight;
	}
	
	
	@Length(min=0, max=32, message="保险品种长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "保险品种", align = 2, sort = 10)
	public String getInsurancetype() {
		return insurancetype;
	}

	public void setInsurancetype(String insurancetype) {
		this.insurancetype = insurancetype;
	}
	
	@Length(min=0, max=32, message="理赔保险金额长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "最高理赔保险金额", align = 2, sort = 11)
	public String getInsuranceamount() {
		return insuranceamount;
	}

	public void setInsuranceamount(String insuranceamount) {
		this.insuranceamount = insuranceamount;
	}
	
	@Length(min=0, max=32, message="保险购买费用长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "保险购买费用", align = 2, sort = 12)
	public String getInsurancefeel() {
		return insurancefeel;
	}

	public void setInsurancefeel(String insurancefeel) {
		this.insurancefeel = insurancefeel;
	}


	@ExcelField(type = 1, title = "商业险总计", align = 2, sort = 13)
	public String getSyxinsurancefeel() {
		return syxinsurancefeel;
	}

	public void setSyxinsurancefeel(String syxinsurancefeel) {
		this.syxinsurancefeel = syxinsurancefeel;
	}

	@ExcelField(type = 1, title = "交强险总计", align = 2, sort = 14)
	public String getJqxinsurancefeel() {
		return jqxinsurancefeel;
	}

	public void setJqxinsurancefeel(String jqxinsurancefeel) {
		this.jqxinsurancefeel = jqxinsurancefeel;
	}

	@ExcelField(type = 1, title = "车船税总计", align = 2, sort = 15)
	public String getTaxfeel() {
		return taxfeel;
	}

	public void setTaxfeel(String taxfeel) {
		this.taxfeel = taxfeel;
	}


	@Length(min=0, max=32, message="保单状态长度必须介于 0 和 32 之间")
	@ExcelField(type = 1, title = "保单状态", align = 2, sort = 16,dictType = "insurance_status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=255, message="运单号长度必须介于 0 和 255 之间")
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	
	@Length(min=0, max=64, message="保单号长度必须介于 0 和 64 之间")
	@ExcelField(type = 1, title = "保单号", align = 2, sort = 17)
	public String getInsuranceNO() {
		return insuranceNO;
	}

	public void setInsuranceNO(String insuranceNO) {
		this.insuranceNO = insuranceNO;
	}

	@Length(min=0, max=500, message="保单凭证长度必须介于 0 和 500 之间")
	public String getVoucherimg() {
		return voucherimg;
	}

	public void setVoucherimg(String voucherimg) {
		this.voucherimg = voucherimg;
	}

	public Address getShipAddress() {
		return shipAddress;
	}
	
	@ExcelField(type = 1, title = "始发地", align = 2, sort = 18)
	public String getShip(){
		if(getShipAddress()==null){
			return "";
		}
		return getShipAddress().getProvince()+getShipAddress().getCity()+getShipAddress().getDistrict();
	}
	@ExcelField(type = 1, title = "详细地址", align = 2, sort = 19)
	public String getShipDetail(){
		if(getShipAddress()==null){
			return "";
		}
		return getShipAddress().getAddress();
	}

	public void setShipAddress(Address shipAddress) {
		this.shipAddress = shipAddress;
	}

	public Address getConsignAddress() {
		return consignAddress;
	}
	
	@ExcelField(type = 1, title = "目的地", align = 2, sort = 20)
	public String getCon(){
		if(getConsignAddress()==null){
			return "";
		}
		return getConsignAddress().getProvince()+getConsignAddress().getCity()+getConsignAddress().getDistrict();
	}
	@ExcelField(type = 1, title = "详细地址", align = 2, sort = 21)
	public String getConDetail(){
		if(getConsignAddress()==null){
			return "";
		}
		return getConsignAddress().getAddress();
	}

	public void setConsignAddress(Address consignAddress) {
		this.consignAddress = consignAddress;
	}

	public Address getApplicantAddress() {
		return applicantAddress;
	}

	public void setApplicantAddress(Address applicantAddress) {
		this.applicantAddress = applicantAddress;
	}

	public String getPayway() {
		return payway;
	}

	public void setPayway(String payway) {
		this.payway = payway;
	}

	public int getStatusInt() {
		return statusInt;
	}

	public void setStatusInt(int statusInt) {
		this.statusInt = statusInt;
	}

	public UserInsurancelist getInsurlist() {
		return insurlist;
	}

	public void setInsurlist(UserInsurancelist insurlist) {
		this.insurlist = insurlist;
	}

	public String getIspaystatus() {
		return ispaystatus;
	}

	public void setIspaystatus(String ispaystatus) {
		this.ispaystatus = ispaystatus;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(type = 1, title = "登记日期", align = 2, sort = 22)
	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	@ExcelField(type = 1, title = "身份证（组织机构代码证）", align = 2, sort = 23)
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	

	public String getUsecharacter() {
		return usecharacter;
	}

	public void setUsecharacter(String usecharacter) {
		this.usecharacter = usecharacter;
	}

	@ExcelField(type = 1, title = "识别代码(车架号)", align = 2, sort = 24)
	public String getVin() {
		return vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	@ExcelField(type = 1, title = "发动机号码", align = 2, sort = 25)
	public String getEngineNo() {
		return engineNo;
	}

	public void setEngineNo(String engineNo) {
		this.engineNo = engineNo;
	}

	@ExcelField(type = 1, title = "核定载客", align = 2, sort = 26)
	public String getPassengersnum() {
		return passengersnum;
	}

	public void setPassengersnum(String passengersnum) {
		this.passengersnum = passengersnum;
	}

	public String getInsuranceway() {
		return insuranceway;
	}

	public void setInsuranceway(String insuranceway) {
		this.insuranceway = insuranceway;
	}

	@ExcelField(type = 1, title = "保险附属类型", align = 2, sort = 27)
	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}

	public String getMeasurestatus() {
		return measurestatus;
	}

	public void setMeasurestatus(String measurestatus) {
		this.measurestatus = measurestatus;
	}

	public String getAwardno() {
		return awardno;
	}

	public void setAwardno(String awardno) {
		this.awardno = awardno;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(type = 1, title = "保险开始时间", align = 2, sort = 28)
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(type = 1, title = "保险结束时间", align = 2, sort = 29)
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	@ExcelField(type = 1, title = "车辆所属", align = 2, sort = 30)
	public String getBelongs() {
		return belongs;
	}

	public void setBelongs(String belongs) {
		this.belongs = belongs;
	}

	@ExcelField(type = 1, title = "主挂信息", align = 2, sort = 31)
	public String getMainHang() {
		return mainHang;
	}

	public void setMainHang(String mainHang) {
		this.mainHang = mainHang;
	}

	public String getIdCardImg() {
		return idCardImg;
	}

	public void setIdCardImg(String idCardImg) {
		this.idCardImg = idCardImg;
	}

	public String getVehicleLicenseImg() {
		return vehicleLicenseImg;
	}

	public void setVehicleLicenseImg(String vehicleLicenseImg) {
		this.vehicleLicenseImg = vehicleLicenseImg;
	}

	public String getQualifiedImg() {
		return qualifiedImg;
	}

	public void setQualifiedImg(String qualifiedImg) {
		this.qualifiedImg = qualifiedImg;
	}

	public String getInvoiceImg() {
		return invoiceImg;
	}

	public void setInvoiceImg(String invoiceImg) {
		this.invoiceImg = invoiceImg;
	}



	public String getInsured() {
		return insured;
	}

	public void setInsured(String insured) {
		this.insured = insured;
	}

	public String getInsuredCard() {
		return insuredCard;
	}

	public void setInsuredCard(String insuredCard) {
		this.insuredCard = insuredCard;
	}

	public String getInsuredAddress() {
		return insuredAddress;
	}

	public void setInsuredAddress(String insuredAddress) {
		this.insuredAddress = insuredAddress;
	}

	public String getInsuredLink() {
		return insuredLink;
	}

	public void setInsuredLink(String insuredLink) {
		this.insuredLink = insuredLink;
	}

	@ExcelField(type = 1, title = "核保人信息", align = 2, sort = 32)
	public String getUnderwriting() {
		return underwriting;
	}

	public void setUnderwriting(String underwriting) {
		this.underwriting = underwriting;
	}

	@ExcelField(type = 1, title = "制单人", align = 2, sort = 33)
	public String getVoucher() {
		return voucher;
	}

	public void setVoucher(String voucher) {
		this.voucher = voucher;
	}

	@ExcelField(type = 1, title = "经办人", align = 2, sort = 34)
	public String getAgent() {
		return agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
	}

	@ExcelField(type = 1, title = "银行流水号", align = 2, sort = 35)
	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(type = 1, title = "收费确认时间", align = 2, sort = 36)
	public Date getChargeTime() {
		return chargeTime;
	}

	public void setChargeTime(Date chargeTime) {
		this.chargeTime = chargeTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(type = 1, title = "投保时间", align = 2, sort = 37)
	public Date getInsuredTime() {
		return insuredTime;
	}

	public void setInsuredTime(Date insuredTime) {
		this.insuredTime = insuredTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPrintTime() {
		return printTime;
	}

	public void setPrintTime(Date printTime) {
		this.printTime = printTime;
	}

	@ExcelField(type = 1, title = "解决方式", align = 2, sort = 38)
	public String getSolution() {
		return solution;
	}

	public void setSolution(String solution) {
		this.solution = solution;
	}

	@ExcelField(type = 1, title = "理赔记录备注", align = 2, sort = 39)
	public String getClaimsRecords() {
		return ClaimsRecords;
	}

	public void setClaimsRecords(String claimsRecords) {
		ClaimsRecords = claimsRecords;
	}

	public List<UserInsuranceInfo> getInfoList() {
		return infoList;
	}

	public void setInfoList(List<UserInsuranceInfo> infoList) {
		this.infoList = infoList;
	}



	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(type = 1, title = "交强险开始时间", align = 2, sort = 40)
	public Date getJqxstartTime() {
		return jqxstartTime;
	}

	public void setJqxstartTime(Date jqxstartTime) {
		this.jqxstartTime = jqxstartTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(type = 1, title = "交强险结束时间", align = 2, sort = 41)
	public Date getJqxendTime() {
		return jqxendTime;
	}

	public void setJqxendTime(Date jqxendTime) {
		this.jqxendTime = jqxendTime;
	}
}