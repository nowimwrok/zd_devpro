/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.railregist;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;

/**
 * 自定义区域注册Entity
 * @author renshuai
 * @version 2017-10-10
 */
public class RailRegist extends DataEntity<RailRegist> {
	
	private static final long serialVersionUID = 1L;
	private String orderinfoId;	//外建，连接订单
	private String railname;		// 围栏名称
	private String areaid;		//围栏id
	private String lonlat;		// 经纬度
	private String radius;		// 范围
	private String actionType;		// 事件类型
	private String type;		// 订阅类型
	





	public RailRegist() {
		super();
	}

	public RailRegist(String id){
		super(id);
	}

	public String getOrderinfoId() {
		return orderinfoId;
	}
	
	public void setOrderinfoId(String orderinfoId) {
		this.orderinfoId = orderinfoId;
	}
	
	public String getAreaid() {
		return areaid;
	}

	public void setAreaid(String areaid) {
		this.areaid = areaid;
	}

	@Length(min=1, max=255, message="围栏名称长度必须介于 1 和 255 之间")
	public String getRailname() {
		return railname;
	}

	public void setRailname(String railname) {
		this.railname = railname;
	}
	
	@Length(min=1, max=255, message="经纬度长度必须介于 1 和 255 之间")
	public String getLonlat() {
		return lonlat;
	}

	public void setLonlat(String lonlat) {
		this.lonlat = lonlat;
	}
	
	
	@Length(min=1, max=3, message="事件类型长度必须介于 1 和 3 之间")
	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	public String getRadius() {
		return radius;
	}

	public void setRadius(String radius) {
		this.radius = radius;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}


	
}