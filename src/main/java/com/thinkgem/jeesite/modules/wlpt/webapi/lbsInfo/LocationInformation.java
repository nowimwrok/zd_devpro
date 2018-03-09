package com.thinkgem.jeesite.modules.wlpt.webapi.lbsInfo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.entity.ParkingInformation;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleEvent;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;

import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.PositionInformationService;

/**
 * 车辆位置查询类
 * 
 * @author Shinelon
 *
 */

@Controller
// @RequestMapping()
public class LocationInformation extends BaseController {

	// 通过车牌号获取最新地理位置信息
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> lastLocation(String vclN, String timeNearby) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		VehicleInformation vpInformation = new VehicleInformation();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			vpInformation = positionIService.getLastLocation(vclN, timeNearby);
			return Tools.getMapResult(state, message, vpInformation);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}
		return Tools.getMapResult(state, message, null);

	}

	// 通过车架号取最新地理位置信息
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> lastLocationVin(String vin,String timeNearby) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		VehicleInformation vpInformation = new VehicleInformation();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			vpInformation = positionIService.getLastLocationVin(vin, timeNearby);

			return Tools.getMapResult(state, message, vpInformation);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}
		return Tools.getMapResult(state, message, null);
	}

	// 通过多个车牌号获取多个最新地理位置信息
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> lastLocationMulti(String vclNs,String timeNearby) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		List<VehicleInformation> vpInformation =new ArrayList<VehicleInformation>();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			vpInformation = positionIService.getLastLocationMulti(vclNs, timeNearby);
			System.out.println(vpInformation);
			if (vpInformation == null) {
				message = "无结果";
				return Tools.getMapResult(state, message, null);
			}
			return Tools.getMapResult(state, message, vpInformation);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}
		return Tools.getMapResult(state, message, null);
	}

	// 指定时间段查询车的地理位置(车牌号)
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> HisTrack24(String vclN, String date1,String date2) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		List<VehicleInformation> vpInformation =new ArrayList<VehicleInformation>();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			vpInformation = positionIService.getVHisTrack(vclN, date1, date2);
			return Tools.getMapResult(state, message, vpInformation);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}

		return Tools.getMapResult(state, message, null);
	}

	// 指定时间段查询车的地理位置(车架号)
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> HisTrackVin24(String vin,String date1,String date2) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		List<VehicleInformation> vpInformation =new ArrayList<VehicleInformation>();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			vpInformation = positionIService.getvHisTrackVin(vin, date1, date2);
			return Tools.getMapResult(state, message, vpInformation);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}

		return Tools.getMapResult(state, message, null);
	}

	// 逆地理位置查询
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> decodeAddress(String lon, String lat,String type) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		VehicleEvent vehicleEvent = new VehicleEvent();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			vehicleEvent = positionIService.getdecodeAddress(lon, lat, type);
			return Tools.getMapResult(state, message, vehicleEvent);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}
		return Tools.getMapResult(state, message, null);
	}

	// 指定时间段停车信息查询
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> vQueryPark(String vclN, String vco, String qryBtm, String qryEtm, String parkMins) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		ParkingInformation parkingInformation = new ParkingInformation();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			parkingInformation = positionIService.getvQueryPark(vclN, vco, qryBtm, qryEtm, parkMins);
			return Tools.getMapResult(state, message, parkingInformation);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}
		return Tools.getMapResult(state, message, null);
	}

	// 指定时间段里程查询
	// @RequestMapping()
	@ResponseBody
	public Map<String, Object> vQueryMileage(String vclN, String vco, String qryBtm, String qryEtm) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "查询成功";
		ParkingInformation parkingInformation = new ParkingInformation();
		PositionInformationService positionIService = new PositionInformationService();
		try {
			parkingInformation = positionIService.getvQueryMileage(vclN, vco, qryBtm, qryEtm);
			return Tools.getMapResult(state, message, parkingInformation);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询失败";
		}
		return Tools.getMapResult(state, message, null);
	}

}
