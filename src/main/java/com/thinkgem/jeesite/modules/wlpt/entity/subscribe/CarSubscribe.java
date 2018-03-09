/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.subscribe;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 车辆与自定义区域绑定Entity
 * @author 车辆订阅
 * @version 2017-10-10
 */
public class CarSubscribe extends DataEntity<CarSubscribe> {
	
	private static final long serialVersionUID = 1L;
	private String vnos;		// 车牌号
	private String areaid;		// 自定义区域id
	
	public CarSubscribe() {
		super();
	}

	public CarSubscribe(String id){
		super(id);
	}

	@Length(min=1, max=255, message="车牌号长度必须介于 1 和 255 之间")
	public String getVnos() {
		return vnos;
	}

	public void setVnos(String vnos) {
		this.vnos = vnos;
	}
	
	@Length(min=1, max=64, message="自定义区域id长度必须介于 1 和 64 之间")
	public String getAreaid() {
		return areaid;
	}

	public void setAreaid(String areaid) {
		this.areaid = areaid;
	}
	
}