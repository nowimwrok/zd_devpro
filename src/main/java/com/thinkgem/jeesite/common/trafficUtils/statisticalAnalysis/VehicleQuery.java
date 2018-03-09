package com.thinkgem.jeesite.common.trafficUtils.statisticalAnalysis;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.ParkingInformation;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;

/**
 * 统计车辆(停车,里程)查询
 * 
 * @author Shinelon
 *
 */
//@Service
public class VehicleQuery {
	private ParkingInformation parkingInformation;

	/**
	 * 车辆停车查询接口 本接口提供指定车牌号，指定时间段查询车辆停车信息，开始时间和结束时间不能超过24小时。
	 * 
	 * @param vclN
	 *            车牌号
	 * @param vco
	 *            车牌颜色，1：蓝色；2：黄色
	 * @param qryBtm
	 *            开始时间
	 * @param qryEtm
	 *            结束时间
	 * @param parkMins
	 *            停车时长 默认为10，单位为分钟，大于等于3的整数
	 */
	public ParkingInformation vQueryPark(String token,String vclN, String vco, String qryBtm, String qryEtm, String parkMins) {
		String jsonstr = ZhiyunOpenapi.vQueryPark(token, vclN, vco, qryBtm, qryEtm, parkMins);
		parkingInformation = new ParkingInformation();
		
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(!jsonObject.isNull("result")) {
				JSONObject json = jsonObject.getJSONObject("result");
				JSONArray jsonArray = new JSONArray(json.getJSONArray("parkInfo"));
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject jsonArray1 = (JSONObject) jsonArray.getJSONObject(i);
					parkingInformation.setAdr(jsonArray1.getString("adr"));
					parkingInformation.setBte(jsonArray1.getString("bte"));
					parkingInformation.setEte(jsonArray1.getString("ete"));
					parkingInformation.setLat(jsonArray1.getString("lat"));
					parkingInformation.setLon(jsonArray1.getString("lon"));
					parkingInformation.setParkMins(jsonArray1.getString("parkMins"));
					
				}
				return parkingInformation;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 车辆里程查询接口
	 * 基于中交兴路智能transmap-mileage算法，本接口提供指定车牌号、指定时间段查询车辆实际行驶里程信息，开始时间和结束时间不能超过24小时。
	 * 
	 * @param vclN
	 *            车牌号
	 * @param vco
	 *            车牌颜色，1：蓝色；2：黄色
	 * @param qryBtm
	 * @param qryEtm
	 */
	public ParkingInformation vQueryMileage(String token,String vclN, String vco, String qryBtm, String qryEtm) {
		String jsonstr = ZhiyunOpenapi.vQueryMileage(token, vclN, vco, qryBtm, qryEtm);
		parkingInformation = new ParkingInformation();
		
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(!jsonObject.isNull("result")) {
				JSONObject json = jsonObject.getJSONObject("result");
				parkingInformation.setEnd(json.getString("end"));
				parkingInformation.setEndLonLat(json.getString("endLonLat"));
				parkingInformation.setEndTime(json.getString("endTime"));
				parkingInformation.setMileage(json.getString("mileage"));
				parkingInformation.setStart(json.getString("start"));
				parkingInformation.setStartLonLat(json.getString("startLonLat"));
				parkingInformation.setStartTime(json.getString("startTime"));
				
			}
			return parkingInformation;
		} catch (Exception e) {
			e.printStackTrace();
			return parkingInformation;
		}
	
	}
}
