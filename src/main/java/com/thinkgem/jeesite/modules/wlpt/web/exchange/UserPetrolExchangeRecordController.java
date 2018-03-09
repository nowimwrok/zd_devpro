/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.exchange;

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
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchangeRecord;
import com.thinkgem.jeesite.modules.wlpt.service.exchange.UserPetrolExchangeRecordService;

/**
 * 油气兑换余额关系表Controller
 * @author zyj
 * @version 2017-02-15
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/exchange/userPetrolExchangeRecord")
public class UserPetrolExchangeRecordController extends BaseController {

	@Autowired
	private UserPetrolExchangeRecordService userPetrolExchangeRecordService;
	
	@ModelAttribute
	public UserPetrolExchangeRecord get(@RequestParam(required=false) String id) {
		UserPetrolExchangeRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userPetrolExchangeRecordService.get(id);
		}
		if (entity == null){
			entity = new UserPetrolExchangeRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:exchange:userPetrolExchangeRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserPetrolExchangeRecord userPetrolExchangeRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserPetrolExchangeRecord> page = userPetrolExchangeRecordService.findPage(new Page<UserPetrolExchangeRecord>(request, response), userPetrolExchangeRecord); 
		model.addAttribute("page", page);
		return "modules/wlpt/exchange/userPetrolExchangeRecordList";
	}

	@RequiresPermissions("wlpt:exchange:userPetrolExchangeRecord:view")
	@RequestMapping(value = "form")
	public String form(UserPetrolExchangeRecord userPetrolExchangeRecord, Model model) {
		model.addAttribute("userPetrolExchangeRecord", userPetrolExchangeRecord);
		return "modules/wlpt/exchange/userPetrolExchangeRecordForm";
	}

	@RequiresPermissions("wlpt:exchange:userPetrolExchangeRecord:edit")
	@RequestMapping(value = "save")
	public String save(UserPetrolExchangeRecord userPetrolExchangeRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userPetrolExchangeRecord)){
			return form(userPetrolExchangeRecord, model);
		}
		userPetrolExchangeRecordService.save(userPetrolExchangeRecord);
		addMessage(redirectAttributes, "保存油气兑换余额关系记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/exchange/userPetrolExchangeRecord/?repage";
	}
	
	@RequiresPermissions("wlpt:exchange:userPetrolExchangeRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(UserPetrolExchangeRecord userPetrolExchangeRecord, RedirectAttributes redirectAttributes) {
		userPetrolExchangeRecordService.delete(userPetrolExchangeRecord);
		addMessage(redirectAttributes, "删除油气兑换余额关系记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/exchange/userPetrolExchangeRecord/?repage";
	}

}