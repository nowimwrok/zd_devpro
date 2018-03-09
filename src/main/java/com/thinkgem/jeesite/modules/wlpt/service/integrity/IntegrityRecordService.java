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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityRecord;
import com.thinkgem.jeesite.modules.wlpt.dao.integrity.IntegrityRecordDao;

/**
 * 诚信积分Service
 * @author 刘欣
 * @version 2016-09-13
 */
@Service
@Transactional(readOnly = true)
public class IntegrityRecordService extends CrudService<IntegrityRecordDao, IntegrityRecord> {

	@Autowired
	private IntegrityRecordDao integrityRecordDao;

	public IntegrityRecord get(String id) {
		return super.get(id);
	}



	public List<IntegrityRecord> findList(IntegrityRecord integrityRecord) {
		return super.findList(integrityRecord);
	}
	
	public Page<IntegrityRecord> findPage(Page<IntegrityRecord> page, IntegrityRecord integrityRecord) {
		return super.findPage(page, integrityRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(IntegrityRecord integrityRecord) {
		super.save(integrityRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(IntegrityRecord integrityRecord) {
		super.delete(integrityRecord);
	}
	
}