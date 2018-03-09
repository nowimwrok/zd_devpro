/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.statistics;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsBusiness;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserBalanceVO;

/**
 * 业务数据统计DAO接口
 * @author 曾煜佳
 * @version 2016-09-12
 */
@MyBatisDao
public interface StatisticsBusinessDao extends CrudDao<StatisticsBusiness> {

	/**
	 * 调用存储过程定时去统计业务数据
	 */
	public void editBusiness();
	/***
	 *
	 * 获取每天数据
	 * @return
	 */
	public List<StatisticsBusiness> getBidEverDay();
	/***
	 *
	 * 获取每周数据
	 * @return
	 */
	public List<StatisticsBusiness> getBidEverWeek();
	/***
	 *
	 * 获取每月数据
	 * @return
	 */
	public List<StatisticsBusiness> getBidEverMonth();
	/***
	 *
	 * 获取每年数据
	 * @return
	 */
	public List<StatisticsBusiness> getBidEverYear();
	
	/***
	 *
	 * 获取招标和合同每月数据
	 * @return
	 */
	public List<StatisticsBusiness> getBidMonthCount(StatisticsBusiness statisticsBusiness);
	
	/***
	 *
	 * 获取竞标每月数据
	 * @return
	 */
	public List<StatisticsBusiness> getBiddingMonthCount(StatisticsBusiness statisticsBusiness);
	
	/***
	 *
	 * 获取竞标统计数据
	 * @return
	 */
	public StatisticsBusiness getBidInfoCount(StatisticsBusiness statisticsBusiness);

	/**
	 * 竞标状态统计
	 * @param userBalanceVO
	 * @return
	 */
	public List<UserBalanceVO> findBiddingStatusMothCount(UserBalanceVO userBalanceVO);

	/**
	 * 合同运输状态统计
	 * @param userBalanceVO
	 * @return
	 */
	public List<UserBalanceVO> findContracStatusMothCount(UserBalanceVO userBalanceVO);

	/**
	 * 合同运输月分析列表
	 * @param statisticsTradetype
	 * @return
	 */
	public List<StatisticsTradetype> findContracBusinessList(StatisticsTradetype statisticsTradetype);

	
}