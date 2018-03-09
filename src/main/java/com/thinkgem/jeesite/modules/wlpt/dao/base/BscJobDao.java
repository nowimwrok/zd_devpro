/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;

/**
 * 任务DAO接口
 * @author 王铸
 * @version 2016-09-07
 */
@MyBatisDao
public interface BscJobDao extends CrudDao<BscJob> {

	public BscJob findByCondition(BscJob bscJob);
}