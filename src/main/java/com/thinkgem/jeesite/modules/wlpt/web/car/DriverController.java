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
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;

/**
 * 司机信息Controller
 * @author 饶江龙
 * @version 2016-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/cs/driver")
public class DriverController extends BaseController {

	@Autowired
	private DriverService driverService;
	
	@ModelAttribute
	public Driver get(@RequestParam(required=false) String id) {
		Driver entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = driverService.get(id);
		}
		if (entity == null){
			entity = new Driver();
		}
		return entity;
	}
	
	/*@RequiresPermissions("wlpt:car:driver:view")*/
	@RequestMapping(value = {"list", ""})
	public String list(Driver driver, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Driver> page = driverService.findPage(new Page<Driver>(request, response), driver); 
		model.addAttribute("page", page);
		return "modules/wlpt/car/driverList";
	}

	@RequiresPermissions("wlpt:car:driver:view")
	@RequestMapping(value = "form")
	public String form(Driver driver, Model model) {
		model.addAttribute("driver", driver);
		return "modules/wlpt/car/driverForm";
	}

	@RequiresPermissions("wlpt:car:driver:edit")
	@RequestMapping(value = "save")
	public String save(Driver driver, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, driver)){
			return form(driver, model);
		}
		driverService.save(driver);
		addMessage(redirectAttributes, "保存司机信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/driver/?repage";
	}
	
	@RequiresPermissions("wlpt:car:driver:edit")
	@RequestMapping(value = "delete")
	public String delete(Driver driver, RedirectAttributes redirectAttributes) {
		driverService.delete(driver);
		addMessage(redirectAttributes, "删除司机信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/driver/?repage";
	}

}