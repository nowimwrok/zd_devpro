/**
 * 
 */
package com.thinkgem.jeesite.modules.sms.web;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sms.entity.Template;
import com.thinkgem.jeesite.modules.sms.service.TemplateService;

/**
 * 消息模版Controller
 * @author 饶江龙
 * @version 2016-07-20
 */
@Controller
@RequestMapping(value = "${adminPath}/sms/template")
public class SmsTemplateController extends BaseController {

	@Autowired
	private TemplateService templateService;
	
	@ModelAttribute
	public Template get(@RequestParam(required=false) String id) {
		Template entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = templateService.get(id);
		}
		if (entity == null){
			entity = new Template();
		}
		return entity;
	}

	
	@RequiresPermissions("sms:smstemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(Template smstemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Template> page = templateService.findPage(new Page<Template>(request, response), smstemplate); 
		model.addAttribute("page", page);
		return "modules/sms/templateList";
	}

	@RequiresPermissions("sms:smstemplate:edit")
	@RequestMapping(value = "form")
	public String form(Template smstemplate, Model model) {
		model.addAttribute("smstemplate", smstemplate);
		return "modules/sms/templateForm";
	}

	@RequiresPermissions("sms:smstemplate:edit")
	@RequestMapping(value = "save")
	public String save(Template smstemplate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, smstemplate)){
			return form(smstemplate, model);
		}
		templateService.save(smstemplate);
		addMessage(redirectAttributes, "保存消息模版成功");
		return "redirect:"+Global.getAdminPath()+"/sms/template/?repage";
	}
	
	@RequiresPermissions("sms:smstemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(Template smstemplate, RedirectAttributes redirectAttributes) {
		templateService.delete(smstemplate);
		addMessage(redirectAttributes, "删除消息模版成功");
		return "redirect:"+Global.getAdminPath()+"/sms/template/?repage";
	}

}