/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.integrity;

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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityCarownerService;

/**
 * 诚信车主Controller
 * @author fjc
 * @version 2016-07-27
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integrity/integrityCarowner")
public class IntegrityCarownerController extends BaseController {

	@Autowired
	private IntegrityCarownerService integrityCarownerService;
	
	@ModelAttribute
	public IntegrityCarowner get(@RequestParam(required=false) String id) {
		IntegrityCarowner entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = integrityCarownerService.get(id);
		}
		if (entity == null){
			entity = new IntegrityCarowner();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:integrity:integrityCarowner:view")
	@RequestMapping(value = {"list", ""})
	public String list(IntegrityCarowner integrityCarowner, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IntegrityCarowner> page = integrityCarownerService.findPage(new Page<IntegrityCarowner>(request, response), integrityCarowner); 
		model.addAttribute("page", page);
		return "modules/wlpt/integrity/integrityCarownerList";
	}

	@RequiresPermissions("wlpt:integrity:integrityCarowner:view")
	@RequestMapping(value = "form")
	public String form(IntegrityCarowner integrityCarowner, Model model) {
		model.addAttribute("integrityCarowner", integrityCarowner);
		return "modules/wlpt/integrity/integrityCarownerForm";
	}

	@RequiresPermissions("wlpt:integrity:integrityCarowner:edit")
	@RequestMapping(value = "save")
	public String save(IntegrityCarowner integrityCarowner, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integrityCarowner)){
			return form(integrityCarowner, model);
		}
		integrityCarownerService.save(integrityCarowner);
		addMessage(redirectAttributes, "保存诚信信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityCarowner/?repage";
	}
	
	@RequiresPermissions("wlpt:integrity:integrityCarowner:edit")
	@RequestMapping(value = "delete")
	public String delete(IntegrityCarowner integrityCarowner, RedirectAttributes redirectAttributes) {
		integrityCarownerService.delete(integrityCarowner);
		addMessage(redirectAttributes, "删除诚信信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityCarowner/?repage";
	}

}