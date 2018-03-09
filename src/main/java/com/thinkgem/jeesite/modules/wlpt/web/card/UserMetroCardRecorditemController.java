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
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecorditem;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecorditemService;

/**
 * 一卡通消费记录明细Controller
 * @author zyj
 * @version 2016-11-24
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/card/userMetroCardRecorditem")
public class UserMetroCardRecorditemController extends BaseController {

	@Autowired
	private UserMetroCardRecorditemService userMetroCardRecorditemService;
	
	@ModelAttribute
	public UserMetroCardRecorditem get(@RequestParam(required=false) String id) {
		UserMetroCardRecorditem entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userMetroCardRecorditemService.get(id);
		}
		if (entity == null){
			entity = new UserMetroCardRecorditem();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:card:userMetroCardRecorditem:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserMetroCardRecorditem userMetroCardRecorditem, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserMetroCardRecorditem> page = userMetroCardRecorditemService.findPage(new Page<UserMetroCardRecorditem>(request, response), userMetroCardRecorditem); 
		model.addAttribute("page", page);
		return "modules/wlpt/card/userMetroCardRecorditemList";
	}

	@RequiresPermissions("wlpt:card:userMetroCardRecorditem:view")
	@RequestMapping(value = "form")
	public String form(UserMetroCardRecorditem userMetroCardRecorditem, Model model) {
		model.addAttribute("userMetroCardRecorditem", userMetroCardRecorditem);
		return "modules/wlpt/card/userMetroCardRecorditemForm";
	}

	@RequiresPermissions("wlpt:card:userMetroCardRecorditem:edit")
	@RequestMapping(value = "save")
	public String save(UserMetroCardRecorditem userMetroCardRecorditem, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userMetroCardRecorditem)){
			return form(userMetroCardRecorditem, model);
		}
		userMetroCardRecorditemService.save(userMetroCardRecorditem);
		addMessage(redirectAttributes, "保存一卡通消费记录明细成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroCardRecorditem/?repage";
	}
	
	@RequiresPermissions("wlpt:card:userMetroCardRecorditem:edit")
	@RequestMapping(value = "delete")
	public String delete(UserMetroCardRecorditem userMetroCardRecorditem, RedirectAttributes redirectAttributes) {
		userMetroCardRecorditemService.delete(userMetroCardRecorditem);
		addMessage(redirectAttributes, "删除一卡通消费记录明细成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroCardRecorditem/?repage";
	}

}