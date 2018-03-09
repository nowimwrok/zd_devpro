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
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserPurseService;

/**
 * 用户钱包信息Controller
 * @author 饶江龙
 * @version 2016-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userPurse")
public class UserPurseController extends BaseController {

	@Autowired
	private UserPurseService userPurseService;
	
	@ModelAttribute
	public UserPurse get(@RequestParam(required=false) String id) {
		UserPurse entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userPurseService.get(id);
		}
		if (entity == null){
			entity = new UserPurse();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userPurse:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserPurse userPurse, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserPurse> page = userPurseService.findPage(new Page<UserPurse>(request, response), userPurse); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userPurseList";
	}

	@RequiresPermissions("wlpt:user:userPurse:view")
	@RequestMapping(value = "form")
	public String form(UserPurse userPurse, Model model) {
		model.addAttribute("userPurse", userPurse);
		return "modules/wlpt/user/userPurseForm";
	}

	@RequiresPermissions("wlpt:user:userPurse:edit")
	@RequestMapping(value = "save")
	public String save(UserPurse userPurse, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userPurse)){
			return form(userPurse, model);
		}
		userPurseService.save(userPurse);
		addMessage(redirectAttributes, "保存用户钱包成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userPurse/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userPurse:edit")
	@RequestMapping(value = "delete")
	public String delete(UserPurse userPurse, RedirectAttributes redirectAttributes) {
		userPurseService.delete(userPurse);
		addMessage(redirectAttributes, "删除用户钱包成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userPurse/?repage";
	}

}