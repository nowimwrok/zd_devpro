package com.thinkgem.jeesite.common.trafficUtils.informationVerification;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;

/**
 * 车主真实性验证接口
 * 
 * @author Shinelon
 *
 */
//@Service
public class CheckOwner {
	

	/**
	 * 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性。
	 * 
	 * @param vclN
	 *            车牌号
	 * @param name
	 *            车主姓名
	 * @param phone
	 *            车主电话
	 */
	public Car checkOwnerByVclNo(String token,String vclN, String name, String phone) {
		Car car = new Car();
		String jsonstr = ZhiyunOpenapi.checkOwnerByVclNo(token, vclN, name, phone);
		JSONObject object = new JSONObject(jsonstr);
		try {
			int status=object.getInt("status");
			if(status==1001) {
				if (object.getString("result").equals("yes")) {
					car.setCheckownerstatus("1");
					return car;
				}
				if (object.getString("result").equals("name")) {
					car.setCheckownerstatus("2");
					return car;
				}
				if (object.getString("result").equals("phone")) {
					car.setCheckownerstatus("3");
					return car;
				}
			}else {
				car.setCheckownerstatus("-1");
			}
			return car;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * 套牌车验证 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性
	 * 
	 * @param vclN
	 *            车牌号
	 * @param area
	 *            区县号
	 */
	public Car checkAreaByVclNo(String token,String vclN, String area) {
		Car car = new Car();
		String jsonstr = ZhiyunOpenapi.checkAreaByVclNo(token, vclN, area);
		try {
			JSONObject json = new JSONObject(jsonstr);
			int status=json.getInt("status");
			if(status==1001) {
				if (json.getString("result").equals("yes")) {
					car.setCheckareastatus("1");
					return car;
				}
				if (json.getString("result").equals("no")) {
					car.setCheckareastatus("2");
					return car;
				}
			}else {
				car.setCheckareastatus("-1");
				return car;
			}
			
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
}
