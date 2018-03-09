package com.thinkgem.jeesite.common.trafficUtils.carEvent;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;

/**
 * 车辆驶入/驶出
 * 
 * @author Shinelon
 *
 */
//@Service
public class Vehicle {


	/**
	 * 自定义区域注册接口 平台实时监控车辆运行轨迹，当车辆驶入预设区域时，平台将车辆驶入事件信息推送到用户数据接收接口。
	 * 
	 * @param vid
	 */
	public  Map<String, Object> areaReg(String token,String areaname, String lonlat, int radius, int type, String actiontype) {
		String jsonstr = ZhiyunOpenapi.areaReg(token, areaname, lonlat, radius, type, actiontype);
		VehicleInformation vehicleInformation = new VehicleInformation();
		int state = DataDic.RAIL_UNKNOWNERROR;
		String message = "";
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			state = jsonObject.getInt("status");
			if(!jsonObject.isNull("result")) {
				JSONObject s = jsonObject.getJSONObject("result");
				vehicleInformation.setAreaid(s.getString("areaid"));
				vehicleInformation.setState(s.getString("state"));
				message = "保存成功";
			}
			return Tools.getMapResult(state, message, vehicleInformation);
		} catch (Exception e) {
			state = DataDic.RAIL_UNKNOWNERROR;
			message = "保存失败";
			return Tools.getMapResult(state, message, vehicleInformation);
		}
	}

	/**
	 * 车辆订阅接口 传入需要订阅的车牌号及自定义区域ID，将为进出自定义区域指定需要通知的车牌号
	 * 
	 * @param areaid
	 * @param vnos
	 */
	public  Map<String, Object> vnoReg(String token,String areaid, String vnos) {
		int state = DataDic.RAIL_UNKNOWNERROR;
		String message = "";
		String jsonstr = ZhiyunOpenapi.vnoReg(token, areaid, vnos);
		JSONObject jsonObject = new JSONObject(jsonstr);
		if(!jsonObject.isNull("result")) {
			if(!jsonObject.isNull("result")){
				message = String.valueOf(jsonObject.get("result"));
				if(message.equals("2")){
					message = "自定义区域id不存在";
				}else{
					message = "订阅成功";
				}
			}else{
				message = "信息为空";
			}
		}
		state = jsonObject.getInt("status");
		
		return Tools.getMapResult(state, message,"");
	}

	/**
	 * 删除车辆订阅接口 传入需要订阅的车牌号及自定义区域ID，将为自定义区域删除订阅的车牌号
	 * 
	 * @param areaid
	 * @param vnos
	 */
	public  Map<String, Object> vnoDel(String token,String areaid, String vnos) {
		String jsonstr = ZhiyunOpenapi.vnoDel(token, areaid, vnos);
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "";
		JSONObject jsonObject = new JSONObject(jsonstr);
		if(!jsonObject.isNull("result")){
			message = String.valueOf(jsonObject.getInt("result"));
			if(message.equals("2")){
				message = "自定义区域id不存在";
				System.out.println(message);
			}else{
				message = "删除成功";
			}
		}else{
			message = "信息为空";
		}
		state = jsonObject.getInt("status");
		return Tools.getMapResult(state, message, null);
	}

	/**
	 * 删除自定义区域接口 传入及自定义区域ID，将为进出自定义区域指定需要通知的车牌号
	 * 
	 * @param areaid
	 */
	public  Map<String, Object> areaDel(String token,String areaid) {
		String jsonstr = ZhiyunOpenapi.areaDel(token, areaid);
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "";
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(!jsonObject.isNull("result")) {
				message = jsonObject.getString("result");
				state = jsonObject.getInt("status");
			}
			return Tools.getMapResult(state, message, "");
		} catch (Exception e) {
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
			return Tools.getMapResult(state, message, "");
		}

	}
	
}
