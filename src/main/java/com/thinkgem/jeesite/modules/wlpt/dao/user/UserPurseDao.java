/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;

/**
 * 账户钱包DAO接口
 * @author 饶江龙
 * @version 2016-07-18
 */
@MyBatisDao
public interface UserPurseDao extends CrudDao<UserPurse> {
	
}