package com.thinkgem.jeesite.common.trafficUtils.entity;


import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 车辆行驶信息实体类
 * @author Shinelon
 *
 */
public class ParkingInformation extends DataEntity<ParkingInformation>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mileage;      //本段行程中车辆总行驶里程数。单位：公里，支持1位小数,四舍五入
	private String startTime;    //精确到年月日时分秒
	private String endTime;      //精确到年月日时分秒
	private String startLonLat;  //本段行程中起点的位置84经纬度坐标信息
	private String start;        //本段行程中起点的位置文字地理信息
	private String endLonLat;    //本段行程中终点的位置84经纬度坐标信息
	private String end;          //本段行程中终点的位置文字地理信息
	private String parkMins;     // 停车时长
	private String bte;          //停车开始时间 2017-04-05 10:00:00
	private String ete;          //停车结束时间 2017-04-05 10:00:00
	private String lon;          //84经度坐标信息
	private String lat;          //84经度坐标信息
	private String adr;          //停车位置
	
	public String getParkMins() {
		return parkMins;
	}
	public void setParkMins(String parkMins) {
		this.parkMins = parkMins;
	}
	public String getBte() {
		return bte;
	}
	public void setBte(String bte) {
		this.bte = bte;
	}
	public String getEte() {
		return ete;
	}
	public void setEte(String ete) {
		this.ete = ete;
	}
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getAdr() {
		return adr;
	}
	public void setAdr(String adr) {
		this.adr = adr;
	}
	public String getMileage() {
		return mileage;
	}
	public void setMileage(String mileage) {
		this.mileage = mileage;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getStartLonLat() {
		return startLonLat;
	}
	public void setStartLonLat(String startLonLat) {
		this.startLonLat = startLonLat;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEndLonLat() {
		return endLonLat;
	}
	public void setEndLonLat(String endLonLat) {
		this.endLonLat = endLonLat;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	
}
