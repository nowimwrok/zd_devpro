/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.webapi.integralexchange;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.integralexchange.Integralexchange;
import com.thinkgem.jeesite.modules.wlpt.service.integralexchange.IntegralexchangeService;

/**
 * 积分规则Controller
 * @author qiao
 * @version 2017-12-22
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integralexchange")
public class IntegralexchangeController extends BaseController {

	@Autowired
	private IntegralexchangeService integralexchangeService;
	
	@ModelAttribute
	public Integralexchange get(@RequestParam(required=false) String id) {
		Integralexchange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = integralexchangeService.get(id);
		}
		if (entity == null){
			entity = new Integralexchange();
		}
		return entity;
	}
	
	@RequestMapping(value = "list")
	public String list(Integralexchange integralexchange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Integralexchange> page = integralexchangeService.findPage(new Page<Integralexchange>(request, response), integralexchange); 
		model.addAttribute("page", page);
		return "modules/wlpt/integralexchange/integralexchangeList";
	}

	@RequestMapping(value = "form")
	public String form(Integralexchange integralexchange, Model model) {
		model.addAttribute("integralexchange", integralexchange);
		return "modules/wlpt/integralexchange/integralexchangeForm";
	}

	@RequestMapping(value = "save")
	public String save(Integralexchange integralexchange, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integralexchange)){
			return form(integralexchange, model);
		}
		integralexchangeService.save(integralexchange);
		addMessage(redirectAttributes, "保存积分规则成功");
		//return "redirect:"+Global.getAdminPath()+"/wlpt/integralexchange/integralexchangeList";
		return "modules/wlpt/integralexchange/integralexchangeForm";
	}
	
	@RequestMapping(value = "delete")
	public String delete(Integralexchange integralexchange, RedirectAttributes redirectAttributes) {
		integralexchangeService.delete(integralexchange);
		addMessage(redirectAttributes, "删除积分规则成功");
		//return "redirect:"+Global.getAdminPath()+"/wlpt/integralexchange/integralexchange/?repage";
		return "modules/wlpt/integralexchange/integralexchangeList";
	}

}