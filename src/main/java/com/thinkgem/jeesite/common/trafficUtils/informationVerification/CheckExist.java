package com.thinkgem.jeesite.common.trafficUtils.informationVerification;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;

/**
 * 车辆验证接口
 * 
 * @author Shinelon
 *
 */
//@Service
public class CheckExist {
	
	
	/**
	 * 车辆入网验证 提供按车牌号判断指定车辆是否在全国货运平台入网服务
	 * 
	 * @param vclN
	 *            车牌号checkTruckExist
	 */

	public Car checkVehicleExist(String token,String vclN) {
		Car car = new Car();
		String jsonstr = ZhiyunOpenapi.checkTruckExist(token, vclN);
		try {
			
			JSONObject json = new JSONObject(jsonstr);
			
			if(json.isNull("result")) {
				
				return null;
			}
			if (json.getString("result").equals("yes")) {
				car.setChecktruckstatus("1");
				return car;
			}
			if (json.getString("result").equals("no")) {
				car.setChecktruckstatus("-1");
				return car;
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 车辆确认接口 本接口提供指定车牌号的车辆查询，验证车辆是否存在，存在则返回最后定位时间
	 * 
	 * @param vclN
	 *            车牌号
	 */
	public String checkTruckExist(String token,String vclN) {
		String jsonstr=ZhiyunOpenapi.checkVehicleExist(token, vclN);
		try {
			JSONObject json = new JSONObject(jsonstr);
			int status=(int) json.get("status");
			if(status==1001) {
				String result=(String) json.get("result");
				if(!result.equals("no")) {
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					long lt = Long.parseLong((String) json.get("result"));
					Date date = new Date(lt);
					return simpleDateFormat.format(date);
				}else {
					
					return "-1";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "-1";

	}


}
