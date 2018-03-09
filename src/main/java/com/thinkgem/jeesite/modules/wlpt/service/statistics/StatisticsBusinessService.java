/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.statistics;

import java.util.List;

import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserBalanceVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsBusiness;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsBusinessDao;

/**
 * 业务数据统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsBusinessService extends CrudService<StatisticsBusinessDao, StatisticsBusiness> {

	@Autowired
	private StatisticsBusinessDao statisticsBusinessDao;

	public StatisticsBusiness get(String id) {
		return super.get(id);
	}

	/**
	 * 调用存储过程定时去统计业务数据
	 */
	@Transactional(readOnly = false)
	public void editBusiness(){
		statisticsBusinessDao.editBusiness();
	}

	public List<StatisticsBusiness> findList(StatisticsBusiness statisticsBusiness) {
		return super.findList(statisticsBusiness);
	}
	
	public Page<StatisticsBusiness> findPage(Page<StatisticsBusiness> page, StatisticsBusiness statisticsBusiness) {
		return super.findPage(page, statisticsBusiness);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsBusiness statisticsBusiness) {
		super.save(statisticsBusiness);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsBusiness statisticsBusiness) {
		super.delete(statisticsBusiness);
	}
	/**
	 * 获取每天数据
	 */
	public List<StatisticsBusiness> getBidEverDay(){
		return statisticsBusinessDao.getBidEverDay();
	}
	/**
	 * 获取每周数据
	 */
	public List<StatisticsBusiness> getBidEverWeek(){
		return statisticsBusinessDao.getBidEverWeek();
	}
	/**
	 * 获取每月数据
	 */
	public List<StatisticsBusiness> getBidEverMonth(){
		return statisticsBusinessDao.getBidEverMonth();
	}
	
	
	/**
	 * 获取每年数据
	 */
	public List<StatisticsBusiness> getBidEverYear(){
		return statisticsBusinessDao.getBidEverYear();
	}
	
	/**
	 * 获取招标和合同每月数据
	 */
	public List<StatisticsBusiness> getBidMonthCount(StatisticsBusiness statisticsBusiness){
		return statisticsBusinessDao.getBidMonthCount(statisticsBusiness);
	}
	
	/***
	 *
	 * 获取竞标每月数据
	 * @return
	 */
	public List<StatisticsBusiness> getBiddingMonthCount(StatisticsBusiness statisticsBusiness){
		return statisticsBusinessDao.getBiddingMonthCount(statisticsBusiness);
	}
	/***
	 *
	 * 获取竞标统计数据
	 * @return
	 */
	public StatisticsBusiness getBidInfoCount(StatisticsBusiness statisticsBusiness){
		return statisticsBusinessDao.getBidInfoCount(statisticsBusiness);
	}
	/**
	 * 竞标状态统计
	 * @param userBalanceVO
	 * @return
	 */
	public List<UserBalanceVO> findBiddingStatusMothCount(UserBalanceVO userBalanceVO){
		return statisticsBusinessDao.findBiddingStatusMothCount(userBalanceVO);
	}

	/**
	 * 合同运输状态统计
	 * @param userBalanceVO
	 * @return
	 */
	public List<UserBalanceVO> findContracStatusMothCount(UserBalanceVO userBalanceVO){
		return statisticsBusinessDao.findContracStatusMothCount(userBalanceVO);
	}

	/**
	 * 合同运输分析列表
	 * @param statisticsTradetype
	 * @return
	 */
	public List<StatisticsTradetype> findContracBusinessList(StatisticsTradetype statisticsTradetype){
		return statisticsBusinessDao.findContracBusinessList(statisticsTradetype);
	}


}