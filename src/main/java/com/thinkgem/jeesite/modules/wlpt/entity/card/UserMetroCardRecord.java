/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.card;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 一卡通消费记录明细Entity
 * 
 * @author fjc
 * @version 2016-09-29
 */
public class UserMetroCardRecord extends DataEntity<UserMetroCardRecord> {

	private static final long serialVersionUID = 1L;
	private String guid; // 单据唯一标识
	private String cardid; // 卡号
	private String isundo; // 是否撤销
	private String billnumber; // 单据号
	private String meno; // 备注
	private String truename; // 会员姓名
	private String totalmoney; // 付应金额
	private String totalpaid; // 实付金额
	private String paidmoney; // 现金支付
	private String paidvalue; // 储值支付
	private String paidpoint; // 积分支付
	private String point; // 获得积分
	private String storename; // 操作店面
	private String useraccount; // useraccount
	private Date operatetime; // 操作时间
	private User user; // 所属用户
	private String status; // 状态
	private String way;//
	private String type;//

	private Date beginOperateDate; // 开始 交易时间时间-
	private Date endOperateDate; // 结束 交易时间-
	private UserMetroCardRecorditem recorditem;//消费明细
	private String posuser;//绑定pos机用戶
	private String exchangeNo;		// 兑换号
	public UserMetroCardRecord() {
		super();
	}

	public UserMetroCardRecord(String id) {
		super(id);
	}

	public UserMetroCardRecorditem getRecorditem() {
		return recorditem;
	}

	public void setRecorditem(UserMetroCardRecorditem recorditem) {
		this.recorditem = recorditem;
	}

	@Length(min = 0, max = 64, message = "单据唯一标识长度必须介于 0 和 64 之间")
	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	@Length(min = 0, max = 32, message = "卡号长度必须介于 0 和 32 之间")
	@ExcelField(title = "卡号", align = 2, sort = 3)
	public String getCardid() {
		return cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	@Length(min = 0, max = 12, message = "是否撤销长度必须介于 0 和 12 之间")
	public String getIsundo() {
		return isundo;
	}

	public void setIsundo(String isundo) {
		this.isundo = isundo;
	}

	@Length(min = 0, max = 32, message = "单据号长度必须介于 0 和 32 之间")
	@ExcelField(title = "单据号", align = 2, sort = 1)
	public String getBillnumber() {
		return billnumber;
	}

	public void setBillnumber(String billnumber) {
		this.billnumber = billnumber;
	}

	@Length(min = 0, max = 256, message = "备注长度必须介于 0 和 256 之间")
	@ExcelField(title = "备注", align = 2, sort = 13)
	public String getMeno() {
		return meno;
	}

	public void setMeno(String meno) {
		this.meno = meno;
	}

	@Length(min = 0, max = 64, message = "会员姓名长度必须介于 0 和 64 之间")
	@ExcelField(title = "会员姓名", align = 2, sort = 6)
	public String getTruename() {
		return truename;
	}

	public void setTruename(String truename) {
		this.truename = truename;
	}

	@ExcelField(title = "应付金额", align = 2, sort = 7)
	public String getTotalmoney() {
		return totalmoney;
	}

	public void setTotalmoney(String totalmoney) {
		this.totalmoney = totalmoney;
	}

	@ExcelField(title = "实付金额", align = 2, sort = 8)
	public String getTotalpaid() {
		return totalpaid;
	}

	public void setTotalpaid(String totalpaid) {
		this.totalpaid = totalpaid;
	}

	@ExcelField(title = "现金支付", align = 2, sort = 9)
	public String getPaidmoney() {
		return paidmoney;
	}

	public void setPaidmoney(String paidmoney) {
		this.paidmoney = paidmoney;
	}

	@ExcelField(title = "储值支付", align = 2, sort = 10)
	public String getPaidvalue() {
		return paidvalue;
	}

	public void setPaidvalue(String paidvalue) {
		this.paidvalue = paidvalue;
	}

	@ExcelField(title = "积分支付", align = 2, sort = 11)
	public String getPaidpoint() {
		return paidpoint;
	}

	public void setPaidpoint(String paidpoint) {
		this.paidpoint = paidpoint;
	}

	@ExcelField(title = "获得积分", align = 2, sort = 12)
	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	@Length(min = 0, max = 128, message = "操作店面长度必须介于 0 和 128 之间")
	@ExcelField(title = "操作店面", align = 2, sort = 5)
	public String getStorename() {
		return storename;
	}

	public void setStorename(String storename) {
		this.storename = storename;
	}

	@Length(min = 0, max = 32, message = "useraccount长度必须介于 0 和 32 之间")
	@ExcelField(title = "工号", align = 2, sort = 4)
	public String getUseraccount() {
		return useraccount;
	}

	public void setUseraccount(String useraccount) {
		this.useraccount = useraccount;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title = "交易时间", align = 2, sort = 14)
	public Date getOperatetime() {
		return operatetime;
	}

	public void setOperatetime(Date operatetime) {
		this.operatetime = operatetime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ExcelField(title = "用户", align = 2, sort = 2)
	public String getuserName() {
		if(user==null){
			return "";
		}
		return user.getLoginName();
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

	public String getPosuser() {
		return posuser;
	}

	public void setPosuser(String posuser) {
		this.posuser = posuser;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getExchangeNo() {
		return exchangeNo;
	}

	public void setExchangeNo(String exchangeNo) {
		this.exchangeNo = exchangeNo;
	}

	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}