/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.comment;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;

/**
 * 交易评论Entity
 * @author 王铸
 * @version 2016-08-31
 */
public class TradeComment extends DataEntity<TradeComment> {
	
	private static final long serialVersionUID = 1L;
	private String orderno;		// 订单号
	private String buyeriscomment;		// 买家评论标识:0没评论1已经评论
	private String buyercomment;		// 买家评论内容
	private String buyercommentlv;		// 买家评论满意度
	private Date buyercommenttime;		// 买家评论时间
	private String selleriscomment;		// 卖家评论标识:0没评论1已经评论
	private String sellercomment;		// 卖家评论内容
	private String sellercommentlv;		// 卖家评论满意度
	private Date sellercommenttime;		// 卖家评论时间
	private String serviceattitudepoint;		// 服务态度评分
	private String transportationcostpoint;		// 运输费用评分
	private String transportlimitationpoint;		// 运输失效评分
	private String goodssafetypoint;		// 货物安全评分
	private String comprehensivepoint;		// 综合评分

	private User user;//评论方
	public TradeComment() {
		super();
	}

	public TradeComment(String id){
		super(id);
	}
	
	@Length(min=1, max=50, message="订单号长度必须介于 1 和 50 之间")
	@ExcelField(type = 1, sort = 0, title = "订单号", align = '2')
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	
	@Length(min=0, max=11, message="买家评论标识:0没评论1已经评论长度必须介于 0 和 11 之间")
	public String getBuyeriscomment() {
		return buyeriscomment;
	}

	public void setBuyeriscomment(String buyeriscomment) {
		this.buyeriscomment = buyeriscomment;
	}
	
	@Length(min=0, max=500, message="买家评论内容长度必须介于 0 和 500 之间")
	public String getBuyercomment() {
		return buyercomment;
	}

	public void setBuyercomment(String buyercomment) {
		this.buyercomment = buyercomment;
	}
	
	@Length(min=0, max=11, message="买家评论满意度长度必须介于 0 和 11 之间")
	public String getBuyercommentlv() {
		return buyercommentlv;
	}

	public void setBuyercommentlv(String buyercommentlv) {
		this.buyercommentlv = buyercommentlv;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBuyercommenttime() {
		return buyercommenttime;
	}

	public void setBuyercommenttime(Date buyercommenttime) {
		this.buyercommenttime = buyercommenttime;
	}
	
	@Length(min=0, max=11, message="卖家评论标识:0没评论1已经评论长度必须介于 0 和 11 之间")
	public String getSelleriscomment() {
		return selleriscomment;
	}

	public void setSelleriscomment(String selleriscomment) {
		this.selleriscomment = selleriscomment;
	}
	
	@Length(min=0, max=500, message="卖家评论内容长度必须介于 0 和 500 之间")
	public String getSellercomment() {
		return sellercomment;
	}

	public void setSellercomment(String sellercomment) {
		this.sellercomment = sellercomment;
	}
	
	@Length(min=0, max=11, message="卖家评论满意度长度必须介于 0 和 11 之间")
	@ExcelField(type = 1, sort = 2, title = "卖家评论满意度", align = '2')
	public String getSellercommentlv() {
		return sellercommentlv;
	}

	public void setSellercommentlv(String sellercommentlv) {
		this.sellercommentlv = sellercommentlv;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSellercommenttime() {
		return sellercommenttime;
	}

	public void setSellercommenttime(Date sellercommenttime) {
		this.sellercommenttime = sellercommenttime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@ExcelField(type = 1, sort = 1, title = "卖家", align = '2')
	public String getName(){
		if(this.getUser()==null){
			return null;
		}
		return this.getUser().getName();
	}

	@ExcelField(type = 1, sort = 3, title = "服务态度评分", align = '2')
	public String getServiceattitudepoint() {
		return serviceattitudepoint;
	}

	
	public void setServiceattitudepoint(String serviceattitudepoint) {
		this.serviceattitudepoint = serviceattitudepoint;
	}

	@ExcelField(type = 1, sort = 4, title = "费用评分", align = '2')
	public String getTransportationcostpoint() {
		return transportationcostpoint;
	}

	public void setTransportationcostpoint(String transportationcostpoint) {
		this.transportationcostpoint = transportationcostpoint;
	}

	@ExcelField(type = 1, sort = 5, title = "时效评分", align = '2')
	public String getTransportlimitationpoint() {
		return transportlimitationpoint;
	}

	public void setTransportlimitationpoint(String transportlimitationpoint) {
		this.transportlimitationpoint = transportlimitationpoint;
	}

	@ExcelField(type = 1, sort = 6, title = "安全评分", align = '2')
	public String getGoodssafetypoint() {
		return goodssafetypoint;
	}

	public void setGoodssafetypoint(String goodssafetypoint) {
		this.goodssafetypoint = goodssafetypoint;
	}

	@ExcelField(type = 1, sort = 7, title = "综合评分", align = '2')
	public String getComprehensivepoint() {
		return comprehensivepoint;
	}

	public void setComprehensivepoint(String comprehensivepoint) {
		this.comprehensivepoint = comprehensivepoint;
	}
	
}