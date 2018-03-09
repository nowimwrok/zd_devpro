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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsUsermoney;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsUsermoneyDao;

/**
 * 账户资金统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsUsermoneyService extends CrudService<StatisticsUsermoneyDao, StatisticsUsermoney> {

	@Autowired
	private StatisticsUsermoneyDao statisticsUsermoneyDao;

	public StatisticsUsermoney get(String id) {
		return super.get(id);
	}

	/**
	 * 调用存储过程定时去统计账户资金
	 */
	@Transactional(readOnly = false)
	public void editUsermoney(){
		statisticsUsermoneyDao.editUsermoney();
	}

	public List<StatisticsUsermoney> findList(StatisticsUsermoney statisticsUsermoney) {
		return super.findList(statisticsUsermoney);
	}
	
	public Page<StatisticsUsermoney> findPage(Page<StatisticsUsermoney> page, StatisticsUsermoney statisticsUsermoney) {
		return super.findPage(page, statisticsUsermoney);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsUsermoney statisticsUsermoney) {
		super.save(statisticsUsermoney);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsUsermoney statisticsUsermoney) {
		super.delete(statisticsUsermoney);
	}
	
}