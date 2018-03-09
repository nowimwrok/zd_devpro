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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandarditems;
import com.thinkgem.jeesite.modules.wlpt.dao.integrity.IntegrityStandarditemsDao;

/**
 * 诚信标准评分项Service
 * @author 刘欣
 * @version 2016-09-13
 */
@Service
@Transactional(readOnly = true)
public class IntegrityStandarditemsService extends CrudService<IntegrityStandarditemsDao, IntegrityStandarditems> {

	@Autowired
	private IntegrityStandarditemsDao integrityStandarditemsDao;

	public IntegrityStandarditems get(String id) {
		return super.get(id);
	}

	public List<IntegrityStandarditems> getByName(IntegrityStandarditems IntegrityStandarditems) {
		return integrityStandarditemsDao.getByName(IntegrityStandarditems);
	}

	public List<IntegrityStandarditems> findList(IntegrityStandarditems integrityStandarditems) {
		return super.findList(integrityStandarditems);
	}
	
	public Page<IntegrityStandarditems> findPage(Page<IntegrityStandarditems> page, IntegrityStandarditems integrityStandarditems) {
		return super.findPage(page, integrityStandarditems);
	}
	
	@Transactional(readOnly = false)
	public void save(IntegrityStandarditems integrityStandarditems) {
		super.save(integrityStandarditems);
	}
	
	@Transactional(readOnly = false)
	public void delete(IntegrityStandarditems integrityStandarditems) {
		super.delete(integrityStandarditems);
	}
	
}