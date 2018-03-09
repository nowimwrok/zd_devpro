/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.card;

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
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardLoss;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardLossService;

/**
 * 一卡通挂失Controller
 * @author fjc
 * @version 2016-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/card/userMetroCardLoss")
public class UserMetroCardLossController extends BaseController {

	@Autowired
	private UserMetroCardLossService userMetroCardLossService;
	
	@ModelAttribute
	public UserMetroCardLoss get(@RequestParam(required=false) String id) {
		UserMetroCardLoss entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userMetroCardLossService.get(id);
		}
		if (entity == null){
			entity = new UserMetroCardLoss();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:card:userMetroCardLoss:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserMetroCardLoss userMetroCardLoss, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserMetroCardLoss> page = userMetroCardLossService.findPage(new Page<UserMetroCardLoss>(request, response), userMetroCardLoss); 
		model.addAttribute("page", page);
		return "modules/wlpt/card/userMetroCardLossList";
	}

	@RequiresPermissions("wlpt:card:userMetroCardLoss:view")
	@RequestMapping(value = "form")
	public String form(UserMetroCardLoss userMetroCardLoss, Model model) {
		model.addAttribute("userMetroCardLoss", userMetroCardLoss);
		return "modules/wlpt/card/userMetroCardLossForm";
	}

	@RequiresPermissions("wlpt:card:userMetroCardLoss:edit")
	@RequestMapping(value = "save")
	public String save(UserMetroCardLoss userMetroCardLoss, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userMetroCardLoss)){
			return form(userMetroCardLoss, model);
		}
		userMetroCardLossService.save(userMetroCardLoss);
		addMessage(redirectAttributes, "保存一卡通挂失信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroCardLoss/?repage";
	}
	
	@RequiresPermissions("wlpt:card:userMetroCardLoss:edit")
	@RequestMapping(value = "delete")
	public String delete(UserMetroCardLoss userMetroCardLoss, RedirectAttributes redirectAttributes) {
		userMetroCardLossService.delete(userMetroCardLoss);
		addMessage(redirectAttributes, "删除一卡通挂失信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroCardLoss/?repage";
	}

}