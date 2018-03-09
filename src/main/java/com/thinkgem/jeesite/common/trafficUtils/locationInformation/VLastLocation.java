package com.thinkgem.jeesite.common.trafficUtils.locationInformation;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;

/**
 * 通过车牌(车架号)查询实时位置
 * 
 * @author Shinelon
 *
 */
//@Service
public class VLastLocation {
	

	private VehicleInformation vpInformation;

	/**
	 * 通过车牌号查车辆最新位置
	 * 
	 * @param vclN
	 *            车牌号
	 */
	public VehicleInformation vLastLocation(String token,String vclN,String timeNearby) {
		
		String jsonstr = ZhiyunOpenapi.vLastLocation(token, vclN, timeNearby);
		vpInformation = new VehicleInformation();
		try {
			
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(jsonObject.isNull("result")) {
				return vpInformation;
			}
				JSONObject s = jsonObject.getJSONObject("result");
				vpInformation.setAdr(s.getString("adr"));
				vpInformation.setDrc(s.getString("drc"));
				vpInformation.setLat(s.getString("lat"));
				vpInformation.setLon(s.getString("lon"));
				vpInformation.setSpd(s.getString("spd"));
				vpInformation.setUtc(s.getString("utc"));
			
			return vpInformation;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * 通过车架vin号查看车的位置 本接口提供指定vin车架号的车辆最新位置查询。
	 * 
	 * @param vin
	 *            车架号
	 */
	public VehicleInformation vLastLocationVin(String token,String vin, String timeNearby) {
		String jsonstr = ZhiyunOpenapi.vLastLocationVin(token, vin, timeNearby);
		vpInformation = new VehicleInformation();
		try {
			
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(jsonObject.isNull("result")) {
				return vpInformation;
			}
			
				JSONObject s = jsonObject.getJSONObject("result");
				vpInformation.setAdr(s.getString("adr"));
				vpInformation.setDrc(s.getString("drc"));
				vpInformation.setLat(s.getString("lat"));
				vpInformation.setLon(s.getString("lon"));
				vpInformation.setSpd(s.getString("spd"));
				vpInformation.setUtc(s.getString("utc"));

			
			return vpInformation;
		} catch (Exception e) {
			e.printStackTrace();
			return vpInformation;
		}

	}

	/**
	 * 查询(通过车牌号)多辆车的位置 在地图上可实时查看车机上报的车辆最新位置信息，包括经纬度、速度、方向、ACC状态等信息。
	 * 本接口提供指定多个车牌号的车辆最新位置查询，车牌号与车牌号之间以半角逗号连接,车牌号最大不超过100个。
	 * 
	 * @param vclNs
	 *            多个车牌号
	 */
	public List<VehicleInformation> vLastLocationMulti(String token,String vclNs, String timeNearby) {
		String jsonstr = ZhiyunOpenapi.vLastLocationMulti(token, vclNs, timeNearby);
		vpInformation = new VehicleInformation();
		List<VehicleInformation> list=new ArrayList<>();
		try {
			JSONObject jsonObj = new JSONObject(jsonstr);
			if(jsonObj.isNull("result")) {
				return list;
			}
			JSONArray jsonArr = jsonObj.getJSONArray("result");
			int jsonSize = jsonArr.length();
			for (int i = 0; i < jsonSize; i++) {
				JSONObject json = (JSONObject) jsonArr.getJSONObject(i);
				vpInformation.setVno(json.getString("vno"));
				vpInformation.setAdr(json.getString("adr"));
				vpInformation.setDrc(json.getString("drc"));
				vpInformation.setLat(json.getString("lat"));
				vpInformation.setLon(json.getString("lon"));
				vpInformation.setSpd(json.getString("spd"));
				vpInformation.setUtc(json.getString("utc"));
				list.add(vpInformation);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return list;

		}
	}
	
}
