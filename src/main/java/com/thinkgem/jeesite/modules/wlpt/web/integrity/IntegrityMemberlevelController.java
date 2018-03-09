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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityMemberlevel;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityMemberlevelService;

/**
 * 诚信会员等级Controller
 * @author 刘欣
 * @version 2016-09-13
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integrity/integrityMemberlevel")
public class IntegrityMemberlevelController extends BaseController {

	@Autowired
	private IntegrityMemberlevelService integrityMemberlevelService;
	
	@ModelAttribute
	public IntegrityMemberlevel get(@RequestParam(required=false) String id) {
		IntegrityMemberlevel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = integrityMemberlevelService.get(id);
		}
		if (entity == null){
			entity = new IntegrityMemberlevel();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:integrity:integrityMemberlevel:view")
	@RequestMapping(value = {"list", ""})
	public String list(IntegrityMemberlevel integrityMemberlevel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IntegrityMemberlevel> page = integrityMemberlevelService.findPage(new Page<IntegrityMemberlevel>(request, response), integrityMemberlevel); 
		model.addAttribute("page", page);
		return "modules/wlpt/integrity/integrityMemberlevelList";
	}

	@RequiresPermissions("wlpt:integrity:integrityMemberlevel:view")
	@RequestMapping(value = "form")
	public String form(IntegrityMemberlevel integrityMemberlevel, Model model) {
		model.addAttribute("integrityMemberlevel", integrityMemberlevel);
		return "modules/wlpt/integrity/integrityMemberlevelForm";
	}

	@RequiresPermissions("wlpt:integrity:integrityMemberlevel:edit")
	@RequestMapping(value = "save")
	public String save(IntegrityMemberlevel integrityMemberlevel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integrityMemberlevel)){
			return form(integrityMemberlevel, model);
		}
		integrityMemberlevelService.save(integrityMemberlevel);
		addMessage(redirectAttributes, "保存诚信会员等级成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityMemberlevel/?repage";
	}
	
	@RequiresPermissions("wlpt:integrity:integrityMemberlevel:edit")
	@RequestMapping(value = "delete")
	public String delete(IntegrityMemberlevel integrityMemberlevel, RedirectAttributes redirectAttributes) {
		integrityMemberlevelService.delete(integrityMemberlevel);
		addMessage(redirectAttributes, "删除诚信会员等级成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityMemberlevel/?repage";
	}

}