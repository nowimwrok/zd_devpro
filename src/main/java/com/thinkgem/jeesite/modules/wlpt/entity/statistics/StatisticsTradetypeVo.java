/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 货源运输量统计Entity
 * @author 曾煜佳
 * @version 2016-10-26
 */
public class StatisticsTradetypeVo extends DataEntity<StatisticsTradetypeVo> {
	
	private static final long serialVersionUID = 1L;
	private Long ctrasportcount;		// 成品运输量
	private String ctransportweight;		// 成品运输吨位
	private String ctransportmoney;		// 成品运费
	private Long ytrasportcount;		// 原材料运输量
	private String ytransportweight;		// 原材料运输吨位
	private String ytransportmoney;		// 原材料运费
	private Date createtime;		// 统计时间
	private String newordermoney;		// 新运单
	private String cancelordermoney;		// 已取消运单
	private String takegdordermoney;		// 已提货运单
	private String waitinggdordermoney;		// 待提货
	private String waitingpay;		// 待支付
	private String pay;		// 已支付
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	public StatisticsTradetypeVo() {
		super();
	}

	public StatisticsTradetypeVo(String id){
		super(id);
	}

	@ExcelField(title="成品运输量", align=2, sort=0)
	public Long getCtrasportcount() {
		return ctrasportcount;
	}

	public void setCtrasportcount(Long ctrasportcount) {
		this.ctrasportcount = ctrasportcount;
	}
	
	@ExcelField(title="成品运输吨位", align=2, sort=1)
	public String getCtransportweight() {
		return ctransportweight;
	}

	public void setCtransportweight(String ctransportweight) {
		this.ctransportweight = ctransportweight;
	}
	
	@ExcelField(title="成品运费", align=2, sort=2)
	public String getCtransportmoney() {
		return ctransportmoney;
	}

	public void setCtransportmoney(String ctransportmoney) {
		this.ctransportmoney = ctransportmoney;
	}
	
	@ExcelField(title="原材料运输量", align=2, sort=3)
	public Long getYtrasportcount() {
		return ytrasportcount;
	}

	public void setYtrasportcount(Long ytrasportcount) {
		this.ytrasportcount = ytrasportcount;
	}
	
	@ExcelField(title="原材料运输吨位", align=2, sort=4)
	public String getYtransportweight() {
		return ytransportweight;
	}

	public void setYtransportweight(String ytransportweight) {
		this.ytransportweight = ytransportweight;
	}
	
	@ExcelField(title="原材料运费", align=2, sort=5)
	public String getYtransportmoney() {
		return ytransportmoney;
	}

	public void setYtransportmoney(String ytransportmoney) {
		this.ytransportmoney = ytransportmoney;
	}
	
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=12)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@ExcelField(title="新运单", align=2, sort=6)
	public String getNewordermoney() {
		return newordermoney;
	}

	public void setNewordermoney(String newordermoney) {
		this.newordermoney = newordermoney;
	}
	
	@ExcelField(title="已取消运单", align=2, sort=7)
	public String getCancelordermoney() {
		return cancelordermoney;
	}

	public void setCancelordermoney(String cancelordermoney) {
		this.cancelordermoney = cancelordermoney;
	}
	
	@ExcelField(title="已提货运单", align=2, sort=8)
	public String getTakegdordermoney() {
		return takegdordermoney;
	}

	public void setTakegdordermoney(String takegdordermoney) {
		this.takegdordermoney = takegdordermoney;
	}
	
	@ExcelField(title="待提货", align=2, sort=9)
	public String getWaitinggdordermoney() {
		return waitinggdordermoney;
	}

	public void setWaitinggdordermoney(String waitinggdordermoney) {
		this.waitinggdordermoney = waitinggdordermoney;
	}
	
	@ExcelField(title="待支付", align=2, sort=10)
	public String getWaitingpay() {
		return waitingpay;
	}

	public void setWaitingpay(String waitingpay) {
		this.waitingpay = waitingpay;
	}
	
	@ExcelField(title="已支付", align=2, sort=11)
	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
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