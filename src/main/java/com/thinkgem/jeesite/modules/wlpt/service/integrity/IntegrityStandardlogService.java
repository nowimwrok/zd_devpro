/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.integrity;

import java.util.List;

import com.thinkgem.jeesite.modules.wlpt.entity.vo.IntegrityRecordVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandardlog;
import com.thinkgem.jeesite.modules.wlpt.dao.integrity.IntegrityStandardlogDao;

/**
 * 诚信积分日志Service
 * @author 刘欣
 * @version 2016-09-13
 */
@Service
@Transactional(readOnly = true)
public class IntegrityStandardlogService extends CrudService<IntegrityStandardlogDao, IntegrityStandardlog> {

	@Autowired
	private IntegrityStandardlogDao integrityStandardlogDao;

	public IntegrityStandardlog get(String id) {
		return super.get(id);
	}



	public List<IntegrityStandardlog> findList(IntegrityStandardlog integrityStandardlog) {
		return super.findList(integrityStandardlog);
	}
	
	public Page<IntegrityStandardlog> findPage(Page<IntegrityStandardlog> page, IntegrityStandardlog integrityStandardlog) {
		return super.findPage(page, integrityStandardlog);
	}
	
	@Transactional(readOnly = false)
	public void save(IntegrityStandardlog integrityStandardlog) {
		super.save(integrityStandardlog);
	}
	
	@Transactional(readOnly = false)
	public void delete(IntegrityStandardlog integrityStandardlog) {
		super.delete(integrityStandardlog);
	}

	/**
	 * 获取积分统计
	 * @param integrityStandardlog
	 * @return
	 */
	public List<IntegrityStandardlog> findSumPointvalueData(IntegrityStandardlog integrityStandardlog){
		return integrityStandardlogDao.findSumPointvalueData(integrityStandardlog);
	}
	/**
	 * 获取积分统计报表
	 * @param integrityRecordVO
	 * @return
	 */
	public Page<IntegrityRecordVO>  findSumPointvalueList(Page<IntegrityRecordVO> page, IntegrityRecordVO integrityRecordVO){
		integrityRecordVO.setPage(page);
		page.setList(dao.findSumPointvalueList(integrityRecordVO));
		return page;
	}
}