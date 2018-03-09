/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 账户资金统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsUsermoney extends DataEntity<StatisticsUsermoney> {
	
	private static final long serialVersionUID = 1L;
	private String umId;		// 账户余额统计主键
	private String webbalance;		// 账户资金
	private String credit;		// 授信资金
	private String webchu;		// 平台余额支出
	private String webru;		// 余额入账
	private String creditru;		// 授信入账
	private String creditchu;		// 授信出账
	private Date createtime;		// 统计时间
	private String petrolebalance;		// 油气金额
	private String returnmoney;		// 运费退款
	private String returnfreight;		// 油气返现
	private String creditfreightrebates;		// 授信运费返款
	private String creditgasrebate;		// 授信油气返款
	private String refunddisputes;		// 争议返款
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	public StatisticsUsermoney() {
		super();
	}

	public StatisticsUsermoney(String id){
		super(id);
	}

	@Length(min=1, max=32, message="账户余额统计主键长度必须介于 1 和 32 之间")
	public String getUmId() {
		return umId;
	}

	public void setUmId(String umId) {
		this.umId = umId;
	}
	
	@ExcelField(title="账户资金", align=2, sort=0)
	public String getWebbalance() {
		return webbalance;
	}

	public void setWebbalance(String webbalance) {
		this.webbalance = webbalance;
	}
	
	public String getCredit() {
		return credit;
	}

	public void setCredit(String credit) {
		this.credit = credit;
	}
	
	@ExcelField(title="平台余额支出", align=2, sort=1)
	public String getWebchu() {
		return webchu;
	}

	public void setWebchu(String webchu) {
		this.webchu = webchu;
	}
	
	@ExcelField(title="余额入账", align=2, sort=2)
	public String getWebru() {
		return webru;
	}

	public void setWebru(String webru) {
		this.webru = webru;
	}
	
	public String getCreditru() {
		return creditru;
	}

	public void setCreditru(String creditru) {
		this.creditru = creditru;
	}
	
	public String getCreditchu() {
		return creditchu;
	}

	public void setCreditchu(String creditchu) {
		this.creditchu = creditchu;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=6)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@ExcelField(title="油气金额", align=2, sort=3)
	public String getPetrolebalance() {
		return petrolebalance;
	}

	public void setPetrolebalance(String petrolebalance) {
		this.petrolebalance = petrolebalance;
	}
	
	@ExcelField(title="运费退款", align=2, sort=4)
	public String getReturnmoney() {
		return returnmoney;
	}

	public void setReturnmoney(String returnmoney) {
		this.returnmoney = returnmoney;
	}
	
	public String getReturnfreight() {
		return returnfreight;
	}

	public void setReturnfreight(String returnfreight) {
		this.returnfreight = returnfreight;
	}
	
	public String getCreditfreightrebates() {
		return creditfreightrebates;
	}

	public void setCreditfreightrebates(String creditfreightrebates) {
		this.creditfreightrebates = creditfreightrebates;
	}
	
	public String getCreditgasrebate() {
		return creditgasrebate;
	}

	public void setCreditgasrebate(String creditgasrebate) {
		this.creditgasrebate = creditgasrebate;
	}
	
	@ExcelField(title="争议返款", align=2, sort=5)
	public String getRefunddisputes() {
		return refunddisputes;
	}

	public void setRefunddisputes(String refunddisputes) {
		this.refunddisputes = refunddisputes;
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