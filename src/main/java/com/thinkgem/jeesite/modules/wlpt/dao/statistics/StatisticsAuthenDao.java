/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.statistics;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsAuthen;

/**
 * 用户认证统计表DAO接口
 * @author 曾煜佳
 * @version 2016-09-12
 */
@MyBatisDao
public interface StatisticsAuthenDao extends CrudDao<StatisticsAuthen> {

	/**
	 * 调用存储过程定时去统计用户认证
	 */
	public void editAuthen();
}