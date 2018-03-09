/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.exchange;

import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;

/**
 * 油气兑换余额审核Entity
 * @author zyj
 * @version 2017-02-15
 */
public class UserPetrolExchange extends DataEntity<UserPetrolExchange> {
	
	private static final long serialVersionUID = 1L;
	private String exchangeNo;		// 兑换号
	private String exchangeCount;		// 兑换明细条数
	private String totalcost;		// 总金额
	private User user;		// 申请人user
	private String status;		// 状态
	private User dealUser;		// 审核人
	private Date dealTime;		// 审核时间
	private Date beginOperateDate; // 开始 pos机绑定时间-
	private Date endOperateDate; // 结束 pos机绑定时间-
	private String invoiceStatus; //发票状态
	private String invoiceStatusName; //发票状态名称
	private String statusName;		// 状态名称
	private List<UserPetrolExchangeRecord> record =new ArrayList<>();
	private List<UserMetroCardRecord> cardRecordList =new ArrayList<>();
	private List<UserMetroCardRecord> addvaluecardRecordList =new ArrayList<>();//充值记录
	
	public UserPetrolExchange() {
		super();
	}

	public UserPetrolExchange(String id){
		super(id);
	}

	@Length(min=1, max=32, message="兑换号长度必须介于 1 和 32 之间")
	public String getExchangeNo() {
		return exchangeNo;
	}

	public void setExchangeNo(String exchangeNo) {
		this.exchangeNo = exchangeNo;
	}
	
	@Length(min=0, max=20, message="兑换明细条数长度必须介于 0 和 20 之间")
	public String getExchangeCount() {
		return exchangeCount;
	}

	public void setExchangeCount(String exchangeCount) {
		this.exchangeCount = exchangeCount;
	}
	
	public String getTotalcost() {
		return totalcost;
	}

	public void setTotalcost(String totalcost) {
		this.totalcost = totalcost;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getDealUser() {
		return dealUser;
	}

	public void setDealUser(User dealUser) {
		this.dealUser = dealUser;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDealTime() {
		return dealTime;
	}

	public void setDealTime(Date dealTime) {
		this.dealTime = dealTime;
	}

	public List<UserPetrolExchangeRecord> getRecord() {
		return record;
	}

	public void setRecord(List<UserPetrolExchangeRecord> record) {
		this.record = record;
	}

	public Date getBeginOperateDate() {
		return beginOperateDate;
	}

	public void setBeginOperateDate(Date beginOperateDate) {
		this.beginOperateDate = beginOperateDate;
	}

	public Date getEndOperateDate() {
		return endOperateDate;
	}

	public void setEndOperateDate(Date endOperateDate) {
		this.endOperateDate = endOperateDate;
	}

	public List<UserMetroCardRecord> getCardRecordList() {
		return cardRecordList;
	}

	public void setCardRecordList(List<UserMetroCardRecord> cardRecordList) {
		this.cardRecordList = cardRecordList;
	}

	public String getInvoiceStatus() {
		return invoiceStatus;
	}

	public void setInvoiceStatus(String invoiceStatus) {
		this.invoiceStatus = invoiceStatus;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getInvoiceStatusName() {
		return invoiceStatusName;
	}

	public void setInvoiceStatusName(String invoiceStatusName) {
		this.invoiceStatusName = invoiceStatusName;
	}

	public List<UserMetroCardRecord> getAddvaluecardRecordList() {
		return addvaluecardRecordList;
	}

	public void setAddvaluecardRecordList(List<UserMetroCardRecord> addvaluecardRecordList) {
		this.addvaluecardRecordList = addvaluecardRecordList;
	}
	
}