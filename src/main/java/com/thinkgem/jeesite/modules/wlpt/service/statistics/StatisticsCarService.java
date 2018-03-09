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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsCar;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsCarDao;

/**
 * 平台车辆统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsCarService extends CrudService<StatisticsCarDao, StatisticsCar> {

	@Autowired
	private StatisticsCarDao statisticsCarDao;

	public StatisticsCar get(String id) {
		return super.get(id);
	}

	/**
	 * 调用存储过程定时去统计平台车辆
	 */
	@Transactional(readOnly = false)
	public void editCar(){
		statisticsCarDao.editCar();
	}
	/**
	 * 获取每月车辆数据
	 */
	public List<StatisticsCar> getCarMonthData(){
		return statisticsCarDao.getCarMonthData();
	}
	/**
	 * 获取平台车辆类型数据
	 */
	public List<StatisticsCar> getCarTypeCount(){
		return statisticsCarDao.getCarTypeCount();
	}

	public List<StatisticsCar> findList(StatisticsCar statisticsCar) {
		return super.findList(statisticsCar);
	}
	
	public Page<StatisticsCar> findPage(Page<StatisticsCar> page, StatisticsCar statisticsCar) {
		return super.findPage(page, statisticsCar);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsCar statisticsCar) {
		super.save(statisticsCar);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsCar statisticsCar) {
		super.delete(statisticsCar);
	}
	
}