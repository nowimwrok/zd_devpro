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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsScore;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsScoreDao;

/**
 * 诚信积分统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsScoreService extends CrudService<StatisticsScoreDao, StatisticsScore> {

	@Autowired
	private StatisticsScoreDao statisticsScoreDao;

	public StatisticsScore get(String id) {
		return super.get(id);
	}

	/**
	 * 调用存储过程定时去统计诚信积分
	 */
	@Transactional(readOnly = false)
	public void editScore(){
		statisticsScoreDao.editScore();
	}

	public List<StatisticsScore> findList(StatisticsScore statisticsScore) {
		return super.findList(statisticsScore);
	}
	
	public Page<StatisticsScore> findPage(Page<StatisticsScore> page, StatisticsScore statisticsScore) {
		return super.findPage(page, statisticsScore);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsScore statisticsScore) {
		super.save(statisticsScore);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsScore statisticsScore) {
		super.delete(statisticsScore);
	}
	
}