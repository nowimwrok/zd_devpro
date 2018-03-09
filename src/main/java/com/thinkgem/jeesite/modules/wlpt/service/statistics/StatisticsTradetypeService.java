/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.statistics;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetypeVo;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsTradetypeDao;

/**
 * 货源运输量统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsTradetypeService extends CrudService<StatisticsTradetypeDao, StatisticsTradetype> {

	@Autowired
	private StatisticsTradetypeDao statisticsTradetypeDao;

	public StatisticsTradetype get(String id) {
		return super.get(id);
	}

	/**
	 * 调用存储过程定时去统计货源运输量
	 */
	@Transactional(readOnly = false)
	public void editTradetype(){
		statisticsTradetypeDao.editTradetype();
	}

	public List<StatisticsTradetype> findList(StatisticsTradetype statisticsTradetype) {
		return super.findList(statisticsTradetype);
	}
	
	public Page<StatisticsTradetype> findPage(Page<StatisticsTradetype> page, StatisticsTradetype statisticsTradetype) {
		return super.findPage(page, statisticsTradetype);
	}
	
	public StatisticsTradetype gettradetype(String id) {
		return statisticsTradetypeDao.gettradetype(id);
	}
	
	/***
	 *
	 * 获取每天数据
	 * @return
	 */
	public Page<StatisticsTradetype> findtradetypeList(Page<StatisticsTradetype> page, StatisticsTradetype statisticsTradetype){
		statisticsTradetype.setPage(page);
		page.setList(statisticsTradetypeDao.findtradetypeList(statisticsTradetype));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsTradetype statisticsTradetype) {
		super.save(statisticsTradetype);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsTradetype statisticsTradetype) {
		super.delete(statisticsTradetype);
	}
	/**
	 * 获取每天数据
	 */
	public List<StatisticsTradetype> getEveryDayCount(StatisticsTradetype statisticsTradetype){
		return statisticsTradetypeDao.getEveryDayCount(statisticsTradetype);
	}
	/**
	 * 获取每周数据
	 */
	public List<StatisticsTradetype> getEveryWeekCount(StatisticsTradetype statisticsTradetype){
		return statisticsTradetypeDao.getEveryWeekCount(statisticsTradetype);
	}
	/**
	 * 获取每月数据
	 */
	public List<StatisticsTradetype> getEveryMothCount(StatisticsTradetype statisticsTradetype){
		return statisticsTradetypeDao.getEveryMothCount(statisticsTradetype);
	}
	
	/**
	 * 获取每月数据
	 */
	public List<StatisticsTradetype> getGoodsCountMonth(StatisticsTradetype statisticsTradetype){
		return statisticsTradetypeDao.getGoodsCountMonth(statisticsTradetype);
	}
	
	/**
	 * 获取每年数据
	 */
	public List<StatisticsTradetype> getEveryYearCount(StatisticsTradetype statisticsTradetype){
		return statisticsTradetypeDao.getEveryYearCount(statisticsTradetype);
	}
	/***
	 * 获取每日数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindDay(){
		return statisticsTradetypeDao.getTradeKindDay();
	}
	/***
	 * 获取每周数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindWeek(){
		return statisticsTradetypeDao.getTradeKindWeek();
	}
	/***
	 * 获取每月数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindMonth(){
		return statisticsTradetypeDao.getTradeKindMonth();
	}
	/***
	 * 获取每年数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindYear(){
		return statisticsTradetypeDao.getTradeKindYear();
	}
	/**
	 * 获取运单统计条数据
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype getOrderNumCount(StatisticsTradetype statisticsTradetype){
		return statisticsTradetypeDao.getOrderNumCount(statisticsTradetype);
	}
	
	
}