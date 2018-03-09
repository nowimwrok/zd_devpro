/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.integrity;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityMemberlevel;
import com.thinkgem.jeesite.modules.wlpt.dao.integrity.IntegrityMemberlevelDao;

/**
 * 诚信会员等级Service
 * @author 刘欣
 * @version 2016-09-13
 */
@Service
@Transactional(readOnly = true)
public class IntegrityMemberlevelService extends CrudService<IntegrityMemberlevelDao, IntegrityMemberlevel> {

	@Autowired
	private IntegrityMemberlevelDao integrityMemberlevelDao;

	public IntegrityMemberlevel get(String id) {
		return super.get(id);
	}



	public List<IntegrityMemberlevel> findList(IntegrityMemberlevel integrityMemberlevel) {
		return super.findList(integrityMemberlevel);
	}
	
	public Page<IntegrityMemberlevel> findPage(Page<IntegrityMemberlevel> page, IntegrityMemberlevel integrityMemberlevel) {
		return super.findPage(page, integrityMemberlevel);
	}
	
	@Transactional(readOnly = false)
	public void save(IntegrityMemberlevel integrityMemberlevel) {
		super.save(integrityMemberlevel);
	}
	
	@Transactional(readOnly = false)
	public void delete(IntegrityMemberlevel integrityMemberlevel) {
		super.delete(integrityMemberlevel);
	}
	
}