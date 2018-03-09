/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.consume;

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
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Deallog;
import com.thinkgem.jeesite.modules.wlpt.service.consume.DeallogService;

/**
 * 后台充值账户审核日志记录Controller
 * @author 饶江龙
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/consume/deallog")
public class DeallogController extends BaseController {

	@Autowired
	private DeallogService deallogService;
	
	@ModelAttribute
	public Deallog get(@RequestParam(required=false) String id) {
		Deallog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = deallogService.get(id);
		}
		if (entity == null){
			entity = new Deallog();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:consume:deallog:view")
	@RequestMapping(value = {"list", ""})
	public String list(Deallog deallog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Deallog> page = deallogService.findPage(new Page<Deallog>(request, response), deallog); 
		model.addAttribute("page", page);
		return "modules/wlpt/consume/deallogList";
	}

	@RequiresPermissions("wlpt:consume:deallog:view")
	@RequestMapping(value = "form")
	public String form(Deallog deallog, Model model) {
		model.addAttribute("deallog", deallog);
		return "modules/wlpt/consume/deallogForm";
	}

	@RequiresPermissions("wlpt:consume:deallog:edit")
	@RequestMapping(value = "save")
	public String save(Deallog deallog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, deallog)){
			return form(deallog, model);
		}
		deallogService.save(deallog);
		addMessage(redirectAttributes, "保存处理日志成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/consume/deallog/?repage";
	}
	
	@RequiresPermissions("wlpt:consume:deallog:edit")
	@RequestMapping(value = "delete")
	public String delete(Deallog deallog, RedirectAttributes redirectAttributes) {
		deallogService.delete(deallog);
		addMessage(redirectAttributes, "删除处理日志成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/consume/deallog/?repage";
	}

}