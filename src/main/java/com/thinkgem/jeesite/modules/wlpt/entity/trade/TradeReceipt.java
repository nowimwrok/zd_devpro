/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.trade;

import org.hibernate.validator.constraints.Length;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 运单证明Entity
 * @author 饶江龙
 * @version 2016-07-28
 */
public class TradeReceipt extends DataEntity<TradeReceipt> {
	
	private static final long serialVersionUID = 1L;
	private Orderinfo orderinfo;		// 订单Id
	private String receiptimg;		// 回单图片名称
	private String type;		// 0:提货单据；1:回单单据
	private String oddloadweight;		// 载重 吨位
	private String updatecount;		// 上传次数:最多上传5次
	private Date beginCreateDate;		// 开始 上传时间
	private Date endCreateDate;		// 结束 上传时间
	private String beginOddloadweight;		// 开始 载重 吨位
	private String endOddloadweight;		// 结束 载重 吨位
	
	public TradeReceipt() {
		super();
	}

	public TradeReceipt(String id){
		super(id);
	}

	public Orderinfo getOrderinfo() {
		return orderinfo;
	}

	public void setOrderinfo(Orderinfo orderinfo) {
		this.orderinfo = orderinfo;
	}
	
	@Length(min=0, max=70, message="回单图片名称长度必须介于 0 和 70 之间")
	public String getReceiptimg() {
		return receiptimg;
	}

	public void setReceiptimg(String receiptimg) {
		this.receiptimg = receiptimg;
	}
	
	@Length(min=0, max=2, message="0:提货单据；1:回单单据长度必须介于 0 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=16, message="载重 吨位长度必须介于 0 和 16 之间")
	public String getOddloadweight() {
		return oddloadweight;
	}

	public void setOddloadweight(String oddloadweight) {
		this.oddloadweight = oddloadweight;
	}
	
	@Length(min=0, max=2, message="上传次数:最多上传5次长度必须介于 0 和 2 之间")
	public String getUpdatecount() {
		return updatecount;
	}

	public void setUpdatecount(String updatecount) {
		this.updatecount = updatecount;
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
		
	public String getBeginOddloadweight() {
		return beginOddloadweight;
	}

	public void setBeginOddloadweight(String beginOddloadweight) {
		this.beginOddloadweight = beginOddloadweight;
	}
	
	public String getEndOddloadweight() {
		return endOddloadweight;
	}

	public void setEndOddloadweight(String endOddloadweight) {
		this.endOddloadweight = endOddloadweight;
	}
		
}