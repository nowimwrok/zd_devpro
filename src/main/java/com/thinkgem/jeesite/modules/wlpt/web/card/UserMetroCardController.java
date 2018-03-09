/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.card;

import java.util.Map;

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
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardService;

/**
 * 用户一卡通Controller
 * 
 * @author 刘欣
 * @version 2016-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/card/userMetroCard")
public class UserMetroCardController extends BaseController {

	@Autowired
	private UserMetroCardService userMetroCardService;

	@Autowired
	private MetroCardBiz metroCardBiz;

	@ModelAttribute
	public UserMetroCard get(@RequestParam(required = false) String id) {
		UserMetroCard entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = userMetroCardService.get(id);
		}
		if (entity == null) {
			entity = new UserMetroCard();
		}
		return entity;
	}

	@RequiresPermissions("wlpt:card:userMetroCard:view")
	@RequestMapping(value = { "list", "" })
	public String list(UserMetroCard userMetroCard, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<UserMetroCard> page = userMetroCardService.findPage(new Page<UserMetroCard>(request, response),
				userMetroCard);
		model.addAttribute("page", page);
		return "modules/wlpt/card/userMetroCardList";
	}

	@RequiresPermissions("wlpt:card:userMetroCard:view")
	@RequestMapping(value = "form")
	public String form(UserMetroCard userMetroCard, Model model) {
		model.addAttribute("userMetroCard", userMetroCard);
		return "modules/wlpt/card/userMetroCardForm";
	}

	@RequiresPermissions("wlpt:card:userMetroCard:edit")
	@RequestMapping(value = "save")
	public String save(UserMetroCard userMetroCard, Model model, RedirectAttributes redirectAttributes) {
		/*
		 * if (!beanValidator(model, userMetroCard)){ return form(userMetroCard,
		 * model); }
		 */
		Map<String, Object> map = metroCardBiz.audit(userMetroCard);
		addMessage(redirectAttributes, map.get("message").toString());
		return "redirect:" + Global.getAdminPath() + "/wlpt/card/userMetroCard/?repage";
	}

	@RequiresPermissions("wlpt:card:userMetroCard:edit")
	@RequestMapping(value = "delete")
	public String delete(UserMetroCard userMetroCard, RedirectAttributes redirectAttributes) {
		userMetroCardService.delete(userMetroCard);
		addMessage(redirectAttributes, "删除用户一卡通成功");
		return "redirect:" + Global.getAdminPath() + "/wlpt/card/userMetroCard/?repage";
	}

	@RequiresPermissions("wlpt:card:userMetroCard:view")
	@RequestMapping(value = "toedit")
	public String toedit(UserMetroCard userMetroCard, Model model) {
		model.addAttribute("userMetroCard", userMetroCard);
		return "modules/wlpt/card/userMetroCardEdit";
	}
	
	/**
	 * 编辑基本信息
	 * 
	 * @param userMetroCard
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("wlpt:card:userMetroCard:edit")
	@RequestMapping(value = "edit")
	public String edit(UserMetroCard userMetroCard, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = metroCardBiz.updateCard(userMetroCard);
		addMessage(redirectAttributes, map.get("message").toString());
		return "redirect:" + Global.getAdminPath() + "/wlpt/card/userMetroCard/?repage";
	}
}