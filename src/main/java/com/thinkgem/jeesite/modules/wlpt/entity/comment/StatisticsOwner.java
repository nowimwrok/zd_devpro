/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.comment;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 用户信息统计表Entity
 * @author 王铸
 * @version 2016-08-31
 */
public class StatisticsOwner extends DataEntity<StatisticsOwner> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户Id
	private Office company;		// 公司Id
	private String loginnum;		// 登录总次数
	private String loginnumweb;		// Web端登录次数
	private String loginnumapk;		// Apk端登录次数
	private String loginnumapp;		// App端登录次数
	private String carsourcenum;		// 发布车源总数
	private String carsourcenumweb;		// Web端发布车源数
	private String carsourcenumapk;		// Apk端发布车源数
	private String carsourcenumapp;		// App端发布车源数
	private String goodssourcenum;		// 发布货源总数
	private String goodssourcenumweb;		// Web端发布货源数
	private String goodssourcenumapk;		// Apk端发布货源数
	private String goodssourcenumapp;		// App端发布货源数
	private String linenum;		// 发布专线总数
	private String linenumweb;		// Web端发布专线数
	private String linenumapk;		// Apk端发布专线数
	private String linenumapp;		// App端发布专线数
	private String serscannum;		// (卖方)被浏览总次数
	private String serscannumweb;		// (卖方)Web端被浏览次数
	private String serscannumapk;		// (卖方)Apk端被浏览次数
	private String serscannumapp;		// (卖方)APP端被浏览次数
	private String serordernum;		// (卖方)接单总次数
	private String serordernumweb;		// (卖方)Web端接单次数
	private String serordernumapk;		// (卖方)APk端接单次数
	private String serordernumapp;		// (卖方)APP端接单次数
	private String sertradenum;		// (卖方)交易总次数
	private String sertradenumweb;		// (卖方)Web端交易次数
	private String sertradenumapk;		// (卖方)APk端交易次数
	private String sertradenumapp;		// (卖方)APP端交易次数
	private String beyscannum;		// (买方)被浏览总次数
	private String berscannumweb;		// (买方)Web端被浏览次数
	private String berscannumapk;		// (买方)Apk端被浏览次数
	private String berscannumapp;		// (买方)APP端被浏览次数
	private String berordernum;		// (买方)接单总次数
	private String berordernumweb;		// (买方)Web端接单次数
	private String berordernumapk;		// (买方)APk端接单次数
	private String berordernumapp;		// (买方)APP端接单次数
	private String bertradenum;		// (买方)交易总次数
	private String bertradenumweb;		// (买方)Web端交易次数
	private String bertradenumapk;		// (买方)APk端交易次数
	private String bertradenumapp;		// (买方)APP端交易次数
	private String totalratingnumber;		// 总的评分次数
	private String serviceattitudepoint;		// 服务态度评分
	private String transportationcostpoint;		// 运输费用评分
	private String transportlimitationpoint;		// 运输时效评分
	private String goodssafetypoint;		// 货物安全评分
	private String comprehensivepoint;		// 综合评分
	private String complainttimes;		// 投诉次数
	private String totalcarnumber;		// 车辆总数
	private String certifiedcarnumber;		// 认证车辆总数
	private String uncompletedordernumber;		// 未完成订单数
	private String pendingvaluationordernumber;		// 待评价订单数
	private Date updatetime;		// 数据最后更新时间
	private String totaltradeorder;		// 总的交易次数
	
	public StatisticsOwner() {
		super();
	}

	public StatisticsOwner(String id){
		super(id);
	}
	
	@Length(min=0, max=11, message="登录总次数长度必须介于 0 和 11 之间")
	public String getLoginnum() {
		return loginnum;
	}

	public void setLoginnum(String loginnum) {
		this.loginnum = loginnum;
	}
	
	@Length(min=0, max=11, message="Web端登录次数长度必须介于 0 和 11 之间")
	public String getLoginnumweb() {
		return loginnumweb;
	}

	public void setLoginnumweb(String loginnumweb) {
		this.loginnumweb = loginnumweb;
	}
	
	@Length(min=0, max=11, message="Apk端登录次数长度必须介于 0 和 11 之间")
	public String getLoginnumapk() {
		return loginnumapk;
	}

	public void setLoginnumapk(String loginnumapk) {
		this.loginnumapk = loginnumapk;
	}
	
	@Length(min=0, max=11, message="App端登录次数长度必须介于 0 和 11 之间")
	public String getLoginnumapp() {
		return loginnumapp;
	}

	public void setLoginnumapp(String loginnumapp) {
		this.loginnumapp = loginnumapp;
	}
	
	@Length(min=0, max=11, message="发布车源总数长度必须介于 0 和 11 之间")
	public String getCarsourcenum() {
		return carsourcenum;
	}

	public void setCarsourcenum(String carsourcenum) {
		this.carsourcenum = carsourcenum;
	}
	
	@Length(min=0, max=11, message="Web端发布车源数长度必须介于 0 和 11 之间")
	public String getCarsourcenumweb() {
		return carsourcenumweb;
	}

	public void setCarsourcenumweb(String carsourcenumweb) {
		this.carsourcenumweb = carsourcenumweb;
	}
	
	@Length(min=0, max=11, message="Apk端发布车源数长度必须介于 0 和 11 之间")
	public String getCarsourcenumapk() {
		return carsourcenumapk;
	}

	public void setCarsourcenumapk(String carsourcenumapk) {
		this.carsourcenumapk = carsourcenumapk;
	}
	
	@Length(min=0, max=11, message="App端发布车源数长度必须介于 0 和 11 之间")
	public String getCarsourcenumapp() {
		return carsourcenumapp;
	}

	public void setCarsourcenumapp(String carsourcenumapp) {
		this.carsourcenumapp = carsourcenumapp;
	}
	
	@Length(min=0, max=11, message="发布货源总数长度必须介于 0 和 11 之间")
	public String getGoodssourcenum() {
		return goodssourcenum;
	}

	public void setGoodssourcenum(String goodssourcenum) {
		this.goodssourcenum = goodssourcenum;
	}
	
	@Length(min=0, max=11, message="Web端发布货源数长度必须介于 0 和 11 之间")
	public String getGoodssourcenumweb() {
		return goodssourcenumweb;
	}

	public void setGoodssourcenumweb(String goodssourcenumweb) {
		this.goodssourcenumweb = goodssourcenumweb;
	}
	
	@Length(min=0, max=11, message="Apk端发布货源数长度必须介于 0 和 11 之间")
	public String getGoodssourcenumapk() {
		return goodssourcenumapk;
	}

	public void setGoodssourcenumapk(String goodssourcenumapk) {
		this.goodssourcenumapk = goodssourcenumapk;
	}
	
	@Length(min=0, max=11, message="App端发布货源数长度必须介于 0 和 11 之间")
	public String getGoodssourcenumapp() {
		return goodssourcenumapp;
	}

	public void setGoodssourcenumapp(String goodssourcenumapp) {
		this.goodssourcenumapp = goodssourcenumapp;
	}
	
	@Length(min=0, max=11, message="发布专线总数长度必须介于 0 和 11 之间")
	public String getLinenum() {
		return linenum;
	}

	public void setLinenum(String linenum) {
		this.linenum = linenum;
	}
	
	@Length(min=0, max=11, message="Web端发布专线数长度必须介于 0 和 11 之间")
	public String getLinenumweb() {
		return linenumweb;
	}

	public void setLinenumweb(String linenumweb) {
		this.linenumweb = linenumweb;
	}
	
	@Length(min=0, max=11, message="Apk端发布专线数长度必须介于 0 和 11 之间")
	public String getLinenumapk() {
		return linenumapk;
	}

	public void setLinenumapk(String linenumapk) {
		this.linenumapk = linenumapk;
	}
	
	@Length(min=0, max=11, message="App端发布专线数长度必须介于 0 和 11 之间")
	public String getLinenumapp() {
		return linenumapp;
	}

	public void setLinenumapp(String linenumapp) {
		this.linenumapp = linenumapp;
	}
	
	@Length(min=0, max=11, message="(卖方)被浏览总次数长度必须介于 0 和 11 之间")
	public String getSerscannum() {
		return serscannum;
	}

	public void setSerscannum(String serscannum) {
		this.serscannum = serscannum;
	}
	
	@Length(min=0, max=11, message="(卖方)Web端被浏览次数长度必须介于 0 和 11 之间")
	public String getSerscannumweb() {
		return serscannumweb;
	}

	public void setSerscannumweb(String serscannumweb) {
		this.serscannumweb = serscannumweb;
	}
	
	@Length(min=0, max=11, message="(卖方)Apk端被浏览次数长度必须介于 0 和 11 之间")
	public String getSerscannumapk() {
		return serscannumapk;
	}

	public void setSerscannumapk(String serscannumapk) {
		this.serscannumapk = serscannumapk;
	}
	
	@Length(min=0, max=11, message="(卖方)APP端被浏览次数长度必须介于 0 和 11 之间")
	public String getSerscannumapp() {
		return serscannumapp;
	}

	public void setSerscannumapp(String serscannumapp) {
		this.serscannumapp = serscannumapp;
	}
	
	@Length(min=0, max=11, message="(卖方)接单总次数长度必须介于 0 和 11 之间")
	public String getSerordernum() {
		return serordernum;
	}

	public void setSerordernum(String serordernum) {
		this.serordernum = serordernum;
	}
	
	@Length(min=0, max=11, message="(卖方)Web端接单次数长度必须介于 0 和 11 之间")
	public String getSerordernumweb() {
		return serordernumweb;
	}

	public void setSerordernumweb(String serordernumweb) {
		this.serordernumweb = serordernumweb;
	}
	
	@Length(min=0, max=11, message="(卖方)APk端接单次数长度必须介于 0 和 11 之间")
	public String getSerordernumapk() {
		return serordernumapk;
	}

	public void setSerordernumapk(String serordernumapk) {
		this.serordernumapk = serordernumapk;
	}
	
	@Length(min=0, max=11, message="(卖方)APP端接单次数长度必须介于 0 和 11 之间")
	public String getSerordernumapp() {
		return serordernumapp;
	}

	public void setSerordernumapp(String serordernumapp) {
		this.serordernumapp = serordernumapp;
	}
	
	@Length(min=0, max=11, message="(卖方)交易总次数长度必须介于 0 和 11 之间")
	public String getSertradenum() {
		return sertradenum;
	}

	public void setSertradenum(String sertradenum) {
		this.sertradenum = sertradenum;
	}
	
	@Length(min=0, max=11, message="(卖方)Web端交易次数长度必须介于 0 和 11 之间")
	public String getSertradenumweb() {
		return sertradenumweb;
	}

	public void setSertradenumweb(String sertradenumweb) {
		this.sertradenumweb = sertradenumweb;
	}
	
	@Length(min=0, max=11, message="(卖方)APk端交易次数长度必须介于 0 和 11 之间")
	public String getSertradenumapk() {
		return sertradenumapk;
	}

	public void setSertradenumapk(String sertradenumapk) {
		this.sertradenumapk = sertradenumapk;
	}
	
	@Length(min=0, max=11, message="(卖方)APP端交易次数长度必须介于 0 和 11 之间")
	public String getSertradenumapp() {
		return sertradenumapp;
	}

	public void setSertradenumapp(String sertradenumapp) {
		this.sertradenumapp = sertradenumapp;
	}
	
	@Length(min=0, max=11, message="(买方)被浏览总次数长度必须介于 0 和 11 之间")
	public String getBeyscannum() {
		return beyscannum;
	}

	public void setBeyscannum(String beyscannum) {
		this.beyscannum = beyscannum;
	}
	
	@Length(min=0, max=11, message="(买方)Web端被浏览次数长度必须介于 0 和 11 之间")
	public String getBerscannumweb() {
		return berscannumweb;
	}

	public void setBerscannumweb(String berscannumweb) {
		this.berscannumweb = berscannumweb;
	}
	
	@Length(min=0, max=11, message="(买方)Apk端被浏览次数长度必须介于 0 和 11 之间")
	public String getBerscannumapk() {
		return berscannumapk;
	}

	public void setBerscannumapk(String berscannumapk) {
		this.berscannumapk = berscannumapk;
	}
	
	@Length(min=0, max=11, message="(买方)APP端被浏览次数长度必须介于 0 和 11 之间")
	public String getBerscannumapp() {
		return berscannumapp;
	}

	public void setBerscannumapp(String berscannumapp) {
		this.berscannumapp = berscannumapp;
	}
	
	@Length(min=0, max=11, message="(买方)接单总次数长度必须介于 0 和 11 之间")
	public String getBerordernum() {
		return berordernum;
	}

	public void setBerordernum(String berordernum) {
		this.berordernum = berordernum;
	}
	
	@Length(min=0, max=11, message="(买方)Web端接单次数长度必须介于 0 和 11 之间")
	public String getBerordernumweb() {
		return berordernumweb;
	}

	public void setBerordernumweb(String berordernumweb) {
		this.berordernumweb = berordernumweb;
	}
	
	@Length(min=0, max=11, message="(买方)APk端接单次数长度必须介于 0 和 11 之间")
	public String getBerordernumapk() {
		return berordernumapk;
	}

	public void setBerordernumapk(String berordernumapk) {
		this.berordernumapk = berordernumapk;
	}
	
	@Length(min=0, max=11, message="(买方)APP端接单次数长度必须介于 0 和 11 之间")
	public String getBerordernumapp() {
		return berordernumapp;
	}

	public void setBerordernumapp(String berordernumapp) {
		this.berordernumapp = berordernumapp;
	}
	
	@Length(min=0, max=11, message="(买方)交易总次数长度必须介于 0 和 11 之间")
	public String getBertradenum() {
		return bertradenum;
	}

	public void setBertradenum(String bertradenum) {
		this.bertradenum = bertradenum;
	}
	
	@Length(min=0, max=11, message="(买方)Web端交易次数长度必须介于 0 和 11 之间")
	public String getBertradenumweb() {
		return bertradenumweb;
	}

	public void setBertradenumweb(String bertradenumweb) {
		this.bertradenumweb = bertradenumweb;
	}
	
	@Length(min=0, max=11, message="(买方)APk端交易次数长度必须介于 0 和 11 之间")
	public String getBertradenumapk() {
		return bertradenumapk;
	}

	public void setBertradenumapk(String bertradenumapk) {
		this.bertradenumapk = bertradenumapk;
	}
	
	@Length(min=0, max=11, message="(买方)APP端交易次数长度必须介于 0 和 11 之间")
	public String getBertradenumapp() {
		return bertradenumapp;
	}

	public void setBertradenumapp(String bertradenumapp) {
		this.bertradenumapp = bertradenumapp;
	}
	
	@Length(min=0, max=11, message="总的评分次数长度必须介于 0 和 11 之间")
	public String getTotalratingnumber() {
		return totalratingnumber;
	}

	public void setTotalratingnumber(String totalratingnumber) {
		this.totalratingnumber = totalratingnumber;
	}
	
	public String getServiceattitudepoint() {
		return serviceattitudepoint;
	}

	public void setServiceattitudepoint(String serviceattitudepoint) {
		this.serviceattitudepoint = serviceattitudepoint;
	}
	
	public String getTransportationcostpoint() {
		return transportationcostpoint;
	}

	public void setTransportationcostpoint(String transportationcostpoint) {
		this.transportationcostpoint = transportationcostpoint;
	}
	
	public String getTransportlimitationpoint() {
		return transportlimitationpoint;
	}

	public void setTransportlimitationpoint(String transportlimitationpoint) {
		this.transportlimitationpoint = transportlimitationpoint;
	}
	
	public String getGoodssafetypoint() {
		return goodssafetypoint;
	}

	public void setGoodssafetypoint(String goodssafetypoint) {
		this.goodssafetypoint = goodssafetypoint;
	}
	
	public String getComprehensivepoint() {
		return comprehensivepoint;
	}

	public void setComprehensivepoint(String comprehensivepoint) {
		this.comprehensivepoint = comprehensivepoint;
	}
	
	@Length(min=0, max=11, message="投诉次数长度必须介于 0 和 11 之间")
	public String getComplainttimes() {
		return complainttimes;
	}

	public void setComplainttimes(String complainttimes) {
		this.complainttimes = complainttimes;
	}
	
	@Length(min=0, max=11, message="车辆总数长度必须介于 0 和 11 之间")
	public String getTotalcarnumber() {
		return totalcarnumber;
	}

	public void setTotalcarnumber(String totalcarnumber) {
		this.totalcarnumber = totalcarnumber;
	}
	
	@Length(min=0, max=11, message="认证车辆总数长度必须介于 0 和 11 之间")
	public String getCertifiedcarnumber() {
		return certifiedcarnumber;
	}

	public void setCertifiedcarnumber(String certifiedcarnumber) {
		this.certifiedcarnumber = certifiedcarnumber;
	}
	
	@Length(min=0, max=11, message="未完成订单数长度必须介于 0 和 11 之间")
	public String getUncompletedordernumber() {
		return uncompletedordernumber;
	}

	public void setUncompletedordernumber(String uncompletedordernumber) {
		this.uncompletedordernumber = uncompletedordernumber;
	}
	
	@Length(min=0, max=11, message="待评价订单数长度必须介于 0 和 11 之间")
	public String getPendingvaluationordernumber() {
		return pendingvaluationordernumber;
	}

	public void setPendingvaluationordernumber(String pendingvaluationordernumber) {
		this.pendingvaluationordernumber = pendingvaluationordernumber;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
	@Length(min=0, max=11, message="总的交易次数长度必须介于 0 和 11 之间")
	public String getTotaltradeorder() {
		return totaltradeorder;
	}

	public void setTotaltradeorder(String totaltradeorder) {
		this.totaltradeorder = totaltradeorder;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
}