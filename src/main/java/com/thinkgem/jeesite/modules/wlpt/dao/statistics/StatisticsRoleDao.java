/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.statistics;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRole;

/**
 * 角色会员总量统计DAO接口
 * @author 曾煜佳
 * @version 2016-09-12
 */
@MyBatisDao
public interface StatisticsRoleDao extends CrudDao<StatisticsRole> {

	/**
	 * 调用存储过程定时去统计角色会员总量
	 */
	public void editRole();
	
	/***
	 * 获取每日数据
	 * @return
     */
	public List<StatisticsRole> getEveryDayByRoleCount();
	
	/***
	 * 获取每周数据
	 * @return
     */
	public List<StatisticsRole> getEveryWeekByRoleCount();
	
	/***
	 * 获取每月数据
	 * @return
     */
	public List<StatisticsRole> getEveryMothByRoleCount();
	
	/***
	 * 获取每年数据
	 * @return
     */
	public List<StatisticsRole> getEveryYearByRoleCount();

}