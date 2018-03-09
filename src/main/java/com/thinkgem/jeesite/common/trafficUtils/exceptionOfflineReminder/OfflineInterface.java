package com.thinkgem.jeesite.common.trafficUtils.exceptionOfflineReminder;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.ReturnValidation;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;

/**
 * 异常离线提示
 * @author Shinelon
 *
 */
//@Service
public class OfflineInterface {
	
	
	
	/**
	 * 离线车辆注册接口
	 * 平台实时监控车辆运行情况，当车辆离线时长达到预设阀值时，平台将车辆异常离线状态数据推送到用户数据接收接口。
	 * 传入需要订阅的离线车牌号
	 * @param vnos
	 */
	public  Map<String,Object> vnoOutReg(String token,String vnos) {
		ReturnValidation returnValidation=new ReturnValidation();
		String jsonstr= ZhiyunOpenapi.vnoOutReg(token, vnos);
		JSONObject json=new JSONObject(jsonstr);
		int state=DataDic.RETURN_STATUS_NORMAL;
		String message="查询成功";
		try {
			if(json.isNull("result")) {
				state=DataDic.RETURN_STATUS_SYSBUG;
				message="查询失败";
				return Tools.getMapResult(state, message,"");
			}	
			returnValidation.setResult(json.getString("result"));
			returnValidation.setStatus(json.getInt("status"));
			return Tools.getMapResult(state, message,returnValidation);
		} catch (Exception e) {
			e.printStackTrace();
			state=DataDic.RETURN_STATUS_SYSBUG;
			message="查询查询失败";
			return Tools.getMapResult(state,message,"");
		}
		
	}
	/**
	 * 删除离线车辆订阅接口
	 * 平台实时监控车辆运行情况，当车辆离线时长达到预设阀值时，平台将车辆异常离线状态数据推送到用户数据接收接口。
	 * @param vnos
	 */
	public  Map<String,Object> vnoOutDel(String token,String vnos) {
		ReturnValidation returnValidation=new ReturnValidation();
		String jsonstr=ZhiyunOpenapi.vnoOutDel(token, vnos);
		JSONObject json=new JSONObject(jsonstr);
		int state=DataDic.RETURN_STATUS_NORMAL;
		String message="查询成功";
		try {
			if(json.isNull("result")) {
				state=DataDic.RETURN_STATUS_SYSBUG;
				message="查询失败";
				return Tools.getMapResult(state, message,"");
			}	
			returnValidation.setResult(json.getString("result"));
			returnValidation.setStatus(json.getInt("status"));
			return Tools.getMapResult(state, message,returnValidation);
		} catch (Exception e) {
			e.printStackTrace();
			state=DataDic.RETURN_STATUS_SYSBUG;
			message="查询查询失败";
			return Tools.getMapResult(state,message,"");
		}
		
	}
	
	
}
