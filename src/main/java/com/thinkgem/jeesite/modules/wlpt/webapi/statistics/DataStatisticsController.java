/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.webapi.statistics;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceLog;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.*;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.statisticsBiz.StatisticsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsBusiness;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;

/**
 * 数据统计Controller
 * 
 * @author
 * @version 2013-8-29
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/statistics")
public class DataStatisticsController extends BaseController {

	@Autowired
	private SystemService systemService;
	
	@Autowired
	private StatisticsBiz statisticsBiz;
	
	@Autowired
	private ConsumerecodService consumerService;

	/**
	 * 去财务统计页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toFinancialStatistics", "" })
	public String toFinancialStatistics(HttpServletRequest request, HttpServletResponse response, Model model) {
		User users = UserUtils.getUser();
		if(!Tools.IsNullOrWhiteSpace(users.getId())){
			users=UserUtils.findUser(users);
		}
		model.addAttribute("user", users);
		return "modules/user_front/statistics/financialStatistics";
		//return "modules/wlpt_front/statistics/financialStatistics";
	}

	/**
	 * 去交易明细页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toTransactionDetail", "" })
	public String toTransactionDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/wlpt_front/statistics/transaction_detail";
	}
	
	
	/**
	 * 去运单统计页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toWaybillStatistics", "" })
	public String toWaybillStatistics(HttpServletRequest request, HttpServletResponse response, Model model) {
		StatisticsTradetype tradetype =new StatisticsTradetype();
		User user= UserUtils.getUser();
    	if (Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
    	tradetype.setUserid(user.getId());
    	tradetype = statisticsBiz.getOrderNumCount(tradetype);
		model.addAttribute("tradetype", tradetype);
		return "modules/user_front/statistics/waybillStatistics";
	}
	
	/**
	 * 去招标统计页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toBidStatistics", "" })
	public String toBidStatistics(HttpServletRequest request, HttpServletResponse response, Model model) {
		StatisticsBusiness business = new StatisticsBusiness();
		User user= UserUtils.getUser();
    	if (Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
    	business.setUserid(user.getId());
    	business = statisticsBiz.getBidInfoCount(business);
		model.addAttribute("business", business);
		return "modules/user_front/statistics/bidStatistics";
	}

	/**
	 * 去货单仓库统计页面
	 *
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toBidBlinfoStatistics", "" })
	public String toBidBlinfoStatistics(HttpServletRequest request, HttpServletResponse response, Model model) {

		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		model.addAttribute("user", user);
		return "modules/user_front/statistics/bidblinfoStatistics";
	}



	/***
     * 获取用户财务统计数据
     *
     * @param userBalanceVO
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"getFinancialData", ""})
    public Object getFinancialData(UserBalanceVO userBalanceVO, Model model, RedirectAttributes redirectAttributes) {
    	User user= UserUtils.getUser();
    	if (Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
        userBalanceVO.setUserid(user.getId());
        return statisticsBiz.getFinancialDataBiz(userBalanceVO);
    }

    
    /***
     * 获取运单交易信息
     * @return
     */
    @RequestMapping(value = "/getOrderCount")
    @ResponseBody
    public Object getOrderCount(StatisticsTradetype tradetype,@RequestParam(required = false) String type, Model model) {
    	
    	
    	User user= UserUtils.getUser();
    	if (Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
    	tradetype.setUserid(user.getId());
    	if("1".equals(type)){
    		return statisticsBiz.getGoodsMothCount(tradetype);
    	}else{
    		return statisticsBiz.getOrderMothCount(tradetype);
    	}
    	
    }
    
    /***
     * 获取招标交易信息
     * @return
     */
    @RequestMapping(value = "/getbidCount")
    @ResponseBody
    public Object getbidCount(StatisticsBusiness business,@RequestParam(required = false) String type, Model model) {
    	
    	
    	User user= UserUtils.getUser();
    	if (Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
    	business.setUserid(user.getId());
    	if("2".equals(type)){
    		return statisticsBiz.getBiddingMonthCountBiz(business);
    	}else{
    		return statisticsBiz.getBidMonthCountBiz(business);
    	}
    	
    }
    
    /***
     * 获取用户财务统计数据
     *
     * @param userBalanceVO
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"getFinancialInfoData", ""})
    public Object getFinancialInfoData(UserBalanceVO userBalanceVO, Model model, RedirectAttributes redirectAttributes) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	InterfaceLog interfaceLog=new InterfaceLog();
    	User user= UserUtils.getUser();
    	if (Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
    	interfaceLog.setUserid(user.getId());
    	userBalanceVO.setSearchType("2");
        userBalanceVO.setUserid(user.getId());
        map.put("pay_data", statisticsBiz.getFinancialDataInfoBiz(userBalanceVO));
        userBalanceVO.setSearchType("1");
        map.put("income_data", statisticsBiz.getFinancialDataInfoBiz(userBalanceVO));
        userBalanceVO.setSearchType("3");
        map.put("financial_data", statisticsBiz.getFinancialDataInfoBiz(userBalanceVO));
		userBalanceVO.setSearchType("5");
		map.put("order_data", statisticsBiz.getFinancialDataInfoBiz(userBalanceVO));
		
		map.put("mony_data", statisticsBiz.findUserBalanceCount(userBalanceVO));

        
        return map;
    }
    
    /***
     * 获取用户财务概览数据
     *
     * @param userBalanceVO
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"getFinancialInfo", ""})
    public Object getFinancialInfo(UserBalanceVO userBalanceVO, Model model, RedirectAttributes redirectAttributes) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	User user= UserUtils.getUser();
    	if (Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
        userBalanceVO.setUserid(user.getId());
        
        return statisticsBiz.getFinancialDataInfoBiz(userBalanceVO);
    }


	/***
	 * 获取应收运单统计列表
	 *
	 * @param statisticsTradetype
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"findBuyerOrderList", ""})
	public Object findBuyerOrderList(StatisticsTradetype statisticsTradetype, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		Page<StatisticsTradetype> page = statisticsBiz.findBuyerOrderList(pg,statisticsTradetype);

		return new JSONPObject("callback", page);
	}

	/***
	 * 获取应付运单统计列表
	 *
	 * @param statisticsTradetype
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"findSllerOrderList", ""})
	public Object findSllerOrderList(StatisticsTradetype statisticsTradetype, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		Page<StatisticsTradetype> page = statisticsBiz.findSllerOrderList(pg,statisticsTradetype);

		return new JSONPObject("callback", page);
	}

	/***
	 * 获取应付运单统计列表
	 *
	 * @param statisticsTradetype
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getOrdeList", ""})
	public Object getOrdeList(StatisticsTradetype statisticsTradetype, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		map.put("sllerOrderCount",statisticsBiz.getSllerOrderCount(statisticsTradetype));
		map.put("buyerOrderCount",statisticsBiz.getBuyerOrderCount(statisticsTradetype));
		return map;
	}

	//=============================运单分析==========================

	/***
	 * 获取运单状态分析统计数据
	 *
	 * @param userBalanceVO
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getOrderStatusCountInfoData", ""})
	public Object getOrderStatusCountInfoData(UserBalanceVO userBalanceVO, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		userBalanceVO.setSearchType("1");
		userBalanceVO.setUserid(user.getId());
		map.put("statusCount_data", statisticsBiz.getOrderStatusCount(userBalanceVO));

		return map;
	}
	/***
	 * 获取应付运单业务统计分析
	 *
	 * @param statisticsTradetype
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getOrderBusinessData", ""})
	public Object getOrderBusinessData(StatisticsTradetype statisticsTradetype, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		map.put("Business_data", statisticsBiz.getOrderBusinessList(statisticsTradetype));

		return map;
	}

	/***
	 * 获取应付运单统计列表
	 *
	 * @param orderinfo
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"findFinancialOrderList", ""})
	public Object findFinancialOrderList(Orderinfo orderinfo,String type, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		//1:应收 ，2：应付
		if("1".equals(type)){
			orderinfo.setBuyer(user);
		}else{
			orderinfo.setSeller(user);
		}

		Page<Orderinfo> page = statisticsBiz.findFinancialOrderList(pg,orderinfo,user);

		return new JSONPObject("callback", page);
	}


	/***
	 * 获取运单统计列表
	 *
	 * @param statisticsTradetype
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getOrdeCountInfo", ""})
	public Object getOrdeCountInfo(StatisticsTradetype statisticsTradetype,String type, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		//1:应收 ，2：应付
		if("1".equals(type)){
			map.put("orderCount",statisticsBiz.getSllerOrderCount(statisticsTradetype));
		}else{
			map.put("orderCount",statisticsBiz.getBuyerOrderCount(statisticsTradetype));

		}
		return map;
	}

	/***
	 * 获取运单统计
	 *
	 * @param statisticsTradetype
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getOrdeCountData", ""})
	public Object getOrdeCountData(StatisticsTradetype statisticsTradetype,String type, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		//1:应收 ，2：应付
		if("1".equals(type)){
			statisticsTradetype.setOrderstatus("1");
			map.put("orderCount1",statisticsBiz.getSllerOrderCount(statisticsTradetype));
			statisticsTradetype.setOrderstatus("2");
			map.put("orderCount2",statisticsBiz.getSllerOrderCount(statisticsTradetype));
			statisticsTradetype.setOrderstatus("3");
			map.put("orderCount3",statisticsBiz.getSllerOrderCount(statisticsTradetype));
			statisticsTradetype.setOrderstatus("4");
			map.put("orderCount4",statisticsBiz.getSllerOrderCount(statisticsTradetype));

		}else{
			statisticsTradetype.setOrderstatus("1");
			map.put("orderCount1",statisticsBiz.getBuyerOrderCount(statisticsTradetype));
			statisticsTradetype.setOrderstatus("2");
			map.put("orderCount2",statisticsBiz.getBuyerOrderCount(statisticsTradetype));
			statisticsTradetype.setOrderstatus("3");
			map.put("orderCount3",statisticsBiz.getBuyerOrderCount(statisticsTradetype));
			statisticsTradetype.setOrderstatus("4");
			map.put("orderCount4",statisticsBiz.getBuyerOrderCount(statisticsTradetype));
		}
		return map;
	}
	/***
	 * 获取运单统计数据
	 *
	 * @param userBalanceVO
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getFinancialDataInfo", ""})
	public Object getFinancialDataInfo(UserBalanceVO userBalanceVO, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		userBalanceVO.setUserid(user.getId());
		map.put("order_data",statisticsBiz.getOrderCount(userBalanceVO));
		userBalanceVO.setSearchType("4");
		map.put("financial_data", statisticsBiz.getFinancialDataInfoBiz(userBalanceVO));

		return map;
	}

	/**
	 * 获取导出运单业务统计分析
	 * @param orderinfoExcelVO
	 * @param type
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "orderExport", method = RequestMethod.POST)
	public Object orderExport(OrderinfoExcelVO orderinfoExcelVO,String type, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			User user= UserUtils.getUser();
			if (Tools.IsNullOrWhiteSpace(user.getId())) {
				return null;
			}
			String title = "应收";
			String statuname = "未完成运输";
			//1:应收 ，2：应付
			if("1".equals(type)){
				title = "应收";
				orderinfoExcelVO.setBuyer(user);
			}else{
				title = "应付";
				orderinfoExcelVO.setSeller(user);
			}
			if("1".equals(orderinfoExcelVO.getOrderstatus())){
				statuname = "未完成运输";
			}else if("2".equals(orderinfoExcelVO.getOrderstatus())){
				statuname = "待结算";
			}else if("3".equals(orderinfoExcelVO.getOrderstatus())){
				statuname = "已结算";
			}
			String fileName = title+"-"+statuname+"账单报表" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<OrderinfoExcelVO> list = statisticsBiz.findFinancialOrderExcel(orderinfoExcelVO);
			if("1".equals(type)){
				new ExportExcel(fileName, OrderinfoExcelVO.class).setDataList(list).write(response, fileName).dispose();
			}else{
				List<OrderinfoPayExcelVO> list2 =new ArrayList<>();
				for (OrderinfoExcelVO data:list ) {
					OrderinfoPayExcelVO op= new OrderinfoPayExcelVO();
					BeanUtils.copyProperties(data,op);
					list2.add(op);
				}

				new ExportExcel(fileName, OrderinfoPayExcelVO.class).setDataList(list2).write(response, fileName).dispose();
			}

			return null;
		} catch (Exception e) {
		addMessage(redirectAttributes, "导出运单业务统计分析失败！失败信息：" + e.getMessage());
	}
        return "redirect:" + frontPath + "/wlpt/statistics/toWaybillStatistics?repage";
	}
	//==================竞标======================
	/***
	 * 获取竞标状态分析统计数据
	 *
	 * @param userBalanceVO
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getBidStatusCountInfoData", ""})
	public Object getBidStatusCountInfoData(UserBalanceVO userBalanceVO, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		userBalanceVO.setUserid(user.getId());
		map.put("biddingStatus_data", statisticsBiz.findBiddingStatusMothCount(userBalanceVO));
		map.put("contracStatus_data", statisticsBiz.findContracStatusMothCount(userBalanceVO));

		return map;
	}

	/***
	 * 合同运输状态统计
	 *
	 * @param userBalanceVO
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getContracStatusCount", ""})
	public Object getContracStatusCount(UserBalanceVO userBalanceVO, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		userBalanceVO.setUserid(user.getId());
		map.put("contracStatus_data", statisticsBiz.findContracStatusMothCount(userBalanceVO));

		return map;
	}

	/***
	 * 获取合同业务统计分析
	 *
	 * @param statisticsTradetype
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getContracBusinessData", ""})
	public Object getContracBusinessData(StatisticsTradetype statisticsTradetype, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		map.put("Business_data", statisticsBiz.findContracBusinessList(statisticsTradetype));

		return map;
	}

	/***
	 * 招标应付-应收数据列表
	 *
	 * @param bidOrderinfoExcelVO
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"findFinancialBidOrderList", ""})
	public Object findFinancialBidOrderList(BidOrderinfoExcelVO bidOrderinfoExcelVO, String type, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		//1:应收 ，2：应付
		if("1".equals(type)){
			bidOrderinfoExcelVO.setBiddinguser(user);
		}else{
			bidOrderinfoExcelVO.setBiduser(user);
		}

		Page<BidOrderinfoExcelVO> page = statisticsBiz.findFinancialBidOrderList(pg,bidOrderinfoExcelVO,user);
		return new JSONPObject("callback", page);
	}

	/***
	 * 获取根据合同状态统计
	 *
	 * @param statisticsTradetype
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getBidOrdeCountInfo", ""})
	public Object getBidOrdeCountInfo(StatisticsTradetype statisticsTradetype,String type, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		//1:应收 ，2：应付
		statisticsTradetype.setSearchinfo(type);
		statisticsTradetype.setType(type);
		map.put("orderCount",statisticsBiz.findFinancialBidOrderCount(statisticsTradetype));
		return map;
	}
	/***
	 *  获取合同结算状态统计
	 *
	 * @param statisticsTradetype
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getBidOrdeCountData", ""})
	public Object getBidOrdeCountData(StatisticsTradetype statisticsTradetype,String type, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		statisticsTradetype.setUserid(user.getId());
		//1:应收 ，2：应付
		statisticsTradetype.setType(type);
		statisticsTradetype.setOrderstatus("1");
		map.put("orderCount1",statisticsBiz.findFinancialBidOrderCount(statisticsTradetype));
		statisticsTradetype.setOrderstatus("2");
		map.put("orderCount2",statisticsBiz.findFinancialBidOrderCount(statisticsTradetype));
		statisticsTradetype.setOrderstatus("3");
		map.put("orderCount3",statisticsBiz.findFinancialBidOrderCount(statisticsTradetype));
		statisticsTradetype.setOrderstatus("4");
		map.put("orderCount4",statisticsBiz.findFinancialBidOrderCount(statisticsTradetype));

		return map;
	}

	/**
	 * 获取招标应付-应收数据列表
	 * @param bidOrderinfoExcelVO
	 * @param type
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"bidOrderExport", ""})
	public Object bidOrderExport(BidOrderinfoExcelVO bidOrderinfoExcelVO, String type, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			User user= UserUtils.getUser();
			if (Tools.IsNullOrWhiteSpace(user.getId())) {
				return null;
			}
			String title = "应收";
			String statuname = "未申请";
			//1:应收 ，2：应付
			if("1".equals(type)){
				title = "应收";
				bidOrderinfoExcelVO.setBiddinguser(user);
			}else{
				title = "应付";
				bidOrderinfoExcelVO.setBiduser(user);
			}
			if("1".equals(bidOrderinfoExcelVO.getSettlestatus())){
				statuname = "未申请";
			}else if("2".equals(bidOrderinfoExcelVO.getSettlestatus())){
				statuname = "审核中";
			}else if("3".equals(bidOrderinfoExcelVO.getSettlestatus())){
				statuname = "结算中";
			}else if("4".equals(bidOrderinfoExcelVO.getSettlestatus())){
				statuname = "已结算";
			}
			String fileName = title+"-"+statuname+"结算账单报表" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<BidOrderinfoExcelVO> list = statisticsBiz.findFinancialBidOrderExcel(bidOrderinfoExcelVO);
			if("1".equals(type)) {
				List<BidOrderinfoPayExcelVO> list2 =new ArrayList<>();
				for (BidOrderinfoExcelVO data:list ) {
					BidOrderinfoPayExcelVO bop= new BidOrderinfoPayExcelVO();
					BeanUtils.copyProperties(data,bop);
					list2.add(bop);
				}
				new ExportExcel(fileName, BidOrderinfoPayExcelVO.class).setDataList(list2).write(response, fileName).dispose();
			}else {
				new ExportExcel(fileName, BidOrderinfoExcelVO.class).setDataList(list).write(response, fileName).dispose();
			}

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出招标应付-应收数据列表失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + frontPath + "/wlpt/statistics/toBidStatistics?repage";
	}

	//===========================================货单仓库分析================================================
	/***
	 * 获取各个仓库分析统计数据
	 *
	 * @param bidBlinfoCountVO
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getBidBlinfoStatusCountData", ""})
	public Object getBidBlinfoStatusCountData(BidBlinfoCountVO bidBlinfoCountVO, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		bidBlinfoCountVO.setUserid(user.getId());
		bidBlinfoCountVO.setType("3");
		map.put("warehouse_data", statisticsBiz.findBlinfoWarehouseList(bidBlinfoCountVO));
		map.put("bidStatus_data", statisticsBiz.findBidStatusCount(bidBlinfoCountVO));

		return map;
	}

	/***
	 * 仓库每日运输分析统计分析
	 *
	 * @param bidBlinfoCountVO
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getBlinfoDayData", ""})
	public Object getBlinfoDayData(BidBlinfoCountVO bidBlinfoCountVO, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		bidBlinfoCountVO.setUserid(user.getId());
		map.put("BlinfoDay_data", statisticsBiz.findBlinfoDayList(bidBlinfoCountVO));

		return map;
	}

	/***
	 * 交易状态统计
	 *
	 * @param bidBlinfoCountVO
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getBlinfoTradeStatusCount", ""})
	public Object getBlinfoTradeStatusCount(BidBlinfoCountVO bidBlinfoCountVO, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		bidBlinfoCountVO.setUserid(user.getId());
		map.put("contracStatus_data", statisticsBiz.findBlinfoTradeStatusCount(bidBlinfoCountVO));

		return map;
	}

	/***
	 *  获取合同结算状态统计
	 *
	 * @param bidBlinfoCountVO
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"findBidBlinfoCountData", ""})
	public Object findBidBlinfoCountData(BidBlinfoCountVO bidBlinfoCountVO,String type, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		bidBlinfoCountVO.setUserid(user.getId());
		bidBlinfoCountVO.setType(type);
		if("1".equals(type) && user.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER)){
			bidBlinfoCountVO.setType("3");
		}

		if("2".equals(type)){
			bidBlinfoCountVO.setBiddingstatus(DataDic.BL_WAREHOUSE_STATUS_DCK);
		}else{
			bidBlinfoCountVO.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_DCK);
		}
		map.put("orderCount1",statisticsBiz.findBidBlinfoCount(bidBlinfoCountVO));
		if("2".equals(type)){
			bidBlinfoCountVO.setBiddingstatus(DataDic.BL_WAREHOUSE_STATUS_YCK);
		}else{
			bidBlinfoCountVO.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_YCK);
		}
		map.put("orderCount2",statisticsBiz.findBidBlinfoCount(bidBlinfoCountVO));
		if("2".equals(type)){
			bidBlinfoCountVO.setBiddingstatus("");
		}else{
			bidBlinfoCountVO.setBidstatus("");
		}
		map.put("orderCount3",statisticsBiz.findBidBlinfoCount(bidBlinfoCountVO));

		return map;
	}

	/***
	 * 获取根据合同状态统计
	 *
	 * @param bidBlinfoCountVO
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"getBidBlinfoCountInfo", ""})
	public Object getBidBlinfoCountInfo(BidBlinfoCountVO bidBlinfoCountVO,String type, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		bidBlinfoCountVO.setUserid(user.getId());
		bidBlinfoCountVO.setType(type);
		if("1".equals(type) && user.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER)){
			bidBlinfoCountVO.setType("3");
		}

		if("2".equals(type)){
			bidBlinfoCountVO.setBiddingstatus(bidBlinfoCountVO.getStatus());
		}else{
			bidBlinfoCountVO.setBidstatus(bidBlinfoCountVO.getStatus());
		}
		map.put("orderCount",statisticsBiz.findBidBlinfoCount(bidBlinfoCountVO));
		return map;
	}

	/***
	 * 招标应付-应收数据列表
	 *
	 * @param bidBlinfoVO
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"findBlinfoList", ""})
	public Object findBlinfoList(BidBlinfoVO bidBlinfoVO,int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		User user= UserUtils.getUser();
		if (Tools.IsNullOrWhiteSpace(user.getId())) {
			return null;
		}
		if("2".equals(bidBlinfoVO.getType())){
			if(user.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER)){
				bidBlinfoVO.setBiduser(user);
			}else{
				bidBlinfoVO.setBiddinguser(user);
			}
			bidBlinfoVO.setBiddingstatus(bidBlinfoVO.getStatus());
		}else{
			bidBlinfoVO.setBiduser(user);
			bidBlinfoVO.setBidstatus(bidBlinfoVO.getStatus());
		}

		Page<BidBlinfoVO> page = statisticsBiz.findBlinfoList(pg,bidBlinfoVO);
		return new JSONPObject("callback", page);
	}

	/**
	 * 导出提货单库管-接单数据列表
	 * @param bidBlinfoVO
	 * @param type
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = {"bidBlinfoExport", ""})
	public Object bidBlinfoExport(BidBlinfoVO bidBlinfoVO,String type, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			User user= UserUtils.getUser();
			if (Tools.IsNullOrWhiteSpace(user.getId())) {
				return null;
			}
			String title = "库管";
			String statuname = "待出库";

			if("2".equals(bidBlinfoVO.getStatus())){
				statuname = "待出库";
			}else if("3".equals(bidBlinfoVO.getStatus())){
				statuname = "已出库";
			}else{
				statuname = "共入库";
			}
			if (Tools.IsNullOrWhiteSpace(user.getId())) {
				return null;
			}
			if("2".equals(type)){
				if(user.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER)){
					bidBlinfoVO.setBiduser(user);
				}else{
					bidBlinfoVO.setBiddinguser(user);
				}
				title = "接单";
				bidBlinfoVO.setBiddingstatus(bidBlinfoVO.getStatus());
			}else{
				title = "库管";
				bidBlinfoVO.setBiduser(user);
				bidBlinfoVO.setBidstatus(bidBlinfoVO.getStatus());
			}



			String fileName = title+"-"+statuname+"货单报表" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<BidBlinfoVO> list = statisticsBiz.findBlinfoAllList(bidBlinfoVO);
			new ExportExcel(fileName, BidBlinfoVO.class).setDataList(list).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出提货单库管-接单数据列表失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + frontPath + "/wlpt/statistics/toBidBlinfoStatistics?repage";
	}

}
