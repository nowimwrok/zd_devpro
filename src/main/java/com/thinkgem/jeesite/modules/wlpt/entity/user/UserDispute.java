/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;

/**
 * 争议处理Entity
 * 
 * @author fjc
 * @version 2016-08-05
 */
public class UserDispute extends DataEntity<UserDispute> {

	private static final long serialVersionUID = 1L;
	private String disputecontent; // 争议内容
	private String orderno; // 争议订单号
	private String disputemoney; // 争议结果费用
	private String dealname; // 处理人姓名
	private String dealphone; // 处理人电话
	private String status; // 处理状态：0发起争议，1处理中，2处理完成3.退款处理
	private String goodsname; // 货物名称
	private String takeloadweight; // 提货吨数
	private String unloadweight; // 货卸吨数
	private String disputeinfo; // 争议说明
	private String disputeeverconfirmed; // 0司机未确认 1司机已确认
	private String disputemoneybefore; // 争议前运单金额
	private String disputemoneydiff; // 议争单运金额差额
	private User dealuser;// 处理用户
	private Orderinfo orderinfo; // 运单信息
	private Date begincreateDate;// 开始发起时间
	private Date endcreateDate;// 开始发起时间
	private String isreject;//争议状态 0正常 1驳回
	private String disputetype;//争议类型：0普通争议，1全额争议

	public UserDispute() {
		super();
	}

	public UserDispute(String id) {
		super(id);
	}

	@Length(min = 0, max = 255, message = "争议内容长度必须介于 0 和 255 之间")
	public String getDisputecontent() {
		return disputecontent;
	}

	public void setDisputecontent(String disputecontent) {
		this.disputecontent = disputecontent;
	}

	@Length(min = 0, max = 32, message = "争议订单号长度必须介于 0 和 32 之间")
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getDisputemoney() {
		return disputemoney;
	}

	public void setDisputemoney(String disputemoney) {
		this.disputemoney = disputemoney;
	}

	@Length(min = 0, max = 32, message = "处理人姓名长度必须介于 0 和 32 之间")
	public String getDealname() {
		return dealname;
	}

	public void setDealname(String dealname) {
		this.dealname = dealname;
	}

	@Length(min = 0, max = 32, message = "处理人电话长度必须介于 0 和 32 之间")
	public String getDealphone() {
		return dealphone;
	}

	public void setDealphone(String dealphone) {
		this.dealphone = dealphone;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min = 0, max = 32, message = "货物名称长度必须介于 0 和 32 之间")
	public String getGoodsname() {
		return goodsname;
	}

	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}

	public String getTakeloadweight() {
		return takeloadweight;
	}

	public void setTakeloadweight(String takeloadweight) {
		this.takeloadweight = takeloadweight;
	}

	public String getUnloadweight() {
		return unloadweight;
	}

	public void setUnloadweight(String unloadweight) {
		this.unloadweight = unloadweight;
	}

	@Length(min = 0, max = 512, message = "争议说明长度必须介于 0 和 512 之间")
	public String getDisputeinfo() {
		return disputeinfo;
	}

	public void setDisputeinfo(String disputeinfo) {
		this.disputeinfo = disputeinfo;
	}

	@Length(min = 0, max = 32, message = "处理用户长度必须介于 0 和 32 之间")
	public User getDealuser() {
		return dealuser;
	}

	public void setDealuser(User dealuser) {
		this.dealuser = dealuser;
	}

	@Length(min = 0, max = 2, message = "0司机未确认 1司机已确认长度必须介于 0 和 2 之间")
	public String getDisputeeverconfirmed() {
		return disputeeverconfirmed;
	}

	public void setDisputeeverconfirmed(String disputeeverconfirmed) {
		this.disputeeverconfirmed = disputeeverconfirmed;
	}

	public String getDisputemoneybefore() {
		return disputemoneybefore;
	}

	public void setDisputemoneybefore(String disputemoneybefore) {
		this.disputemoneybefore = disputemoneybefore;
	}

	public String getDisputemoneydiff() {
		return disputemoneydiff;
	}

	public void setDisputemoneydiff(String disputemoneydiff) {
		this.disputemoneydiff = disputemoneydiff;
	}

	public Orderinfo getOrderinfo() {
		return orderinfo;
	}

	public void setOrderinfo(Orderinfo orderinfo) {
		this.orderinfo = orderinfo;
	}

	public Date getBegincreateDate() {
		return begincreateDate;
	}

	public void setBegincreateDate(Date begincreateDate) {
		this.begincreateDate = begincreateDate;
	}

	public Date getEndcreateDate() {
		return endcreateDate;
	}

	public void setEndcreateDate(Date endcreateDate) {
		this.endcreateDate = endcreateDate;
	}

	public String getIsreject() {
		return isreject;
	}

	public void setIsreject(String isreject) {
		this.isreject = isreject;
	}

	public String getDisputetype() {
		return disputetype;
	}

	public void setDisputetype(String disputetype) {
		this.disputetype = disputetype;
	}

}