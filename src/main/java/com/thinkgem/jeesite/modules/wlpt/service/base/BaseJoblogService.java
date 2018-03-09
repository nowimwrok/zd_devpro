package com.thinkgem.jeesite.modules.wlpt.service.base;
/**
 * 
 */

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseJoblogDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseJoblog;


/**
 * 任务日志Service
 * @author 王铸
 * @version 2016-09-07
 */
@Service
@Transactional(readOnly = true)
public class BaseJoblogService extends CrudService<BaseJoblogDao,BaseJoblog> {

	@Autowired
	private BaseJoblogDao baseJoblogDao;

	public BaseJoblog get(String id) {
		return super.get(id);
	}



	public List<BaseJoblog> findList(BaseJoblog baseJoblog) {
		return super.findList(baseJoblog);
	}
	
	public Page<BaseJoblog> findPage(Page<BaseJoblog> page, BaseJoblog baseJoblog) {
		return super.findPage(page, baseJoblog);
	}
	
	public BaseJoblog findByCondition(BaseJoblog baseJoblog){
		return baseJoblogDao.findByCondition(baseJoblog);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseJoblog baseJoblog) {
		super.save(baseJoblog);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseJoblog baseJoblog) {
		super.delete(baseJoblog);
	}
	
}