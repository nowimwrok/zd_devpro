package com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.entity.InfomationDetection;
import com.thinkgem.jeesite.common.trafficUtils.findCarDelivery.Query;
import com.thinkgem.jeesite.common.trafficUtils.informationVerification.CheckExist;
import com.thinkgem.jeesite.common.trafficUtils.informationVerification.CheckOwner;
import com.thinkgem.jeesite.common.trafficUtils.informationVerification.RoadVerification;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.Travelinformation;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.interfacelog.TravelinformationService;

@Service
@Transactional(readOnly = true)
public class TotalValidationBiz {

	@Autowired
	private CarService carservice;

	@Autowired
	private ConsumeRecodBiz consumebiz;
	@Autowired
	private InterfaceLogBiz interfacelogbiz;
	@Autowired
	private TravelinformationService traveservice;

	/**
	 * 
	 * @param name
	 *            名字
	 * @param phone
	 *            电话
	 * @param vclN
	 *            车牌号
	 * @param area
	 *            区县号
	 * @param vco
	 *            车牌颜色
	 * 
	 * @param regist
	 *            调用的服务
	 * @param carid
	 *            车辆表ID
	 * @param userid
	 *            用户ID
	 * @return 先从数据库查询是否有数据，没有才调用接口查询
	 */
	
	@Transactional(readOnly = false)
	public Map<String, Object> totalvalidation(String name, String phone, String vclN, String area, String vco,
			String regist, String carid, String authentication) {

		InterfaceToken interfacetoken = interfacelogbiz.interfacetokens();
		String token = interfacetoken.getToken();
		Map<String, Object> map = new HashMap<String, Object>();
		String price = "";
		Double money = 0.0;
		User curUser = UserUtils.getUser(); // 获取当前用户
		String service = "";
		if (regist.indexOf(DataDic.ZJXL_TRUCKEXIST) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_TRUCKEXIST, "zjxl_port", "");
			service += "车辆入网验证";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_TRAVEQUERY) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_TRAVEQUERY, "zjxl_port", "");
			service += "车辆行驶信息查询";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_QUERYRTCNO) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_QUERYRTCNO, "zjxl_port", "");
			service += "道路运输证查询";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_OWNERBYVC) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_OWNERBYVC, "zjxl_port", "");
			service += "车主真实性验证";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_AREABYVClNPO) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_AREABYVClNPO, "zjxl_port", "");
			service += "套牌车验证";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		String user_id = curUser.getId();

		// 1是用户收费，0是管理者， 不收费
		if (authentication.equals(DataDic.INFORMATION_YES)) {
			if (money != 0.0) {
				int paymentinfo = consumebiz.payAuthInfoBiz(user_id, money, service);
				if (paymentinfo == DataDic.RETURN_STATUS_INFOBUG) {
					map.put("paymentinfo", DataDic.RETURN_STATUS_INFOBUG);
					return map;
				}
				if (paymentinfo == DataDic.RETURN_STATUS_MONEYBUG) {
					map.put("paymentinfo", DataDic.RETURN_STATUS_MONEYBUG);
					return map;
				}
			}
		}
		// 车辆入网验证 提供按车牌号判断指定车辆是否在全国货运平台入网服务
		if (vclN != null && regist.indexOf(DataDic.ZJXL_TRUCKEXIST) != DataDic.RETURN_STATUS_SYSBUG) {
			Car car = carservice.get(carid);
			if (car == null || null == car.getChecktruckstatus() || DataDic.NO.equals(car.getChecktruckstatus())) {
				CheckExist checkExist = new CheckExist();
				car = new Car();
				String carstr = checkExist.checkTruckExist(token, vclN);
				if (carstr != null && !carstr.equals("") && !DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(carstr)) {
					car.setId(carid);
					car.setChecktruckstatus(carstr);
					carservice.updateValidation(car);
					map.put("TruckExist", car);
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRUCKEXIST, "车辆入网验证", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_YES, price);
				} else {
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRUCKEXIST, "车辆入网验证", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_NO, price);
				}
			} else {
				map.put("TruckExist", car);
			}

			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}

		}

		// 车辆行驶信息查询
		if (vclN != null && vco != null && regist.indexOf(DataDic.ZJXL_TRAVEQUERY) != DataDic.RETURN_STATUS_SYSBUG) {

			Travelinformation traveLin = new Travelinformation();
			traveLin.setCarid(carid);
			traveLin = traveservice.getBycarid(traveLin);
			if (traveLin != null && !"".equals(traveLin.getVclN())) {
				map.put("vQueryLicense", traveLin);
			} else {
				Query query = new Query();
				Map<String, Object> mapd = query.vQueryLicense(token, vclN, vco);
				int state = (int) mapd.get("state");
				if (state == DataDic.RAIL_SUCCESS) {
					Travelinformation traveLinfor = (Travelinformation) mapd.get("data");
					traveLinfor.setCarid(carid);
					traveservice.save(traveLinfor);
					map.put("vQueryLicense", traveLinfor);
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRAVEQUERY, "车辆行驶信息查询", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_YES, price);
				} else {
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRAVEQUERY, "车辆行驶信息查询", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_NO, price);

				}

			}

		}

		// 道路运输证查询接口 本接口通过指定车牌号、车牌颜色号，查询道路运输证号码，验证道路运输证信息是否准确
		if (vclN != null && vco != null && regist.indexOf(DataDic.ZJXL_QUERYRTCNO) != DataDic.RETURN_STATUS_SYSBUG) {
			Car car = new Car();
			car.setId(carid);
			Car cars = carservice.get(car);
			if (null != cars && cars.getTransportcard() != null && cars.getValidityterm() != null
					&& !DataDic.NO.equals(cars.getTransportcard()) && !DataDic.NO.equals(cars.getValidityterm())) {
				map.put("RTCNo", cars);
			} else {
				RoadVerification roadVerification = new RoadVerification();
				InfomationDetection infomation;
				infomation = roadVerification.vQueryRTCNo(token, vclN, vco);
				car = new Car();
				if (infomation.getStatus() == DataDic.RAIL_SUCCESS) {
					car.setId(carid);
					car.setTransportcard(infomation.getRoadTransport());
					car.setValidityterm(infomation.getVdtTm());
					carservice.updateValidation(car);
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_QUERYRTCNO, "道路运输证查询", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_YES, price);
				} else {
					car.setTransportcard("未查询到信息");
					car.setValidityterm("未查询到信息");
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_QUERYRTCNO, "道路运输证查询", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_NO, price);

				}
				map.put("RTCNo", car);
			}

		}
		// 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性
		if (vclN != null && name != null && phone != null
				&& regist.indexOf(DataDic.ZJXL_OWNERBYVC) != DataDic.RETURN_STATUS_SYSBUG) {

			Car car = carservice.get(carid);
			if (null == car || null == car.getCheckownerstatus() || DataDic.NO.equals(car.getCheckownerstatus())
					|| DataDic.METRO_REGISTER_RESULTSTATUS_FAIL.equals(car.getCheckownerstatus())) {
				CheckOwner checkOwner = new CheckOwner();
				car = checkOwner.checkOwnerByVclNo(token, vclN, name, phone);
				if (car != null && DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(car.getCheckownerstatus())) {
					car.setId(carid);
					carservice.updateValidation(car);
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_OWNERBYVC, "车主真实性验证", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_YES, price);
				} else {
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_OWNERBYVC, "车主真实性验证", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_NO, price);
				}
				map.put("OwnerByVclNo", car);
			} else {
				map.put("OwnerByVclNo", car);
			}

		}
		// 套牌车验证 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性
		if (vclN != null && area != null && regist.indexOf(DataDic.ZJXL_AREABYVClNPO) != DataDic.RETURN_STATUS_SYSBUG) {

			Car car = carservice.get(carid);
			if (car != null && DataDic.NO.equals(car.getCheckareastatus())) {
				CheckOwner checkOwner = new CheckOwner();
				car = checkOwner.checkAreaByVclNo(token, vclN, area);
				if (car != null) {
					car.setId(carid);
					carservice.updateValidation(car);
				}
				map.put("AreaByVclNo", car);
			} else {
				map.put("AreaByVclNo", car);
			}

			interfacelogbiz.addBiz(curUser, DataDic.ZJXL_AREABYVClNPO, "套牌车查询", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_YES, price);

		}

		return map;
	}
	/**
	 * 通过车牌号查询并保存所有数据
	 * @param name
	 *            名字
	 * @param phone
	 *            电话
	 * @param vclN
	 *            车牌号
	 * @param area
	 *            区县号
	 * @param vco
	 *            车牌颜色
	 * 
	 * @param regist
	 *            调用的服务
	 * @param carid
	 *            车辆表ID
	 * @param userid
	 *            用户ID
	 * @return 先从数据库查询是否有数据，没有才调用接口查询
	 */
	
	@Transactional(readOnly = false)
	public Map<String, Object> totalvalidations(String name, String phone, String vclN, String area, String vco,
			String regist, String authentication) {
		InterfaceToken interfacetoken = interfacelogbiz.interfacetokens();
		String token = interfacetoken.getToken();
		Map<String, Object> map = new HashMap<String, Object>();
		String price = "";
		Double money = 0.0;
		User curUser = UserUtils.getUser(); // 获取当前用户
		String service = "";
		if (regist.indexOf(DataDic.ZJXL_TRUCKEXIST) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_TRUCKEXIST, "zjxl_port", "");
			service += "车辆入网验证";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_TRAVEQUERY) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_TRAVEQUERY, "zjxl_port", "");
			service += "车辆行驶信息查询";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_QUERYRTCNO) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_QUERYRTCNO, "zjxl_port", "");
			service += "道路运输证查询";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_OWNERBYVC) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_OWNERBYVC, "zjxl_port", "");
			service += "车主真实性验证";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		if (regist.indexOf(DataDic.ZJXL_AREABYVClNPO) != DataDic.RETURN_STATUS_SYSBUG) {
			price = DictUtils.getMsgLabel(DataDic.ZJXL_AREABYVClNPO, "zjxl_port", "");
			service += "套牌车验证";
			if (price != null && !price.equals("")) {
				money += Double.parseDouble(price);
			}
		}
		String user_id = curUser.getId();
		
		// 1是用户收费，0是管理者， 不收费
		if (authentication.equals(DataDic.INFORMATION_YES)) {
			if (money != 0.0) {
				int paymentinfo = consumebiz.payAuthInfoBiz(user_id, money, service);
				if (paymentinfo == DataDic.RETURN_STATUS_INFOBUG) {
					map.put("paymentinfo", DataDic.RETURN_STATUS_INFOBUG);
					return map;
				}
				if (paymentinfo == DataDic.RETURN_STATUS_MONEYBUG) {
					map.put("paymentinfo", DataDic.RETURN_STATUS_MONEYBUG);
					return map;
				}
			}
		}
		List<String> carList = carservice.findIdByCarnumber(vclN);
		// 车辆入网验证 提供按车牌号判断指定车辆是否在全国货运平台入网服务
		if (vclN != null && regist.indexOf(DataDic.ZJXL_TRUCKEXIST) != DataDic.RETURN_STATUS_SYSBUG) {
			if(carList != null && carList.size() > 0){
				Car car = carservice.get(carList.get(0));
				if (car == null || null == car.getChecktruckstatus() || DataDic.NO.equals(car.getChecktruckstatus())) {
					CheckExist checkExist = new CheckExist();
					car = new Car();
					String carstr = checkExist.checkTruckExist(token, vclN);
					if (carstr != null && !carstr.equals("") && !DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(carstr)) {
						//遍历所有车辆
						for(String carid : carList){
							System.out.println("========1");
							car.setId(carid);
							car.setChecktruckstatus(carstr);
							carservice.updateValidation(car);
						}
						map.put("TruckExist", car);
						interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRUCKEXIST, "车辆入网验证", DataDic.INFACESSOURCE_ZJXL,
								DataDic.INFORMATION_YES, price);
					} else {
						interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRUCKEXIST, "车辆入网验证", DataDic.INFACESSOURCE_ZJXL,
								DataDic.INFORMATION_NO, price);
					}
				} else {
					map.put("TruckExist", car);
				}
				
				if (price != null && !price.equals("")) {
					money += Double.parseDouble(price);
				}
			}
			
		}
		
		// 车辆行驶信息查询
		if (vclN != null && vco != null && regist.indexOf(DataDic.ZJXL_TRAVEQUERY) != DataDic.RETURN_STATUS_SYSBUG) {
			
			Travelinformation traveLin = new Travelinformation();
			if(carList != null && carList.size() >0){
				traveLin.setCarid(carList.get(0));
				traveLin = traveservice.getBycarid(traveLin);
				if (traveLin != null && !"".equals(traveLin.getVclN())) {
					map.put("vQueryLicense", traveLin);
				} else {
					Query query = new Query();
					Map<String, Object> mapd = query.vQueryLicense(token, vclN, vco);
					int state = (int) mapd.get("state");
					if (state == DataDic.RAIL_SUCCESS) {
						Travelinformation traveLinfor = (Travelinformation) mapd.get("data");
						for(String carid : carList){
						traveLinfor.setCarid(carid);
						traveservice.save(traveLinfor);
						}
						map.put("vQueryLicense", traveLinfor);
						interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRAVEQUERY, "车辆行驶信息查询", DataDic.INFACESSOURCE_ZJXL,
								DataDic.INFORMATION_YES, price);
					} else {
						interfacelogbiz.addBiz(curUser, DataDic.ZJXL_TRAVEQUERY, "车辆行驶信息查询", DataDic.INFACESSOURCE_ZJXL,
								DataDic.INFORMATION_NO, price);
						
					}
					
				}
		}
			
		}
		
		// 道路运输证查询接口 本接口通过指定车牌号、车牌颜色号，查询道路运输证号码，验证道路运输证信息是否准确
		if (vclN != null && vco != null && regist.indexOf(DataDic.ZJXL_QUERYRTCNO) != DataDic.RETURN_STATUS_SYSBUG) {
			Car car = new Car();
			if(carList != null && carList.size() > 0){
			car.setId(carList.get(0));
			Car cars = carservice.get(car);
			if (null != cars && cars.getTransportcard() != null && cars.getValidityterm() != null
					&& !DataDic.NO.equals(cars.getTransportcard()) && !DataDic.NO.equals(cars.getValidityterm())) {
				map.put("RTCNo", cars);
			} else {
				RoadVerification roadVerification = new RoadVerification();
				InfomationDetection infomation;
				infomation = roadVerification.vQueryRTCNo(token, vclN, vco);
				car = new Car();
				if (infomation.getStatus() == DataDic.RAIL_SUCCESS) {
					for(String carid : carList){
					car.setId(carid);
					car.setTransportcard(infomation.getRoadTransport());
					car.setValidityterm(infomation.getVdtTm());
					carservice.updateValidation(car);
					}
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_QUERYRTCNO, "道路运输证查询", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_YES, price);
				} else {
					car.setTransportcard("未查询到信息");
					car.setValidityterm("未查询到信息");
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_QUERYRTCNO, "道路运输证查询", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_NO, price);
					
				}
				map.put("RTCNo", car);
			}
			}
			
		}
		// 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性
		if (vclN != null && name != null && phone != null
				&& regist.indexOf(DataDic.ZJXL_OWNERBYVC) != DataDic.RETURN_STATUS_SYSBUG) {
			if(carList != null && carList.size() > 0){
			
			Car car = carservice.get(carList.get(carList.size()-1));
			if (null == car || null == car.getCheckownerstatus() || DataDic.NO.equals(car.getCheckownerstatus())
					|| DataDic.METRO_REGISTER_RESULTSTATUS_FAIL.equals(car.getCheckownerstatus())) {
				CheckOwner checkOwner = new CheckOwner();
				car = checkOwner.checkOwnerByVclNo(token, vclN, name, phone);
				if (car != null && DataDic.CONSUMEAUDIT_STATUS_FAILED.equals(car.getCheckownerstatus())) {
					for(String carid : carList){
						car.setId(carid);
						carservice.updateValidation(car);
					}
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_OWNERBYVC, "车主真实性验证", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_YES, price);
				} else {
					interfacelogbiz.addBiz(curUser, DataDic.ZJXL_OWNERBYVC, "车主真实性验证", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_NO, price);
				}
				map.put("OwnerByVclNo", car);
			} else {
				map.put("OwnerByVclNo", car);
			}
			}
			
		}
		// 套牌车验证 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性
		if (vclN != null && area != null && regist.indexOf(DataDic.ZJXL_AREABYVClNPO) != DataDic.RETURN_STATUS_SYSBUG) {
			if(carList != null && carList.size() > 0){
			Car car = carservice.get(carList.get(0));
			if (car != null && DataDic.NO.equals(car.getCheckareastatus())) {
				CheckOwner checkOwner = new CheckOwner();
				car = checkOwner.checkAreaByVclNo(token, vclN, area);
				if (car != null) {
					for(String carid : carList){
						car.setId(carid);
						carservice.updateValidation(car);
					}
				}
				map.put("AreaByVclNo", car);
			} else {
				map.put("AreaByVclNo", car);
			}
			
			interfacelogbiz.addBiz(curUser, DataDic.ZJXL_AREABYVClNPO, "套牌车查询", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_YES, price);
			
		}
		}
		return map;
	}

	/**
	 * 后台展示存入数据库的数据
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> showMsg(String name, String phone, String vclN, String area, String vco, String regist,
			String carid, String authentication) {

		Map<String, Object> map = new HashMap<String, Object>();

		// 车辆入网验证 提供按车牌号判断指定车辆是否在全国货运平台入网服务
			Car car = carservice.get(carid);
				map.put("TruckExist", car);

		// 车辆行驶信息查询

		Travelinformation traveLin = new Travelinformation();
		traveLin.setCarid(carid);
		traveLin = traveservice.getBycarid(traveLin);
		map.put("vQueryLicense", traveLin);

		// 道路运输证查询接口 本接口通过指定车牌号、车牌颜色号，查询道路运输证号码，验证道路运输证信息是否准确
		map.put("RTCNo", car);

		// 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性

		map.put("OwnerByVclNo", car);

		// 套牌车验证 本接口通过指定车牌号、车主姓名及车主电话，验证车主真实性

		map.put("AreaByVclNo", car);

		return map;
	}
}
