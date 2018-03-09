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
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsLocationinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.lbs.LbsLocationinfoDao;

/**
 * LBS定位记录表Service
 * @author zyj
 * @version 2016-10-10
 */
@Service
@Transactional(readOnly = true)
public class LbsLocationinfoService extends CrudService<LbsLocationinfoDao, LbsLocationinfo> {

	@Autowired
	private LbsLocationinfoDao lbsLocationinfoDao;

	public LbsLocationinfo get(String id) {
		return super.get(id);
	}



	public List<LbsLocationinfo> findList(LbsLocationinfo lbsLocationinfo) {
		return super.findList(lbsLocationinfo);
	}
	
	public Page<LbsLocationinfo> findPage(Page<LbsLocationinfo> page, LbsLocationinfo lbsLocationinfo) {
		return super.findPage(page, lbsLocationinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(LbsLocationinfo lbsLocationinfo) {
		super.save(lbsLocationinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(LbsLocationinfo lbsLocationinfo) {
		super.delete(lbsLocationinfo);
	}
	
}