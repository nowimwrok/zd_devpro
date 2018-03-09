/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.contacts;

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
import com.thinkgem.jeesite.modules.wlpt.biz.contacts.CommonContactsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.contacts.UserCommonContacts;
import com.thinkgem.jeesite.modules.wlpt.service.contacts.UserCommonContactsService;

/**
 * 常用联系人Controller
 * @author zyj
 * @version 2017-04-11
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/contacts/userCommonContacts")
public class UserCommonContactsController extends BaseController {

	@Autowired
	private CommonContactsBiz commonContactsBiz;
	
	@ModelAttribute
	public UserCommonContacts get(@RequestParam(required=false) String id) {
		UserCommonContacts entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = commonContactsBiz.get(id);
		}
		if (entity == null){
			entity = new UserCommonContacts();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:contacts:userCommonContacts:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserCommonContacts userCommonContacts, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserCommonContacts> page = commonContactsBiz.findPage(new Page<UserCommonContacts>(request, response), userCommonContacts); 
		model.addAttribute("page", page);
		return "modules/wlpt/contacts/userCommonContactsList";
	}

	@RequiresPermissions("wlpt:contacts:userCommonContacts:view")
	@RequestMapping(value = "form")
	public String form(UserCommonContacts userCommonContacts, Model model) {
		model.addAttribute("userCommonContacts", userCommonContacts);
		return "modules/wlpt/contacts/userCommonContactsForm";
	}

	@RequiresPermissions("wlpt:contacts:userCommonContacts:edit")
	@RequestMapping(value = "save")
	public String save(UserCommonContacts userCommonContacts, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userCommonContacts)){
			return form(userCommonContacts, model);
		}
		commonContactsBiz.save(userCommonContacts);
		addMessage(redirectAttributes, "保存常用联系人成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/contacts/userCommonContacts/?repage";
	}
	
	@RequiresPermissions("wlpt:contacts:userCommonContacts:edit")
	@RequestMapping(value = "delete")
	public String delete(UserCommonContacts userCommonContacts, RedirectAttributes redirectAttributes) {
		commonContactsBiz.delete(userCommonContacts);
		addMessage(redirectAttributes, "删除常用联系人成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/contacts/userCommonContacts/?repage";
	}

}