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
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanypictureService;

/**
 * 企业图片信息Controller
 * @author fjc
 * @version 2016-07-27
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userCompanypicture")
public class UserCompanypictureController extends BaseController {

	@Autowired
	private UserCompanypictureService userCompanypictureService;
	
	@ModelAttribute
	public UserCompanypicture get(@RequestParam(required=false) String id) {
		UserCompanypicture entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userCompanypictureService.get(id);
		}
		if (entity == null){
			entity = new UserCompanypicture();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userCompanypicture:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserCompanypicture userCompanypicture, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserCompanypicture> page = userCompanypictureService.findPage(new Page<UserCompanypicture>(request, response), userCompanypicture); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userCompanypictureList";
	}

	@RequiresPermissions("wlpt:user:userCompanypicture:view")
	@RequestMapping(value = "form")
	public String form(UserCompanypicture userCompanypicture, Model model) {
		model.addAttribute("userCompanypicture", userCompanypicture);
		return "modules/wlpt/user/userCompanypictureForm";
	}

	@RequiresPermissions("wlpt:user:userCompanypicture:edit")
	@RequestMapping(value = "save")
	public String save(UserCompanypicture userCompanypicture, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userCompanypicture)){
			return form(userCompanypicture, model);
		}
		userCompanypictureService.save(userCompanypicture);
		addMessage(redirectAttributes, "保存企业信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userCompanypicture/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userCompanypicture:edit")
	@RequestMapping(value = "delete")
	public String delete(UserCompanypicture userCompanypicture, RedirectAttributes redirectAttributes) {
		userCompanypictureService.delete(userCompanypicture);
		addMessage(redirectAttributes, "删除企业信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userCompanypicture/?repage";
	}

}