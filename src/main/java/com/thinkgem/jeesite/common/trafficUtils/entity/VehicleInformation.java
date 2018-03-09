package com.thinkgem.jeesite.common.trafficUtils.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 车辆位置信息
 *
 * @author Shinelon
 */
public class VehicleInformation extends DataEntity<VehicleInformation> {

    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private String vno;  // 车牌号 : 字符串类型
    private String utc;  // 车辆定位时间 : 字符串类型
    private String spd;  // 速度 : 字符串类型单位km/h
    private String drc;  // 方向 : 字符串类型（0或360：正北，大于0且小于90：东北，等于90：正东，大于90且小于180：东南，等于180：正南，大于180且小于270：西南，等于270：正西，大于270且小于等于359：西北，其他：未知）
    private String adr;  // 车辆地理位置名称: 字符串类型
    private String lat;  // 纬度 : 字符串类型单位：1/600000.0
    private String lon;  // 经度 : 字符串类型单位：1/600000.0
    private String gtm;  // GPS时间: 字符串类型格式：yyyyMMdd/HHmmss
    private String mlg;  // 里程: 字符串类型当大于0时，需乘以0.1换算成实际里程，单位为km，
    private String hgt;  // 海拔: 字符串类型单位为m
    private String agl;  // 正北方向夹角 : 字符串类型（0--359 ，正北为0，顺时针）
    private String areaid;//自定义区域ID（当注册成功时返回自定义区域ID，失败时为空）
    private String state; //1：注册成功，2：注册失败

    public String getVno() {
        return vno;
    }

    public String getAreaid() {
        return areaid;
    }

    public void setAreaid(String areaid) {
        this.areaid = areaid;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setVno(String vno) {
        this.vno = vno;
    }

    public String getUtc() {
        return utc;
    }

    public void setUtc(String utc) {
        this.utc = utc;
    }

    public String getSpd() {
        return spd;
    }

    public void setSpd(String spd) {
        this.spd = spd;
    }

    public String getDrc() {
        return drc;
    }

    public void setDrc(String drc) {
        this.drc = drc;
    }

    public String getAdr() {
        return adr;
    }

    public void setAdr(String adr) {
        this.adr = adr;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getLon() {
        return lon;
    }

    public void setLon(String lon) {
        this.lon = lon;
    }

    public String getGtm() {
        return gtm;
    }

    public void setGtm(String gtm) {
        this.gtm = gtm;
    }

    public String getMlg() {
        return mlg;
    }

    public void setMlg(String mlg) {
        this.mlg = mlg;
    }

    public String getHgt() {
        return hgt;
    }

    public void setHgt(String hgt) {
        this.hgt = hgt;
    }

    public String getAgl() {
        return agl;
    }

    public void setAgl(String agl) {
        this.agl = agl;
    }
//	@Override
//	public String toString() {
//		return "VehiclePositionInformation [vno=" + vno + ", utc=" + utc + ", spd=" + spd + ", drc=" + drc + ", adr="
//				+ adr + ", lat=" + lat + ", lon=" + lon + ", gtm=" + gtm + ", mlg=" + mlg + ", hgt=" + hgt + ", agl="
//				+ agl + "]";
//	}


}
