/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

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
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanyService;

/**
 * 用户公司信息Controller
 * @author 饶江龙
 * @version 2016-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userCompany")
public class UserCompanyController extends BaseController {

	@Autowired
	private UserCompanyService userCompanyService;
	
	@ModelAttribute
	public UserCompany get(@RequestParam(required=false) String id) {
		UserCompany entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userCompanyService.get(id);
		}
		if (entity == null){
			entity = new UserCompany();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userCompany:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserCompany userCompany, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserCompany> page = userCompanyService.findPage(new Page<UserCompany>(request, response), userCompany); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userCompanyList";
	}

	@RequiresPermissions("wlpt:user:userCompany:view")
	@RequestMapping(value = "form")
	public String form(UserCompany userCompany, Model model) {
		model.addAttribute("userCompany", userCompany);
		return "modules/wlpt/user/userCompanyForm";
	}

	@RequiresPermissions("wlpt:user:userCompany:edit")
	@RequestMapping(value = "save")
	public String save(UserCompany userCompany, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userCompany)){
			return form(userCompany, model);
		}
		userCompanyService.save(userCompany);
		addMessage(redirectAttributes, "保存公司信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userCompany/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userCompany:edit")
	@RequestMapping(value = "delete")
	public String delete(UserCompany userCompany, RedirectAttributes redirectAttributes) {
		userCompanyService.delete(userCompany);
		addMessage(redirectAttributes, "删除公司信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userCompany/?repage";
	}

}