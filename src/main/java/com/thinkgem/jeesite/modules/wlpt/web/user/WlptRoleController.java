/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.Role;
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
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptRoleService;

/**
 * 平台角色Controller
 * @author 饶江龙
 * @version 2016-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/wlptRole")
public class WlptRoleController extends BaseController {

	@Autowired
	private WlptRoleService wlptRoleService;
	
	@ModelAttribute
	public Role get(@RequestParam(required=false) String id) {
		Role entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wlptRoleService.get(id);
		}
		if (entity == null){
			entity = new Role();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:wlptRole:view")
	@RequestMapping(value = {"list", ""})
	public String list(Role wlptRole, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Role> page = wlptRoleService.findPage(new Page<Role>(request, response), wlptRole);
		model.addAttribute("page", page);
		return "modules/wlpt/user/wlptRoleList";
	}

	@RequiresPermissions("wlpt:user:wlptRole:view")
	@RequestMapping(value = "form")
	public String form(Role wlptRole, Model model) {
		model.addAttribute("wlptRole", wlptRole);
		return "modules/wlpt/user/wlptRoleForm";
	}

	@RequiresPermissions("wlpt:user:wlptRole:edit")
	@RequestMapping(value = "save")
	public String save(Role wlptRole, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wlptRole)){
			return form(wlptRole, model);
		}
		wlptRoleService.save(wlptRole);
		addMessage(redirectAttributes, "保存平台角色成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/wlptRole/?repage";
	}
	
	@RequiresPermissions("wlpt:user:wlptRole:edit")
	@RequestMapping(value = "delete")
	public String delete(Role wlptRole, RedirectAttributes redirectAttributes) {
		wlptRoleService.delete(wlptRole);
		addMessage(redirectAttributes, "删除平台角色成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/wlptRole/?repage";
	}

}