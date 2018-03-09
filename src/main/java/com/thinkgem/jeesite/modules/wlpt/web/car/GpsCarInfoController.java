/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.car;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;

/**
 * 车辆gps数据，获取keyController
 * @author 饶江龙
 * @version 2016-08-17
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/car/gpsCarInfo")
public class GpsCarInfoController extends BaseController {

	@Autowired
	private GpsCarInfoService gpsCarInfoService;
	
	@ModelAttribute
	public GpsCarInfo get(@RequestParam(required=false) String id) {
		GpsCarInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = gpsCarInfoService.get(id);
		}
		if (entity == null){
			entity = new GpsCarInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:car:gpsCarInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(GpsCarInfo gpsCarInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GpsCarInfo> page = gpsCarInfoService.findPage(new Page<GpsCarInfo>(request, response), gpsCarInfo); 
		model.addAttribute("page", page);
		return "modules/wlpt/car/gpsCarInfoList";
	}

	@RequiresPermissions("wlpt:car:gpsCarInfo:view")
	@RequestMapping(value = "form")
	public String form(GpsCarInfo gpsCarInfo, Model model) {
		model.addAttribute("gpsCarInfo", gpsCarInfo);
		return "modules/wlpt/car/gpsCarInfoForm";
	}

	@RequiresPermissions("wlpt:car:gpsCarInfo:edit")
	@RequestMapping(value = "save")
	public String save(GpsCarInfo gpsCarInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, gpsCarInfo)){
			return form(gpsCarInfo, model);
		}
		gpsCarInfoService.save(gpsCarInfo);
		addMessage(redirectAttributes, "保存gps数据成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/gpsCarInfo/?repage";
	}
	
	@RequiresPermissions("wlpt:car:gpsCarInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(GpsCarInfo gpsCarInfo, RedirectAttributes redirectAttributes) {
		gpsCarInfoService.delete(gpsCarInfo);
		addMessage(redirectAttributes, "删除gps数据成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/gpsCarInfo/?repage";
	}

}