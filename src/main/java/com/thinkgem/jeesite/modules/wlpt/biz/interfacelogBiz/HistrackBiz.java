package com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;
import com.thinkgem.jeesite.common.trafficUtils.locationInformation.VHisTrack;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.gps.GpsInfoBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;

@Service
public class HistrackBiz {
	@Autowired
	private InterfaceLogBiz interfacelogbiz;
	@Autowired
	private GpsCarInfoService carInfoService;
	@Autowired
	private ConsumeRecodBiz consumebiz;
	@Autowired
	private GpsInfoBiz gpsInfoBiz;
	

	/**
	 * 车牌号查定位轨迹
	 * 
	 * @param vclN
	 * @param beginTime  开始时间
	 * @param endTimes   结束时间
	 * @param authentication 是否收费
	 * @return
	 * @throws ParseException
	 */
	@Transactional(readOnly = false)
	public Object vclnHist(String vclN, String beginTime,String endTimes,String authentication) {


		InterfaceToken interfacetoken = interfacelogbiz.interfacetokens();
		String token = interfacetoken.getToken();
		Map<String, Object> map = new HashMap<String, Object>();
		List<VehicleInformation> list = new ArrayList<>();
		List<Map<String, Object>> mapListJson = new ArrayList<>();
		User curUser = UserUtils.getUser(); // 获取当前用户
		String price = "查询成功";
		
		// 收费
		String user_id = curUser.getId();
		int state=DataDic.INFACESSOURCE_ZJXL_INT;
		String message="";
		price = DictUtils.getMsgLabel(DataDic.ZJXL_HISTRACK, "zjxl_port", "");

		Date newdate;
		String endTime="";
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 北斗接口目前只能查询24小时内的轨迹，所以取运单生成的时间加上24小时作为查询条件
		try {
			newdate = formatDate.parse(beginTime);
			Long nowValue = newdate.getTime();
			Long afterHour = nowValue + 23 * 60 * 60 * 1000;
			endTime = formatDate.format(new Date(afterHour));
		} catch (Exception e) {
			
		}
		mapListJson = (List<Map<String, Object>>) gpsInfoBiz.getTrackList(vclN, beginTime, endTimes);
		if (mapListJson != null && !mapListJson.isEmpty()) {
			message="永奎查询结果";
			interfacelogbiz.addBiz(curUser, DataDic.YONGKUI_TRACK, DataDic.INTERFACE_YONGKUIG,
					DataDic.INFACESSOURCE_YONGKUI, DataDic.INFORMATION_YES, price);
			state=DataDic.INFACESSOURCE_LBS_INT;
			map.put("mapListJson", mapListJson);

		} else {
			try {
				Date begDate = formatDate.parse(beginTime);
				Date edDate = formatDate.parse(endTimes);
				long beglong = begDate.getTime();
				long edlong = edDate.getTime();
				//判断该记录未超过24小时
				if( (edlong - beglong) > 24*60*60*1000 ){
					state=DataDic.ZJXL_RAILBUG;
					message = "超过24小时后，不能进行轨迹查询动作。";
					authentication = DataDic.INFORMATION_NO;
					return Tools.getMapResult(state, message, map);
				}
			}catch (Exception e){

			}
			// 车辆轨迹查询（车牌号）
			price = DictUtils.getMsgLabel(DataDic.ZJXL_HISTRACK, "zjxl_port", "");
			VHisTrack vhis = new VHisTrack();

			list = vhis.vHisTrack24(token, vclN, beginTime, endTime);
			//字符串转为Date

			if (list.size() > 0) {

				map.put("TrackVcl", list); // 北斗接口是否查询到都记录并扣费
				interfacelogbiz.addBiz(curUser, DataDic.ZJXL_HISTRACK, "车辆轨迹查询(车牌号)", DataDic.INFACESSOURCE_ZJXL,
						DataDic.INFORMATION_YES, price);
				message="中交兴路查询到结果";
			} else {
				message="中交兴路未查询到结果";
				interfacelogbiz.addBiz(curUser, DataDic.ZJXL_HISTRACK, "车辆轨迹查询(车牌号)", DataDic.INFACESSOURCE_ZJXL,
						DataDic.INFORMATION_NO, price);
			}

		}
		if(authentication.equals(DataDic.INFORMATION_YES)) {
			int underbalance = consumebiz.payGPSLocationBiz(user_id, Double.parseDouble(price), DataDic.INTERFACE_ZJXLG);
			if (underbalance == DataDic.RETURN_STATUS_MONEYBUG) { // 余额不足，不进行查询操作
				state=DataDic.RETURN_STATUS_MONEYBUG;
				message="账户可用余额不足";
				return Tools.getMapResult(state, message, map);
			}
		}
		return Tools.getMapResult(state, message, map);
	}

	/**
	 * 车架号查询车辆轨迹信息
	 * 
	 * @param vin
	 * @param date1
	 * @param date2
	 * @return
	 * @throws ParseException
	 */
	@Transactional(readOnly = false)
	public Object vinHist(String vin, String beginTime, String endtime,String authentication) throws ParseException {
		InterfaceToken interfacetoken = interfacelogbiz.interfacetokens();
		String token = interfacetoken.getToken();
		Map<String, Object> map = new HashMap<String, Object>();
		List<VehicleInformation> list = new ArrayList<>();
		User curUser = UserUtils.getUser(); // 获取当前用户
		String user_id = curUser.getId();
		// 车辆轨迹查询（vin车架号）
		int state=DataDic.INFACESSOURCE_ZJXL_INT;
		String message="";
		String price = DictUtils.getMsgLabel(DataDic.ZJXL_TRACKVIN, "zjxl_port", "");
		if(authentication.equals(DataDic.INFORMATION_YES)) {
			
			int underbalance = consumebiz.payGPSLocationBiz(user_id, Double.parseDouble(price), DataDic.INTERFACE_ZJXLG);
			if (underbalance == DataDic.RETURN_STATUS_MONEYBUG) { // 余额不足，不进行查询操作
				state=DataDic.RETURN_STATUS_MONEYBUG;
				message="账户可用余额不足";
				return Tools.getMapResult(state, message, map);
			}
		}
		VHisTrack vhis = new VHisTrack();
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 北斗接口目前只能查询24小时内的轨迹，所以取运单生成的时间加上24小时作为查询条件
		Date newdate = formatDate.parse(beginTime);
		Long nowValue = newdate.getTime();
		Long afterHour = nowValue + 23 * 60 * 60 * 1000;
		String endTime = formatDate.format(new Date(afterHour));
		list = vhis.vHisTrackVin24(token, vin, beginTime, endTime);
		if (list.size() > 0) {
			map.put("TrackVin", list); // 北斗接口是否查询到都记录并扣费
			interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRACKVIN, "车辆轨迹查询(vin号)", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_YES, price);
		} else {
			interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRACKVIN, "车辆轨迹查询(vin号)", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_NO, price);
		}

		return map;
	}

}
