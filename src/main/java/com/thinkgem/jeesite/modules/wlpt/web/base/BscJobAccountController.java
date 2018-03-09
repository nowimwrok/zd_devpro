/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

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
import com.thinkgem.jeesite.modules.wlpt.biz.base.BscJobAccountBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJobAccount;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscJobAccountService;

/**
 * 轮询任务数据管理Controller
 * @author zyj
 * @version 2017-03-21
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/bscJobAccount")
public class BscJobAccountController extends BaseController {

	@Autowired
	private BscJobAccountBiz bscJobAccountBiz;
	
	@ModelAttribute
	public BscJobAccount get(@RequestParam(required=false) String id) {
		BscJobAccount entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bscJobAccountBiz.get(id);
		}
		if (entity == null){
			entity = new BscJobAccount();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:bscJobAccount:view")
	@RequestMapping(value = {"list", ""})
	public String list(BscJobAccount bscJobAccount, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BscJobAccount> page = bscJobAccountBiz.findPage(new Page<BscJobAccount>(request, response), bscJobAccount); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/bscJobAccountList";
	}

	@RequiresPermissions("wlpt:base:bscJobAccount:view")
	@RequestMapping(value = "form")
	public String form(BscJobAccount bscJobAccount, Model model) {
		model.addAttribute("bscJobAccount", bscJobAccount);
		return "modules/wlpt/base/bscJobAccountForm";
	}

	@RequiresPermissions("wlpt:base:bscJobAccount:edit")
	@RequestMapping(value = "save")
	public String save(BscJobAccount bscJobAccount, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bscJobAccount)){
			return form(bscJobAccount, model);
		}
		bscJobAccountBiz.save(bscJobAccount);
		addMessage(redirectAttributes, "保存轮询任务数据管理成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscJobAccount/?repage";
	}
	
	@RequiresPermissions("wlpt:base:bscJobAccount:edit")
	@RequestMapping(value = "delete")
	public String delete(BscJobAccount bscJobAccount, RedirectAttributes redirectAttributes) {
		bscJobAccountBiz.delete(bscJobAccount);
		addMessage(redirectAttributes, "删除轮询任务数据管理成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscJobAccount/?repage";
	}

}