/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 业务数据统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsBusiness extends DataEntity<StatisticsBusiness> {
	
	private static final long serialVersionUID = 1L;
	//招标
	private Long bidcount;		// 招标数量
	private String bidprice;		// 招标总价
	private String bidweight;		// 招标总吨位
	
	//合同
	private String settlemoney;		// 结算金额
	private Long settlecount;		// 结算单数
	private String settleweight;		// 结算吨位
	
	private Date createtime;		// 统计时间
	
	//运单
	private Long trasportcount;		// 交易量
	private String trademoney;		// 交易金额
	private String tradeweight;		// 交易吨位
	private String arriveweight;		// 到达吨位
	private String arrivemoney;		// 到达支付金额
	private Long arrivecount;		// 达到量
	
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	
	private String endDate;		// 结束 create_date
	private String beginDate;		// 开始 create_date
	//扩展字段
	private String timeflg;
	private String cretime;
	private String userid;//用户id
	
	//扩展字段--竞标统计
	private String biddingpcount; //竞标数量
	private String biddingprice; //竞标总金额
	private String biddingweight; //竞标总吨位
	
	public StatisticsBusiness() {
		super();
	}

	public StatisticsBusiness(String id){
		super(id);
	}

	@ExcelField(title="招标数量", align=2, sort=0)
	public Long getBidcount() {
		return bidcount;
	}

	public void setBidcount(Long bidcount) {
		this.bidcount = bidcount;
	}
	
	
	@ExcelField(title="交易量", align=2, sort=3)
	public Long getTrasportcount() {
		return trasportcount;
	}

	public void setTrasportcount(Long trasportcount) {
		this.trasportcount = trasportcount;
	}
	
	@ExcelField(title="结算金额", align=2, sort=11)
	public String getSettlemoney() {
		return settlemoney;
	}

	public void setSettlemoney(String settlemoney) {
		this.settlemoney = settlemoney;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=12)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@ExcelField(title="招标总价", align=2, sort=1)
	public String getBidprice() {
		return bidprice;
	}

	public void setBidprice(String bidprice) {
		this.bidprice = bidprice;
	}
	
	@ExcelField(title="招标总吨位", align=2, sort=2)
	public String getBidweight() {
		return bidweight;
	}

	public void setBidweight(String bidweight) {
		this.bidweight = bidweight;
	}
	
	@ExcelField(title="交易金额", align=2, sort=5)
	public String getTrademoney() {
		return trademoney;
	}

	public void setTrademoney(String trademoney) {
		this.trademoney = trademoney;
	}
	
	@ExcelField(title="交易吨位", align=2, sort=4)
	public String getTradeweight() {
		return tradeweight;
	}

	public void setTradeweight(String tradeweight) {
		this.tradeweight = tradeweight;
	}
	
	@ExcelField(title="到达吨位", align=2, sort=7)
	public String getArriveweight() {
		return arriveweight;
	}

	public void setArriveweight(String arriveweight) {
		this.arriveweight = arriveweight;
	}
	
	@ExcelField(title="到达支付金额", align=2, sort=8)
	public String getArrivemoney() {
		return arrivemoney;
	}

	public void setArrivemoney(String arrivemoney) {
		this.arrivemoney = arrivemoney;
	}
	
	@ExcelField(title="结算单数", align=2, sort=9)
	public Long getSettlecount() {
		return settlecount;
	}

	public void setSettlecount(Long settlecount) {
		this.settlecount = settlecount;
	}
	
	@ExcelField(title="结算吨位", align=2, sort=10)
	public String getSettleweight() {
		return settleweight;
	}

	public void setSettleweight(String settleweight) {
		this.settleweight = settleweight;
	}
	
	@ExcelField(title="达到量", align=2, sort=6)
	public Long getArrivecount() {
		return arrivecount;
	}

	public void setArrivecount(Long arrivecount) {
		this.arrivecount = arrivecount;
	}

	public String getTimeflg() {
		return timeflg;
	}

	public void setTimeflg(String timeflg) {
		this.timeflg = timeflg;
	}

	
	public String getCretime() {
		return cretime;
	}

	public void setCretime(String cretime) {
		this.cretime = cretime;
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

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getBiddingpcount() {
		return biddingpcount;
	}

	public void setBiddingpcount(String biddingpcount) {
		this.biddingpcount = biddingpcount;
	}

	public String getBiddingprice() {
		return biddingprice;
	}

	public void setBiddingprice(String biddingprice) {
		this.biddingprice = biddingprice;
	}

	public String getBiddingweight() {
		return biddingweight;
	}

	public void setBiddingweight(String biddingweight) {
		this.biddingweight = biddingweight;
	}
	
}