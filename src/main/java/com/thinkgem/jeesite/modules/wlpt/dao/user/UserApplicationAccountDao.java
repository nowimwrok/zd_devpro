/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserApplicationAccount;

/**
 * 会员账户申请DAO接口
 * @author wz
 * @version 2017-05-19
 */
@MyBatisDao
public interface UserApplicationAccountDao extends CrudDao<UserApplicationAccount> {

	/**
     * 通过条件查询
     */
	public UserApplicationAccount findByCondition(UserApplicationAccount userApplicationAccount);
}