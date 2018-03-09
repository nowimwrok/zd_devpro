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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityEnterprise;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityEnterpriseService;

/**
 * 诚信企业Controller
 * @author fjc
 * @version 2016-07-27
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integrity/integrityEnterprise")
public class IntegrityEnterpriseController extends BaseController {

	@Autowired
	private IntegrityEnterpriseService integrityEnterpriseService;
	
	@ModelAttribute
	public IntegrityEnterprise get(@RequestParam(required=false) String id) {
		IntegrityEnterprise entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = integrityEnterpriseService.get(id);
		}
		if (entity == null){
			entity = new IntegrityEnterprise();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:integrity:integrityEnterprise:view")
	@RequestMapping(value = {"list", ""})
	public String list(IntegrityEnterprise integrityEnterprise, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IntegrityEnterprise> page = integrityEnterpriseService.findPage(new Page<IntegrityEnterprise>(request, response), integrityEnterprise); 
		model.addAttribute("page", page);
		return "modules/wlpt/integrity/integrityEnterpriseList";
	}

	@RequiresPermissions("wlpt:integrity:integrityEnterprise:view")
	@RequestMapping(value = "form")
	public String form(IntegrityEnterprise integrityEnterprise, Model model) {
		model.addAttribute("integrityEnterprise", integrityEnterprise);
		return "modules/wlpt/integrity/integrityEnterpriseForm";
	}

	@RequiresPermissions("wlpt:integrity:integrityEnterprise:edit")
	@RequestMapping(value = "save")
	public String save(IntegrityEnterprise integrityEnterprise, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integrityEnterprise)){
			return form(integrityEnterprise, model);
		}
		integrityEnterpriseService.save(integrityEnterprise);
		addMessage(redirectAttributes, "保存诚信信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityEnterprise/?repage";
	}
	
	@RequiresPermissions("wlpt:integrity:integrityEnterprise:edit")
	@RequestMapping(value = "delete")
	public String delete(IntegrityEnterprise integrityEnterprise, RedirectAttributes redirectAttributes) {
		integrityEnterpriseService.delete(integrityEnterprise);
		addMessage(redirectAttributes, "删除诚信信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityEnterprise/?repage";
	}

}