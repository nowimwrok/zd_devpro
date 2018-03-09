/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.comment;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 总体交易评分表Entity
 * @author 王铸
 * @version 2016-08-31
 */
public class Ratingscale extends DataEntity<Ratingscale> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 卖家Id(被评分)
	private String serviceattitudepoint;		// 服务态度评分
	private String transportationcostpoint;		// 运输费用评分
	private String transportlimitationpoint;		// 运输时效评分
	private String goodssafetypoint;		// 货物安全评分
	private String comprehensivepoint;		// 综合评分
	private Long serviceattitudetotallnumber;		// 服务态度总的评分次数
	private Long goodssafetylevel2num;		// 货物安全评分2次数
	private Long transportlimitationtotalnumber;		// 运输时效总的评分次数
	private Long goodssafetytotalnumber;		// 货物安全总的评分次数
	private Long serviceattitudelevel5num;		// 服务态度评分5次数
	private Long transportationcostlevel5num;		// 运输费用评分5次数
	private Long transportlimitationlevel5num;		// 运输时效评分5次数
	private Long goodssafetylevel1num;		// 货物安全评分1次数
	private Long transportationcosttotalnumber;		// 运输费用总的评分次数
	private Long transportationcostlevel1num;		// 运输费用评分1次数
	private Long transportationcostlevel2num;		// 运输费用评分2次数
	private Long transportationcostlevel3num;		// 运输费用评分3次数
	private Long transportationcostlevel4num;		// 运输费用评分4次数
	private Long serviceattitudelevel1num;		// 服务态度评分1次数
	private Long transportlimitationlevel1num;		// 运输时效评分1次数
	private Long transportlimitationlevel2num;		// 运输时效评分2次数
	private Long transportlimitationlevel3num;		// 运输时效评分3次数
	private Long transportlimitationlevel4num;		// 运输时效评分4次数
	private Long serviceattitudelevel4num;		// 服务态度评分4次数
	private Long serviceattitudelevel3num;		// 服务态度评分3次数
	private Long serviceattitudelevel2num;		// 服务态度评分2次数
	private Long goodssafetylevel3num;		// 货物安全评分3次数
	private Long goodssafetylevel4num;		// 货物安全评分4次数
	private Long goodssafetylevel5num;		// 货物安全评分5次数
	
	public Ratingscale() {
		super();
	}

	public Ratingscale(String id){
		super(id);
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
	
	public Long getServiceattitudetotallnumber() {
		return serviceattitudetotallnumber;
	}

	public void setServiceattitudetotallnumber(Long serviceattitudetotallnumber) {
		this.serviceattitudetotallnumber = serviceattitudetotallnumber;
	}
	
	public Long getGoodssafetylevel2num() {
		return goodssafetylevel2num;
	}

	public void setGoodssafetylevel2num(Long goodssafetylevel2num) {
		this.goodssafetylevel2num = goodssafetylevel2num;
	}
	
	public Long getTransportlimitationtotalnumber() {
		return transportlimitationtotalnumber;
	}

	public void setTransportlimitationtotalnumber(Long transportlimitationtotalnumber) {
		this.transportlimitationtotalnumber = transportlimitationtotalnumber;
	}
	
	public Long getGoodssafetytotalnumber() {
		return goodssafetytotalnumber;
	}

	public void setGoodssafetytotalnumber(Long goodssafetytotalnumber) {
		this.goodssafetytotalnumber = goodssafetytotalnumber;
	}
	
	public Long getServiceattitudelevel5num() {
		return serviceattitudelevel5num;
	}

	public void setServiceattitudelevel5num(Long serviceattitudelevel5num) {
		this.serviceattitudelevel5num = serviceattitudelevel5num;
	}
	
	public Long getTransportationcostlevel5num() {
		return transportationcostlevel5num;
	}

	public void setTransportationcostlevel5num(Long transportationcostlevel5num) {
		this.transportationcostlevel5num = transportationcostlevel5num;
	}
	
	public Long getTransportlimitationlevel5num() {
		return transportlimitationlevel5num;
	}

	public void setTransportlimitationlevel5num(Long transportlimitationlevel5num) {
		this.transportlimitationlevel5num = transportlimitationlevel5num;
	}
	
	public Long getGoodssafetylevel1num() {
		return goodssafetylevel1num;
	}

	public void setGoodssafetylevel1num(Long goodssafetylevel1num) {
		this.goodssafetylevel1num = goodssafetylevel1num;
	}
	
	public Long getTransportationcosttotalnumber() {
		return transportationcosttotalnumber;
	}

	public void setTransportationcosttotalnumber(Long transportationcosttotalnumber) {
		this.transportationcosttotalnumber = transportationcosttotalnumber;
	}
	
	public Long getTransportationcostlevel1num() {
		return transportationcostlevel1num;
	}

	public void setTransportationcostlevel1num(Long transportationcostlevel1num) {
		this.transportationcostlevel1num = transportationcostlevel1num;
	}
	
	public Long getTransportationcostlevel2num() {
		return transportationcostlevel2num;
	}

	public void setTransportationcostlevel2num(Long transportationcostlevel2num) {
		this.transportationcostlevel2num = transportationcostlevel2num;
	}
	
	public Long getTransportationcostlevel3num() {
		return transportationcostlevel3num;
	}

	public void setTransportationcostlevel3num(Long transportationcostlevel3num) {
		this.transportationcostlevel3num = transportationcostlevel3num;
	}
	
	public Long getTransportationcostlevel4num() {
		return transportationcostlevel4num;
	}

	public void setTransportationcostlevel4num(Long transportationcostlevel4num) {
		this.transportationcostlevel4num = transportationcostlevel4num;
	}
	
	public Long getServiceattitudelevel1num() {
		return serviceattitudelevel1num;
	}

	public void setServiceattitudelevel1num(Long serviceattitudelevel1num) {
		this.serviceattitudelevel1num = serviceattitudelevel1num;
	}
	
	public Long getTransportlimitationlevel1num() {
		return transportlimitationlevel1num;
	}

	public void setTransportlimitationlevel1num(Long transportlimitationlevel1num) {
		this.transportlimitationlevel1num = transportlimitationlevel1num;
	}
	
	public Long getTransportlimitationlevel2num() {
		return transportlimitationlevel2num;
	}

	public void setTransportlimitationlevel2num(Long transportlimitationlevel2num) {
		this.transportlimitationlevel2num = transportlimitationlevel2num;
	}
	
	public Long getTransportlimitationlevel3num() {
		return transportlimitationlevel3num;
	}

	public void setTransportlimitationlevel3num(Long transportlimitationlevel3num) {
		this.transportlimitationlevel3num = transportlimitationlevel3num;
	}
	
	public Long getTransportlimitationlevel4num() {
		return transportlimitationlevel4num;
	}

	public void setTransportlimitationlevel4num(Long transportlimitationlevel4num) {
		this.transportlimitationlevel4num = transportlimitationlevel4num;
	}
	
	public Long getServiceattitudelevel4num() {
		return serviceattitudelevel4num;
	}

	public void setServiceattitudelevel4num(Long serviceattitudelevel4num) {
		this.serviceattitudelevel4num = serviceattitudelevel4num;
	}
	
	public Long getServiceattitudelevel3num() {
		return serviceattitudelevel3num;
	}

	public void setServiceattitudelevel3num(Long serviceattitudelevel3num) {
		this.serviceattitudelevel3num = serviceattitudelevel3num;
	}
	
	public Long getServiceattitudelevel2num() {
		return serviceattitudelevel2num;
	}

	public void setServiceattitudelevel2num(Long serviceattitudelevel2num) {
		this.serviceattitudelevel2num = serviceattitudelevel2num;
	}
	
	public Long getGoodssafetylevel3num() {
		return goodssafetylevel3num;
	}

	public void setGoodssafetylevel3num(Long goodssafetylevel3num) {
		this.goodssafetylevel3num = goodssafetylevel3num;
	}
	
	public Long getGoodssafetylevel4num() {
		return goodssafetylevel4num;
	}

	public void setGoodssafetylevel4num(Long goodssafetylevel4num) {
		this.goodssafetylevel4num = goodssafetylevel4num;
	}
	
	public Long getGoodssafetylevel5num() {
		return goodssafetylevel5num;
	}

	public void setGoodssafetylevel5num(Long goodssafetylevel5num) {
		this.goodssafetylevel5num = goodssafetylevel5num;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}