/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 一卡通消费记录明细Entity
 * 
 * @author fjc
 * @version 2016-09-29
 */
public class UserMetroCardRecordVO extends DataEntity<UserMetroCardRecordVO> {

	private static final long serialVersionUID = 1L;
	private String guid; // 单据唯一标识
	private String cardid; // 卡号
	private String isundo; // 是否撤销
	private String billnumber; // 单据号
	private String meno; // 备注
	private String truename; // 会员姓名
	private String totalpaid; // 实付金额
	private String paidvalue; // 储值支付
	private String paidpoint; // 积分支付
	private String point; // 获得积分
	private String storename; // 操作店面
	private String useraccount; // useraccount
	private Date operatetime; // 操作时间
	private User user; // 所属用户
	private String posuser;//绑定pos机用戶
	private String isnormal;//用于对账
	private String way;
	private String type;

	private Date beginOperateDate; // 开始 交易时间时间-
	private Date endOperateDate; // 结束 交易时间-
	private UserMetroCardRecorditemVO recorditem;//消费明细

	public UserMetroCardRecordVO() {
		super();
	}

	public UserMetroCardRecordVO(String id) {
		super(id);
	}

	public UserMetroCardRecorditemVO getRecorditem() {
		return recorditem;
	}

	public void setRecorditem(UserMetroCardRecorditemVO recorditem) {
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
	@ExcelField(title = "备注", align = 2, sort = 12)
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

	
	

	
	public String getTotalpaid() {
		return totalpaid;
	}

	public void setTotalpaid(String totalpaid) {
		this.totalpaid = totalpaid;
	}

	

	
	public String getPaidvalue() {
		return paidvalue;
	}

	public void setPaidvalue(String paidvalue) {
		this.paidvalue = paidvalue;
	}

	
	public String getPaidpoint() {
		return paidpoint;
	}

	public void setPaidpoint(String paidpoint) {
		this.paidpoint = paidpoint;
	}

	
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
	@ExcelField(title = "交易时间", align = 2, sort = 13)
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

	@Length(min=0, max=32, message="商品编码长度必须介于 0 和 32 之间")
	@ExcelField(title = "商品编码", align = 2, sort = 7,value = "recorditem.barcode")
	public String getBarcode() {
		return getRecorditem().getBarcode();
	}
	
	@Length(min=0, max=100, message="商品名称长度必须介于 0 和 100 之间")
	@ExcelField(title = "商品名称", align = 2, sort = 8,value = "recorditem.gooditemname")
	public String getGooditemname() {
		return getRecorditem().getGooditemname();
	}
	
	//@ExcelField(title = "明细总金额", align = 2, sort = 9,value = "recorditem.totalmoney")
	public String getTotalmoney() {
		return getRecorditem().getTotalmoney();
	}

	@Length(min=0, max=20, message="商品数量长度必须介于 0 和 20 之间")
	@ExcelField(title = "商品数量", align = 2, sort = 9,value = "recorditem.number")
	public String getNumber() {
		return getRecorditem().getNumber();
	}

	@ExcelField(title = "商品单价", align = 2, sort = 10,value = "recorditem.oldprice")
	public String getOldprice() {
		return getRecorditem().getOldprice();
	}

	
	@ExcelField(title = "实付金额", align = 2, sort = 11,value = "recorditem.paidmoney")
	public String getPaidmoney() {
		return getRecorditem().getPaidmoney();
	}

	
	//@ExcelField(title = "折扣", align = 2, sort = 12,value = "recorditem.discount")
	public String getDiscount() {
		return getRecorditem().getDiscount();
	}

	public String getPosuser() {
		return posuser;
	}

	public void setPosuser(String posuser) {
		this.posuser = posuser;
	}

	@ExcelField(title = "核对状态", align = 2, sort = 14)
	public String getIsnormal() {
		return isnormal;
	}

	public void setIsnormal(String isnormal) {
		this.isnormal = isnormal;
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