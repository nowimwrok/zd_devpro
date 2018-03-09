/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.trade;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
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
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;


/**
 * 运单信息Controller
 * @author 饶江龙
 * @version 2016-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/trade/orderinfo")
public class OrderinfoController extends BaseController {

	@Autowired
	@Resource(name = "tradeBiz")
	private TradeBiz tradeBiz;

	@ModelAttribute
	public Orderinfo get(@RequestParam(required=false) String id) {
		Orderinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = tradeBiz.get(id);
		}
		if (entity == null){
			entity = new Orderinfo();
		}
		return entity;
	}

	/***
	 * 确认运单信息,传运单ID
	 * @param orderinfo 传运单ID
	 * @param model
	 * @param redirectAttributes
     * @return
     */
	@RequestMapping(value = {"confrimOrder", ""})
	public String confrimOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		String url="modules/wlpt/trade/orderinfoList";
		int result=tradeBiz.confrimOrderBiz(orderinfo,model);
		if (DataDic.RETURN_STATUS_NORMAL!=result){
			model.addAttribute("orderinfo",orderinfo);
			model.addAttribute("quoteinfo",orderinfo.getQuoteinfo());
			model.addAttribute("message",Tools.statusMessage(result,"确认运单"));
			return "redirect:"+Global.getAdminPath()+"/wlpt/trade/orderinfo/?repage";
		}
		return url;
	}

	/***
	 * 报价生成运单
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
     * @return
     */
	@RequestMapping(value = {"createOrder", ""})
	public String createOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		String url="modules/wlpt/trade/orderinfoList";
		int result=tradeBiz.createOrderBiz(orderinfo,model);
		///返回结果是否正常
		if (result != DataDic.RETURN_STATUS_NORMAL){
			model.addAttribute("orderinfo",orderinfo);
			model.addAttribute("quoteinfo",orderinfo.getQuoteinfo());
			model.addAttribute("message", Tools.statusMessage(result,"生成运单"));
			return "redirect:"+Global.getAdminPath()+"/wlpt/goods/quoteinfo/quoteOrder?id"+orderinfo.getQuoteinfo().getId();
		}
		return url;
	}

	/**
	 * 获取列表信息
	 * @param orderinfo
	 * @param request
	 * @param response
	 * @param model
     * @return
     */
	@RequiresPermissions("wlpt:trade:orderinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Orderinfo> page = tradeBiz.getOrderList(new Page<Orderinfo>(request, response), orderinfo);
		model.addAttribute("page", page);
		return "modules/wlpt/trade/orderinfoList";
	}

	/*@RequiresPermissions("wlpt:trade:orderinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Orderinfo> page = orderinfoService.findPage(new Page<Orderinfo>(request, response), orderinfo); 
		model.addAttribute("page", page);
		return "modules/wlpt/trade/orderinfoList";
	}*/

	@RequiresPermissions("wlpt:trade:orderinfo:view")
	@RequestMapping(value = "form")
	public String form(Orderinfo orderinfo, Model model) {
		model.addAttribute("orderinfo", orderinfo);
		return "modules/wlpt/trade/orderinfoForm";
	}

	@RequiresPermissions("wlpt:trade:orderinfo:edit")
	@RequestMapping(value = "save")
	public String save(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, orderinfo)){
			return form(orderinfo, model);
		}
		tradeBiz.save(orderinfo);
		addMessage(redirectAttributes, "保存运单成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/trade/orderinfo/?repage";
	}

	@RequiresPermissions("wlpt:trade:orderinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(Orderinfo orderinfo, RedirectAttributes redirectAttributes) {
		tradeBiz.delete(orderinfo);
		addMessage(redirectAttributes, "删除运单成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/trade/orderinfo/?repage";
	}
	
	/**
	 * 获取支付审核列表信息
	 * @param orderinfo
	 * @param request
	 * @param response
	 * @param model
     * @return
     */
	@RequiresPermissions("wlpt:trade:orderinfo:view")
	@RequestMapping(value = {"orderPayApplylist", ""})
	public String orderPayApplylist(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		orderinfo.setPayway(DataDic.ORDER_PAYWAY_ACCOUNT);
		orderinfo.setOrderstatus(DataDic.ORDER_STATUS_PAY);
		//orderinfo.setOrderispay("1");
		Page<Orderinfo> page = tradeBiz.findPage(new Page<Orderinfo>(request, response), orderinfo);
		model.addAttribute("page", page);
		return "modules/wlpt/trade/orderapplyinfoList";
	}
	@RequiresPermissions("wlpt:trade:orderinfo:edit")
	@RequestMapping(value = "tradePayinfoApply")
	public String tradePayinfoApply(Orderinfo orderinfo, Model model) {
		
		model.addAttribute("orderinfo", orderinfo);
		return "modules/wlpt/trade/tradePayinfoApplyForm";
	}
	
	
	
	@RequiresPermissions("wlpt:trade:orderinfo:edit")
	@RequestMapping(value = "orderPayapplyinfo")
	public String orderPayapplyinfo(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		map = tradeBiz.orderPayApply(orderinfo.getId());
		addMessage(redirectAttributes, map.get("message").toString());
		return "redirect:"+Global.getAdminPath()+"/wlpt/trade/orderinfo/orderPayApplylist";
	}
}