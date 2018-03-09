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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRole;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsRoleDao;

/**
 * 角色会员总量统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsRoleService extends CrudService<StatisticsRoleDao, StatisticsRole> {

	@Autowired
	private StatisticsRoleDao statisticsRoleDao;

	public StatisticsRole get(String id) {
		return super.get(id);
	}

	/**
	 * 调用存储过程定时去统计角色会员总量
	 */
	@Transactional(readOnly = false)
	public void editRole(){
		statisticsRoleDao.editRole();
	}

	public List<StatisticsRole> findList(StatisticsRole statisticsRole) {
		return super.findList(statisticsRole);
	}
	
	public Page<StatisticsRole> findPage(Page<StatisticsRole> page, StatisticsRole statisticsRole) {
		return super.findPage(page, statisticsRole);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsRole statisticsRole) {
		super.save(statisticsRole);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsRole statisticsRole) {
		super.delete(statisticsRole);
	}
	
	/***
	 * 获取每日数据
	 * @return
     */
	public List<StatisticsRole> getEveryDayByRoleCount(){
		return statisticsRoleDao.getEveryDayByRoleCount();
	}
	
	/***
	 * 获取每周数据
	 * @return
     */
	public List<StatisticsRole> getEveryWeekByRoleCount(){
		return statisticsRoleDao.getEveryWeekByRoleCount();
	}
	
	/***
	 * 获取每月数据
	 * @return
     */
	public List<StatisticsRole> getEveryMothByRoleCount(){
		return statisticsRoleDao.getEveryMothByRoleCount();
	}
	
	/***
	 * 获取每年数据
	 * @return
     */
	public List<StatisticsRole> getEveryYearByRoleCount(){
		return statisticsRoleDao.getEveryYearByRoleCount();
	}
}