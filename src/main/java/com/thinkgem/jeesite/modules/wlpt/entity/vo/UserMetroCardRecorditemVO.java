/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 一卡通消费记录明细Entity
 * @author zyj
 * @version 2016-11-24
 */
public class UserMetroCardRecorditemVO extends DataEntity<UserMetroCardRecorditemVO> {
	
	private static final long serialVersionUID = 1L;
	private String guid;		// 消费明细唯一标识
	private UserMetroCardRecordVO record ;		// 消费记录
	private String goodsitemguid;		// 消费商品唯一标识
	private String barcode;		// 商品编码
	private String gooditemname;		// 商品名称
	private String totalmoney;		// 明细总金额
	private String number;		// 商品数量
	private String oldprice;		// 商品单价
	private String paidmoney;		// 实付金额
	private String discount;		// 折扣
	private String point;		// 获得积分
	private String meno;		// 备注
	private User user;		// 所属用户
	
	public UserMetroCardRecorditemVO() {
		super();
	}

	public UserMetroCardRecorditemVO(String id){
		super(id);
	}

	@Length(min=0, max=64, message="消费明细唯一标识长度必须介于 0 和 64 之间")
	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}
	
	
	
	public UserMetroCardRecordVO getRecord() {
		return record;
	}

	public void setRecord(UserMetroCardRecordVO record) {
		this.record = record;
	}

	@Length(min=0, max=64, message="消费商品唯一标识长度必须介于 0 和 64 之间")
	public String getGoodsitemguid() {
		return goodsitemguid;
	}

	public void setGoodsitemguid(String goodsitemguid) {
		this.goodsitemguid = goodsitemguid;
	}
	
	@Length(min=0, max=32, message="商品编码长度必须介于 0 和 32 之间")
	@ExcelField(title = "商品编码", align = 2, sort = 7)
	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	
	@Length(min=0, max=100, message="商品名称长度必须介于 0 和 100 之间")
	@ExcelField(title = "商品名称", align = 2, sort = 8)
	public String getGooditemname() {
		return gooditemname;
	}

	public void setGooditemname(String gooditemname) {
		this.gooditemname = gooditemname;
	}
	
	//@ExcelField(title = "明细总金额", align = 2, sort = 9)
	public String getTotalmoney() {
		return totalmoney;
	}

	public void setTotalmoney(String totalmoney) {
		this.totalmoney = totalmoney;
	}
	
	@Length(min=0, max=20, message="商品数量长度必须介于 0 和 20 之间")
	@ExcelField(title = "商品数量", align = 2, sort = 9)
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
	@ExcelField(title = "商品单价", align = 2, sort = 10)
	public String getOldprice() {
		return oldprice;
	}

	public void setOldprice(String oldprice) {
		this.oldprice = oldprice;
	}
	
	@ExcelField(title = "实付金额", align = 2, sort = 11)
	public String getPaidmoney() {
		return paidmoney;
	}

	public void setPaidmoney(String paidmoney) {
		this.paidmoney = paidmoney;
	}
	
	//@ExcelField(title = "折扣", align = 2, sort = 12)
	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}
	
	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}
	
	@Length(min=0, max=255, message="备注长度必须介于 0 和 255 之间")
	public String getMeno() {
		return meno;
	}

	public void setMeno(String meno) {
		this.meno = meno;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	
}