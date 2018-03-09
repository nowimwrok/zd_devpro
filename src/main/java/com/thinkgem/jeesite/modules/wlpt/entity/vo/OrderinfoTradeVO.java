/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;

import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoVo;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.Date;

import javax.validation.constraints.NotNull;

/**
 * 运单信息Entity
 * 
 * @author fjc
 * @version 2016-09-22
 */
public class OrderinfoTradeVO extends DataEntity<OrderinfoTradeVO> {

	private static final long serialVersionUID = 1L;
	private Quoteinfo quoteinfo; // 报价ID,外键
	private User buyer; // 车队
	private User seller; // 货主
	private User driver; // 货主
	private String orderno; // 运单号
	private String orderstatus; // 运单状态
	private String iscomment; // 是否评价
	private String totalcost; // 总运费
	private String isonlinepay; // 是否线上支付:0线下,1线上支付
	private String isprepay; // 是否预支付:0不预支付,1预支付
	private String paystatus; // －1:免运费0:未支付1：暂扣费2:已支付到司机3:已返款
	private String payway; // 支付方式:0余额支付，1.结算卡,2授信支付，2免运费
	private String isprint; // 是否打印回执单
	private String isdispute; // 是否发起争议：0，1
	private String islocated; // 是否开启定位
	private TradePayinfo payinfo; // 支付流水ID&mdash;&mdash;外键
	private String beginTotalcost; // 开始 总运费
	private String endTotalcost; // 结束 总运费
	private String statusStr; /// 状态字符
	private Boolean isBuyer; // 是否是买家
	private String searchinfo; /// 查找信息
	private UserDispute userDispute; // 争议信息
	private String istrading; // 是交易中--用于微信查询
	private String ispaycoin; /// 是否使用卓币
	private String isprecoin; // 卓币:是否预付

	private BidOrderinfo bidorder; /// 招标合同信息

	protected Date createDateFormat; // 创建日期 yy-mm-dd
	private Date endCreateDate; // 结束 create_date
	private Date beginCreateDate; // 开始 create_date

	private Date endUpdateDate; // 结束 Update_date
	private Date beginUpdateDate; // 开始 Update_date

	private String sumorder;// 统计运单数
	private String sumoddloadweight;// 统计运单吨数
	private String sumtotalcost;// 统计运单运费
	private String sumsearch;// 统计运单数据的条件
	private Double locationamount;   //定位所需要花费的金额
	private OrderinfoVo orderInfoVo; /// 运单统计业务附表
	private Boolean isGps;// 是否Gps车辆
	private String timeflag; /// 格式化日期
	private String showtime; // 展示格式化时间

	public Date getEndUpdateDate() {
		return endUpdateDate;
	}

	public void setEndUpdateDate(Date endUpdateDate) {
		this.endUpdateDate = endUpdateDate;
	}

	public Date getBeginUpdateDate() {
		return beginUpdateDate;
	}

	public void setBeginUpdateDate(Date beginUpdateDate) {
		this.beginUpdateDate = beginUpdateDate;
	}

	public String getTimeflag() {
		return timeflag;
	}

	public void setTimeflag(String timeflag) {
		this.timeflag = timeflag;
	}

	public String getShowtime() {
		return showtime;
	}

	public void setShowtime(String showtime) {
		this.showtime = showtime;
	}

	public OrderinfoVo getOrderInfoVo() {
		return orderInfoVo;
	}

	public void setOrderInfoVo(OrderinfoVo orderInfoVo) {
		this.orderInfoVo = orderInfoVo;
	}

	public String getSumsearch() {
		return sumsearch;
	}

	public String getIspaycoin() {
		return ispaycoin;
	}

	public void setIspaycoin(String ispaycoin) {
		this.ispaycoin = ispaycoin;
	}

	public String getIsprecoin() {
		return isprecoin;
	}

	public void setIsprecoin(String isprecoin) {
		this.isprecoin = isprecoin;
	}

	public void setSumsearch(String sumsearch) {
		this.sumsearch = sumsearch;
	}

	public String getSumorder() {
		return sumorder;
	}

	public void setSumorder(String sumorder) {
		this.sumorder = sumorder;
	}

	public String getSumoddloadweight() {
		return sumoddloadweight;
	}

	public void setSumoddloadweight(String sumoddloadweight) {
		this.sumoddloadweight = sumoddloadweight;
	}

	public String getSumtotalcost() {
		return sumtotalcost;
	}

	public void setSumtotalcost(String sumtotalcost) {
		this.sumtotalcost = sumtotalcost;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getCreateDateFormat() {
		return createDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public String getIstrading() {
		return istrading;
	}

	public void setIstrading(String istrading) {
		this.istrading = istrading;
	}

	// @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:SS")
	// @ExcelField(title = "下单时间",align = 2,sort = 9)
	// public Date getCreateDate() {
	// return createDate;
	// }
	//
	// public void setCreateDate(Date createDate) {
	// this.createDate = createDate;
	// }
	// @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:SS")
	// @ExcelField(title = "下单时间",align = 2,sort = 9)
	// public Date getUpdateDate() {
	// return updateDate;
	// }
	//
	// public void setUpdateDate(Date updateDate) {
	// this.updateDate = updateDate;
	// }

	public OrderinfoTradeVO() {
		super();
	}

	public OrderinfoTradeVO(String id) {
		super(id);
	}

	public BidOrderinfo getBidorder() {
		return bidorder;
	}

	public void setBidorder(BidOrderinfo bidorder) {
		this.bidorder = bidorder;
	}

	public UserDispute getUserDispute() {
		return userDispute;
	}

	public void setUserDispute(UserDispute userDispute) {
		this.userDispute = userDispute;
	}

	//// 查询条件
	public String getSearchinfo() {
		return searchinfo;
	}

	public void setSearchinfo(String searchinfo) {
		this.searchinfo = searchinfo;
	}

	public Boolean getIsBuyer() {
		return isBuyer;
	}

	public void setIsBuyer(Boolean isBuyer) {
		this.isBuyer = isBuyer;
	}

	public String getStatusStr() {
		return statusStr;
	}

	public void setStatusStr(String statusStr) {
		this.statusStr = statusStr;
	}

	@NotNull(message = "缺少报价信息")
	@ExcelField(sort = 3, title = "车牌号码", align = '2', value = "quoteinfo.car.carnumber")
	public Quoteinfo getQuoteinfo() {
		return quoteinfo;
	}

	@ExcelField(title = "货物名称", align = 2, sort = 6, value = "quoteinfo.goods.goodsname")
	public String goodsName() {
		return getQuoteinfo().getGoods().getGoodsname();
	}
	
	@ExcelField(title = "货物类型",align = 2,sort = 7,value = "quoteinfo.goods.gsoddtype",dictType="gsoddtype")
	public String gsoddType() {
		return getQuoteinfo().getGoods().getGsoddtype();
	}
	
	@ExcelField(title = "货物重量(吨)",align = 2,sort = 8)
	public String goodsLoadWeight() {
		return getQuoteinfo().getOddloadweight();
	}
	/*
	 * @ExcelField(title = "下单时间",align = 2,sort = 9,value =
	 * "quoteinfo.beginCreateDate") public Date getbeginCreateDate() { return
	 * getQuoteinfo().getBeginCreateDate(); }
	 * 
	 * @ExcelField(title = "更新时间",align = 2,sort = 8,value =
	 * "quoteinfo.beginUpdateDate") public Date getbeginUpdateDate() { return
	 * getQuoteinfo().getBeginUpdateDate(); }
	 */

	public void setQuoteinfo(Quoteinfo quoteinfo) {
		this.quoteinfo = quoteinfo;
	}

	@ExcelField(sort = 4, title = "货主", align = '2', value = "seller.name")
	public User getBuyer() {
		return buyer;
	}

	@ExcelField(title = "货主电话", align = 2, sort = 5, value = "seller.phone")
	public String buyerPhone() {
		return getBuyer().getPhone();
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	@ExcelField(title = "承运方", align = 2, sort = 1, value = "buyer.name")
	public User getSeller() {
		return seller;
	}

	@ExcelField(title = "承运方电话", align = 2, sort = 2, value = "buyer.phone")
	public String sellerPhone() {
		return getSeller().getPhone();
	}

	@ExcelField(title = "司机", align = 2, sort = 3, value = "quoteinfo.driver.name")
	public String getDriver() {
		return getQuoteinfo().getDriver().getName();
	}
	@ExcelField(title = "司机手机", align = 2, sort = 4, value = "quoteinfo.driver.phone")
	public String getDriverPhone() {
		return getQuoteinfo().getDriver().getPhone();
	}

	public void setSeller(User seller) {
		this.seller = seller;
	}

	@Length(min = 0, max = 64, message = "运单号长度必须介于 0 和 64 之间")
	@ExcelField(title = "运单号", align = 2, sort = 0)
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	@Length(min = 0, max = 11, message = "运单状态长度必须介于 0 和 11 之间")
	@ExcelField(title = "运单状态", align = 2, sort = 77, dictType = "order_status")
	public String getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}

	@Length(min = 0, max = 11, message = "是否评价长度必须介于 0 和 11 之间")
	public String getIscomment() {
		return iscomment;
	}

	public void setIscomment(String iscomment) {
		this.iscomment = iscomment;
	}

	@ExcelField(title = "运费", align = 2, sort = 9)
	public String getTotalcost() {
		return totalcost;
	}

	public void setTotalcost(String totalcost) {
		this.totalcost = totalcost;
	}

	@Length(min = 0, max = 11, message = "是否线上支付:0线下,1线上支付长度必须介于 0 和 11 之间")
	@ExcelField(title = "支付类型", align = 2, sort = 101, dictType = "order_isonlinepay")
	public String getIsonlinepay() {
		return isonlinepay;
	}

	public void setIsonlinepay(String isonlinepay) {
		this.isonlinepay = isonlinepay;
	}

	@Length(min = 0, max = 11, message = "是否预支付:0不预支付,1预支付长度必须介于 0 和 11 之间")
	@ExcelField(title = "预支付", align = 2, sort = 102, dictType = "order_isprepay")
	public String getIsprepay() {
		return isprepay;
	}

	public void setIsprepay(String isprepay) {
		this.isprepay = isprepay;
	}

	@Length(min = 0, max = 11, message = "－1:免运费0:未支付1：暂扣费2:已支付到司机3:已返款长度必须介于 0 和 11 之间")
	@ExcelField(title = "支付状态", align = 2, sort = 100, dictType = "order_paystatus")
	public String getPaystatus() {
		return paystatus;
	}

	public void setPaystatus(String paystatus) {
		this.paystatus = paystatus;
	}

	// @结算卡,2授信支付，2免运费长度必须介于 0 和 11 之间")
	@ExcelField(title = "支付方式", align = 2, sort = 89, dictType = "order_payway")
	public String getPayway() {
		return payway;
	}

	public void setPayway(String payway) {
		this.payway = payway;
	}

	@Length(min = 0, max = 11, message = "是否打印回执单长度必须介于 0 和 11 之间")
	@ExcelField(title = "是否已打印", align = 2, sort = 87, dictType = "order_isprint")
	public String getIsprint() {
		return isprint;
	}

	public void setIsprint(String isprint) {
		this.isprint = isprint;
	}

	@Length(min = 0, max = 11, message = "是否发起争议：0，1长度必须介于 0 和 11 之间")
	public String getIsdispute() {
		return isdispute;
	}

	public void setIsdispute(String isdispute) {
		this.isdispute = isdispute;
	}

	@Length(min = 0, max = 11, message = "是否开启定位长度必须介于 0 和 11 之间")
	@ExcelField(title = "是否LBS定位", align = 2, sort = 88, dictType = "order_location")
	public String getIslocated() {
		return islocated;
	}

	public void setIslocated(String islocated) {
		this.islocated = islocated;
	}

	public TradePayinfo getPayinfo() {
		return payinfo;
	}

	public void setPayinfo(TradePayinfo payinfo) {
		this.payinfo = payinfo;
	}

	public String getBeginTotalcost() {
		return beginTotalcost;
	}

	public void setBeginTotalcost(String beginTotalcost) {
		this.beginTotalcost = beginTotalcost;
	}

	public String getEndTotalcost() {
		return endTotalcost;
	}

	public void setEndTotalcost(String endTotalcost) {
		this.endTotalcost = endTotalcost;
	}

	public Boolean getIsGps() {
		return isGps;
	}

	public void setIsGps(Boolean isGps) {
		this.isGps = isGps;
	}

	@ExcelField(title = "线上支付金额", align = 2, sort = 103, value = "payinfo.onlineamount")
	public String getOnlineamount() {
		return getPayinfo().getOnlineamount();
	}

	@ExcelField(title = "线下支付金额", align = 2, sort = 104, value = "payinfo.lineamount")
	public String getLineamount() {
		return getPayinfo().getLineamount();
	}

	@ExcelField(title = "线上预支付金额", align = 2, sort = 105, value = "payinfo.preamount")
	public String getPreamount() {
		return getPayinfo().getPreamount();
	}

	@ExcelField(title = "线上支付余款", align = 2, sort = 106, value = "payinfo.onlinebalance")
	public String getOnlinebalance() {
		return getPayinfo().getOnlinebalance();
	}

	@ExcelField(title = "争议金额", align = 2, sort = 107, value = "payinfo.disputeamount")
	public String getDisputeamount() {
		return getPayinfo().getDisputeamount();
	}

	@ExcelField(title = "实际支付金额", align = 2, sort = 108, value = "payinfo.actualamount")
	public String getActualamount() {
		return getPayinfo().getActualamount();
	}

	@ExcelField(title = "线上支付卓币金额", align = 2, sort = 109, value = "payinfo.coinamount")
	public String getCoinamount() {
		return getPayinfo().getCoinamount();
	}

	@ExcelField(title = "线上预付卓币金额", align = 2, sort = 110, value = "payinfo.coinpreamount")
	public String getCoinpreamount() {
		return getPayinfo().getCoinpreamount();
	}

	@ExcelField(title = "线上实际卓币金额", align = 2, sort = 111, value = "payinfo.coinactualpay")
	public String getCoinactualpay() {
		return getPayinfo().getCoinactualpay();
	}

	
	@ExcelField(title = "LBS定位总费用", align = 2, sort = 112, value = "payinfo.coinactualpay")
	public Double getLocationamount() {
		return locationamount;
	}

	public void setLocationamount(Double locationamount) {
		this.locationamount = locationamount;
	}

	@ExcelField(title = "运单生成时间", align = 2, sort = 113)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOrderCreateDate() {
		return this.createDate;
	}

	@ExcelField(title = "运单更新时间", align = 2, sort = 114)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOrderUpdateDate() {
		return this.updateDate;
	}



}