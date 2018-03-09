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
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserSettle;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserSettleService;

/**
 * 用户结算资金－－招标结算资金Controller
 * @author 饶江龙
 * @version 2016-07-24
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userSettle")
public class UserSettleController extends BaseController {

	@Autowired
	private UserSettleService userSettleService;
	
	@ModelAttribute
	public UserSettle get(@RequestParam(required=false) String id) {
		UserSettle entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userSettleService.get(id);
		}
		if (entity == null){
			entity = new UserSettle();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userSettle:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserSettle userSettle, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserSettle> page = userSettleService.findPage(new Page<UserSettle>(request, response), userSettle); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userSettleList";
	}

	@RequiresPermissions("wlpt:user:userSettle:view")
	@RequestMapping(value = "form")
	public String form(UserSettle userSettle, Model model) {
		model.addAttribute("userSettle", userSettle);
		return "modules/wlpt/user/userSettleForm";
	}

	@RequiresPermissions("wlpt:user:userSettle:edit")
	@RequestMapping(value = "save")
	public String save(UserSettle userSettle, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userSettle)){
			return form(userSettle, model);
		}
		userSettleService.save(userSettle);
		addMessage(redirectAttributes, "保存用户结算成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userSettle/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userSettle:edit")
	@RequestMapping(value = "delete")
	public String delete(UserSettle userSettle, RedirectAttributes redirectAttributes) {
		userSettleService.delete(userSettle);
		addMessage(redirectAttributes, "删除用户结算成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userSettle/?repage";
	}

}