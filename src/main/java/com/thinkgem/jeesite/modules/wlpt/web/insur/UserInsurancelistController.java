/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.insur;

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
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurancelist;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsurancelistService;

/**
 * 保险品种管理Controller
 * @author zyj
 * @version 2017-03-09
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/insur/userInsurancelist")
public class UserInsurancelistController extends BaseController {

	@Autowired
	private UserInsurancelistService userInsurancelistService;
	
	@ModelAttribute
	public UserInsurancelist get(@RequestParam(required=false) String id) {
		UserInsurancelist entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userInsurancelistService.get(id);
		}
		if (entity == null){
			entity = new UserInsurancelist();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:insur:userInsurancelist:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserInsurancelist userInsurancelist, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserInsurancelist> page = userInsurancelistService.findPage(new Page<UserInsurancelist>(request, response), userInsurancelist); 
		model.addAttribute("page", page);
		return "modules/wlpt/insur/userInsurancelistList";
	}

	@RequiresPermissions("wlpt:insur:userInsurancelist:view")
	@RequestMapping(value = "form")
	public String form(UserInsurancelist userInsurancelist, Model model) {
		model.addAttribute("userInsurancelist", userInsurancelist);
		return "modules/wlpt/insur/userInsurancelistForm";
	}

	@RequiresPermissions("wlpt:insur:userInsurancelist:edit")
	@RequestMapping(value = "save")
	public String save(UserInsurancelist userInsurancelist, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userInsurancelist)){
			return form(userInsurancelist, model);
		}
		userInsurancelistService.save(userInsurancelist);
		addMessage(redirectAttributes, "保存保险险种管理成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/insur/userInsurancelist/?repage";
	}
	
	@RequiresPermissions("wlpt:insur:userInsurancelist:edit")
	@RequestMapping(value = "delete")
	public String delete(UserInsurancelist userInsurancelist, RedirectAttributes redirectAttributes) {
		userInsurancelistService.delete(userInsurancelist);
		addMessage(redirectAttributes, "删除保险险种管理成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/insur/userInsurancelist/?repage";
	}

}