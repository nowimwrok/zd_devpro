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
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJobAccount;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BscJobAccountDao;

/**
 * 轮询任务数据管理Service
 * @author zyj
 * @version 2017-03-21
 */
@Service
@Transactional(readOnly = true)
public class BscJobAccountService extends CrudService<BscJobAccountDao, BscJobAccount> {

	@Autowired
	private BscJobAccountDao bscJobAccountDao;

	public BscJobAccount get(String id) {
		return super.get(id);
	}

	/**
	 * 根据单据号
	 * @param bscJobAccount
	 * @return
	 */
	public BscJobAccount findByCondition(BscJobAccount bscJobAccount){
		return bscJobAccountDao.findByCondition(bscJobAccount);
	}

	public List<BscJobAccount> findList(BscJobAccount bscJobAccount) {
		return super.findList(bscJobAccount);
	}
	
	public Page<BscJobAccount> findPage(Page<BscJobAccount> page, BscJobAccount bscJobAccount) {
		return super.findPage(page, bscJobAccount);
	}
	
	@Transactional(readOnly = false)
	public void save(BscJobAccount bscJobAccount) {
		super.save(bscJobAccount);
	}
	
	@Transactional(readOnly = false)
	public void delete(BscJobAccount bscJobAccount) {
		super.delete(bscJobAccount);
	}
	
}