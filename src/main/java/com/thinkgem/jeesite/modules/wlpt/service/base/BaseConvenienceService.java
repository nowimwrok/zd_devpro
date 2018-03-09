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
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseConvenience;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseConvenienceDao;

/**
 * 便民服务Service
 * @author 王铸
 * @version 2016-08-08
 */
@Service
@Transactional(readOnly = true)
public class BaseConvenienceService extends CrudService<BaseConvenienceDao, BaseConvenience> {

	@Autowired
	private BaseConvenienceDao baseConvenienceDao;

	public BaseConvenience get(String id) {
		return super.get(id);
	}



	public List<BaseConvenience> findList(BaseConvenience baseConvenience) {
		return super.findList(baseConvenience);
	}
	
	public Page<BaseConvenience> findPage(Page<BaseConvenience> page, BaseConvenience baseConvenience) {
		return super.findPage(page, baseConvenience);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseConvenience baseConvenience) {
		super.save(baseConvenience);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseConvenience baseConvenience) {
		super.delete(baseConvenience);
	}
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		baseConvenienceDao.deleteAll(map);
	}
}