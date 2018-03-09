/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.bid;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;

/**
 * 提货单Entity
 * @author 刘欣
 * @version 2016-08-02
 */
@JsonIgnoreProperties(value = { "currentUser"})
public class BidBlinfo extends DataEntity<BidBlinfo> {
	
	private static final long serialVersionUID = 1L;
	private User biddinguser;		// 竞标方用户
	private User biduser;		// 发布招标方用户
	private Goods goods;		// 提货单的货源
	private Goods bidgoods;		// 招标的货源
	private String contractno;		// 合同号
	private BidOrderinfo bidOrder;		// 合同
	private String namematerials;		// 品名材质
	private String standard;		// 规格
	private String  quantity;		// 重量/数量
	private String batch;		// 批次
	private String blstatus;		// 提货单状态
	private String blcode;		// 订单
	private String tradestatus;		// 交易状态
	private String address;		// 卸货地址
	private String width;		// 宽度
	private String bltype;		// 提货单类型
	private String userid;		// 竞标或中标id

	private String biddingstatus;		// 竞标方仓库状态:1:已入库（已竞标的提货单）、2:待出库（已发货的提货单）、3:已出库（已提货的货单）
	private String bidstatus;		// 招标方仓库状态:1:已入库、2:待出库（已发标的提货单）、3:已出库（已竞标的提货单）
	private String warehousename;		// 仓库名称

	private Date biddingInboundDate;		// 竞标方入库时间
	private Date biddingOutboundDate;		// 竞标方出库时间
	private Date bidInboundDate;		// 招标方入库时间
	private Date bidOutboundDate;		// 招标方出库时间

	private String ymdbiddingInboundDate;		// 招标方入库时间

	//扩展字段
	private String ymdDate;
	
	public BidBlinfo() {
		super();
	}

	public BidBlinfo(String id){
		super(id);
	}

	public User getBiddinguser() {
		return biddinguser;
	}

	public void setBiddinguser(User biddinguser) {
		this.biddinguser = biddinguser;
	}
	
	public User getBiduser() {
		return biduser;
	}

	public void setBiduser(User biduser) {
		this.biduser = biduser;
	}
	
	

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}



	public Goods getBidgoods() {
		return bidgoods;
	}

	public void setBidgoods(Goods bidgoods) {
		this.bidgoods = bidgoods;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public BidOrderinfo getBidOrder() {
		return bidOrder;
	}

	public void setBidOrder(BidOrderinfo bidOrder) {
		this.bidOrder = bidOrder;
	}

	@ExcelField(sort = 0, title = "仓库名称", align = '2')
	public String getWarehousename() {
		return warehousename;
	}

	public void setWarehousename(String warehousename) {
		this.warehousename = warehousename;
	}

	@Length(min=0, max=32, message="合同号长度必须介于 0 和 32 之间")
	@ExcelField(sort = 1, title = "合同号", align = '2')
	public String getContractno() {
		return contractno;
	}

	public void setContractno(String contractno) {
		this.contractno = contractno;
	}

	@Length(min=0, max=16, message="批次长度必须介于 0 和 16 之间")
	@ExcelField(sort = 2, title = "批号", align = '2')
	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	@Length(min=0, max=32, message="品名材质长度必须介于 0 和 32 之间")
	@ExcelField(sort = 3, title = "材质", align = '2')
	public String getNamematerials() {
		return namematerials;
	}

	public void setNamematerials(String namematerials) {
		this.namematerials = namematerials;
	}
	
	@Length(min=0, max=16, message="规格长度必须介于 0 和 16 之间")
	@ExcelField(sort = 4, title = "规格", align = '2')
	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	@ExcelField(sort = 5, title = "宽度", align = '2')
	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	@ExcelField(sort = 6, title = "重量", align = '2')
	@NotNull(message = "不许为空")
	@DecimalMin(value = "0.00")
	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	@Length(min=0, max=255, message="卸货地址长度必须介于 0 和 255 之间")
	@ExcelField(sort = 7, title = "卸货地址", align = '2')
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@ExcelField(sort = 8, title = "备注", align = '2')
	public String getRemarks(){
		return remarks;
	}
	
	@Length(min=0, max=2, message="提货单状态长度必须介于 0 和 2 之间")
	public String getBlstatus() {
		return blstatus;
	}

	public void setBlstatus(String blstatus) {
		this.blstatus = blstatus;
	}
	
	@Length(min=0, max=32, message="订单长度必须介于 0 和 32 之间")
	public String getBlcode() {
		return blcode;
	}

	public void setBlcode(String blcode) {
		this.blcode = blcode;
	}
	
	@Length(min=0, max=2, message="交易状态长度必须介于 0 和 2 之间")
	public String getTradestatus() {
		return tradestatus;
	}

	public void setTradestatus(String tradestatus) {
		this.tradestatus = tradestatus;
	}
	




    public String getBltype() {
        return bltype;
    }

    public void setBltype(String bltype) {
        this.bltype = bltype;
    }



	public String getBiddingstatus() {
		return biddingstatus;
	}

	public void setBiddingstatus(String biddingstatus) {
		this.biddingstatus = biddingstatus;
	}

	public String getBidstatus() {
		return bidstatus;
	}

	public void setBidstatus(String bidstatus) {
		this.bidstatus = bidstatus;
	}



	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBiddingInboundDate() {
		return biddingInboundDate;
	}

	public void setBiddingInboundDate(Date biddingInboundDate) {
		this.biddingInboundDate = biddingInboundDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBiddingOutboundDate() {
		return biddingOutboundDate;
	}

	public void setBiddingOutboundDate(Date biddingOutboundDate) {
		this.biddingOutboundDate = biddingOutboundDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBidInboundDate() {
		return bidInboundDate;
	}

	public void setBidInboundDate(Date bidInboundDate) {
		this.bidInboundDate = bidInboundDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBidOutboundDate() {
		return bidOutboundDate;
	}

	public void setBidOutboundDate(Date bidOutboundDate) {
		this.bidOutboundDate = bidOutboundDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public String getYmdDate() {
		return ymdDate;
	}

	public void setYmdDate(String ymdDate) {
		this.ymdDate = ymdDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public String getYmdbiddingInboundDate() {
		return ymdbiddingInboundDate;
	}

	public void setYmdbiddingInboundDate(String ymdbiddingInboundDate) {
		this.ymdbiddingInboundDate = ymdbiddingInboundDate;
	}
}