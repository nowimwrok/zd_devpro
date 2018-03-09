/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BscJobDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;

/**
 * 任务Service
 * @author 王铸
 * @version 2016-09-07
 */
@Service
@Transactional(readOnly = true)
public class BscJobService extends CrudService<BscJobDao, BscJob> {

	@Autowired
	private BscJobDao bscJobDao;

	public BscJob get(String id) {
		return super.get(id);
	}



	public List<BscJob> findList(BscJob bscJob) {
		return super.findList(bscJob);
	}
	
	public Page<BscJob> findPage(Page<BscJob> page, BscJob bscJob) {
		return super.findPage(page, bscJob);
	}
	
	public BscJob findByCondition(BscJob bscJob){
		return bscJobDao.findByCondition(bscJob);
	}
	
	@Transactional(readOnly = false)
	public void save(BscJob bscJob) {
		super.save(bscJob);
	}
	
	@Transactional(readOnly = false)
	public void delete(BscJob bscJob) {
		super.delete(bscJob);
	}
	
}