/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseFeedback;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseFeedbackDao;

/**
 * 意见反馈Service
 * @author 王铸
 * @version 2016-08-09
 */
@Service
@Transactional(readOnly = true)
public class BaseFeedbackService extends CrudService<BaseFeedbackDao, BaseFeedback> {

	@Autowired
	private BaseFeedbackDao baseFeedbackDao;

	public BaseFeedback get(String id) {
		return super.get(id);
	}



	public List<BaseFeedback> findList(BaseFeedback baseFeedback) {
		return super.findList(baseFeedback);
	}
	
	public Page<BaseFeedback> findPage(Page<BaseFeedback> page, BaseFeedback baseFeedback) {
		return super.findPage(page, baseFeedback);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseFeedback baseFeedback) {
		super.save(baseFeedback);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseFeedback baseFeedback) {
		super.delete(baseFeedback);
	}
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		baseFeedbackDao.deleteAll(map);
	}
}