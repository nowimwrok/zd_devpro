/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * gps车辆定位信息Entity
 * @author 王铸
 * @version 2016-09-06
 */
public class GpsCarLocs extends DataEntity<GpsCarLocs> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 车牌号
	private String mobile;		// 话电
	private String recvtime;		// 务器服时间（毫秒数）
	private String gpstime;		// GPS时间（毫秒数）
	private String lat;		// 经度
	private String lng;		// 纬度
	private String latXz;		// 经度修正值
	private String lngXz;		// 纬度修正值
	private String state;		// 车辆状态
	private String speed;		// 速度
	private String direct;		// 方向
	private String temp;		// 温度
	private String oil;		// 油量
	private String oilmn1;		// oilmn1
	private String oilmn2;		// oilmn2
	private String distance;		// 行驶里程
	private String totaldis;		// 总里程
	private String av;		// 有效性
	private String info;		// 文字位置信息
	private String vhcofflinemin;		// 不在线时长（分钟）
	private String stopdefdis;		// stopdefdis
	private String stopdeflat;		// stopdeflat
	private String stopdeflng;		// stopdeflng
	private String temp1;		// temp1
	private String temp2;		// temp2
	private String temp3;		// temp3
	private String temp4;		// temp4
	
	private String formatrecvtime;
	private String formatgpstime;
	private String infoshort;		// 简单文字位置信息
	public GpsCarLocs() {
		super();
	}

	public GpsCarLocs(String id){
		super(id);
	}

	@Length(min=0, max=32, message="车牌号长度必须介于 0 和 32 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=32, message="话电长度必须介于 0 和 32 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Length(min=0, max=32, message="务器服时间（毫秒数）长度必须介于 0 和 32 之间")
	public String getRecvtime() {
		return recvtime;
	}

	public void setRecvtime(String recvtime) {
		this.recvtime = recvtime;
	}
	
	@Length(min=0, max=32, message="GPS时间（毫秒数）长度必须介于 0 和 32 之间")
	public String getGpstime() {
		return gpstime;
	}

	public void setGpstime(String gpstime) {
		this.gpstime = gpstime;
	}
	
	@Length(min=0, max=32, message="经度长度必须介于 0 和 32 之间")
	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}
	
	@Length(min=0, max=32, message="纬度长度必须介于 0 和 32 之间")
	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}
	
	@Length(min=0, max=32, message="经度修正值长度必须介于 0 和 32 之间")
	public String getLatXz() {
		return latXz;
	}

	public void setLatXz(String latXz) {
		this.latXz = latXz;
	}
	
	@Length(min=0, max=32, message="纬度修正值长度必须介于 0 和 32 之间")
	public String getLngXz() {
		return lngXz;
	}

	public void setLngXz(String lngXz) {
		this.lngXz = lngXz;
	}
	
	@Length(min=0, max=32, message="车辆状态长度必须介于 0 和 32 之间")
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	@Length(min=0, max=32, message="速度长度必须介于 0 和 32 之间")
	public String getSpeed() {
		return speed;
	}

	public void setSpeed(String speed) {
		this.speed = speed;
	}
	
	@Length(min=0, max=32, message="方向长度必须介于 0 和 32 之间")
	public String getDirect() {
		return direct;
	}

	public void setDirect(String direct) {
		this.direct = direct;
	}
	
	@Length(min=0, max=32, message="温度长度必须介于 0 和 32 之间")
	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
	
	@Length(min=0, max=32, message="油量长度必须介于 0 和 32 之间")
	public String getOil() {
		return oil;
	}

	public void setOil(String oil) {
		this.oil = oil;
	}
	
	@Length(min=0, max=32, message="oilmn1长度必须介于 0 和 32 之间")
	public String getOilmn1() {
		return oilmn1;
	}

	public void setOilmn1(String oilmn1) {
		this.oilmn1 = oilmn1;
	}
	
	@Length(min=0, max=32, message="oilmn2长度必须介于 0 和 32 之间")
	public String getOilmn2() {
		return oilmn2;
	}

	public void setOilmn2(String oilmn2) {
		this.oilmn2 = oilmn2;
	}
	
	@Length(min=0, max=32, message="行驶里程长度必须介于 0 和 32 之间")
	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}
	
	@Length(min=0, max=32, message="总里程长度必须介于 0 和 32 之间")
	public String getTotaldis() {
		return totaldis;
	}

	public void setTotaldis(String totaldis) {
		this.totaldis = totaldis;
	}
	
	@Length(min=0, max=32, message="有效性长度必须介于 0 和 32 之间")
	public String getAv() {
		return av;
	}

	public void setAv(String av) {
		this.av = av;
	}
	
	@Length(min=0, max=256, message="文字位置信息长度必须介于 0 和 256 之间")
	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
	
	@Length(min=0, max=32, message="不在线时长（分钟）长度必须介于 0 和 32 之间")
	public String getVhcofflinemin() {
		return vhcofflinemin;
	}

	public void setVhcofflinemin(String vhcofflinemin) {
		this.vhcofflinemin = vhcofflinemin;
	}
	
	@Length(min=0, max=32, message="stopdefdis长度必须介于 0 和 32 之间")
	public String getStopdefdis() {
		return stopdefdis;
	}

	public void setStopdefdis(String stopdefdis) {
		this.stopdefdis = stopdefdis;
	}
	
	@Length(min=0, max=32, message="stopdeflat长度必须介于 0 和 32 之间")
	public String getStopdeflat() {
		return stopdeflat;
	}

	public void setStopdeflat(String stopdeflat) {
		this.stopdeflat = stopdeflat;
	}
	
	@Length(min=0, max=32, message="stopdeflng长度必须介于 0 和 32 之间")
	public String getStopdeflng() {
		return stopdeflng;
	}

	public void setStopdeflng(String stopdeflng) {
		this.stopdeflng = stopdeflng;
	}
	
	@Length(min=0, max=32, message="temp1长度必须介于 0 和 32 之间")
	public String getTemp1() {
		return temp1;
	}

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	
	@Length(min=0, max=32, message="temp2长度必须介于 0 和 32 之间")
	public String getTemp2() {
		return temp2;
	}

	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}
	
	@Length(min=0, max=32, message="temp3长度必须介于 0 和 32 之间")
	public String getTemp3() {
		return temp3;
	}

	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}
	
	@Length(min=0, max=32, message="temp4长度必须介于 0 和 32 之间")
	public String getTemp4() {
		return temp4;
	}

	public void setTemp4(String temp4) {
		this.temp4 = temp4;
	}

	public String getInfoshort() {
		return infoshort;
	}

	public void setInfoshort(String infoshort) {
		this.infoshort = infoshort;
	}

	public String getFormatrecvtime() {
		return formatrecvtime;
	}

	public void setFormatrecvtime(String formatrecvtime) {
		this.formatrecvtime = formatrecvtime;
	}

	public String getFormatgpstime() {
		return formatgpstime;
	}

	public void setFormatgpstime(String formatgpstime) {
		this.formatgpstime = formatgpstime;
	}
	
}