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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsAuthen;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsAuthenDao;

/**
 * 用户认证统计表Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsAuthenService extends CrudService<StatisticsAuthenDao, StatisticsAuthen> {

	@Autowired
	private StatisticsAuthenDao statisticsAuthenDao;

	public StatisticsAuthen get(String id) {
		return super.get(id);
	}


	/**
	 * 调用存储过程定时去统计用户认证
	 */
	@Transactional(readOnly = false)
	public void editAuthen(){
		statisticsAuthenDao.editAuthen();
	}
	public List<StatisticsAuthen> findList(StatisticsAuthen statisticsAuthen) {
		return super.findList(statisticsAuthen);
	}
	
	public Page<StatisticsAuthen> findPage(Page<StatisticsAuthen> page, StatisticsAuthen statisticsAuthen) {
		return super.findPage(page, statisticsAuthen);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsAuthen statisticsAuthen) {
		super.save(statisticsAuthen);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsAuthen statisticsAuthen) {
		super.delete(statisticsAuthen);
	}
	
}