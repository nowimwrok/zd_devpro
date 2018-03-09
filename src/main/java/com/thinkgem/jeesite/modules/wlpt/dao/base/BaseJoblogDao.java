/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseJoblog;

/**
 * 任务日志DAO接口
 * @author 王铸
 * @version 2016-09-07
 */
@MyBatisDao
public interface BaseJoblogDao extends CrudDao<BaseJoblog> {

	public BaseJoblog findByCondition(BaseJoblog baseJoblog);
}