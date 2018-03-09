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
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsWhitelist;
import com.thinkgem.jeesite.modules.wlpt.dao.lbs.LbsWhitelistDao;

/**
 * LBS白名单Service
 * @author zyj
 * @version 2016-10-10
 */
@Service
@Transactional(readOnly = true)
public class LbsWhitelistService extends CrudService<LbsWhitelistDao, LbsWhitelist> {

	@Autowired
	private LbsWhitelistDao lbsWhitelistDao;

	public LbsWhitelist get(String id) {
		return super.get(id);
	}



	public List<LbsWhitelist> findList(LbsWhitelist lbsWhitelist) {
		return super.findList(lbsWhitelist);
	}
	
	public Page<LbsWhitelist> findPage(Page<LbsWhitelist> page, LbsWhitelist lbsWhitelist) {
		return super.findPage(page, lbsWhitelist);
	}
	
	@Transactional(readOnly = false)
	public void save(LbsWhitelist lbsWhitelist) {
		super.save(lbsWhitelist);
	}
	
	@Transactional(readOnly = false)
	public void delete(LbsWhitelist lbsWhitelist) {
		super.delete(lbsWhitelist);
	}
	
}