/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.subscribe;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.subscribeBiz.CarSubscribeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.subscribe.CarSubscribe;
import com.thinkgem.jeesite.modules.wlpt.service.subscribe.CarSubscribeService;

/**
 * 车辆与自定义区域绑定Controller
 * @author 车辆订阅
 * @version 2017-10-10
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/subscribe/carSubscribe")
public class CarSubscribeController extends BaseController {

	@Autowired
	private CarSubscribeService carSubscribeService;
	@Autowired
	private CarSubscribeBiz carSubscribeBiz;
	
	@ModelAttribute
	public CarSubscribe get(@RequestParam(required=false) String id) {
		CarSubscribe entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = carSubscribeService.get(id);
		}
		if (entity == null){
			entity = new CarSubscribe();
		}
		return entity;
	}
	
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String,Object> save(String railid,String carNumber){
		Map<String,Object> map = carSubscribeBiz.insert(railid, carNumber);
		return map;
	}
	
	@RequestMapping(value = "delete")
	@ResponseBody
	public Map<String,Object> delete(String railid,String carNumber){
		Map<String,Object> map = carSubscribeBiz.delete(railid,carNumber);
		return map;
	}

}