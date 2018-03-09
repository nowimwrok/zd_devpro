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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradeflow;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsTradeflowDao;

/**
 * 运输流向统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsTradeflowService extends CrudService<StatisticsTradeflowDao, StatisticsTradeflow> {

	@Autowired
	private StatisticsTradeflowDao statisticsTradeflowDao;

	public StatisticsTradeflow get(String id) {
		return super.get(id);
	}

	/**
	 * 调用存储过程定时去统计运输流向
	 */
	@Transactional(readOnly = false)
	public void editTradeflow(){
		statisticsTradeflowDao.editTradeflow();
	}

	public List<StatisticsTradeflow> findList(StatisticsTradeflow statisticsTradeflow) {
		return super.findList(statisticsTradeflow);
	}
	
	public Page<StatisticsTradeflow> findPage(Page<StatisticsTradeflow> page, StatisticsTradeflow statisticsTradeflow) {
		return super.findPage(page, statisticsTradeflow);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsTradeflow statisticsTradeflow) {
		super.save(statisticsTradeflow);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsTradeflow statisticsTradeflow) {
		super.delete(statisticsTradeflow);
	}
	
}