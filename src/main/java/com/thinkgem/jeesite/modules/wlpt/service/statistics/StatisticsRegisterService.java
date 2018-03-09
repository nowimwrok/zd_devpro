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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRegister;
import com.thinkgem.jeesite.modules.wlpt.dao.statistics.StatisticsRegisterDao;

/**
 * 注册统计Service
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Service
@Transactional(readOnly = true)
public class StatisticsRegisterService extends CrudService<StatisticsRegisterDao, StatisticsRegister> {

	@Autowired
	private StatisticsRegisterDao statisticsRegisterDao;

	public StatisticsRegister get(String id) {
		return super.get(id);
	}
	/**
	 * 调用存储过程定时去统计用户注册
	 */
	@Transactional(readOnly = false)
	public void editRegister(){
		statisticsRegisterDao.editRegister();
	}
	/**
	 * 获取平台角色数据
	 */
	public List<StatisticsRegister> getRoleCount(){
		return statisticsRegisterDao.getRoleCount();
	}


	public List<StatisticsRegister> findList(StatisticsRegister statisticsRegister) {
		return super.findList(statisticsRegister);
	}
	
	public Page<StatisticsRegister> findPage(Page<StatisticsRegister> page, StatisticsRegister statisticsRegister) {
		return super.findPage(page, statisticsRegister);
	}
	
	@Transactional(readOnly = false)
	public void save(StatisticsRegister statisticsRegister) {
		super.save(statisticsRegister);
	}
	
	@Transactional(readOnly = false)
	public void delete(StatisticsRegister statisticsRegister) {
		super.delete(statisticsRegister);
	}
	
}