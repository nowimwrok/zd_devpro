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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandard;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityStandardService;

/**
 * 诚信标准Controller
 * @author 刘欣
 * @version 2016-09-13
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integrity/integrityStandard")
public class IntegrityStandardController extends BaseController {

	@Autowired
	private IntegrityStandardService integrityStandardService;
	
	@ModelAttribute
	public IntegrityStandard get(@RequestParam(required=false) String id) {
		IntegrityStandard entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = integrityStandardService.get(id);
		}
		if (entity == null){
			entity = new IntegrityStandard();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:integrity:integrityStandard:view")
	@RequestMapping(value = {"list", ""})
	public String list(IntegrityStandard integrityStandard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IntegrityStandard> page = integrityStandardService.findPage(new Page<IntegrityStandard>(request, response), integrityStandard); 
		model.addAttribute("page", page);
		return "modules/wlpt/integrity/integrityStandardList";
	}

	@RequiresPermissions("wlpt:integrity:integrityStandard:view")
	@RequestMapping(value = "form")
	public String form(IntegrityStandard integrityStandard, Model model) {
		model.addAttribute("integrityStandard", integrityStandard);
		return "modules/wlpt/integrity/integrityStandardForm";
	}

	@RequiresPermissions("wlpt:integrity:integrityStandard:edit")
	@RequestMapping(value = "save")
	public String save(IntegrityStandard integrityStandard, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integrityStandard)){
			return form(integrityStandard, model);
		}
		integrityStandardService.save(integrityStandard);
		addMessage(redirectAttributes, "保存诚信标准成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityStandard/?repage";
	}
	
	@RequiresPermissions("wlpt:integrity:integrityStandard:edit")
	@RequestMapping(value = "delete")
	public String delete(IntegrityStandard integrityStandard, RedirectAttributes redirectAttributes) {
		integrityStandardService.delete(integrityStandard);
		addMessage(redirectAttributes, "删除诚信标准成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityStandard/?repage";
	}

}