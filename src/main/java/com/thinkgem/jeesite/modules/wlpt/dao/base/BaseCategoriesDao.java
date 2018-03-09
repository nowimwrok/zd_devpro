/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseCategories;

/**
 * categoriesDAO接口
 * @author 王铸
 * @version 2016-08-04
 */
@MyBatisDao
public interface BaseCategoriesDao extends CrudDao<BaseCategories> {
	
	/**
	 * 通过 baseCategories获取信息列表
	 * @param baseCategories
	 * @return List<BaseCategories>
	 */
	public List<BaseCategories> getCategoriesByCondition(BaseCategories baseCategories);

	
}