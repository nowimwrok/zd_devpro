/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 货源运输量统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsTradetype extends DataEntity<StatisticsTradetype> {
	
	private static final long serialVersionUID = 1L;
	private Long ctrasportcount;		// 成品运输量
	private String ctransportweight;		// 成品运输吨位
	private String ctransportmoney;		// 成品运费
	private Long ytrasportcount;		// 原材料运输量
	private String ytransportweight;		// 原材料运输吨位
	private String ytransportmoney;		// 原材料运费
	private Date createtime;		// 统计时间
	
	//扩展字段
	//运单
	private String newordermoney;///待提货
	private String cancelordermoney;///取消运单
	private String getgdordermoney;//已提货
	private String upordermoney;//待支付
	private String payordermoney;//已支付
	private String nieordermoney;//新建单
	private String orderstatus;
	private String gsType;
	private String evercout;
	private String cretime;
	private String timeflg;
	private String alltradmy;
	private String totaltradmy;
	private String allweight;
	private String sellercount;
	
	//货物
	private String invalidweight;//失效吨数
	private String quoteweight; //已经报价吨数
	private String singleweight;//已经建单
	
	private StatisticsTradetypeVo tradetypevo;//原实体
	private String type;
	
	private String endDate;		// 结束 create_date
	private String beginDate;		// 开始 create_date
	private String userid;//用户id
	private String username;//用户名称
	private String phone;//用户号码
	
	public StatisticsTradetype() {
		super();
	}

	public StatisticsTradetype(String id){
		super(id);
	}

	public StatisticsTradetypeVo getTradetypevo() {
		return tradetypevo;
	}

	public void setTradetypevo(StatisticsTradetypeVo tradetypevo) {
		this.tradetypevo = tradetypevo;
	}

	public Long getCtrasportcount() {
		return ctrasportcount;
	}

	public void setCtrasportcount(Long ctrasportcount) {
		this.ctrasportcount = ctrasportcount;
	}
	
	public String getCtransportweight() {
		return ctransportweight;
	}

	public void setCtransportweight(String ctransportweight) {
		this.ctransportweight = ctransportweight;
	}
	
	public String getCtransportmoney() {
		return ctransportmoney;
	}

	public void setCtransportmoney(String ctransportmoney) {
		this.ctransportmoney = ctransportmoney;
	}
	
	public Long getYtrasportcount() {
		return ytrasportcount;
	}

	public void setYtrasportcount(Long ytrasportcount) {
		this.ytrasportcount = ytrasportcount;
	}
	
	public String getYtransportweight() {
		return ytransportweight;
	}

	public void setYtransportweight(String ytransportweight) {
		this.ytransportweight = ytransportweight;
	}
	
	public String getYtransportmoney() {
		return ytransportmoney;
	}

	public void setYtransportmoney(String ytransportmoney) {
		this.ytransportmoney = ytransportmoney;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getNewordermoney() {
		return newordermoney;
	}

	public void setNewordermoney(String newordermoney) {
		this.newordermoney = newordermoney;
	}

	public String getCancelordermoney() {
		return cancelordermoney;
	}

	public void setCancelordermoney(String cancelordermoney) {
		this.cancelordermoney = cancelordermoney;
	}

	public String getGetgdordermoney() {
		return getgdordermoney;
	}

	public void setGetgdordermoney(String getgdordermoney) {
		this.getgdordermoney = getgdordermoney;
	}

	public String getUpordermoney() {
		return upordermoney;
	}

	public void setUpordermoney(String upordermoney) {
		this.upordermoney = upordermoney;
	}

	public String getPayordermoney() {
		return payordermoney;
	}

	public void setPayordermoney(String payordermoney) {
		this.payordermoney = payordermoney;
	}

	public String getNieordermoney() {
		return nieordermoney;
	}

	public void setNieordermoney(String nieordermoney) {
		this.nieordermoney = nieordermoney;
	}

	public String getGsType() {
		return gsType;
	}

	public void setGsType(String gsType) {
		this.gsType = gsType;
	}

	public String getEvercout() {
		return evercout;
	}

	public void setEvercout(String evercout) {
		this.evercout = evercout;
	}

	public String getCretime() {
		return cretime;
	}

	public void setCretime(String cretime) {
		this.cretime = cretime;
	}

	public String getAlltradmy() {
		return alltradmy;
	}

	public void setAlltradmy(String alltradmy) {
		this.alltradmy = alltradmy;
	}

	public String getTimeflg() {
		return timeflg;
	}

	public void setTimeflg(String timeflg) {
		this.timeflg = timeflg;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getInvalidweight() {
		return invalidweight;
	}

	public void setInvalidweight(String invalidweight) {
		this.invalidweight = invalidweight;
	}

	public String getQuoteweight() {
		return quoteweight;
	}

	public void setQuoteweight(String quoteweight) {
		this.quoteweight = quoteweight;
	}

	public String getSingleweight() {
		return singleweight;
	}

	public void setSingleweight(String singleweight) {
		this.singleweight = singleweight;
	}

	public String getAllweight() {
		return allweight;
	}

	public void setAllweight(String allweight) {
		this.allweight = allweight;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getSellercount() {
		return sellercount;
	}

	public void setSellercount(String sellercount) {
		this.sellercount = sellercount;
	}

	public String getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}

	public String getTotaltradmy() {
		return totaltradmy;
	}

	public void setTotaltradmy(String totaltradmy) {
		this.totaltradmy = totaltradmy;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
}