/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.lbs;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsReslog;
import com.thinkgem.jeesite.modules.wlpt.dao.lbs.LbsReslogDao;

/**
 * LBS日志记录Service
 * @author zyj
 * @version 2016-10-10
 */
@Service
@Transactional(readOnly = true)
public class LbsReslogService extends CrudService<LbsReslogDao, LbsReslog> {

	@Autowired
	private LbsReslogDao lbsReslogDao;

	public LbsReslog get(String id) {
		return super.get(id);
	}



	public List<LbsReslog> findList(LbsReslog lbsReslog) {
		return super.findList(lbsReslog);
	}
	
	public Page<LbsReslog> findPage(Page<LbsReslog> page, LbsReslog lbsReslog) {
		return super.findPage(page, lbsReslog);
	}
	
	@Transactional(readOnly = false)
	public void save(LbsReslog lbsReslog) {
		super.save(lbsReslog);
	}
	
	@Transactional(readOnly = false)
	public void delete(LbsReslog lbsReslog) {
		super.delete(lbsReslog);
	}
	
}