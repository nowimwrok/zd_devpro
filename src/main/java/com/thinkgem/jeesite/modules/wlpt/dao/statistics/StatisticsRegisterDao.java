/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.statistics;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRegister;

/**
 * 注册统计DAO接口
 * @author 曾煜佳
 * @version 2016-09-12
 */
@MyBatisDao
public interface StatisticsRegisterDao extends CrudDao<StatisticsRegister> {

	/**
	 * 调用存储过程定时去统计用户注册
	 */
	public void editRegister();
	
	/***
	 *
	 * 获取平台角色数据
	 * @return
	 */
	public List<StatisticsRegister> getRoleCount();
}