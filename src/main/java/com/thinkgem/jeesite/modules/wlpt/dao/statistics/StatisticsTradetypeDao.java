/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.statistics;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.Page;

import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetypeVo;

/**
 * 货源运输量统计DAO接口
 * @author 曾煜佳
 * @version 2016-09-12
 */
@MyBatisDao
public interface StatisticsTradetypeDao extends CrudDao<StatisticsTradetype> {

	/**
	 * 调用存储过程定时去统计货源运输量
	 */
	public void editTradetype();
	/***
	 *
	 * 获取每天数据
	 * @return
	 */
	public List<StatisticsTradetype> getEveryDayCount(StatisticsTradetype statisticsTradetype);
	/***
	 *
	 * 获取每周数据
	 * @return
	 */
	public List<StatisticsTradetype> getEveryWeekCount(StatisticsTradetype statisticsTradetype);
	/***
	 *
	 * 获取每月数据
	 * @return
	 */
	public List<StatisticsTradetype> getEveryMothCount(StatisticsTradetype statisticsTradetype);
	
	/***
	 *
	 * 获取每月数据
	 * @return
	 */
	public List<StatisticsTradetype> getGoodsCountMonth(StatisticsTradetype statisticsTradetype);
	
	/***
	 *
	 * 获取每年数据
	 * @return
	 */
	public List<StatisticsTradetype> getEveryYearCount(StatisticsTradetype statisticsTradetype);
	/***
	 * 获取每日数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindDay();
	/***
	 * 获取每周数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindWeek();
	/***
	 * 获取每月数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindMonth();
	/***
	 * 获取每年数据 交易类型货物类型
	 * @return
	 */
	public List<StatisticsTradetype> getTradeKindYear();
	
	/**
	 * 获取单条数据
	 * @param id
	 * @return
	 */
	public StatisticsTradetype gettradetype(String id);
	
	/**
	 * 获取运单统计条数据
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype getOrderNumCount(StatisticsTradetype statisticsTradetype);
	
	/***
	 *
	 * 获取每天数据
	 * @return
	 */
	public List<StatisticsTradetype> findtradetypeList(StatisticsTradetype statisticsTradetype);
}