package com.thinkgem.jeesite.modules.wlpt.biz.railregistBiz;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.trafficUtils.carEvent.Vehicle;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.entity.railregist.RailRegist;
import com.thinkgem.jeesite.modules.wlpt.service.railregist.RailRegistService;

@Service
@Transactional(readOnly = true)
public class RailRegistBiz {
	@Autowired
	private RailRegistService railRegistService;
	@Autowired
	private InterfaceLogBiz interfacelogbiz;
	/**
	 * 自定义区域注册
	 * @param railRegist
	 * @return
	 */
	@Transactional(readOnly=false)
	public Map<String,Object> save(RailRegist railRegist){
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		String regex = "^[-+]?\\d+(\\.\\d+)?$";
		RailRegist railRegistConf = new RailRegist();
		int state = DataDic.RAIL_UNKNOWNERROR;
		String message = "";
		//判断为空及参数是否正确
		if(railRegist.getRailname() == null){
			state = DataDic.RAIL_PARAMERROR;
			message = "围栏名称错误";
		}
		railRegistConf.setRailname(railRegist.getRailname());
		String lonlat = railRegist.getLonlat();
		if(lonlat != null && lonlat.contains(",")){
			String[] lonlats = railRegist.getLonlat().split(",");
			if(Pattern.matches(regex,lonlats[0]) && Pattern.matches(regex,lonlats[1])){
				railRegistConf.setLonlat(railRegist.getLonlat());
			}else{
				state = DataDic.RAIL_PARAMERROR;
				message = "经纬度错误";
			}
		}else{
			state = DataDic.RAIL_PARAMERROR;
			message = "经纬度错误";
		}
		if(railRegist.getRadius() == null){
			state = DataDic.RAIL_PARAMERROR;
			message = "范围错误";
		}
		railRegistConf.setRadius(railRegist.getRadius());
		if(railRegist.getType() != (null) && railRegist.getType().equals(DataDic.THECAR)){
			railRegistConf.setType(railRegist.getType());
		}else{
			state = DataDic.RAIL_PARAMERROR;
			message = "订阅类型错误";
		}
		if(railRegist.getActionType()!=null || railRegist.getActionType().toString().trim().equals(DataDic.RAIL_IN) && railRegist.getActionType().toString().trim().equals(DataDic.RAIL_OUT) || railRegist.getActionType().toString().trim().equals(DataDic.RAIL_IN+","+DataDic.RAIL_OUT)){
			railRegistConf.setActionType(railRegist.getActionType());
		}else{
			state = DataDic.RAIL_PARAMERROR;
			message = "时间类型错误";
		}
		User userConf = new User();
		userConf.setId(DataDic.FIXED_ID);
		User user = new User();
		user.setId(DataDic.FIXED_ID);
		user.setCreateBy(userConf);
		user.setUpdateBy(userConf);
		railRegistConf.setCreateBy(user.getCreateBy());
		railRegistConf.setUpdateBy(user.getUpdateBy());
		VehicleInformation vehicleInformation = new VehicleInformation();
		if(railRegistConf.getCreateBy()!=null){
			
		if(state == DataDic.RAIL_UNKNOWNERROR){
			Vehicle vehicle=new Vehicle();
			Map<String,Object> map = vehicle.areaReg(token,railRegistConf.getRailname(), railRegistConf.getLonlat(), Integer.parseInt(railRegistConf.getRadius()), Integer.parseInt(railRegistConf.getType()), railRegistConf.getActionType());
			state = Integer.parseInt(map.get("state").toString());
			message = map.get("message").toString();
			vehicleInformation = (VehicleInformation)map.get("data");
		}
		}else{
			state = DataDic.RAIL_PARAMERROR;
			message = "创建者错误";
		}
	
		System.out.println(vehicleInformation.getAreaid());
		if(vehicleInformation.getAreaid()!=null){
			System.out.println(vehicleInformation.getAreaid());
			railRegistConf.setAreaid(vehicleInformation.getAreaid());
		}else{
			state = DataDic.RAIL_PARAMERROR;
			message = "未知异常";
		}
		railRegistConf.setOrderinfoId(railRegist.getOrderinfoId());

		if(state == DataDic.RAIL_SUCCESS){
			railRegistService.save(railRegistConf);
			//日志
			interfacelogbiz.addBiz(user, DataDic.ZJXL_AREAREG, "自定义区域注册", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_YES, DictUtils.getMsgLabel(DataDic.ZJXL_AREAREG, "zjxl_port", ""));
		}else{
			interfacelogbiz.addBiz(user, DataDic.ZJXL_AREAREG, "自定义区域注册", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_NO, DictUtils.getMsgLabel(DataDic.ZJXL_AREAREG, "zjxl_port", ""));

		}
		return Tools.getMapResult(state, message, vehicleInformation);
	}

	/**
	 * 自定义区域删除
	 * @param railRegist
	 */
	@Transactional(readOnly=false)
	public Map<String,Object> delete(RailRegist railRegist){
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		Vehicle vehicle=new Vehicle();
		System.out.println("=========="+railRegist+"================");
		Map<String,Object> map = vehicle.areaDel(token,railRegist.getAreaid());
		String message = "未知异常";
		User user = new User();
		user.setId("004f01bf85a84584945ca78216d6e3d9");
		if(Integer.parseInt(map.get("state").toString()) == DataDic.RAIL_SUCCESS){
			System.out.println(DictUtils.getMsgLabel(DataDic.ZJXL_AREAREG, "zjxl_port", ""));
			interfacelogbiz.addBiz(user, DataDic.ZJXL_AREADEL, "自定义区域删除", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_YES, DictUtils.getMsgLabel(DataDic.ZJXL_AREADEL, "zjxl_port", ""));
			railRegistService.delete(railRegist);
			message = "删除成功";
		}else{
			interfacelogbiz.addBiz(user, DataDic.ZJXL_AREADEL, "自定义区域删除", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_NO, DictUtils.getMsgLabel(DataDic.ZJXL_AREADEL, "zjxl_port", ""));
		}
		return Tools.getMapResult(Integer.parseInt(map.get("state").toString()), message, null);
	}

	/**
	 * 自定义区域通过areaid删除
	 */
	public Map<String,Object> deleteByAreaid(RailRegist railRegist){
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		Vehicle vehicle=new Vehicle();
		Map<String,Object> map = vehicle.areaDel(token,railRegist.getAreaid());
		String message = map.get("message").toString();
		User user = new User();
		user.setId("004f01bf85a84584945ca78216d6e3d9");
		if(Integer.parseInt(map.get("state").toString()) == DataDic.RAIL_SUCCESS && message.equals("1")){
			interfacelogbiz.addBiz(user, DataDic.ZJXL_AREADEL, "自定义区域删除", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_YES, DictUtils.getMsgLabel(DataDic.ZJXL_AREADEL, "zjxl_port", ""));
			railRegistService.deleteByAreaid(railRegist);
			message = "删除成功";
		}else if(message.equals("2")){
			interfacelogbiz.addBiz(user, DataDic.ZJXL_AREADEL, "自定义区域删除", DataDic.INFACESSOURCE_ZJXL,
					DataDic.INFORMATION_NO, DictUtils.getMsgLabel(DataDic.ZJXL_AREADEL, "zjxl_port", ""));
			message = "自定义区域id不存在";
		}
		return Tools.getMapResult(Integer.parseInt(map.get("state").toString()), message, null);
	}

	/**
	 * 自定义区域查询
	 */
	public List<RailRegist> findList(RailRegist railRegist){
		 return railRegistService.findList(railRegist);
	}

	/**
	 * 自定义区域查询分页
	 */
	public Page<RailRegist> findPage(Page<RailRegist> page,RailRegist railRegist){
		return railRegistService.findPage(page,railRegist);
	}

}
