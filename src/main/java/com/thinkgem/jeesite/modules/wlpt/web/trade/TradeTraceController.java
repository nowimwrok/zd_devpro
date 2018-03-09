/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.trade;

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
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeTrace;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradeTraceService;

/**
 * 运单操作日志记录Controller
 * @author 饶江龙
 * @version 2016-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/trade/tradeTrace")
public class TradeTraceController extends BaseController {

	@Autowired
	private TradeTraceService tradeTraceService;
	
	@ModelAttribute
	public TradeTrace get(@RequestParam(required=false) String id) {
		TradeTrace entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = tradeTraceService.get(id);
		}
		if (entity == null){
			entity = new TradeTrace();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:trade:tradeTrace:view")
	@RequestMapping(value = {"list", ""})
	public String list(TradeTrace tradeTrace, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TradeTrace> page = tradeTraceService.findPage(new Page<TradeTrace>(request, response), tradeTrace); 
		model.addAttribute("page", page);
		return "modules/wlpt/trade/tradeTraceList";
	}

	@RequiresPermissions("wlpt:trade:tradeTrace:view")
	@RequestMapping(value = "form")
	public String form(TradeTrace tradeTrace, Model model) {
		model.addAttribute("tradeTrace", tradeTrace);
		return "modules/wlpt/trade/tradeTraceForm";
	}

	@RequiresPermissions("wlpt:trade:tradeTrace:edit")
	@RequestMapping(value = "save")
	public String save(TradeTrace tradeTrace, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, tradeTrace)){
			return form(tradeTrace, model);
		}
		tradeTraceService.save(tradeTrace);
		addMessage(redirectAttributes, "保存操作记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/trade/tradeTrace/?repage";
	}
	
	@RequiresPermissions("wlpt:trade:tradeTrace:edit")
	@RequestMapping(value = "delete")
	public String delete(TradeTrace tradeTrace, RedirectAttributes redirectAttributes) {
		tradeTraceService.delete(tradeTrace);
		addMessage(redirectAttributes, "删除操作记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/trade/tradeTrace/?repage";
	}

}