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
import com.thinkgem.jeesite.modules.wlpt.entity.car.Cardriver;
import com.thinkgem.jeesite.modules.wlpt.service.car.CardriverService;

/**
 * 司机管理Controller
 * @author 饶江龙
 * @version 2016-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/cs/cardriver")
public class CardriverController extends BaseController {

	@Autowired
	private CardriverService cardriverService;
	
	@ModelAttribute
	public Cardriver get(@RequestParam(required=false) String id) {
		Cardriver entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cardriverService.get(id);
		}
		if (entity == null){
			entity = new Cardriver();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:car:cardriver:view")
	@RequestMapping(value = {"list", ""})
	public String list(Cardriver cardriver, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Cardriver> page = cardriverService.findPage(new Page<Cardriver>(request, response), cardriver); 
		model.addAttribute("page", page);
		return "modules/wlpt/car/cardriverList";
	}

	@RequiresPermissions("wlpt:car:cardriver:view")
	@RequestMapping(value = "form")
	public String form(Cardriver cardriver, Model model) {
		model.addAttribute("cardriver", cardriver);
		return "modules/wlpt/car/cardriverForm";
	}

	@RequiresPermissions("wlpt:car:cardriver:edit")
	@RequestMapping(value = "save")
	public String save(Cardriver cardriver, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cardriver)){
			return form(cardriver, model);
		}
		cardriverService.save(cardriver);
		addMessage(redirectAttributes, "保存绑定司机成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/cardriver/?repage";
	}
	
	@RequiresPermissions("wlpt:car:cardriver:edit")
	@RequestMapping(value = "delete")
	public String delete(Cardriver cardriver, RedirectAttributes redirectAttributes) {
		cardriverService.delete(cardriver);
		addMessage(redirectAttributes, "删除绑定司机成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/cardriver/?repage";
	}

}