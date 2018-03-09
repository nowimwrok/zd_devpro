/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.trade;

import org.hibernate.validator.constraints.Length;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 运单操作日志记录Entity
 * @author 饶江龙
 * @version 2016-07-28
 */
public class TradeTrace extends DataEntity<TradeTrace> {
	
	private static final long serialVersionUID = 1L;
	private Orderinfo orderinfo;		// 订单Id
	private String title;		// 标题:
	private String type;		// 类型：0:运单状态，2:支付状态，3运单运输
	private String status;		// 变化的状态值
	private String content;		// 操作日志内容
	private Date beginCreateDate;		// 开始 create_date
	private Date endCreateDate;		// 结束 create_date
	
	public TradeTrace() {
		super();
	}

	public TradeTrace(String id){
		super(id);
	}

	public Orderinfo getOrderinfo() {
		return orderinfo;
	}

	public void setOrderinfo(Orderinfo orderinfo) {
		this.orderinfo = orderinfo;
	}
	
	@Length(min=1, max=64, message="标题:长度必须介于 1 和 64 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=11, message="类型：0:运单状态，2:支付状态，3运单运输长度必须介于 0 和 11 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=11, message="变化的状态值长度必须介于 0 和 11 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=255, message="操作日志内容长度必须介于 0 和 255 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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