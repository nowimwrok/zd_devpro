/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.lbs;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * LBS定位记录表Entity
 * @author zyj
 * @version 2016-10-10
 */
public class LbsLocationinfo extends DataEntity<LbsLocationinfo> {
	
	private static final long serialVersionUID = 1L;
	private String id;		// 位置信息Id
	private String mobile;		// 手机号码
	private String lng;		// 经度
	private String lat;		// 纬度
	private String address;		// 地址
	private String province;		// 省
	private String city;		// 城市
	private String district;		// 区
	private String street;		// 街道
	private String streetnumber;		// 街道号
	private String locationtype;		// 定位类型
	private Date locationtime;		// 定位时间
	private Date createtime;		// 创建时间
	private String username;		// 定位者
	private String userip;		// 定位者Ip
	private String tradeorderid;		// tradeorderid
	private String carid;		// carid
	
	public LbsLocationinfo() {
		super();
	}

	public LbsLocationinfo(String id){
		super(id);
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	@Length(min=0, max=20, message="手机号码长度必须介于 0 和 20 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}
	
	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}
	
	@Length(min=0, max=200, message="地址长度必须介于 0 和 200 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=20, message="省长度必须介于 0 和 20 之间")
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}
	
	@Length(min=0, max=20, message="城市长度必须介于 0 和 20 之间")
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	@Length(min=0, max=20, message="区长度必须介于 0 和 20 之间")
	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}
	
	@Length(min=0, max=20, message="街道长度必须介于 0 和 20 之间")
	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}
	
	@Length(min=0, max=20, message="街道号长度必须介于 0 和 20 之间")
	public String getStreetnumber() {
		return streetnumber;
	}

	public void setStreetnumber(String streetnumber) {
		this.streetnumber = streetnumber;
	}
	
	@Length(min=0, max=11, message="定位类型长度必须介于 0 和 11 之间")
	public String getLocationtype() {
		return locationtype;
	}

	public void setLocationtype(String locationtype) {
		this.locationtype = locationtype;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getLocationtime() {
		return locationtime;
	}

	public void setLocationtime(Date locationtime) {
		this.locationtime = locationtime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@Length(min=0, max=50, message="定位者长度必须介于 0 和 50 之间")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@Length(min=0, max=128, message="定位者Ip长度必须介于 0 和 128 之间")
	public String getUserip() {
		return userip;
	}

	public void setUserip(String userip) {
		this.userip = userip;
	}
	
	@Length(min=0, max=32, message="tradeorderid长度必须介于 0 和 32 之间")
	public String getTradeorderid() {
		return tradeorderid;
	}

	public void setTradeorderid(String tradeorderid) {
		this.tradeorderid = tradeorderid;
	}
	
	@Length(min=0, max=32, message="carid长度必须介于 0 和 32 之间")
	public String getCarid() {
		return carid;
	}

	public void setCarid(String carid) {
		this.carid = carid;
	}
	
}