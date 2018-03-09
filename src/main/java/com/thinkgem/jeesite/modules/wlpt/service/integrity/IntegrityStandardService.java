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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandard;
import com.thinkgem.jeesite.modules.wlpt.dao.integrity.IntegrityStandardDao;

/**
 * 诚信标准Service
 * @author 刘欣
 * @version 2016-09-13
 */
@Service
@Transactional(readOnly = true)
public class IntegrityStandardService extends CrudService<IntegrityStandardDao, IntegrityStandard> {

	@Autowired
	private IntegrityStandardDao integrityStandardDao;

	public IntegrityStandard get(String id) {
		return super.get(id);
	}



	public List<IntegrityStandard> findList(IntegrityStandard integrityStandard) {
		return super.findList(integrityStandard);
	}
	
	public Page<IntegrityStandard> findPage(Page<IntegrityStandard> page, IntegrityStandard integrityStandard) {
		return super.findPage(page, integrityStandard);
	}
	
	@Transactional(readOnly = false)
	public void save(IntegrityStandard integrityStandard) {
		super.save(integrityStandard);
	}
	
	@Transactional(readOnly = false)
	public void delete(IntegrityStandard integrityStandard) {
		super.delete(integrityStandard);
	}
	
}