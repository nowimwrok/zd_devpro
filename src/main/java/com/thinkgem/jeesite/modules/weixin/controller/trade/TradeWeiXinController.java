package com.thinkgem.jeesite.modules.weixin.controller.trade;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;

/**
 * 微信我的运单Controller
 *
 * @author
 * @version 2016-08-26
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/trade")
public class TradeWeiXinController {
	@Autowired
	private TradeBiz tradeBiz;

	@Autowired
	private GpsCarInfoService carInfoService;

	/***
	 * 去运单交易列表
	 *
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "trade_list", "" })
	public String trade_list(Orderinfo orderinfo, Model model) {
		model.addAttribute("orderinfo", orderinfo);
		return "modules/wx_front/trade/order_list";
	}

	/***
	 * 获取运单列表
	 *
	 * @param orderinfo
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getTradeList")
	public Object getTradeList(Orderinfo orderinfo, Page pg, Model model) {

		/*
		 * pg.setPageNo(pageNo); pg.setPageSize(pageSize);
		 */
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null) {
			return new JSONPObject("callback", null);
		}
		Page<Orderinfo> page = tradeBiz.findPage(pg, orderinfo, UserUtils.getUser());
		for (Orderinfo var : page.getList()) {
			var.getQuoteinfo().getGoods().setGsoddtype(
					DictUtils.getDictLabel(var.getQuoteinfo().getGoods().getGsoddtype(), "gsoddtype", ""));
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/***
	 * 运单交易跟踪
	 *
	 * @param request
	 * @param response
	 * @param model
	 * @param orderinfo
	 *            运单ID
	 * @return
	 */
	@RequestMapping(value = { "order_details", "" })
	public String trade_shadow(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getWeixinPath() + "/weixin/trade/trade_list";
		}
		/// 当前是否有用户登录,未登录去登录页面
		if (UserUtils.getUser() == null) {
			return "redirect:" + Global.getWeixinPath() + "/weixin/trade/trade_list";
		} else {
			/// 获取详细信息
			orderinfo = tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser());
			if (orderinfo == null) {
				model.addAttribute("message", "信息不存在");
			}
			if(orderinfo.getLocationstate()>=Integer.parseInt(DataDic.LBS_STATUS_CREATE)){
	        	model.addAttribute("islbs", "true");
	        }
			GpsCarInfo gpsCar = new GpsCarInfo();
			/// 通过GPS车辆车牌号码获取
			gpsCar.setCname(orderinfo.getQuoteinfo().getCar().getCarnumber());
			gpsCar = carInfoService.get(gpsCar);
			// 获取运单凭证信息
			model.addAttribute("takeGoods",
					tradeBiz.getTradeReceiptBiz(orderinfo.getId(), DataDic.TRADERECEIPT_TYPE_TAKEGOODS));
			model.addAttribute("tradeReceipt",
					tradeBiz.getTradeReceiptBiz(orderinfo.getId(), DataDic.TRADERECEIPT_TYPE_RECEIPT));
			model.addAttribute("orderinfo", orderinfo);
			model.addAttribute("gpsCar", gpsCar);
		}
		return "modules/wx_front/trade/order_details";
	}

	/***
	 * 获取交易历史记录
	 *
	 * @param orderinfo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getTraceList")
	public Object getTraceList(Orderinfo orderinfo, Model model) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG,
					Tools.statusMessage(DataDic.RETURN_STATUS_INFOBUG, "获取历史记录"), null);
		}
		/// 当前是否有用户登录,未登录去登录页面
		if (UserUtils.getUser() == null) {
			return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG,
					Tools.statusMessage(DataDic.RETURN_STATUS_INFOBUG, "获取历史记录"), null);
		} else {

			/// 获取详细信息
			return tradeBiz.getTraceBiz(orderinfo, DataDic.ORDER_TRACE_TYPE_STATUS);
		}
	}

	 /***
     * 确认运单信息,传运单ID
     *
     * @param orderinfo          传运单ID
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"confrimOrder", ""})
    public Object confrimOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
    	int result = DataDic.RETURN_STATUS_INFOBUG;
    	if (orderinfo != null || !Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
    		result = tradeBiz.confrimOrderBiz(orderinfo, model);
        }
        
        //model.addAttribute("message", Tools.statusMessage(result, "确认运单"));
        return Tools.getMapResult(result, Tools.statusMessage(result, "确认运单"),null);
    }
    /***
	 * 运单交易跟踪
	 *
	 * @param request
	 * @param response
	 * @param model
	 * @param orderinfo
	 *            运单ID
	 * @return
	 */
	@RequestMapping(value = { "trade_details", "" })
	public String trade_details(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		/*if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getWeixinPath() + "/weixin/trade/trade_list";
		}*/
		
		/// 获取详细信息
		orderinfo = tradeBiz.getOrder(orderinfo.getId());
		if (orderinfo == null) {
			model.addAttribute("message", "信息不存在");
		}else{
			GpsCarInfo gpsCar = new GpsCarInfo();
			/// 通过GPS车辆车牌号码获取
			gpsCar.setCname(orderinfo.getQuoteinfo().getCar().getCarnumber());
			gpsCar = carInfoService.get(gpsCar);
			// 获取运单凭证信息
			model.addAttribute("takeGoods",
					tradeBiz.getTradeReceiptBiz(orderinfo.getId(), DataDic.TRADERECEIPT_TYPE_TAKEGOODS));
			model.addAttribute("tradeReceipt",
					tradeBiz.getTradeReceiptBiz(orderinfo.getId(), DataDic.TRADERECEIPT_TYPE_RECEIPT));
			model.addAttribute("orderinfo", orderinfo);
			model.addAttribute("gpsCar", gpsCar);
		}
		return "modules/wx_front/trade/trade_details";
	}
}
