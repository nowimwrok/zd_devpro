/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseCategories;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseCategoriesDao;

/**
 * categoriesService
 * @author 王铸
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class BaseCategoriesService extends CrudService<BaseCategoriesDao, BaseCategories> {

	@Autowired
	private BaseCategoriesDao baseCategoriesDao;

	public BaseCategories get(String id) {
		return super.get(id);
	}

	public List<BaseCategories> findList(BaseCategories baseCategories) {
		return super.findList(baseCategories);
	}
	
	public Page<BaseCategories> findPage(Page<BaseCategories> page, BaseCategories baseCategories) {
		return super.findPage(page, baseCategories);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseCategories baseCategories) {
		super.save(baseCategories);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseCategories baseCategories) {
		super.delete(baseCategories);
	}
	
	/**
	 * 通过baseCategories获取信息列表
	 * @param baseCategories
	 * @return List<BaseCategories>
	 */
	public List<BaseCategories> getCategoriesByCondition(BaseCategories baseCategories){
		return baseCategoriesDao.getCategoriesByCondition(baseCategories);
	}
	/**
	 * 获取指定parent_id的Categories列表
	 * @param categories name
	 * @return List<BaseCategories>
	 */
	public List<BaseCategories> getCategories(String name){
		BaseCategories baseCategories=new BaseCategories();
		baseCategories.setName(name);
		baseCategories=this.getCategoriesByCondition(baseCategories).get(0);
		BaseCategories baseCategories1=new BaseCategories();
		baseCategories1.setParent(baseCategories);
		List<BaseCategories> list=this.getCategoriesByCondition(baseCategories1);
		return list;
	}
	
}