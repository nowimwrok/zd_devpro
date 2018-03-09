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
 * 运输流向统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsTradeflow extends DataEntity<StatisticsTradeflow> {
	
	private static final long serialVersionUID = 1L;
	private String startaddress;		// 开始地址
	private String endaddress;		// 目的地
	private Long everycount;		// 数量
	private String money;		// 金额统计
	private Date createtime;		// 统计时间
	private String tradeweight;		// 运输吨位
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	public StatisticsTradeflow() {
		super();
	}

	public StatisticsTradeflow(String id){
		super(id);
	}

	@Length(min=0, max=64, message="开始地址长度必须介于 0 和 64 之间")
	@ExcelField(title="始发地", align=2, sort=0)
	public String getStartaddress() {
		return startaddress;
	}

	public void setStartaddress(String startaddress) {
		this.startaddress = startaddress;
	}
	
	@Length(min=0, max=64, message="目的地长度必须介于 0 和 64 之间")
	@ExcelField(title="目的地", align=2, sort=1)
	public String getEndaddress() {
		return endaddress;
	}

	public void setEndaddress(String endaddress) {
		this.endaddress = endaddress;
	}
	
	@ExcelField(title="数量", align=2, sort=2)
	public Long getEverycount() {
		return everycount;
	}

	public void setEverycount(Long everycount) {
		this.everycount = everycount;
	}
	
	@ExcelField(title="金额", align=2, sort=3)
	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=5)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@ExcelField(title="运输吨位", align=2, sort=4)
	public String getTradeweight() {
		return tradeweight;
	}

	public void setTradeweight(String tradeweight) {
		this.tradeweight = tradeweight;
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