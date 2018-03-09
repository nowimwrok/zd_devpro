/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseCredibility;

/**
 * 物流诚信DAO接口
 * @author 王铸
 * @version 2016-08-08
 */
@MyBatisDao
public interface BaseCredibilityDao extends CrudDao<BaseCredibility> {

	/**
	 * 批量删除
	 * @param map
	 * @return
	 */
	public void deleteAll(Map<String,String> map);
}