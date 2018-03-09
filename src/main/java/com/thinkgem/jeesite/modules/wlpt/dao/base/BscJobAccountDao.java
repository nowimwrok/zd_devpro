/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJobAccount;

/**
 * 轮询任务数据管理DAO接口
 * @author zyj
 * @version 2017-03-21
 */
@MyBatisDao
public interface BscJobAccountDao extends CrudDao<BscJobAccount> {

	/**
	 * 根据单据号
	 * @param bscJobAccount
	 * @return
	 */
	BscJobAccount findByCondition(BscJobAccount bscJobAccount);
}