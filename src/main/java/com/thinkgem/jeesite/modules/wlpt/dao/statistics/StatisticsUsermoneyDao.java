/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.statistics;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsUsermoney;

/**
 * 账户资金统计DAO接口
 * @author 曾煜佳
 * @version 2016-09-12
 */
@MyBatisDao
public interface StatisticsUsermoneyDao extends CrudDao<StatisticsUsermoney> {

	/**
	 * 调用存储过程定时去统计账户资金
	 */
	public void editUsermoney();
}