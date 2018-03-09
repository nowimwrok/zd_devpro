package com.thinkgem.jeesite.common.trafficUtils.informationVerification;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.InfomationDetection;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;

/**
 * 道路运输证(信息)验证
 * 
 * @author Shinelon
 *
 */
//@Service
public class RoadVerification {
	

	/**
	 * 道路运输证验证接口 本接口通过指定车牌号、道路运输证号码，验证道路运输证信息是否准确。
	 * 
	 * @param vclN
	 *            车牌号
	 * @param vco
	 *            车牌颜色 车牌颜色，1：蓝色；2：黄色
	 * @param rtcNo
	 *            道路运输证号码
	 */
	public Userinfo checkRTCNo(String token,String vclN, String vco, String rtcNo) {
		Userinfo userinfo = new Userinfo();
		String jsonstr = ZhiyunOpenapi.checkRTCNo(token, vclN, vco, rtcNo);
		try {

			JSONObject json = new JSONObject(jsonstr);
			if (json.isNull("result")) {
				return null;
			}
			if (json.getString("result").equals("yes")) {
				userinfo.setRoadcertificate("1");
				return userinfo;
			}
			if (json.getString("result").equals("no")) {
				userinfo.setRoadcertificate("2");
				return userinfo;
			}
			if (json.getString("result").equals("unknown")) {
				userinfo.setRoadcertificate("3");
				return userinfo;
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * 道路运输证查询接口 本接口通过指定车牌号、车牌颜色查询道路运输证号码及有效期等信息。
	 * 
	 * @param vclN
	 *            车牌号
	 * @param vco
	 *            车牌颜色 车牌颜色，1：蓝色；2：黄色
	 */
	public InfomationDetection vQueryRTCNo(String token,String vclN, String vco) {
		InfomationDetection infomation = new InfomationDetection();
		String jsonstr = ZhiyunOpenapi.vQueryRTCNo(token, vclN, vco);
		JSONObject json = new JSONObject(jsonstr);
		int status=json.getInt("status");
		try {
			if (status!=1001) {
				infomation.setStatus(status);
				return infomation;
			}
			infomation.setStatus(json.getInt("status"));
			JSONObject jsonreult = json.getJSONObject("result");
			infomation.setRoadTransport(jsonreult.getString("roadTransport"));
			infomation.setVdtTm(jsonreult.getString("vdtTm"));
			return infomation;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

}
