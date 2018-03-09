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
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsuranceInfo;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceInfoService;

/**
 * 保险险种记录Controller
 * @author zyj
 * @version 2017-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/insur/userInsuranceInfo")
public class UserInsuranceInfoController extends BaseController {

	@Autowired
	private UserInsuranceInfoService userInsuranceInfoService;
	
	@ModelAttribute
	public UserInsuranceInfo get(@RequestParam(required=false) String id) {
		UserInsuranceInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userInsuranceInfoService.get(id);
		}
		if (entity == null){
			entity = new UserInsuranceInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:insur:userInsuranceInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserInsuranceInfo userInsuranceInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserInsuranceInfo> page = userInsuranceInfoService.findPage(new Page<UserInsuranceInfo>(request, response), userInsuranceInfo); 
		model.addAttribute("page", page);
		return "modules/wlpt/insur/userInsuranceInfoList";
	}

	@RequiresPermissions("wlpt:insur:userInsuranceInfo:view")
	@RequestMapping(value = "form")
	public String form(UserInsuranceInfo userInsuranceInfo, Model model) {
		model.addAttribute("userInsuranceInfo", userInsuranceInfo);
		return "modules/wlpt/insur/userInsuranceInfoForm";
	}

	@RequiresPermissions("wlpt:insur:userInsuranceInfo:edit")
	@RequestMapping(value = "save")
	public String save(UserInsuranceInfo userInsuranceInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userInsuranceInfo)){
			return form(userInsuranceInfo, model);
		}
		userInsuranceInfoService.save(userInsuranceInfo);
		addMessage(redirectAttributes, "保存保险险种记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/insur/userInsuranceInfo/?repage";
	}
	
	@RequiresPermissions("wlpt:insur:userInsuranceInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(UserInsuranceInfo userInsuranceInfo, RedirectAttributes redirectAttributes) {
		userInsuranceInfoService.delete(userInsuranceInfo);
		addMessage(redirectAttributes, "删除保险险种记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/insur/userInsuranceInfo/?repage";
	}

}