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
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseCredibility;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseCredibilityDao;

/**
 * 物流诚信Service
 * @author 王铸
 * @version 2016-08-08
 */
@Service
@Transactional(readOnly = true)
public class BaseCredibilityService extends CrudService<BaseCredibilityDao, BaseCredibility> {

	@Autowired
	private BaseCredibilityDao baseCredibilityDao;

	public BaseCredibility get(String id) {
		return super.get(id);
	}



	public List<BaseCredibility> findList(BaseCredibility baseCredibility) {
		return super.findList(baseCredibility);
	}
	
	public Page<BaseCredibility> findPage(Page<BaseCredibility> page, BaseCredibility baseCredibility) {
		return super.findPage(page, baseCredibility);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseCredibility baseCredibility) {
		super.save(baseCredibility);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseCredibility baseCredibility) {
		super.delete(baseCredibility);
	}
	
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		baseCredibilityDao.deleteAll(map);
	}
}