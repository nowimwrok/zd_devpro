/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BasePolicy;

/**
 * 政策公告DAO接口
 * @author 王铸
 * @version 2016-08-04
 */
@MyBatisDao
public interface BasePolicyDao extends CrudDao<BasePolicy> {

	/**
	 * 批量删除
	 * @param map
	 * @return
	 */
	public void deleteAll(Map<String,String> map);
}