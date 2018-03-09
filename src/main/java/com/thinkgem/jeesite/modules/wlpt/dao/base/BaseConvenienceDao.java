/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.Map;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseConvenience;

/**
 * 便民服务DAO接口
 * @author 王铸
 * @version 2016-08-08
 */
@MyBatisDao
public interface BaseConvenienceDao extends CrudDao<BaseConvenience> {

	/**
	 * 批量删除
	 * @param map
	 * @return
	 */
	public void deleteAll(Map<String,String> map);
}