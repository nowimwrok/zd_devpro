/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserScore;

/**
 * 用户积分表，相关等级、积分诚信积分DAO接口
 * @author 饶江龙
 * @version 2016-07-22
 */
@MyBatisDao
public interface UserScoreDao extends CrudDao<UserScore> {
	
}