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
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradePayinfoService;

/**
 * 运单支付信息Controller
 * @author 饶江龙
 * @version 2016-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/trade/tradePayinfo")
public class TradePayinfoController extends BaseController {

	@Autowired
	private TradePayinfoService tradePayinfoService;
	
	@ModelAttribute
	public TradePayinfo get(@RequestParam(required=false) String id) {
		TradePayinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = tradePayinfoService.get(id);
		}
		if (entity == null){
			entity = new TradePayinfo();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:trade:tradePayinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(TradePayinfo tradePayinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TradePayinfo> page = tradePayinfoService.findPage(new Page<TradePayinfo>(request, response), tradePayinfo); 
		model.addAttribute("page", page);
		return "modules/wlpt/trade/tradePayinfoList";
	}

	@RequiresPermissions("wlpt:trade:tradePayinfo:view")
	@RequestMapping(value = "form")
	public String form(TradePayinfo tradePayinfo, Model model) {
		model.addAttribute("tradePayinfo", tradePayinfo);
		return "modules/wlpt/trade/tradePayinfoForm";
	}

	@RequiresPermissions("wlpt:trade:tradePayinfo:edit")
	@RequestMapping(value = "save")
	public String save(TradePayinfo tradePayinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, tradePayinfo)){
			return form(tradePayinfo, model);
		}
		tradePayinfoService.save(tradePayinfo);
		addMessage(redirectAttributes, "保存支付信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/trade/tradePayinfo/?repage";
	}
	
	@RequiresPermissions("wlpt:trade:tradePayinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(TradePayinfo tradePayinfo, RedirectAttributes redirectAttributes) {
		tradePayinfoService.delete(tradePayinfo);
		addMessage(redirectAttributes, "删除支付信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/trade/tradePayinfo/?repage";
	}

}