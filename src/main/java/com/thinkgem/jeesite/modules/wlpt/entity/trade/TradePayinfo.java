/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.trade;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.springframework.core.annotation.Order;

/**
 * 运单支付信息Entity
 * @author 饶江龙
 * @version 2016-07-28
 */
public class TradePayinfo extends DataEntity<TradePayinfo> {
	
	private static final long serialVersionUID = 1L;
	private Orderinfo orderinfo;		// 运单ID
	private String paystatus;		// 支付状态
	private String totalcost;		// 总运费
	private String onlineamount;		// 线上支付金额
	private String lineamount;		// 线下支付金额
	private String onlineratio;		// 线上支付比例
	private String preraio;		// 预支付比例
	private String preamount;		// 线上预支付金额
	private String onlinebalance;		// 线上支付余款
	private String disputeamount;		// 争议金额
	private String actualamount;		// 实际支付金额
	private String coinamount; ///线上支付卓币金额
	private String coinprepaio; ///卓币预付比例
	private String coinpreamount; ///线上预付卓币金额
	private String coinactualpay; ///线上实际卓币金额



	public TradePayinfo() {
		super();
	}

	public TradePayinfo(String id){
		super(id);
	}

	public Orderinfo getOrderinfo() {
		return orderinfo;
	}

	public void setOrderinfo(Orderinfo orderinfo) {
		this.orderinfo = orderinfo;
	}
	
	@Length(min=0, max=11, message="支付状态长度必须介于 0 和 11 之间")
	public String getPaystatus() {
		return paystatus;
	}

	public void setPaystatus(String paystatus) {
		this.paystatus = paystatus;
	}
	
	public String getTotalcost() {
		return totalcost;
	}

	public void setTotalcost(String totalcost) {
		this.totalcost = totalcost;
	}
	
	public String getOnlineamount() {
		return onlineamount;
	}

	public void setOnlineamount(String onlineamount) {
		this.onlineamount = onlineamount;
	}
	
	public String getLineamount() {
		return lineamount;
	}

	public void setLineamount(String lineamount) {
		this.lineamount = lineamount;
	}
	
	public String getOnlineratio() {
		return onlineratio;
	}

	public void setOnlineratio(String onlineratio) {
		this.onlineratio = onlineratio;
	}
	
	public String getPreraio() {
		return preraio;
	}

	public void setPreraio(String preraio) {
		this.preraio = preraio;
	}
	
	public String getPreamount() {
		return preamount;
	}

	public void setPreamount(String preamount) {
		this.preamount = preamount;
	}
	
	public String getOnlinebalance() {
		return onlinebalance;
	}

	public void setOnlinebalance(String onlinebalance) {
		this.onlinebalance = onlinebalance;
	}
	
	public String getDisputeamount() {
		return disputeamount;
	}

	public void setDisputeamount(String disputeamount) {
		this.disputeamount = disputeamount;
	}
	
	public String getActualamount() {
		return actualamount;
	}

	public void setActualamount(String actualamount) {
		this.actualamount = actualamount;
	}

	public String getCoinamount() {
		return coinamount;
	}

	public void setCoinamount(String coinamount) {
		this.coinamount = coinamount;
	}

	public String getCoinprepaio() {
		return coinprepaio;
	}

	public void setCoinprepaio(String coinprepaio) {
		this.coinprepaio = coinprepaio;
	}

	public String getCoinpreamount() {
		return coinpreamount;
	}

	public void setCoinpreamount(String coinpreamount) {
		this.coinpreamount = coinpreamount;
	}

	public String getCoinactualpay() {
		return coinactualpay;
	}

	public void setCoinactualpay(String coinactualpay) {
		this.coinactualpay = coinactualpay;
	}
}