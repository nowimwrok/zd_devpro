package com.thinkgem.jeesite.common.trafficUtils.carEvent;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleEvent;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
//@Service
public class SendMessage {
	
	/**
	 * 下发车机信息接口
	 * 本接口通过指定车牌号、指定消息内容向目标车辆的车机上发送消息通知，车机最终以语音播报的方式通知车主或司机。
	 * @param vclN  车牌号
	 * @param vco   车牌颜色	1是蓝色，2是黄色
	 * @param type  信息类型	1.广告信息；2.货源信息；3.找车信息；4.业务提醒；5.路况信息；6.调度提醒；7.天气情况；8.警示提醒；（如果没有你需要的类型，请联系我们提交申请）
	 * @param info  下发的文本内容	单条不超过100个字符
	 */
	public  VehicleEvent sendMessageByVclNo(String token,String vclN,String vco, String type,String info) {
		VehicleEvent vehicleEvent=new VehicleEvent();
		String jsonstr= ZhiyunOpenapi.sendMessageByVclNo(token,vclN, vco, type, info);
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(!jsonObject.isNull("result")) {
				JSONObject s= jsonObject.getJSONObject("result");	
				vehicleEvent.setState(s.getString("state"));
				vehicleEvent.setUtc(s.getString("utc"));
			}
			return vehicleEvent;
		} catch (Exception e) {
			e.printStackTrace();
			return vehicleEvent;
		}
		
	}
	
	
}
