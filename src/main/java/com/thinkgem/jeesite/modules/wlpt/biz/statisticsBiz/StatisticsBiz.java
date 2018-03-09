package com.thinkgem.jeesite.modules.wlpt.biz.statisticsBiz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.*;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsBusiness;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsCar;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRegister;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRole;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradeflow;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightrateLineService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsBusinessService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsCarService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsRegisterService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsRoleService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsTradeflowService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsTradetypeService;

@Service
@Transactional(readOnly = true)
public class StatisticsBiz {
	
	@Autowired
	private StatisticsRoleService statisticsRoleService;
	@Autowired
	private StatisticsBusinessService statisticsBusinessService;
	@Autowired
	private StatisticsTradetypeService statisticsTradetypeService;
	@Autowired
	private StatisticsRegisterService statisticsRegisterService;
	@Autowired
	private StatisticsCarService statisticsCarService;
	@Autowired
	private FreightrateLineService freightrateLineService;
	@Autowired
	private StatisticsTradeflowService statisticsTradeflowService;
	@Autowired
	private ConsumerecodService consumerecodService;
	@Autowired
	private OrderinfoService orderinfoService;
	@Autowired
	private BidOrderinfoService bidOrderinfoService;
	@Autowired
	private BidBlinfoService bidBlinfoService;

	/***
	 * 获取每日数据
	 * @return
     */
	public Object getEveryDayCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每日数据成功";
		List<StatisticsRole> roleList = null;
		try {
			roleList=statisticsRoleService.getEveryDayByRoleCount();
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每日数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每周数据
	 * @return
	 */
	public Object getEveryWeekCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每周数据成功";
		List<StatisticsRole> roleList = null;
		try {
			roleList=statisticsRoleService.getEveryWeekByRoleCount();
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每周数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每月数据
	 * @return
	 */
	public Object getEveryMothCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月数据成功";
		List<StatisticsRole> roleList = null;
		try {
			roleList=statisticsRoleService.getEveryMothByRoleCount();
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每年数据
	 * @return
	 */
	public Object getEveryYearCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每周数据成功";
		List<StatisticsRole> roleList = null;
		try {
			roleList=statisticsRoleService.getEveryYearByRoleCount();
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每周数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 *
	 * 获取每日数据
	 * @return
    */
	public Object getBidEverDayBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每日招标成功";
		List<StatisticsBusiness> varList = null;
		try {
			varList=statisticsBusinessService.getBidEverDay();
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每日数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 *
	 * 获取每周数据
	 * @return
	 */
	public Object getBidEverWeekBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每周招标成功";
		List<StatisticsBusiness> varList = null;

		try {
			varList=statisticsBusinessService.getBidEverWeek();
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每周数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 *
	 * 获取每月数据
	 * @return
	 */
	public Object getBidEverMonthBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月招标成功";
		List<StatisticsBusiness> varList = null;
		try {
			varList=statisticsBusinessService.getBidEverMonth();
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 *
	 * 获取每年数据
	 * @return
	 */
	public Object getBidEverYearBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每年招标成功";
		List<StatisticsBusiness> varList = null;

		try {
			varList=statisticsBusinessService.getBidEverYear();
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取年数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每日数据
	 * @return
     */
	public Object getEveryDayCount(StatisticsTradetype statisticsTradetype) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每日数据成功";
		List<StatisticsTradetype> roleList = null;
		try {
			roleList=statisticsTradetypeService.getEveryDayCount(statisticsTradetype);
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每日数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每周数据
	 * @return
	 */
	public Object getEveryWeekCount(StatisticsTradetype statisticsTradetype) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每周数据成功";
		List<StatisticsTradetype> roleList = null;
		try {
			roleList=statisticsTradetypeService.getEveryWeekCount(statisticsTradetype);
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每周数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每月数据
	 * @return
	 */
	public Object getEveryMothCount(StatisticsTradetype statisticsTradetype) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月数据成功";
		List<StatisticsTradetype> roleList = null;
		try {
			roleList=statisticsTradetypeService.getEveryMothCount(statisticsTradetype);
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每年数据
	 * @return
	 */
	public Object getEveryYearCount(StatisticsTradetype statisticsTradetype) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每周数据成功";
		List<StatisticsTradetype> roleList = null;
		try {
			roleList=statisticsTradetypeService.getEveryYearCount(statisticsTradetype);
			map.put("roleList",roleList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每周数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取用户角色总数数据
	 * @return
	 */
	public Object getRoleCountBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取用户角色成功";
		List<StatisticsRegister> varList = null;
		try {
			varList=statisticsRegisterService.getRoleCount();
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取用户数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/****
	 * 获取车辆月数据
	 * @return
	 */
	public Object getCarMonthDataBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取车辆月数据成功";
		List<StatisticsCar> varList = null;

		try {
			varList=statisticsCarService.getCarMonthData();
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取车辆月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/****
	 * 获取车辆类型
	 * @return
     */
	public Object getCarTypeCountBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取车辆类型成功";
		List<StatisticsCar> varList = null;
		try {
			varList=statisticsCarService.getCarTypeCount();
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取车辆类型失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/**
     * 获取所有 的数据统计业务
     * @param searchTime
     * @return
     */
    public Object getEveryData(String searchTime) {
        Map<String, Object> map = new HashMap<String, Object>();
        // 1:成功，0,不成功
        int state = 1;
        // 提示语
        String message = "获取统计成功";
        List<StatisticsBusiness> varList = new ArrayList<>();
        StatisticsBusiness statisticsBusiness=new StatisticsBusiness();
        statisticsBusiness.setTimeflg(searchTime);
        try {

        	varList=statisticsBusinessService.findList(statisticsBusiness);
 
            map.put("varList", varList);
        } catch (Exception e) {
            e.printStackTrace();
            state = 0;
            message = "获取统计失败";
        }
        return Tools.getMapResult(state, message, map);

    }
    
	/****
	 * 获取运价信息
	 * @param startAddress
	 * @return
     */
	public Object getTrateLineDataBiz(String startAddress){
		int state = 1;
		String message = "";
		Map<String, Object> map = new HashMap<String, Object>();
		List<FreightrateLine> varList=new ArrayList<FreightrateLine>();
		FreightrateLine freightrateLine=new FreightrateLine();
		freightrateLine.setStartaddress(startAddress);
		try {
			varList=freightrateLineService.findList(freightrateLine);
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "程序异常";
		}

		return Tools.getMapResult(state, message, map);
	}
	
	/***
	 * 获取交易流向
	 * @param fromcity
	 * @return
     */
	public Object getTradeFlowDataBiz(String fromcity) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取交易流向成功";
		List<StatisticsTradeflow> varList = null;
		StatisticsTradeflow statisticsTradeflow=new StatisticsTradeflow();
		statisticsTradeflow.setStartaddress(fromcity);
		try {
			varList = statisticsTradeflowService.findList(statisticsTradeflow);

			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取交易流向失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每日数据 交易类型货物类型
	 * @return
	 */
	public Object getTradeKindDay() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每日数据成功";
		List<StatisticsTradetype> varList = null;
		try {
			varList = statisticsTradetypeService.getTradeKindDay();

			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每日数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每周数据 货物类型
	 * @return
	 */
	public Object getTradeKindWeek() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每周数据成功";
		List<StatisticsTradetype> varList = null;

		try {
			varList = statisticsTradetypeService.getTradeKindWeek();

			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每周数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每月数据 货物类型数据
	 * @return
	 */
	public Object getTradeKindMonth() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月数据成功";
		List<StatisticsTradetype> varList = null;
		try {
			varList = statisticsTradetypeService.getTradeKindMonth();

			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取每年数据 货物类型数据分析
	 * @return
	 */
	public Object getTradeKindYear() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取年数据成功";
		List<StatisticsTradetype> varList = null;
		try {
			varList = statisticsTradetypeService.getTradeKindYear();

			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每年数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取交易热区分布
	 * @param
	 * @return
	 */
	public Object getTradeHotDataBiz() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取交易流向成功";
		List<StatisticsTradeflow> varList = null;

		try {
			varList = statisticsTradeflowService.findList(new StatisticsTradeflow());

			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取交易流向失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取财务统计
	 * @param
	 * @return
	 */
	public Object getFinancialDataBiz(UserBalanceVO userBalanceVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取财务统计信息成功";
		List<UserBalanceVO> varList = null;
		List<UserBalanceVO> list = new ArrayList<>();

		try {
			varList = consumerecodService.findUserBalanceList(userBalanceVO);
			if(varList.size()>0){
				String oldname = "";
				Double oldmony = 0.0;
				int num = 0;
				for (UserBalanceVO balance : varList) {
					num++;
					if("0702".equals(balance.getCode())||"0507".equals(balance.getCode())){
						oldname = "消费";
						oldmony = oldmony+balance.getMony();
					}else if("0705".equals(balance.getCode())){
						balance.setName("其他");
						list.add(balance);
					}else if("0106".equals(balance.getCode())||"0103".equals(balance.getCode())){
						oldname = "运费";
						oldmony = oldmony+balance.getMony();
					}else{
						list.add(balance);
					}
					if(num == varList.size()){
						UserBalanceVO b = new UserBalanceVO();
						b.setName(oldname);
						b.setMony(oldmony);
						list.add(b);
					}
				}
						
			}
			map.put("varList",list);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取交易流向失败";
		}
		return Tools.getMapResult(state,message,map);
	}	

	
	//=================================================个人中心统计=================================================
	
	
	/***
	 * 获取运单每月数据
	 * @return
	 */
	public Object getOrderMothCount(StatisticsTradetype statisticsTradetype) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月数据成功";
		List<StatisticsTradetype> varList = null;
		try {
			if(!Tools.IsNullOrWhiteSpace(statisticsTradetype.getBeginDate())){
				statisticsTradetype.setBeginDate(statisticsTradetype.getBeginDate()+"-01 00:00:00");
			}
			if(!Tools.IsNullOrWhiteSpace(statisticsTradetype.getEndDate())){
				statisticsTradetype.setEndDate(statisticsTradetype.getEndDate()+"-31 23:59:59");
			}
			varList=statisticsTradetypeService.getEveryMothCount(statisticsTradetype);
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每每月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 * 获取货物每月数据
	 * @return
	 */
	public Object getGoodsMothCount(StatisticsTradetype statisticsTradetype) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月数据成功";
		List<StatisticsTradetype> varList = null;
		try {
			if(!Tools.IsNullOrWhiteSpace(statisticsTradetype.getBeginDate())){
				statisticsTradetype.setBeginDate(statisticsTradetype.getBeginDate()+"-01 00:00:00");
			}
			if(!Tools.IsNullOrWhiteSpace(statisticsTradetype.getEndDate())){
				statisticsTradetype.setEndDate(statisticsTradetype.getEndDate()+"-31 23:59:59");
			}
			varList=statisticsTradetypeService.getGoodsCountMonth(statisticsTradetype);
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取每月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	
	/***
	 *
	 * 获取招标和合同每月数据
	 * @return
	 */
	public Object getBidMonthCountBiz(StatisticsBusiness business) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月招标成功";
		List<StatisticsBusiness> varList = null;
		try {
			if(!Tools.IsNullOrWhiteSpace(business.getBeginDate())){
				business.setBeginDate(business.getBeginDate()+"-01 00:00:00");
			}
			if(!Tools.IsNullOrWhiteSpace(business.getEndDate())){
				business.setEndDate(business.getEndDate()+"-31 23:59:59");
			}
			varList=statisticsBusinessService.getBidMonthCount(business);
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	
	/***
	 *
	 * 获取竞标每月数据
	 * @return
	 */
	public Object getBiddingMonthCountBiz(StatisticsBusiness business) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取每月招标成功";
		List<StatisticsBusiness> varList = null;
		try {
			if(!Tools.IsNullOrWhiteSpace(business.getBeginDate())){
				business.setBeginDate(business.getBeginDate()+"-01 00:00:00");
			}
			if(!Tools.IsNullOrWhiteSpace(business.getEndDate())){
				business.setEndDate(business.getEndDate()+"-31 23:59:59");
			}
			varList=statisticsBusinessService.getBiddingMonthCount(business);
			map.put("varList",varList);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取月数据失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	/***
	 *
	 * 获取竞标统计数据
	 * @return
	 */
	public StatisticsBusiness getBidInfoCount(StatisticsBusiness business){
		if(!Tools.IsNullOrWhiteSpace(business.getBeginDate())){
			business.setBeginDate(business.getBeginDate()+"-01 00:00:00");
		}
		if(!Tools.IsNullOrWhiteSpace(business.getEndDate())){
			business.setEndDate(business.getEndDate()+"-31 23:59:59");
		}
		return statisticsBusinessService.getBidInfoCount(business);
	}
	/**
	 * 获取运单统计条数据
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype getOrderNumCount(StatisticsTradetype statisticsTradetype){
		if(!Tools.IsNullOrWhiteSpace(statisticsTradetype.getBeginDate())){
			statisticsTradetype.setBeginDate(statisticsTradetype.getBeginDate()+"-01 00:00:00");
		}
		if(!Tools.IsNullOrWhiteSpace(statisticsTradetype.getEndDate())){
			statisticsTradetype.setEndDate(statisticsTradetype.getEndDate()+"-31 23:59:59");
		}
		return statisticsTradetypeService.getOrderNumCount(statisticsTradetype);
	}
	
	
	
	
	/***
	 * 获取财务统计分析
	 * @param userBalanceVO
	 * @return
	 */
	public Object getFinancialDataInfoBiz(UserBalanceVO userBalanceVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取财务统计分析成功";
		List<UserBalanceVO> varList = null;
		List<UserBalanceVO> list = new ArrayList<>();

		try {
			varList = consumerecodService.findUserBalanceInfoList(userBalanceVO);
			if(varList.size()>0){
				String oldname = "";
				Double oldmony = 0.0;
				String oldname1 = "";
				Double oldmony1 = 0.0;
				int num = 0;
				for (UserBalanceVO balance : varList) {
					num++;
					if("0106".equals(balance.getCode())||"0103".equals(balance.getCode())){
						oldname = "运费收入";
						oldmony = oldmony+balance.getMony();
					}else if("0121".equals(balance.getCode())||"0123".equals(balance.getCode())||"0125".equals(balance.getCode())){
						oldname1="运输服务";
						oldmony1 = oldmony1+balance.getMony();
					}else{
						list.add(balance);
					}
					if(!Tools.IsNullOrWhiteSpace(oldname)&&num == varList.size()){
						UserBalanceVO b = new UserBalanceVO();
						b.setName(oldname);
						b.setMony(oldmony);
						list.add(b);
					}
					if(!Tools.IsNullOrWhiteSpace(oldname1)&&num == varList.size()){
						UserBalanceVO b = new UserBalanceVO();
						b.setName(oldname1);
						b.setMony(oldmony1);
						list.add(b);
					}
				}
						
			}
			map.put("varList",list);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取财务统计分析失败";
		}
		return Tools.getMapResult(state,message,map);
	}
	/**
	 * 通过参数类型查询入账和出账统计分析
	 * @param userBalanceVO
	 * @return
	 */
	public Object findUserBalanceCount(UserBalanceVO userBalanceVO){
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取财务入账和出账统计分析成功";
		//交易类型 1收入 2支出
		userBalanceVO.setSearchType("1");
		map.put("income_data",consumerecodService.findUserBalanceCount(userBalanceVO));
		userBalanceVO.setSearchType("2");
		map.put("pay_data",consumerecodService.findUserBalanceCount(userBalanceVO));
		return Tools.getMapResult(state,message,map);
	}
	/**
	 * 获取应收运单统计列表
	 * @param statisticsTradetype
	 * @return
	 */
	public Page<StatisticsTradetype> findBuyerOrderList(Page<StatisticsTradetype> page,StatisticsTradetype statisticsTradetype){
		return orderinfoService.findBuyerOrderList(page,statisticsTradetype);
	}

	/**
	 * 获取应付运单统计列表
	 * @param statisticsTradetype
	 * @return
	 */
	public Page<StatisticsTradetype> findSllerOrderList(Page<StatisticsTradetype> page,StatisticsTradetype statisticsTradetype){
		return orderinfoService.findSllerOrderList(page,statisticsTradetype);
	}



	/**
	 * 获取应收运单统计统计
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype getBuyerOrderCount(StatisticsTradetype statisticsTradetype){
		return orderinfoService.getBuyerOrderCount(statisticsTradetype);
	}

	/**
	 * 获取应付运单统计统计
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype getSllerOrderCount(StatisticsTradetype statisticsTradetype){
		return orderinfoService.getSllerOrderCount(statisticsTradetype);
	}

	/**
	 * 获取运单状态统计
	 * @param userBalanceVO
	 * @return
	 */
	public Object getOrderStatusCount(UserBalanceVO userBalanceVO){
		Map<String, Object> map = new HashMap<String, Object>();
		// 1:成功，0,不成功
		int state = 1;
		// 提示语
		String message = "获取运单统计统计成功";
		List<UserBalanceVO> varList = null;
		List<UserBalanceVO> list = new ArrayList<>();
		UserBalanceVO zydata = new UserBalanceVO();
		try {
			varList = orderinfoService.getOrderStatusCount(userBalanceVO);
			if(varList.size()>0){
				String oldname = "";
				Double oldmony = 0.0;
				Double oldweight = 0.0;
				int oldcount = 0;
				int num = 0;

				for (UserBalanceVO balance : varList) {
					num++;
					if("-1".equals(balance.getCode())||"0".equals(balance.getCode())||"1".equals(balance.getCode())){
						oldname = "新运单";
						oldmony = oldmony+balance.getMony();
						oldweight = oldweight+balance.getWeight();
						oldcount = oldcount+balance.getCount();
					}else if("6".equals(balance.getCode())||"7".equals(balance.getCode())){
						zydata.setName("发起争议");
						zydata.setCount(zydata.getCount()+balance.getCount());
						zydata.setMony(zydata.getMony()+balance.getMony());
						zydata.setWeight(zydata.getWeight()+balance.getWeight());
					}else{
						list.add(balance);
					}
					if(!Tools.IsNullOrWhiteSpace(oldname)&&num == varList.size()){
						UserBalanceVO b = new UserBalanceVO();
						b.setName(oldname);
						b.setMony(oldmony);
						b.setWeight(oldweight);
						b.setCount(oldcount);
						list.add(b);
						list.add(zydata);
					}
				}

			}
			map.put("varList",list);
		} catch (Exception e) {
			e.printStackTrace();
			state = 0;
			message = "获取运单统计统计失败";
		}
		return Tools.getMapResult(state,message,map);
	}

	/**
	 * 获取应付运单业务统计分析
	 * @param statisticsTradetype
	 * @return
	 */
	public List<StatisticsTradetype> getOrderBusinessList(StatisticsTradetype statisticsTradetype){
		return orderinfoService.getOrderBusinessList(statisticsTradetype);
	}


	/**
	 * 获取应收-应收运单统计列表
	 * @param orderinfo
	 * @return
	 */
	public Page<Orderinfo> findFinancialOrderList(Page<Orderinfo> page, Orderinfo orderinfo,User user){
		Page<Orderinfo> pageVal = orderinfoService.findFinancialOrderList(page,orderinfo);
		/// 如果是查询个人用户的运单信息则判断是否是买家
		for (Orderinfo var : pageVal.getList()) {
			if (user != null && !Tools.IsNullOrWhiteSpace(user.getId())) {
				/// 判断用户ID是否相等
				if (user.getId().equals(var.getBuyer().getId())) {
					var.setIsBuyer(true);
				} else {
					var.setIsBuyer(false);
				}
			}
			/// 符状态--运单状态转化为中文字
			var.setStatusStr(DictUtils.getDictLabel(var.getOrderstatus(), "order_status", null));
		}
		return pageVal;
	}
	/**
	 * 获取运单统计
	 * @param userBalanceVO
	 * @return
	 */
	public UserBalanceVO getOrderCount(UserBalanceVO userBalanceVO){
		return orderinfoService.getOrderCount(userBalanceVO);
	}

	/**
	 * 获取导出应付运单业务统计分析
	 * @param orderinfoExcelVO
	 * @return
	 */
	public List<OrderinfoExcelVO> findFinancialOrderExcel(OrderinfoExcelVO orderinfoExcelVO){
		return orderinfoService.findFinancialOrderExcel(orderinfoExcelVO);
	}
	//=====================================================招标=========================================================

	/**
	 * 竞标状态统计
	 * @param userBalanceVO
	 * @return
	 */
	public List<UserBalanceVO> findBiddingStatusMothCount(UserBalanceVO userBalanceVO){
		return statisticsBusinessService.findBiddingStatusMothCount(userBalanceVO);
	}

	/**
	 * 合同运输状态统计
	 * @param userBalanceVO
	 * @return
	 */
	public List<UserBalanceVO> findContracStatusMothCount(UserBalanceVO userBalanceVO){
		List<UserBalanceVO> varList = null;
		List<UserBalanceVO> list = new ArrayList<>();

		try {
			varList = statisticsBusinessService.findContracStatusMothCount(userBalanceVO);
			if(varList.size()>0){
				String oldname = "";
				Double oldmony = 0.0;
				Double oldweight = 0.0;
				int oldcount = 0;
				int num = 0;
				for (UserBalanceVO balance : varList) {
					num++;
					if("0".equals(balance.getCode())){
						balance.setName("未运输");
						list.add(balance);
					}else if("1".equals(balance.getCode())||"2".equals(balance.getCode())||"3".equals(balance.getCode())){
						oldname = "运输中";
						oldmony = oldmony+balance.getMony();
						oldweight = oldweight+balance.getWeight();
						oldcount = oldcount+balance.getCount();
					}else{
						list.add(balance);
					}
					if(!Tools.IsNullOrWhiteSpace(oldname)&&num == varList.size()){
						UserBalanceVO b = new UserBalanceVO();
						b.setName(oldname);
						b.setMony(oldmony);
						b.setWeight(oldweight);
						b.setCount(oldcount);
						list.add(b);
					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 合同运输月分析列表
	 * @param statisticsTradetype
	 * @return
	 */
	public List<StatisticsTradetype> findContracBusinessList(StatisticsTradetype statisticsTradetype){
		return statisticsBusinessService.findContracBusinessList(statisticsTradetype);
	}

	/**
	 * 招标应付-应收数据列表
	 * @param bidOrderinfoExcelVO
	 * @return
	 */
	public Page<BidOrderinfoExcelVO> findFinancialBidOrderList(Page<BidOrderinfoExcelVO> page, BidOrderinfoExcelVO bidOrderinfoExcelVO ,User user) {
		Page<BidOrderinfoExcelVO> pg = bidOrderinfoService.getFinancialBidOrderList(page, bidOrderinfoExcelVO);
		for (BidOrderinfoExcelVO var : pg.getList()) {
			///获取合同状态
			var.setContractStr(DictUtils.getDictLabel(var.getContractstatus(), "bidOrder_status", null));

		}
		return pg;
	}
	/**
	 * 获取合同统计统计
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype findFinancialBidOrderCount(StatisticsTradetype statisticsTradetype){
		return bidOrderinfoService.findFinancialBidOrderCount(statisticsTradetype);
	}

	/**
	 * 招标导出应付-应收数据列表
	 * @param bidOrderinfoExcelVO
	 * @return
	 */
	public List<BidOrderinfoExcelVO> findFinancialBidOrderExcel(BidOrderinfoExcelVO bidOrderinfoExcelVO){
		return bidOrderinfoService.findFinancialBidOrderExcel(bidOrderinfoExcelVO);
	}

	//======================================================仓库管理====================================================

	/**
	 * 自发仓库状态统计
	 * @param bidBlinfoCountVO
	 * @return
	 */
	public List<BidBlinfoCountVO> findBidStatusCount(BidBlinfoCountVO bidBlinfoCountVO){
		return bidBlinfoService.findBidStatusCount(bidBlinfoCountVO);
	}

	/**
	 * 接单仓库状态统计
	 * @param bidBlinfoCountVO
	 * @return
	 */
	public List<BidBlinfoCountVO> findBiddingStatusCount(BidBlinfoCountVO bidBlinfoCountVO){
		return bidBlinfoService.findBiddingStatusCount(bidBlinfoCountVO);
	}

	/**
	 * 仓库状态总统计
	 * @param bidBlinfoCountVO
	 * @return
	 */
	public BidBlinfoCountVO findBidBlinfoCount(BidBlinfoCountVO bidBlinfoCountVO){
		return bidBlinfoService.findBidBlinfoCount(bidBlinfoCountVO);
	}

	/**
	 * 交易状态统计
	 * @param bidBlinfoCountVO
	 * @return
	 */
	public List<BidBlinfoCountVO> findBlinfoTradeStatusCount(BidBlinfoCountVO bidBlinfoCountVO){
		List<BidBlinfoCountVO> varList = null;
		List<BidBlinfoCountVO> list = new ArrayList<>();

		try {
			varList = bidBlinfoService.findBlinfoTradeStatusCount(bidBlinfoCountVO);
			if(varList.size()>0){
				String oldname = "";
				Double oldmony = 0.0;
				Double oldweight = 0.0;
				int oldcount = 0;
				int num = 0;
				for (BidBlinfoCountVO balance : varList) {
					num++;
					if("1".equals(balance.getCode())){
						balance.setName("运输中");
						list.add(balance);
					}else if("-1".equals(balance.getCode())||"0".equals(balance.getCode())){
						oldname = "未运输";
						oldmony = oldmony+balance.getMony();
						oldweight = oldweight+balance.getWeight();
						oldcount = oldcount+balance.getCount();
					}else{
						list.add(balance);
					}
					if(!Tools.IsNullOrWhiteSpace(oldname)&&num == varList.size()){
						BidBlinfoCountVO b = new BidBlinfoCountVO();
						b.setName(oldname);
						b.setMony(oldmony);
						b.setWeight(oldweight);
						b.setCount(oldcount);
						list.add(b);
					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 各个仓库统计
	 * @param bidBlinfoCountVO
	 * @return
	 */
	public List<BidBlinfoCountVO> findBlinfoWarehouseList(BidBlinfoCountVO bidBlinfoCountVO){
		return bidBlinfoService.findBlinfoWarehouseList(bidBlinfoCountVO);
	}

	/**
	 * 仓库每日运输分析统计
	 * @param bidBlinfoCountVO
	 * @return
	 */
	public List<BidBlinfoCountVO> findBlinfoDayList(BidBlinfoCountVO bidBlinfoCountVO){
		return bidBlinfoService.findBlinfoDayList(bidBlinfoCountVO);
	}

	/**
	 * 仓库报表统计
	 * @param bidBlinfoVO
	 * @return
	 */
	public Page<BidBlinfoVO> findBlinfoList(Page<BidBlinfoVO> page,BidBlinfoVO bidBlinfoVO){
		Page<BidBlinfoVO> pg =bidBlinfoService.findBlinfoList(page,bidBlinfoVO);
		for (BidBlinfoVO item : pg.getList()){
			item.setStatusname(DictUtils.getDictLabel(item.getStatus(), "bidwarehouse_status", null));
		}
		return pg;
	}
	/**
	 * 仓库报表统计导出
	 * @param bidBlinfoVO
	 * @return
	 */
	public List<BidBlinfoVO> findBlinfoAllList(BidBlinfoVO bidBlinfoVO){
		return bidBlinfoService.findBlinfoAllList(bidBlinfoVO);
	}
}
