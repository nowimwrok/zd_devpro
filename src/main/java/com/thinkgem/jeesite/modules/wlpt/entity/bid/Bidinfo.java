/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.bid;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import org.hibernate.validator.constraints.Length;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 招标信息Entity
 * @author 刘欣
 * @version 2016-08-02
 */
public class Bidinfo extends DataEntity<Bidinfo> {

	private static final long serialVersionUID = 1L;
	private String bidcode;		// 标招文号
	private Goods goods;		// 货物id
	private User biduser;		// 招标用户
	private String bidtitle;		// 招标标题
	private Integer paytype;		// 支付类型
	private String expectedprice;		// 拦标价
	private Integer isbill;		// 是否需要发票
	private Integer isupbl;    //是否上传明细
	private String bidstatus;		// 招标状态
	private Date endtime;		// 招标截止时间
	private String endtimeFM;		// 招标截止时间 y-m-d H:i:s格式
	private Date publishtime;		// 发布时间
	private String publishtimeFM;		// 招标截止时间 y-m-d H:i:s格式

	private String settlementtype;  //结算周期类型
	private Date settlementtime;		// 结算时间
	private Integer settlementperiod;		// 结算周期
	private Integer biddingcount;		// 投标次数
	private Integer clickcount;		// 点击次数
	private Date beginEndtime;		// 开始 招标截止时间
	private Date endEndtime;		// 结束 招标截止时间
	private Date beginPublishtime;		// 开始 发布时间
	private Date endPublishtime;		// 结束 发布时间
	private List<BidBlinfo> blinfoList;
	private List<Biddinginfo> biddingList;



	public Bidinfo() {
		super();
	}

	public Bidinfo(String id){
		super(id);
	}

	public List<BidBlinfo> getBlinfoList() {
		return blinfoList;
	}

	public void setBlinfoList(List<BidBlinfo> blinfoList) {
		this.blinfoList = blinfoList;
	}

	@Length(min=0, max=32, message="标招文号长度必须介于 0 和 32 之间")
	public String getBidcode() {
		return bidcode;
	}

	public void setBidcode(String bidcode) {
		this.bidcode = bidcode;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public User getBiduser() {
		return biduser;
	}

	public void setBiduser(User biduser) {
		this.biduser = biduser;
	}

	public String getBidtitle() {
		return bidtitle;
	}

	public void setBidtitle(String bidtitle) {
		this.bidtitle = bidtitle;
	}

	public Integer getPaytype() {
		return paytype;
	}

	public void setPaytype(Integer paytype) {
		this.paytype = paytype;
	}

	public String getExpectedprice() {
		return expectedprice;
	}

	public void setExpectedprice(String expectedprice) {
		this.expectedprice = expectedprice;
	}
	

	public Integer getIsbill() {
		return isbill;
	}

	public void setIsbill(Integer isbill) {
		this.isbill = isbill;
	}
 
	public String isbill(){
		if(getIsbill()==DataDic.NO_INT){
			return DataDic.NO_STR;
		}else{
			return DataDic.YES_STR;
		}
	}
	
	public Integer getIsupbl() {
		return isupbl;
	}

	public void setIsupbl(Integer isupbl) {
		this.isupbl = isupbl;
	}

	public String getBidstatus() {
		return bidstatus;
	}

	public void setBidstatus(String bidstatus) {
		this.bidstatus = bidstatus;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	
	public String endtime(){
		if(getEndtime()!=null){
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(getEndtime());
		}else{
			return "";
		}
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPublishtime() {
		return publishtime;
	}

	public void setPublishtime(Date publishtime) {
		this.publishtime = publishtime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public String getPublishtimeFM() {
		return publishtimeFM;
	}

	public void setPublishtimeFM(String publishtimeFM) {
		this.publishtimeFM = publishtimeFM;
	}

	public String getSettlementtype() {
		return settlementtype;
	}

	public void setSettlementtype(String settlementtype) {
		this.settlementtype = settlementtype;
	}
	
	public String settlementType(){
		if(getSettlementtype().equals(DataDic.SETTLEMENT_TYPE_START)){
			return DataDic.SETTLEMENT_TYPE_START_STR;
		}else{
			return DataDic.SETTLEMENT_TYPE_END_STR;
		}
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSettlementtime() {
		return settlementtime;
	}

	public void setSettlementtime(Date settlementtime) {
		this.settlementtime = settlementtime;
	}
	
	public String settlementTime(){
		if(getSettlementtime()!=null){
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(getSettlementtime());
		}else{
			return "";
		}
	}

	public Integer getSettlementperiod() {
		return settlementperiod;
	}

	public void setSettlementperiod(Integer settlementperiod) {
		this.settlementperiod = settlementperiod;
	}

	public Integer getBiddingcount() {
		return biddingcount;
	}

	public void setBiddingcount(Integer biddingcount) {
		this.biddingcount = biddingcount;
	}

	public Integer getClickcount() {
		return clickcount;
	}

	public void setClickcount(Integer clickcount) {
		this.clickcount = clickcount;
	}

	public Date getBeginEndtime() {
		return beginEndtime;
	}

	public void setBeginEndtime(Date beginEndtime) {
		this.beginEndtime = beginEndtime;
	}

	public Date getEndEndtime() {
		return endEndtime;
	}

	public void setEndEndtime(Date endEndtime) {
		this.endEndtime = endEndtime;
	}

	public Date getBeginPublishtime() {
		return beginPublishtime;
	}

	public void setBeginPublishtime(Date beginPublishtime) {
		this.beginPublishtime = beginPublishtime;
	}

	public Date getEndPublishtime() {
		return endPublishtime;
	}

	public void setEndPublishtime(Date endPublishtime) {
		this.endPublishtime = endPublishtime;
	}

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public String getEndtimeFM() {
		return endtimeFM;
	}

	public void setEndtimeFM(String endtimeFM) {
		this.endtimeFM = endtimeFM;
	}

	public String updateTime(){
		if(getUpdateDate()!=null){
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(getUpdateDate());
		}else{
			return "";
		}
	}

	public String remarks(){
		return getRemarks();
	}

	public List<Biddinginfo> getBiddingList() {
		return biddingList;
	}

	public void setBiddingList(List<Biddinginfo> biddingList) {
		this.biddingList = biddingList;
	}

}