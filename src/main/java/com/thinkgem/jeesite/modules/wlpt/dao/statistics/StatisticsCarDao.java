/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.statistics;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsCar;

/**
 * 平台车辆统计DAO接口
 * @author 曾煜佳
 * @version 2016-09-12
 */
@MyBatisDao
public interface StatisticsCarDao extends CrudDao<StatisticsCar> {

	/**
	 * 调用存储过程定时去统计平台车辆
	 */
	public void editCar();
	/***
	 *
	 * 获取每月数据
	 * @return
	 */
	public List<StatisticsCar> getCarMonthData();
	/***
	 *
	 * 获取车类型数据
	 * @return
	 */
	public List<StatisticsCar> getCarTypeCount();
}