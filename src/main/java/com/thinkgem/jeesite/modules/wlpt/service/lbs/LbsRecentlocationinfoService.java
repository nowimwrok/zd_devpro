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
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsRecentlocationinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.lbs.LbsRecentlocationinfoDao;

/**
 * LBS历史定位表Service
 * @author zyj
 * @version 2016-10-10
 */
@Service
@Transactional(readOnly = true)
public class LbsRecentlocationinfoService extends CrudService<LbsRecentlocationinfoDao, LbsRecentlocationinfo> {

	@Autowired
	private LbsRecentlocationinfoDao lbsRecentlocationinfoDao;

	public LbsRecentlocationinfo get(String id) {
		return super.get(id);
	}



	public List<LbsRecentlocationinfo> findList(LbsRecentlocationinfo lbsRecentlocationinfo) {
		return super.findList(lbsRecentlocationinfo);
	}
	
	public Page<LbsRecentlocationinfo> findPage(Page<LbsRecentlocationinfo> page, LbsRecentlocationinfo lbsRecentlocationinfo) {
		return super.findPage(page, lbsRecentlocationinfo);
	}
	
	
	public LbsRecentlocationinfo findByCondition(LbsRecentlocationinfo lbsRecentlocationinfo) {
		return lbsRecentlocationinfoDao.findByCondition(lbsRecentlocationinfo);
	}
	@Transactional(readOnly = false)
	public void save(LbsRecentlocationinfo lbsRecentlocationinfo) {
		super.save(lbsRecentlocationinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(LbsRecentlocationinfo lbsRecentlocationinfo) {
		super.delete(lbsRecentlocationinfo);
	}
	
}