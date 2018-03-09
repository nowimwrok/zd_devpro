/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.web.gps;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.gps.GpsUpdateBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.gps.GpsUpdate;
import com.thinkgem.jeesite.modules.wlpt.service.gps.GpsUpdateService;

/**
 * 这是个测试类Controller
 * @author leifeng
 * @version 2017-09-05
 */
@Controller
@RequestMapping(value = "${frontPath}/gps/gpsUpdate")
public class GpsUpdateController extends BaseController {

	@Autowired
	private GpsUpdateBiz gpsUpdateBiz;
	@Autowired
	private GpsUpdateService gpsUpdateService;
	@Autowired
	private TradeBiz tradeBiz;
	@ModelAttribute
	public GpsUpdate get(@RequestParam(required=false) String id) {
		GpsUpdate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = gpsUpdateService.get(id);
		}
		if (entity == null){
			entity = new GpsUpdate();
		}
		return entity;
	}
	//显示数据
	@RequestMapping(value = "show")
	@ResponseBody
	public GpsUpdate showMessage(@RequestParam(required=false)String id){
		GpsUpdate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = gpsUpdateService.get(id);
		}
		if (entity == null){
			entity = new GpsUpdate();
		}
		return entity;
	}
	

	@RequestMapping(value="test")
	@ResponseBody
	public void sendSMS(){
		String[] test = {"test"};
		SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_AUTHENSUCCES, "18730921565",
				Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_AUTHEN, test,null,null,true, SmsConfig.smsAuthSuccess);

	}
	
	/**
	 * 保存数据
	 * @param username
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "railsave")
	@ResponseBody
	public Object saveRail(String username,String password,String carNumber,String railName,String railType,String railTime,String railLeaveTime,String railStopTime, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = gpsUpdateBiz.sendRail(username,password,carNumber,railName,railType,railTime,railLeaveTime,railStopTime);
		if(message != null){
			addMessage(redirectAttributes, "保存成功");
			return message;
		}
		return "未知异常";
	}
	
	@RequestMapping(value = "list")
	@ResponseBody
	public void updateGps(){
		tradeBiz.regionRegistration();
	}

}