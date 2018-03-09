package com.thinkgem.jeesite.modules.wlpt.webapi.trade;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.barcode.QRCodeUtils;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.insur.InsurBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.TradeComment;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeReceipt;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoTradeVO;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;
import com.thinkgem.jeesite.modules.wlpt.service.comment.TradeCommentService;

/**
 * Created by ForHeart on 16/8/10.
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/trade")
public class TradeController extends BaseController {

	@Autowired
	private TradeBiz tradeBiz;

	@Autowired
	private GoodsBiz goodsBiz;

	@Autowired
	private GpsCarInfoService carInfoService;

	@Autowired
	private TradeCommentService tradeCommentService;

	@Autowired
	private InsurBiz insurBiz;

	/***
	 * 运单搜索
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = { "searchOrder", "" })
	public String searchOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		String url = "modules/user_front/trade/trade_search";
		if (orderinfo == null) {
			return /* "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list" */ url;
		}
		/// 获取运单详情
		orderinfo = tradeBiz.getOrderByNo(orderinfo);
		if (orderinfo == null) {
			return url;
		}
		if (orderinfo.getLocationstate() >= Integer.parseInt(DataDic.LBS_STATUS_CREATE)) {
			model.addAttribute("islbs", "true");
		}
		GpsCarInfo gpsCar = new GpsCarInfo();
		/// 通过GPS车辆车牌号码获取
		gpsCar.setCname(orderinfo.getQuoteinfo().getCar().getCarnumber());
		gpsCar = carInfoService.findByCondition(gpsCar);

		model.addAttribute("start", orderinfo.getCreateDate().getTime());
		if (orderinfo.getPayDate() != null) {
			model.addAttribute("end", orderinfo.getPayDate().getTime());
		}
		model.addAttribute("orderinfo", orderinfo);
		model.addAttribute("gpsCar", gpsCar);
		return url;
	}

	/***
	 * 获取用户运单统计数据
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "getEverData", "" })
	public Object getEverData(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		if (UserUtils.getUser() == null) {
			return null;
		}
		return tradeBiz.getEverDataBiz(orderinfo, UserUtils.getUser());
	}

	/**
	 * 打印提货单
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(value = "user")
	@ResponseBody
	@RequestMapping(value = { "printOrder", "" })
	public Object printOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return this.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "打印", null);
		}
		return tradeBiz.editPrintBiz(orderinfo.getId());
	}

	/**
	 * 打印提货单
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(value = "user")
	@ResponseBody
	@RequestMapping(value = { "updatePrintcount", "" })
	public Object updatePrintcount(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return this.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "记录打印次数", null);
		}
		return tradeBiz.updatePrintcount(orderinfo.getId());
	}

	/***
	 * 运输完成
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(value = "user")
	@ResponseBody
	@RequestMapping(value = { "endOrder", "" })
	public Object endOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return this.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "确认运输完成", null);
		}
		return tradeBiz.saveOrderEnd(orderinfo.getId(), UserUtils.getUser());
		// model.addAttribute("message", Tools.statusMessage(result, "确认运单"));
		// return Tools.getMapResult(result, Tools.statusMessage(result, "取消运单"),null);
	}

	/***
	 * 关闭运单信息
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */

	@RequiresPermissions(value = "user")
	@ResponseBody
	@RequestMapping(value = { "cancelOrder", "" })
	public Object cancelOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		int result = tradeBiz.cancelOrderBiz(orderinfo, model);
		// model.addAttribute("message", Tools.statusMessage(result, "确认运单"));
		return Tools.getMapResult(result, Tools.statusMessage(result, "取消运单"), null);
	}

	/***
	 * 去运单支付页面
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = { "toOrderPay", "" })
	public String toPayInfo(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		String url = "modules/user_front/trade/trade_pay";
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		model.addAttribute("orderinfo", tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser()));
		model.addAttribute("curUser", UserUtils.getUser());
		return url;
	}

	/**
	 * 去支付信息页面
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = { "toPayInfo", "" })
	public String toOrderPay(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		String url = "modules/user_front/trade/trade_payinfo";
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		model.addAttribute("orderinfo", tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser()));
		model.addAttribute("curUser", UserUtils.getUser());
		return url;
	}

	/***
	 * 确认运单信息,传运单ID
	 *
	 * @param orderinfo
	 *            传运单ID
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(value = "user")
	@ResponseBody
	@RequestMapping(value = { "confrimOrder", "" })
	public Object confrimOrder(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {

		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		int result = tradeBiz.confrimOrderBiz(orderinfo, model);
		// model.addAttribute("message", Tools.statusMessage(result, "确认运单"));
		return Tools.getMapResult(result, Tools.statusMessage(result, "确认运单"), null);
	}

	/***
	 * 去运单轨迹页面
	 *
	 * @param orderinfo
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = { "trade_track", "" })
	public String trade_track(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		/// 获取运单详情
		orderinfo = tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser());

		if (orderinfo.getLocationstate() >= Integer.parseInt(DataDic.LBS_STATUS_CREATE)) {
			model.addAttribute("islbs", "true");
		}
		GpsCarInfo gpsCar = new GpsCarInfo();
		if (orderinfo.getQuoteinfo().getCar() != null
				&& !Tools.IsNullOrWhiteSpace(orderinfo.getQuoteinfo().getCar().getCarnumber())) {
			/// 通过GPS车辆车牌号码获取
			gpsCar.setCname(orderinfo.getQuoteinfo().getCar().getCarnumber());
			gpsCar = carInfoService.findByCondition(gpsCar);
		}

		model.addAttribute("start", orderinfo.getCreateDate().getTime());
		if (orderinfo.getPayDate() != null) {
			model.addAttribute("end", orderinfo.getPayDate().getTime());
		}
		model.addAttribute("orderinfo", orderinfo);
		model.addAttribute("gpsCar", gpsCar);
		return "modules/user_front/trade/trade_gpstrack";
	}

	/***
	 * 去运单提货单页面
	 *
	 * @param orderinfo
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = { "trade_taklist", "" })
	public String trade_taklist(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		orderinfo = tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser());
		try {
			QRCodeUtils.encode("http://" + Global.LINK_WEB + "/wx/weixin/trade/trade_details?id=" + orderinfo.getId(),
					orderinfo.getOrderno(),
					Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + "/code/getheadimg.jpeg",
					Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + "/code", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("orderinfo", orderinfo);
		// return "modules/wlpt_front/trade/trade_taklist";
		return "modules/user_front/trade/trade_taklist";
	}

	/***
	 * 去运单交易列表
	 *
	 * @param orderinfo
	 * @param model
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = { "trade_list", "" })
	public String trade_list(Orderinfo orderinfo, Model model, HttpServletRequest request, HttpServletResponse response,
			String isRedrect) {
		User user = UserUtils.getUser();
		if (user.getId() == null) {
			return "modules/wlpt_front/admin/login";
		}
		model.addAttribute("orderinfo", orderinfo);
		model.addAttribute("isRedrect", isRedrect);
		if (isRedrect == null || isRedrect == "") {
			Cookie[] cookies = request.getCookies();
			for (Cookie c : cookies) {
				if (c.getName().equals("trade_searchinfo") || c.getName().equals("trade_orderstatus")
						|| c.getName().equals("trade_pageno") || c.getName().equals("trade_gsoddtype")) {
					c.setValue(null);
					response.addCookie(c);
				}
			}
		}
		// return "modules/wlpt_front/trade/trade_list";
		return "modules/user_front/trade/trade_list";
	}

	/**
	 * 去运单详情页面
	 *
	 * @param request
	 * @param response
	 * @param model
	 * @param orderinfo
	 *            运单ID
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = { "trade_detail", "" })
	public String trade_detail(Orderinfo orderinfo, String urltype, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		if (orderinfo == null) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		if ("backurl".equals(urltype)) {
			orderinfo = tradeBiz.getOrderByNo(orderinfo);
			urltype = "trade_shadow";
		} else {
			orderinfo = tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser());
		}
		model.addAttribute("orderinfo", orderinfo);
		model.addAttribute("urltype", urltype);
		return "modules/user_front/trade/trade_detail";
	}

	/***
	 * 运单交易凭据
	 *
	 * @param request
	 * @param response
	 * @param model
	 *            * @param orderinfo 运单ID
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = { "trade_receipt", "" })
	public String trade_receipt(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		model.addAttribute("takeGoods",
				tradeBiz.getTradeReceiptBiz(orderinfo.getId(), DataDic.TRADERECEIPT_TYPE_TAKEGOODS));
		model.addAttribute("tradeReceipt",
				tradeBiz.getTradeReceiptBiz(orderinfo.getId(), DataDic.TRADERECEIPT_TYPE_RECEIPT));
		orderinfo = tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser());
		model.addAttribute("orderinfo", orderinfo);
		return "modules/user_front/trade/trade_receipt";
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
	@RequiresPermissions("user")
	@RequestMapping(value = { "trade_shadow", "" })
	public String trade_shadow(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (orderinfo == null || Tools.IsNullOrWhiteSpace(orderinfo.getId())) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		}
		/// 当前是否有用户登录,未登录去登录页面
		if (UserUtils.getUser() == null) {
			return "redirect:" + Global.getFrontPath() + "/wlpt/trade/trade_list";
		} else {
			/// 获取详细信息
			orderinfo = tradeBiz.getDetail(orderinfo.getId(), UserUtils.getUser());
			if (orderinfo == null) {
				model.addAttribute("message", "信息不存在");
			}
			model.addAttribute("orderinfo", orderinfo);
		}
		return "modules/user_front/trade/trade_shadow";
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
	public Object getTradeList(Orderinfo orderinfo, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null) {
			return new JSONPObject("callback", null);
		}
		Page<Orderinfo> page = tradeBiz.findPage(pg, orderinfo, UserUtils.getUser());
		List<String> gpslist = new ArrayList<>();
		for (Orderinfo order : page.getList()) {
			if (UserUtils.getUser().getId().equals(order.getSeller().getId())) {
				order.setFlag(true);
			} else {
				order.setFlag(false);
			}
			if (order.getQuoteinfo().getCar() != null) {
				gpslist.add(order.getQuoteinfo().getCar().getCarnumber());
			}

			order.getQuoteinfo().getGoods().setGsoddtype(
					DictUtils.getDictLabel(order.getQuoteinfo().getGoods().getGsoddtype(), "gsoddtype", ""));
			/*
			 * GpsCarInfo gpsCarInfo=new GpsCarInfo();
			 * gpsCarInfo.setCname(order.getQuoteinfo().getCar().getCarnumber());
			 * List<GpsCarInfo> gpsCars = carInfoService.findList(gpsCarInfo); if
			 * (gpsCars.size()>0){ order.setIsGps(true); }
			 */
			/*
			 * for (GpsCarInfo gpsCar : gpsCars) { if
			 * (gpsCar.getCname().equals(order.getQuoteinfo().getCar().getCarnumber())) {
			 * order.setIsGps(true); } }
			 */
		}

		if (gpslist.size() > 0) {
			List<GpsCarInfo> gpsCars = carInfoService.findByGroup(gpslist.toArray(new String[gpslist.size()]));
			for (Orderinfo order : page.getList()) {

				for (GpsCarInfo gpsCar : gpsCars) {
					if (order.getQuoteinfo().getCar() != null) {
						if (gpsCar.getCname().equals(order.getQuoteinfo().getCar().getCarnumber())) {
							order.setIsGps(true);
						}
					}
				}
			}
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/**
	 * 获取招标合同运单信息信息
	 *
	 * @param bidOrderinfo
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getBidTradeList")
	public Object getBidTradeList(BidOrderinfo bidOrderinfo, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null || bidOrderinfo == null || bidOrderinfo.getId() == null) {
			return new JSONPObject("callback", null);
		}
		Orderinfo orderinfo = new Orderinfo();
		orderinfo.setBidorder(bidOrderinfo);
		Page<Orderinfo> page = tradeBiz.findBidOrderPage(pg, orderinfo, UserUtils.getUser());
		for (Orderinfo var : page.getList()) {
			var.getQuoteinfo().getGoods().setGsoddtype(
					DictUtils.getDictLabel(var.getQuoteinfo().getGoods().getGsoddtype(), "gsoddtype", ""));
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/***
	 * 报价生成运单
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "createOrder")
	public Object createOrder(Orderinfo orderinfo, Model model, HttpServletRequest request,
			RedirectAttributes redirectAttributes) throws IOException {
		ObjectMapper mapper = new ObjectMapper();
		mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
		mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
		mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
		String blinfoStr = request.getParameter("blinfoList");
		if (!Tools.IsNullOrWhiteSpace(blinfoStr)) {
			List<BidBlinfo> blinfoList = Arrays.asList(mapper.readValue(blinfoStr, BidBlinfo[].class));
			orderinfo.getQuoteinfo().setBlinfoList(blinfoList);
		}

		int result = tradeBiz.createReLoadOrderBiz(orderinfo, model);
		return new JSONPObject("callback", result);
	}

	/**
	 * 运单上传提货凭据
	 *
	 * @param tradeReceipt
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveTradeTakeGoods")
	public Object saveTradeTakeGoods(TradeReceipt tradeReceipt, Model model, RedirectAttributes redirectAttributes) {
		int result = tradeBiz.saveTradeTakeGoods(tradeReceipt.getId(), tradeReceipt.getReceiptimg(),
				tradeReceipt.getOddloadweight());
		return Tools.getMapResult(result, Tools.statusMessage(result, "上传凭据"), null);
	}

	/**
	 * 运单上传回执单
	 *
	 * @param tradeReceipt
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveTradeReceipt")
	public Object saveTradeReceipt(TradeReceipt tradeReceipt, Model model, RedirectAttributes redirectAttributes) {
		int result = tradeBiz.saveTradeReceipt(tradeReceipt.getId(), tradeReceipt.getReceiptimg(),
				tradeReceipt.getOddloadweight());
		return Tools.getMapResult(result, Tools.statusMessage(result, "上传回单"), null);
	}

	/**
	 * 运单发起争议
	 *
	 * @param orderinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveTradeDispute")
	public Object saveTradeDispute(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		return tradeBiz.saveUserDispute(orderinfo.getId(), orderinfo.getUserDispute().getGoodsname(),
				orderinfo.getUserDispute().getTakeloadweight(), orderinfo.getUserDispute().getUnloadweight(),
				orderinfo.getUserDispute().getDisputeinfo(), orderinfo.getUserDispute().getDisputemoney(),
				orderinfo.getUserDispute().getDisputetype());

	}

	/**
	 * 运单司机是否同意争议
	 *
	 * @param userDispute
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "isAgreeDispute")
	public Object isAgreeDispute(UserDispute userDispute, Model model, RedirectAttributes redirectAttributes) {
		Boolean result = tradeBiz.confirmUserdispute(userDispute.getId(), userDispute.getIsreject());
		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "保存成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "保存失败", null);
		}
	}

	/**
	 * 个人中心首页运单列表导出运单数据
	 *
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "export")
	public String exportFile(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			User user = UserUtils.getUser();
			if (user.getId() != null) {
				orderinfo.setSeller(user);
				String fileName = "运单信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
				Page<Orderinfo> page = tradeBiz.findPage(new Page<Orderinfo>(), orderinfo);
				List<Orderinfo> varOList = page.getList();
				List<OrderinfoTradeVO> orderinfoTradeVOs = new ArrayList<OrderinfoTradeVO>();
				for (Orderinfo orderinfo2 : varOList) {
					OrderinfoTradeVO accountRechargeVO = new OrderinfoTradeVO();
					BeanUtils.copyProperties(orderinfo2, accountRechargeVO);
					orderinfoTradeVOs.add(accountRechargeVO);
				}
				new ExportExcel("运单信息数据", OrderinfoTradeVO.class).setDataList(orderinfoTradeVOs)
						.write(response, fileName).dispose();
			}

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return null;
	}

	@RequestMapping(value = "/to_ordercomment")
	public String toOrdercomment(Orderinfo orderinfo, Model model) {
		Orderinfo order = tradeBiz.get(orderinfo.getId());
		User user = UserUtils.getUser();
		if (!user.getId().equals(order.getSeller().getId()) && !user.getId().equals(order.getBuyer().getId())) {
			return "modules/user_front/trade/trade_list";
		}
		TradeComment tradeComment = new TradeComment();
		tradeComment.setOrderno(order.getOrderno());
		List<TradeComment> comment = tradeCommentService.findList(tradeComment);
		if (user.getId().equals(order.getSeller().getId())) {
			if (comment.size() != 0) {
				tradeComment = comment.get(0);
				order.setFlag(false);
			} else {
				order.setFlag(true);
			}
		} else {
			if (comment.size() != 0) {
				tradeComment = comment.get(0);
			}
			order.setFlag(false);
		}
		model.addAttribute("tradeComment", tradeComment);
		order.getQuoteinfo().setGoods(goodsBiz.get(order.getQuoteinfo().getGoods().getId()));
		model.addAttribute("order", order);
		model.addAttribute("user", user);
		return "modules/user_front/trade/order_comment";
	}

	@ResponseBody
	@RequestMapping(value = "ordercomment")
	public Object ordercomment(TradeComment tradeComment, Model model) {
		return tradeBiz.ordercommentBiz(tradeComment);
	}

	/**
	 * 添加运单定位信息
	 *
	 * @param orderinfo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "trade_lbs", "" })
	public String orderlbs(Orderinfo orderinfo, Model model) {
		User user = UserUtils.getUser();

		try {
			orderinfo = tradeBiz.get(orderinfo.getId());
			model.addAttribute("user", user);
			model.addAttribute("orderinfo", orderinfo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "modules/user_front/trade/trade_lbs";
	}

	/**
	 * 保险填写
	 *
	 * @return
	 */
	@RequestMapping(value = "toinsur")
	public String toinsur(String orderno, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		Orderinfo oinfo = tradeBiz.getDetailByOrderNo(orderno, user);
		UserInsurance insur = new UserInsurance();
		insur.setOrderno(orderno);
		UserInsurance uis = insurBiz.getInsurInfo(insur);
		model.addAttribute("oinfo", oinfo);
		model.addAttribute("uis", uis);
		model.addAttribute("user", user);
		return "modules/wlpt_front/trade/insur_add";
	}

	/**
	 * 编辑报价页面
	 *
	 * @return
	 */
	@RequestMapping(value = "toassign")
	public String toassign(String orderno, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		Orderinfo oinfo = tradeBiz.getDetailByOrderNo(orderno, user);
		Quoteinfo quoteinfo = new Quoteinfo();
		quoteinfo.setId(oinfo.getQuoteinfo().getId());
		quoteinfo = goodsBiz.getQuote(quoteinfo);
		Goods goods = goodsBiz.get(oinfo.getQuoteinfo().getGoods().getId());
		model.addAttribute("goods", goods);
		model.addAttribute("quoteinfo", quoteinfo);
		model.addAttribute("oinfo", oinfo);
		model.addAttribute("user", user);
		// return "modules/wlpt_front/trade/trade_assign";
		return "modules/user_front/trade/trade_assign";
	}

	// @RequestMapping(value="commentInfo")
	// public String commentInfo(Orderinfo orderinfo, Model model){
	// Orderinfo order=tradeBiz.get(orderinfo.getId());
	// TradeComment tradeComment=new TradeComment();
	// tradeComment.setOrderno(order.getOrderno());
	// List<TradeComment> comment=tradeCommentService.findList(tradeComment);
	// if(comment.size()!=0){
	// tradeComment=comment.get(0);
	// }
	// order.getQuoteinfo().setGoods(goodsBiz.get(order.getQuoteinfo().getGoods().getId()));
	// model.addAttribute("order", order);
	// model.addAttribute("tradeComment", tradeComment);
	// return "modules/wlpt_front/trade/commentInfo";
	// }

	/***
	 * 查询运单信息 searchinfo
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "searchInfo")
	public Object searchInfo(String searchinfo, String type, Model model) {
		Orderinfo oinfo = tradeBiz.getDetailByOrderNo(searchinfo, UserUtils.getUser());
		Map map = new HashMap();
		if (oinfo != null) {
			if (DataDic.ORDER_STATUS_NEW.equals(oinfo.getOrderstatus())
					|| DataDic.ORDER_STATUS_SURE.equals(oinfo.getOrderstatus())
					|| DataDic.ORDER_STATUS_TAKEGOODS.equals(oinfo.getOrderstatus())) {
				if (Tools.IsNullOrWhiteSpace(type)) {
					UserInsurance insur = new UserInsurance();
					insur.setOrderno(searchinfo);
					UserInsurance uis = insurBiz.getInsurInfo(insur);
					if (uis != null) {
						return new JSONPObject("callback", "3");
					}
				}

				if (oinfo.getQuoteinfo() != null && oinfo.getQuoteinfo().getGoods() != null) {
					Quoteinfo qinfo = oinfo.getQuoteinfo();
					Goods goods = oinfo.getQuoteinfo().getGoods();
					goods.setGsoddtype(DictUtils.getDictLabel(goods.getGsoddtype(), "gsoddtype", ""));
					qinfo.setGoods(goods);
					oinfo.setQuoteinfo(qinfo);
				}

				map.put("oinfo", oinfo);
				return new JSONPObject("callback", map);
			}
			return new JSONPObject("callback", "2");
		} else {
			return new JSONPObject("callback", "1");
		}

	}

	/**
	 * 获取用户各状态的订单数目
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getStatusList")
	public Object getStatusList() {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "";
		return this.getMapResult(state, message, tradeBiz.getStatusNum());
	}

	@RequestMapping(value = "toTradeGpsInfo")
	public String toTradeGpsInfo(Orderinfo orderinfo, Model model) {
		return "modules/user_front/trade/trade_gps";
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
	@RequestMapping(value = "getCarAndTradeList")
	public Object getCarAndTradeList(Orderinfo orderinfo, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null) {
			return new JSONPObject("callback", null);
		}
		Page<Orderinfo> page = tradeBiz.getCarAndTradeList(pg, orderinfo, UserUtils.getUser());

		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/**
	 * 获取运单信息
	 * @param orderinfo
	 * @param orderNos
	 * @param newtime
	 * @param carNumber
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "carAndTradeInfo")
	@Transactional(readOnly = false)
	public Object getCarAndTradeInfo(String orderNos, String newtime, String carNumber,
			Model model) {
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null) {
			return new JSONPObject("callback", null);
		}
		Map<String,Object> maplist = tradeBiz.getCarAndTradeInfo(orderNos,newtime,carNumber);
		
		return new JSONPObject("callback", maplist);
	}

	/**
	 * 获取gps数据
	 *
	 * @param carnumber
	 * @param beginTime
	 * @param endTime
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(value = "getCarGpsInfo")
	public Object getlCarGpsInfo(Orderinfo orderinfo, String orderNos, String carnumber, String beginTime,
			String endTime, Model model) throws ParseException {
		//return tradeBiz.getlCarGpsInfos(orderinfo, orderNos, carnumber, beginTime, endTime);
		return tradeBiz.getlCarGpsInfo(orderinfo, orderNos, carnumber, beginTime, endTime);
	}

	/***
	 * 获取车辆的所有定位信息
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getTradeTrackList")
	public Object getTradeTrackList() {
		List<GpsCarInfo> gpsCars = new ArrayList<>();
		Page pg = new Page();
		pg.setPageNo(0);
		pg.setPageSize(Integer.MAX_VALUE);
		/// 判断用户是否登录获取数据
		if (UserUtils.getUser() == null) {
			return new JSONPObject("callback", null);
		}
		Page<Orderinfo> page = tradeBiz.getCarAndTradeList(pg, new Orderinfo(), UserUtils.getUser());
		List<String> gpslist = new ArrayList<>();
		for (Orderinfo order : page.getList()) {
			if (order.getQuoteinfo().getCar() != null) {
				gpslist.add(order.getQuoteinfo().getCar().getCarnumber());
			}

		}

		if (gpslist.size() > 0) {
			gpsCars = carInfoService.findByGroup(gpslist.toArray(new String[gpslist.size()]));
		}
		return new JSONPObject("callback", gpsCars);
	}

	/**
	 * 开通gps定位
	 */
	@RequestMapping(value = "openGps")
	@ResponseBody
	public Object openGps(Orderinfo orderinfo, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = tradeBiz.openGps(orderinfo);
		return map;
	}
	
	@RequiresPermissions("user")
	@RequestMapping(value = "findCar")
	public String findCar( HttpServletRequest request, HttpServletResponse response,
			Model model) {
		return "modules/user_front/trade/trade_findcar";
	}
}
