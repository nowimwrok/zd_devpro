package com.thinkgem.jeesite.common.trafficUtils.findCarDelivery;

import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.GoodsRelease;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.Travelinformation;

/**
 * 找车接口
 * 
 * @author Shinelon
 *
 */
//@Service
public class Query {
	
	/**
	 * 多维度找车 提供按始发地、目的地、周边距离、货物位置、常运货物类型、车辆类型、车长、载重等信息进行精细化找车查询服务
	 * 本接口提供按照车型、车长、载重、起始地、目的地、多维度查询指定经纬度坐标点为中心查询指定公里范围内的前50辆在线车辆。
	 * 
	 * @param lon
	 *            经度
	 * @param lat
	 *            纬度
	 * @param type
	 *            车辆类型
	 */
	public Map<String, Object> queryVclByMulFs(String token,String lon, String lat,String type) {
		String jsonstr = ZhiyunOpenapi.queryVclByMulFs(token, lon, lat, type);
		String message = "查询成功";
		int state = DataDic.RETURN_STATUS_NORMAL;
		GoodsRelease release = new GoodsRelease();
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			if (jsonObject.isNull("result")) {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "查询失败";
				return Tools.getMapResult(state, message, release);
			}
			if (jsonObject.has("result")) {
				JSONArray jsonObjects = jsonObject.getJSONArray("result");
				System.out.println(jsonObjects);
				for (int i = 0; i < jsonObjects.length(); i++) {
					JSONObject s = jsonObjects.getJSONObject(i);
					release.setVid(s.getString("vid"));
					release.setVno(s.getString("vno"));
					release.setVco(s.getString("vco"));
					release.setUtc(s.getString("utc"));
					release.setLon(s.getString("lon"));
					release.setLat(s.getString("lat"));
					release.setVcltype(s.getString("vcltype"));
					release.setImg(s.getString("img"));
					release.setVehicleLength(s.getString("vehicleLength"));
				}

			}

			return Tools.getMapResult(state, message, release);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
			return Tools.getMapResult(state, message, release);
		}

	}

	/**
	 * 车辆ID获取车主信息 本接口提供按照车辆ID查询对应车主信息。
	 * 
	 * @param vid
	 *            车辆ID
	 */
	public Map<String, Object> queryInfoByVid(String token,String vid) {
		String jsonstr = ZhiyunOpenapi.queryInfoByVid(token, vid);

		String message = "查询成功";
		GoodsRelease release = new GoodsRelease();
		JSONObject jsonObject = new JSONObject(jsonstr);
		int status = jsonObject.getInt("status");

		try {
			if (status!=1001) {
				status = DataDic.RETURN_STATUS_SYSBUG;
				message = "查询失败";
				return Tools.getMapResult(status, message, release);
			}

			if (status==1001) {
				JSONObject jsonObjects = jsonObject.getJSONObject("result");
				release.setVehicleno(jsonObjects.getString("vehicleno"));
				release.setPlatecolorid(jsonObjects.getString("platecolorid"));
				release.setVehicleOwnerName(jsonObjects.getString("vehicleOwnerName"));
				release.setVehicleOwnerPhone(jsonObjects.getString("vehicleOwnerPhone"));

			}

			return Tools.getMapResult(status, message, release);

		} catch (Exception e) {
			e.printStackTrace();
			status = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
			return Tools.getMapResult(status, message, release);
		}

	}

	/**
	 * 车辆行驶证信息查询接口
	 * 
	 * @param vclN
	 *            车牌号
	 * @param vco
	 *            车颜色1：蓝色；2：黄色
	 * @return 车辆行驶信息
	 */
	public Map<String, Object> vQueryLicense(String token,String vclN, String vco) {
		String jsonstr = ZhiyunOpenapi.vQueryLicense(token, vclN, vco);
		String message = "查询成功";
		int state = DataDic.RETURN_STATUS_NORMAL;
		Travelinformation infomation = new Travelinformation();
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			int status =(int) jsonObject.get("status");
			if (status!=1001) {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "查询失败";
				return Tools.getMapResult(status, message, null);
			}
			if (status==1001) {
				JSONObject jsonObjects = jsonObject.getJSONObject("result");
				infomation.setVclN(vclN);
				infomation.setVclWnrNm(jsonObjects.getString("vclWnrNm"));
				infomation.setVclWnrPhn(jsonObjects.getString("vclWnrPhn"));
				infomation.setAreaName(jsonObjects.getString("areaName"));
				infomation.setVclTpNm(jsonObjects.getString("vclTpNm"));
				infomation.setVbrndCdNm(jsonObjects.getString("vbrndCdNm"));
				infomation.setPrdCdNm(jsonObjects.getString("prdCdNm"));
				infomation.setCmpNm(jsonObjects.getString("cmpNm"));
				infomation.setVin(jsonObjects.getString("vin"));
				infomation.setVclTn(jsonObjects.getString("vclTn"));
				infomation.setLdTn(jsonObjects.getString("ldTn"));
				infomation.setVclDrwTn(jsonObjects.getString("vclDrwTn"));
				infomation.setVclLng(jsonObjects.getString("vclLng"));
				infomation.setVclWdt(jsonObjects.getString("vclWdt"));
				infomation.setVclHgt(jsonObjects.getString("vclHgt"));
				infomation.setBoxLng(jsonObjects.getString("boxLng"));
				infomation.setBoxWdt(jsonObjects.getString("boxWdt"));
				infomation.setBoxHgt(jsonObjects.getString("boxHgt"));
				infomation.setServiceName(jsonObjects.getString("serviceName"));
				infomation.setServicePhone(jsonObjects.getString("servicePhone"));
			}
			return Tools.getMapResult(status, message, infomation);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
			return Tools.getMapResult(state, message, null);
		}

	}

}
