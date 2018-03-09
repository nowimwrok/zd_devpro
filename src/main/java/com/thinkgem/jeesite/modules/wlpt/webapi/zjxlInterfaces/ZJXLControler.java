package com.thinkgem.jeesite.modules.wlpt.webapi.zjxlInterfaces;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.LocationBiz;



@Controller
@RequestMapping(value="${frontPath}/wlpt/zjxl")
public class ZJXLControler {
	@Autowired
	private LocationBiz zjxlbiz;
	@ResponseBody
	@RequestMapping(value="interfaces")
	@Transactional(readOnly = false)
	public Map<String,Object> zjxlinterfaces(String vclN,String timeNearby,String vin, String date1,
			String date2,String regist, String authentication) {
		
		Map<String,Object> map=zjxlbiz.vclnLocation(vclN, timeNearby,authentication);
		return map;
	}
}
