package com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;
import com.thinkgem.jeesite.common.trafficUtils.locationInformation.VLastLocation;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.gps.GpsInfoBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarLocsService;

@Service
public class LocationBiz {
	@Autowired
	private InterfaceLogBiz interfacelogbiz;

	@Autowired
	private ConsumeRecodBiz consumebiz;

	@Autowired
	private GpsCarLocsService carlocsService;	
	@Autowired
	private GpsCarInfoService carInfoService;
	@Autowired
	private GpsInfoBiz gpsInfoBiz;

	/**
	 * 车牌号位置查询
	 * 
	 * @param vclN   车牌号
	 * @param timeNearby  时间（小时）
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> vclnLocation(String vclN, String timeNearby,String authentication) {
		InterfaceToken interfacetoken = interfacelogbiz.interfacetokens();
		String token = interfacetoken.getToken();
		Map<String, Object> map = new HashMap<String, Object>();
		VehicleInformation vpIn = new VehicleInformation();
		String price = "";
		User curUser = UserUtils.getUser(); // 获取当前用户
		List<GpsCarInfo> gpsCars = new ArrayList<>();
		List<Map<String, Object>> mapListJson = new ArrayList<>();
		int state=DataDic.NO_INT;
		if(authentication.equals(DataDic.INFORMATION_YES)) {// 1是用户收费，0是管理者， 不收费
			// 收费
			String user_id = curUser.getId();
			price = DictUtils.getMsgLabel(DataDic.ZJXL_LASTlOCATION, "zjxl_port", "");                                      //从数据字典中获取价格
			int underbalance = consumebiz.payGPSLocationBiz(user_id, Double.parseDouble(price), DataDic.INTERFACE_ZJXLD);
			if (underbalance == DataDic.RETURN_STATUS_MONEYBUG) { // 余额不足，不进行查询操作
				state=DataDic.RETURN_STATUS_MONEYBUG;
				return Tools.getMapResult(state,"用户余额不足",map);
			}
		}else {
			//管理者后台调用不收费之记录日志
		}
		List<String> gpslist = new ArrayList<>();
		mapListJson = (List<Map<String, Object>>) gpsInfoBiz.getNewTrackInof(vclN);
		System.out.println(mapListJson);
		if (mapListJson != null && !mapListJson.isEmpty()) {                                //永奎接口查询到数据，把数据更新到车辆位置信息表中，因为jeesite所带的save方法存在问题，所以自己判断插入还是更新
			state=DataDic.INFACESSOURCE_LBS_INT;
			map.put("mapListJson",mapListJson);
			for (Map<String, Object> listmap : mapListJson) {
					GpsCarLocs carlocs = new GpsCarLocs();
					carlocs.setName(vclN);
					GpsCarLocs carlocsnum = carlocsService.get(carlocs);
					carlocs.setSpeed((String)listmap.get("SPEED"));
					carlocs.setDirect((String)listmap.get("DIRECTION"));
					carlocs.setLat((String)listmap.get("DEF_X"));
					carlocs.setLng((String)listmap.get("DEF_Y"));
					if (carlocsnum==null || null == carlocsnum.getName()) {
						String maxid = carlocsService.getmaxid();
						int id = Integer.parseInt(maxid);
						id++;
						String strid = Integer.toString(id);
						carlocs.setIsNewRecord(true);
						carlocs.setId(strid);
						//carlocs.setGpstime((String)listmap.get("DRIVING_STATE"));
						carlocsService.insert(carlocs);
					} else {
						carlocs.setId(carlocsnum.getId());
						carlocsService.update(carlocs);
					}
				
			}
			interfacelogbiz.addBiz(curUser, DataDic.YONGKUI_LOCATION, DataDic.INTERFACE_YONGKUID,
					DataDic.INFACESSOURCE_YONGKUI, DataDic.INFORMATION_YES, price);
		} else {

			VLastLocation vlast = new VLastLocation();
			vpIn = vlast.vLastLocation(token, vclN, timeNearby);
			state=DataDic.INFACESSOURCE_ZJXL_INT;
			if (vpIn != null&& vpIn.getAdr()!=null) {
				map.put("LocationVcln", vpIn);
				interfacelogbiz.addBiz(curUser, DataDic.ZJXL_LASTlOCATION, "车辆最新位置(车牌号)", DataDic.INFACESSOURCE_ZJXL,
						DataDic.INFORMATION_YES, price);
				GpsCarLocs carlocs = new GpsCarLocs();
				carlocs.setName(vclN);
				GpsCarLocs carlocsnum = carlocsService.get(carlocs);
				if (carlocsnum == null) {                           //北斗接口查询到数据，把数据更新到车辆位置信息表中，因为jeesite所带的save方法存在问题，所以自己判断插入还是更新
					String maxid = carlocsService.getmaxid();
					int id = Integer.parseInt(maxid);
					id++;
					String strid = Integer.toString(id);
					carlocs.setIsNewRecord(true);
					carlocs.setId(strid);
					carlocs.setSpeed(vpIn.getSpd());
					carlocs.setDirect(vpIn.getDrc());
					carlocs.setInfo(vpIn.getAdr());
					carlocs.setLat(vpIn.getLat());
					carlocs.setLng(vpIn.getLon());
					carlocs.setGpstime(vpIn.getUtc());
					carlocsService.insert(carlocs);

				} else {
					carlocs.setId(carlocsnum.getId());
					carlocs.setSpeed(vpIn.getSpd());
					carlocs.setDirect(vpIn.getDrc());
					carlocs.setInfo(vpIn.getAdr());
					carlocs.setLat(vpIn.getLat());
					carlocs.setLng(vpIn.getLon());
					carlocs.setGpstime(vpIn.getUtc());
					carlocsService.update(carlocs);
				}
			} else {
				interfacelogbiz.addBiz(curUser, DataDic.ZJXL_LASTlOCATION, "车辆最新位置(车牌号)", DataDic.INFACESSOURCE_ZJXL,
						DataDic.INFORMATION_NO, price);
			}

		}
		return Tools.getMapResult(state,"正常查询",map);
	}

	/**
	 * 车架号位置查询
	 * 
	 * @param vin
	 * @param timeNearby
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object vinLocation(String vin, String timeNearby,String authentication) {
		InterfaceToken interfacetoken = interfacelogbiz.interfacetokens();
		String token = interfacetoken.getToken();
		Map<String, Object> map = new HashMap<String, Object>();
		VLastLocation vlast = new VLastLocation();
		VehicleInformation vpIn = new VehicleInformation();
		String price = DictUtils.getMsgLabel(DataDic.ZJXL_LOCATIONVIN, "zjxl_port", "");
		User curUser = UserUtils.getUser(); // 获取当前用户
		int state=DataDic.NO_INT;
		String message="";
		if(authentication.equals(DataDic.INFORMATION_YES)) {// 1是用户收费，0是管理者， 不收费
			// 收费
			String user_id = curUser.getId();
			price = DictUtils.getMsgLabel(DataDic.ZJXL_LASTlOCATION, "zjxl_port", "");                                      //从数据字典中获取价格
			int underbalance = consumebiz.payGPSLocationBiz(user_id, Double.parseDouble(price), DataDic.INTERFACE_ZJXLD);
			if (underbalance == DataDic.RETURN_STATUS_MONEYBUG) { // 余额不足，不进行查询操作
				state=DataDic.RETURN_STATUS_MONEYBUG;
				return Tools.getMapResult(state,"用户余额不足",map);
			}
		}
		// 车架vin号最新位置查询
		vpIn = vlast.vLastLocationVin(token, vin, timeNearby);
		if (vpIn != null) {
			map.put("LocationVin", vpIn);
			interfacelogbiz.addBiz(curUser, DataDic.ZJXL_LOCATIONVIN, "车辆最新位置(vin号)", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_YES, price);
		} else {
			interfacelogbiz.addBiz(curUser, DataDic.ZJXL_LOCATIONVIN, "车辆最新位置(vin号)", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_NO, price);
		}

		return map;
	}
}
