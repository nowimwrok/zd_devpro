/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.consume;

import java.util.Date;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 后台充值账户审核日志记录Entity
 * @author 饶江龙
 * @version 2016-08-02
 */
public class Deallog extends DataEntity<Deallog> {
	
	private static final long serialVersionUID = 1L;
	private String dealtype;		// 0:后台充值，1&hellip;&hellip;
	private Consumeaudit consumeaudit;		// 交易记录id外键
	private String delstatus;		// delstatus
	private Date beginCreateDate;		// 开始 处理时间
	private Date endCreateDate;		// 结束 处理时间
	
	public Deallog() {
		super();
	}

	public Deallog(String id){
		super(id);
	}

	@Length(min=0, max=2, message="0:后台充值，1&hellip;&hellip;长度必须介于 0 和 2 之间")
	public String getDealtype() {
		return dealtype;
	}

	public void setDealtype(String dealtype) {
		this.dealtype = dealtype;
	}
	
	@Length(min=0, max=33, message="交易记录id外键长度必须介于 0 和 33 之间")
	public Consumeaudit getConsumeaudit() {
		return consumeaudit;
	}

	public void setConsumeaudit(Consumeaudit consumeaudit) {
		this.consumeaudit = consumeaudit;
	}
	
	@Length(min=0, max=11, message="delstatus长度必须介于 0 和 11 之间")
	public String getDelstatus() {
		return delstatus;
	}

	public void setDelstatus(String delstatus) {
		this.delstatus = delstatus;
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