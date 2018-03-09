package com.thinkgem.jeesite.common.trafficUtils.geographicInversion;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleEvent;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;

/**
 * 逆地理信息查询接口
 * @author Shinelon
 *
 */
//@Service
public class InverseQuery {
	
	/**
	 * 逆地理信息查询接口
	 * 本接口提供传入经纬度及坐标系类型来查询地址。
	 * @param lon      经度d
	 * @param lat      纬度
	 * @param type     坐标类型	传入的经纬度坐标系类型。1:84坐标系  2：TransMap坐标系  3：百度坐标系4：谷歌坐标系	5：高德坐标系  
	 */
	public VehicleEvent decodeAddress(String token,String lon,String lat,String type) {
		VehicleEvent vehicleEvent=new VehicleEvent();
		String jsonstr=ZhiyunOpenapi.decodeAddress(token, lon, lat, type);
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(!jsonObject.isNull("result")) {
				JSONObject s= jsonObject.getJSONObject("result");
				vehicleEvent.setPor(s.getString("por"));
				vehicleEvent.setCit(s.getString("cit"));
				vehicleEvent.setCou(s.getString("cou"));
				vehicleEvent.setDes(s.getString("des"));
			}
			return vehicleEvent;
		} catch (Exception e) {
			e.printStackTrace();
			return vehicleEvent;
		}
		
	}
	
}
