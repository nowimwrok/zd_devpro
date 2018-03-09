/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.trade;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
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
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeReceipt;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradeReceiptService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradeReceiptService;

/**
 * 运单证明Controller
 * @author 饶江龙
 * @version 2016-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/trade/tradereceipt")
public class TradeReceiptController extends BaseController {

	@Autowired
	private TradeReceiptService tradeReceiptService;
	
	@Autowired
	private TradeBiz tradeBiz;
	
	   @ModelAttribute
	    public TradeReceipt get(@RequestParam(required=false) String id) {
	        TradeReceipt entity = null;
	        if (StringUtils.isNotBlank(id)){
	            entity = tradeReceiptService.get(id);
	        }
	        if (entity == null){
	            entity = new TradeReceipt();
	        }
	        return entity;
	    }

	    @RequiresPermissions("wlpt:trade:tradeReceipt:view")
	    @RequestMapping(value = {"list", ""})
	    public String list(TradeReceipt tradeReceipt, HttpServletRequest request, HttpServletResponse response, Model model) {
	        Page<TradeReceipt> page = tradeReceiptService.findPage(new Page<TradeReceipt>(request, response), tradeReceipt);
	        model.addAttribute("page", page);
	        return "modules/wlpt/trade/tradereceiptList";
	    }

	    @RequiresPermissions("wlpt:trade:tradeReceipt:view")
	    @RequestMapping(value = "form")
	    public String form(TradeReceipt tradeReceipt, Model model) {
	        model.addAttribute("tradereceipt", tradeReceipt);
	        return "modules/wlpt/trade/tradereceiptForm";
	    }

	    @RequiresPermissions("wlpt:trade:tradeReceipt:edit")
	    @RequestMapping(value = "save")
	    public String save(TradeReceipt tradeReceipt, Model model, RedirectAttributes redirectAttributes) {
			/*if (!beanValidator(model, tradeReceipt)){
				return form(tradeReceipt, model);
			}*/
	        int result= tradeBiz.saveTradeTakeGoods(tradeReceipt.getOrderinfo().getId(), tradeReceipt.getReceiptimg(), tradeReceipt.getOddloadweight());
	/*		int result= orderinfoService.saveTradeReceipt(tradeReceipt.getOrderinfo().getId(), tradeReceipt.getReceiptimg(), tradeReceipt.getOddloadweight());
	*/		/*tradereceiptService.save(tradeReceipt);*/
	        addMessage(redirectAttributes, "保存运单证明成功");
	        model.addAttribute("result",result );
	        return "redirect:"+ Global.getAdminPath()+"/wlpt/trade/tradeReceipt/?repage";
	    }

	    @RequiresPermissions("wlpt:trade:tradeReceipt:edit")
	    @RequestMapping(value = "delete")
	    public String delete(TradeReceipt tradeReceipt, RedirectAttributes redirectAttributes) {
	    	tradeReceiptService.delete(tradeReceipt);
	        addMessage(redirectAttributes, "删除运单证明成功");
	        return "redirect:"+Global.getAdminPath()+"/wlpt/trade/tradeReceipt/?repage";
	    }

}