package com.thinkgem.jeesite.common.trafficUtils.locationInformation;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;

/**
 * 车辆轨迹查询（车牌号,vin车架号）接口
 * 
 * @author Shinelon
 *
 */
//@Service
public class VHisTrack {

	/**
	 * 车辆轨迹查询（车牌号）接口 本接口提供指定车牌号，指定时间段查询车辆的轨迹服务，单次查询时间段范围不能超过24小时。
	 * 
	 * @param vclN
	 *            车牌号
	 * @param date1
	 *            开始的时间
	 * @param date2
	 *            结束的时间
	 */
	public  List<VehicleInformation> vHisTrack24(String token,String vclN, String date1, String date2) {
		String jsonstr = ZhiyunOpenapi.vHisTrack24(token, vclN, date1, date2);
		List<VehicleInformation> list=new ArrayList<>();
		try {


			JSONObject jsonObject = new JSONObject(jsonstr);//北斗接口返回json数据，解析存入对象之中result是信息state是状态码
			if(jsonObject.isNull("result")) {
				return list;
			}
			JSONArray jsonArr = jsonObject.getJSONArray("result");
			int jsonSize = jsonArr.length();
			for (int i = 0; i < jsonSize; i++) {
				JSONObject s = (JSONObject) jsonArr.getJSONObject(i);
				VehicleInformation vehicleInformation = new VehicleInformation();
				vehicleInformation.setLat(s.getString("lat"));
				vehicleInformation.setLon(s.getString("lon"));
				vehicleInformation.setGtm(s.getString("gtm"));
				vehicleInformation.setSpd(s.getString("spd"));
				vehicleInformation.setMlg(s.getString("mlg"));
				vehicleInformation.setHgt(s.getString("hgt"));
				vehicleInformation.setAgl(s.getString("agl"));
				
				list.add(vehicleInformation);
			}
			System.out.println(list);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return list;
		}

	}

	/**
	 * 车辆轨迹查询（vin车架号）接口 本接口提供指定vin车架号，指定时间段查询车辆的轨迹服务，单次查询时间段范围不能超过24小时。
	 * 
	 * @param vin
	 *            车架号
	 * @param date1
	 *            开始的时间
	 * @param date2
	 *            结束的时间
	 */
	public  List<VehicleInformation> vHisTrackVin24(String token,String vin, String date1, String date2) {
		String jsonstr = ZhiyunOpenapi.vHisTrackVin24(token, vin, date1, date2);
		VehicleInformation vpInformation = new VehicleInformation();
		List<VehicleInformation> list=new ArrayList<>();
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);                    //北斗接口返回json数据，解析存入对象之中result是信息state是状态码
			if(jsonObject.isNull("result")) {
				return list;
			}
			JSONArray jsonArr = jsonObject.getJSONArray("result");
			int jsonSize = jsonArr.length();
			for (int i = 0; i < jsonSize; i++) {
				JSONObject s = (JSONObject) jsonArr.getJSONObject(i);
				
				vpInformation.setLat(s.getString("lat"));
				vpInformation.setLon(s.getString("lon"));
				vpInformation.setGtm(s.getString("gtm"));
				vpInformation.setSpd(s.getString("spd"));
				vpInformation.setMlg(s.getString("mlg"));
				vpInformation.setHgt(s.getString("hgt"));
				vpInformation.setAgl(s.getString("agl"));
				list.add(vpInformation);
			}
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		}

	}
	
	

}
