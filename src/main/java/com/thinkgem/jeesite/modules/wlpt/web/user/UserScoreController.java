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
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserScore;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserScoreService;

/**
 * 用户积分表，相关等级、积分诚信积分Controller
 * @author 饶江龙
 * @version 2016-07-22
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userScore")
public class UserScoreController extends BaseController {

	@Autowired
	private UserScoreService userScoreService;
	
	@ModelAttribute
	public UserScore get(@RequestParam(required=false) String id) {
		UserScore entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userScoreService.get(id);
		}
		if (entity == null){
			entity = new UserScore();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userScore:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserScore userScore, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserScore> page = userScoreService.findPage(new Page<UserScore>(request, response), userScore); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userScoreList";
	}

	@RequiresPermissions("wlpt:user:userScore:view")
	@RequestMapping(value = "form")
	public String form(UserScore userScore, Model model) {
		model.addAttribute("userScore", userScore);
		return "modules/wlpt/user/userScoreForm";
	}

	@RequiresPermissions("wlpt:user:userScore:edit")
	@RequestMapping(value = "save")
	public String save(UserScore userScore, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userScore)){
			return form(userScore, model);
		}
		userScoreService.save(userScore);
		addMessage(redirectAttributes, "保存用户积分成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userScore/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userScore:edit")
	@RequestMapping(value = "delete")
	public String delete(UserScore userScore, RedirectAttributes redirectAttributes) {
		userScoreService.delete(userScore);
		addMessage(redirectAttributes, "删除用户积分成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userScore/?repage";
	}

}