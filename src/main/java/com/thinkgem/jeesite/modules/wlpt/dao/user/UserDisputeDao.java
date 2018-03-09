/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;

/**
 * 争议处理DAO接口
 * @author fjc
 * @version 2016-08-05
 */
@MyBatisDao
public interface UserDisputeDao extends CrudDao<UserDispute> {

	/**
	 * 通过运单id获取争议信息
	 * @param orderId
	 * @return
	 */
	UserDispute getByUserDispute(String orderId);
}