package com.thinkgem.jeesite.modules.wlpt.web.dataCenter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.statisticsBiz.StatisticsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;

@Controller
@RequestMapping(value="${adminPath}/wlpt/dataCenter")
public class DataCenterController extends BaseController{

	@Autowired 
    private StatisticsBiz statisticsBiz;
	
	/**
     *默认进入首页
     */
    @RequestMapping(value="/index")
    public String index(){
        return "modules/wlpt_front/analysis/index";
    }
	/***
     * 全局概览
     * @return
     */
	@RequestMapping(value = "/testvalid")
	public String testvalid(){
		return "modules/wlpt_front/analysis/default";
	}
	/****
     * 去用户中心
     * @return
     */
    @RequestMapping(value = "/userindex")
    public String userindex() {
        return "modules/wlpt_front/analysis/user_index";
    }
    
    /***
     * 去交易流向首页
     * @return
     */
    @RequestMapping(value = "/tradeflow_index")
    public String tradeflow_index() {
        return "modules/wlpt_front/analysis/tradeflow_index";
    }
    
    /***
     * 去LED首页
     * @return
     */
    @RequestMapping(value = "/led_index")
    public String led_index() {
        return "modules/wlpt_front/analysis/led_index";
    }
	
    /***
     * 运输种类分析
     * @return
     */
    @RequestMapping(value = "/tradekinds_index")
    public String tradekinds_index() {
        return "modules/wlpt_front/analysis/tradekinds_index";
    }
    
    /***
     * 运输车辆分析
     * @return
     */
    @RequestMapping(value = "/car_index")
    public String car_index() {
        return "modules/wlpt_front/analysis/car_index";
    }
    
	/***
     * 获取用户趋势
     * @return
     */
    @RequestMapping(value = "/user_trend")
    public String user_trend() {
        return "modules/wlpt_front/analysis/user_trend";
    }
    
    /***
     * 获取用户每日注册用户信息
     * @return
     */
    @RequestMapping(value = "/getUseCount")
    @ResponseBody
    public Object getUseCount(@RequestParam(required = false) String dataName, Model model) {

        if ("everyDay".equals(dataName)||dataName==null){
            return statisticsBiz.getEveryDayCount();
        }else if ("everyWeek".equals(dataName)){
            return statisticsBiz.getEveryWeekCount();
        }else if ("everyMoth".equals(dataName)){
            return statisticsBiz.getEveryMothCount();
        }else if ("everyYear".equals(dataName)){
            return statisticsBiz.getEveryYearCount();
        }
        else{
            return statisticsBiz.getEveryDayCount();
        }
    }
    
    /***
     * 获取运输资金趋势
     * @return
     */
    @RequestMapping(value = "/order_trend")
    public String order_trend() {
        return "modules/wlpt_front/analysis/order_trend";
    }
    
    /****
     * 去招标分析
     * @return
     */
    @RequestMapping(value = "/bid_trend")
    public String bid_trend() {
        return "modules/wlpt_front/analysis/bid_trend";
    }
    
    /***
     * 获取运费交易信息
     * @return
     */
    @RequestMapping(value = "/getOrderCount")
    @ResponseBody
    public Object getOrderCount(@RequestParam(required = false) String dataName,@RequestParam(required = false) String gsType, Model model) {
    	StatisticsTradetype statisticsTradetype=new StatisticsTradetype();
    	statisticsTradetype.setGsType(gsType);
        if ("everyDay".equals(dataName)||dataName==null){
            return statisticsBiz.getEveryDayCount(statisticsTradetype);
        }else if ("everyWeek".equals(dataName)){
            return statisticsBiz.getEveryWeekCount(statisticsTradetype);
        }else if ("everyMoth".equals(dataName)){
            return statisticsBiz.getEveryMothCount(statisticsTradetype);
        }else if ("everyYear".equals(dataName)){
            return statisticsBiz.getEveryYearCount(statisticsTradetype);
        }
        else{
            return statisticsBiz.getEveryDayCount(statisticsTradetype);
        }
    }
    
    /***
     * 获取招标信息
     * @return
     */
    @RequestMapping(value = "/getBidCount")
    @ResponseBody
    public Object getBidCount(@RequestParam(required = false) String dataName, Model model) {
        if ("everyDay".equals(dataName)||dataName==null){
            return statisticsBiz.getBidEverDayBiz();
        }else if ("everyWeek".equals(dataName)){
            return statisticsBiz.getBidEverWeekBiz();
        }else if ("everyMoth".equals(dataName)){
            return statisticsBiz.getBidEverMonthBiz();
        }else if ("everyYear".equals(dataName)){
            return statisticsBiz.getBidEverYearBiz();
        }
        else{
            return statisticsBiz.getBidEverDayBiz();
        }
    }
    
    /***
     * 获取用户认证和角色分类分析
     * @return
     */
    @RequestMapping(value = "/user_roleauthen")
    public String user_role() {
        return "modules/wlpt_front/analysis/roleauthen_trend";
    }
    
    /****
     * 获取车辆数据页面
     * @return
     */
    @RequestMapping(value = "/car_trend")
    public String car_trend() {
        return "modules/wlpt_front/analysis/car_trend";
    }
    
    /***
     * 获取每种角色信息
     * @return
     */
    @RequestMapping(value = "/getRoleCount")
    @ResponseBody
    public Object getRoleCount() {
       return statisticsBiz.getRoleCountBiz();
    }
    
    /****
     * 获取车辆月数据数据
     * @return
     */
    @RequestMapping(value = "/getCarMothData")
    @ResponseBody
    public Object getCarMothData() {
        return statisticsBiz.getCarMonthDataBiz();
    }
    
    /****
     * 获取车辆数据
     * @return
     */
    @RequestMapping(value = "/getCarTypeCount")
    @ResponseBody
    public Object getCarTypeCount() {
        return statisticsBiz.getCarTypeCountBiz();
    }
    
    /***
     * 获取交易流向
     * @return
     */
    @RequestMapping(value = "/flow_trend")
    public String flow_trend() {
        return "modules/wlpt_front/analysis/flow_trend";
    }
    
    /***
     *  获取交易流向信息--业务数据
     * @return
     */
    @RequestMapping(value = "/getBusinessData")
    @ResponseBody
    public Object getBusinessData(@RequestParam(required = false) String searchTime,Model model) {
        return statisticsBiz.getEveryData(searchTime);
    }
    
    /***
     * 获取交易流向信息--运价指数
     * @return
     */
    @RequestMapping(value = "/getTrateLineData")
    @ResponseBody
    public Object getTrateLineData(@RequestParam(required = false) String startAddress,Model model) {
        return statisticsBiz.getTrateLineDataBiz(startAddress);
    }
    
    /***
     * 获取交易流向信息
     * @return
     */
    @RequestMapping(value = "/getTradeFlowData")
    @ResponseBody
    public Object getTradeFlowData(@RequestParam(required = false) String fromcity,Model model) {
        return statisticsBiz.getTradeFlowDataBiz(fromcity);
    }
    
	// 跳转大屏
	@RequestMapping(value = "/toHall")
	public String toHall() {
		return "modules/wlpt_front/analysis/listHall";
	}
	
	/***
     * 货物类型交易
     * @return
     */
    @RequestMapping(value = "/gdtypetrade_trend")
    public String gdtypetrade_trend() {
        return "modules/wlpt_front/analysis/gdtypetrade_trend";
    }
    
    /***
     * 去交易种类分析模块
     * @return
     */
    @RequestMapping(value = "/kinds_trend")
    public String kinds_trend() {
        return "modules/wlpt_front/analysis/kinds_trend";
    }
    
    /***
     * 交易运输种类分析
     * @return
     */
    @RequestMapping(value = "/getTradeKindData")
    @ResponseBody
    public Object getTradeKindData(@RequestParam(required = false) String dataName,Model model) {
        if ("everyDay".equals(dataName)||dataName==null){
            return statisticsBiz.getTradeKindDay();
        }else if ("everyWeek".equals(dataName)){
            return statisticsBiz.getTradeKindWeek();
        }else if ("everyMoth".equals(dataName)){
            return statisticsBiz.getTradeKindMonth();
        }else if ("everyYear".equals(dataName)){
            return statisticsBiz.getTradeKindYear();
        }
        else{
            return statisticsBiz.getTradeKindDay();
        }
    }
    
    /***
     * 运输热区分析
     * @return
     */
    @RequestMapping(value = "/tradehot_trend")
    public String tradehate_trend() {
        return "modules/wlpt_front/analysis/tradehot_trend";
    }
    
    /***
     * 获取交易热区页面数据
     * @return
     */
    @RequestMapping(value = "/getTradeHotData")
    @ResponseBody
    public Object getTradeHateData() {
        return statisticsBiz.getTradeHotDataBiz();
    }
    
    /**
     * 左侧菜单栏
     */
    @RequestMapping(value="/left")
    public String left(Model model){
        List<Menu> menus = UserUtils.getAnalysisMenu();
        model.addAttribute("menus", menus);
        return "modules/wlpt_front/analysis/left";
    }
    
}
