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
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserIdcard;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserIdcardService;

/**
 * 用户身份证Controller
 * @author fjc
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userIdcard")
public class UserIdcardController extends BaseController {

	@Autowired
	private UserIdcardService userIdcardService;
	
	@ModelAttribute
	public UserIdcard get(@RequestParam(required=false) String id) {
		UserIdcard entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userIdcardService.get(id);
		}
		if (entity == null){
			entity = new UserIdcard();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userIdcard:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserIdcard userIdcard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserIdcard> page = userIdcardService.findPage(new Page<UserIdcard>(request, response), userIdcard); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userIdcardList";
	}

	@RequiresPermissions("wlpt:user:userIdcard:view")
	@RequestMapping(value = "form")
	public String form(UserIdcard userIdcard, Model model) {
		model.addAttribute("userIdcard", userIdcard);
		return "modules/wlpt/user/userIdcardForm";
	}

	@RequiresPermissions("wlpt:user:userIdcard:edit")
	@RequestMapping(value = "save")
	public String save(UserIdcard userIdcard, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userIdcard)){
			return form(userIdcard, model);
		}
		userIdcardService.save(userIdcard);
		addMessage(redirectAttributes, "保存用户身份证信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userIdcard/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userIdcard:edit")
	@RequestMapping(value = "delete")
	public String delete(UserIdcard userIdcard, RedirectAttributes redirectAttributes) {
		userIdcardService.delete(userIdcard);
		addMessage(redirectAttributes, "删除用户身份证信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userIdcard/?repage";
	}

}