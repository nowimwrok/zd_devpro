package com.thinkgem.jeesite.modules.wlpt.biz.subscribeBiz;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.carEvent.Vehicle;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.entity.subscribe.CarSubscribe;
import com.thinkgem.jeesite.modules.wlpt.service.subscribe.CarSubscribeService;

@Service
@Transactional(readOnly = true)
public class CarSubscribeBiz{
	@Autowired
	private CarSubscribeService carSubscribeService;
	
	@Autowired
	private InterfaceLogBiz interfacelogbiz;
	
	/**
	 * 车辆订阅接口
	 * @param railid 自定义区域id
	 * @param carNumbers 车牌号
	 * @return
	 */
	@Transactional(readOnly=false)
		public Map<String,Object> insert(String railid,String carNumbers){
			int state = DataDic.RAIL_UNKNOWNERROR;
			String message = "";
			InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
			String token=interfacetoken.getToken();
			CarSubscribe carSubscribe = new CarSubscribe();
			if(Tools.IsNullOrWhiteSpace(railid)){
				state = DataDic.RAIL_PARAMERROR;
				message = "自定义区域为空";
			}
			if(Tools.IsNullOrWhiteSpace(carNumbers)){
				state = DataDic.RAIL_PARAMERROR;
				message = "车牌为空";
			}
			carSubscribe.setVnos(carNumbers);
			carSubscribe.setAreaid(railid);
			User userconf = new User();
			userconf.setId(DataDic.FIXED_ID);
			User user = new User();
			user.setId(userconf.getId());
			user.setCreateBy(userconf);
			user.setUpdateBy(userconf);
			carSubscribe.setCreateBy(user);
			carSubscribe.setUpdateBy(user);
			if(carSubscribe.getCreateBy()!=null){
			if(state == DataDic.RAIL_UNKNOWNERROR){
				Vehicle vehicle=new Vehicle();
				Map<String,Object> map = vehicle.vnoReg(token,railid, carNumbers);
				state = Integer.parseInt(map.get("state").toString());
				System.out.println(state);
				message = String.valueOf(map.get("message"));
				if(Tools.IsNullOrWhiteSpace(message)){
					message = "参数不正确";
				}
			}
			}else{
				state = DataDic.RAIL_PARAMERROR;
				message = "创建者错误";
			}
			if(state == DataDic.RAIL_SUCCESS){
				carSubscribeService.save(carSubscribe);
				interfacelogbiz.addBiz(user, DataDic.ZJXL_VNOREG, "车辆订阅", DataDic.INFACESSOURCE_ZJXL,
						DataDic.INFORMATION_YES, DictUtils.getMsgLabel(DataDic.ZJXL_VNOREG, "zjxl_port", ""));
			}else{
				interfacelogbiz.addBiz(user, DataDic.ZJXL_VNOREG, "车辆订阅", DataDic.INFACESSOURCE_ZJXL,
						DataDic.INFORMATION_NO, DictUtils.getMsgLabel(DataDic.ZJXL_VNOREG, "zjxl_port", ""));
			}
			return Tools.getMapResult(state, message, null);
		}
	/**
	 * 订阅删除接口
	 */
	@Transactional(readOnly=false)
	public Map<String,Object> delete(String railid,String vnos){
		int state = DataDic.RAIL_UNKNOWNERROR;
		Vehicle vehicle=new Vehicle();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		Map<String,Object> map = vehicle.vnoDel(token,railid, vnos);
		User user = new User();
		user.setId("004f01bf85a84584945ca78216d6e3d9");
		String message = "未知异常";
		if(Integer.parseInt(map.get("state").toString()) == DataDic.RAIL_SUCCESS){
			CarSubscribe carSubscribeConf = new CarSubscribe();
			carSubscribeConf.setAreaid(railid);
			carSubscribeConf.setVnos(vnos);
			//判断数据库是否有值
			List<CarSubscribe> list = carSubscribeService.findByCallback(carSubscribeConf);
			
			if(list != null && list.size() > 0){
				for(CarSubscribe carSubscribe : list){
					interfacelogbiz.addBiz(user, DataDic.ZJXL_VNODEL, "删除车辆订阅", DataDic.INFACESSOURCE_ZJXL,
							DataDic.INFORMATION_YES, DictUtils.getMsgLabel(DataDic.ZJXL_VNODEL, "zjxl_port", ""));
					state = DataDic.RAIL_SUCCESS;
					message = "删除成功";
					carSubscribeService.delete(carSubscribe);
				}
			}else{
				interfacelogbiz.addBiz(user, DataDic.ZJXL_VNODEL, "删除车辆订阅", DataDic.INFACESSOURCE_ZJXL,
						DataDic.INFORMATION_NO, DictUtils.getMsgLabel(DataDic.ZJXL_VNODEL, "zjxl_port", ""));
				state = DataDic.RAIL_MSGERROR;
			}
		}
		return Tools.getMapResult(state, message, null);
	}
}
