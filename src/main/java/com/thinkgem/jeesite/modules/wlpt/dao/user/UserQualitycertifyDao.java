/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserQualitycertify;

/**
 * 资质认证DAO接口
 * @author fjc
 * @version 2016-08-01
 */
@MyBatisDao
public interface UserQualitycertifyDao extends CrudDao<UserQualitycertify> {

	void save(UserQualitycertify userQualitycertify);
	
	/**
	 * 通过目标ID回去认证数据
	 * @param userQualitycertify
	 * @return
	 */
	UserQualitycertify getQualitycertifyInfo(UserQualitycertify userQualitycertify);
	
}