/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.comment;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.comment.StatisticsOwnerDao;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.StatisticsOwner;

/**
 * 用户信息统计表Service
 * @author 王铸
 * @version 2016-08-31
 */
@Service
@Transactional(readOnly = true)
public class StatisticsOwnerService extends CrudService<StatisticsOwnerDao, StatisticsOwner> {

	@Autowired
	private StatisticsOwnerDao statisticsOwnerDao;

	public StatisticsOwner get(String id) {
		return super.get(id);
	}



	public List<StatisticsOwner> findList(StatisticsOwner statisticsOwner) {
		return super.findList(statisticsOwner);
	}
	
	public Page<StatisticsOwner> findPage(Page<StatisticsOwner> page, StatisticsOwner statisticsOwner) {
		return super.findPage(page, statisticsOwner);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsOwner statisticsOwner) {
		super.save(statisticsOwner);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsOwner statisticsOwner) {
		super.delete(statisticsOwner);
	}
	
}