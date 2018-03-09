/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.integrity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;

/**
 * 诚信车主DAO接口
 * @author fjc
 * @version 2016-07-27
 */
@MyBatisDao
public interface IntegrityCarownerDao extends CrudDao<IntegrityCarowner> {

	/**
	 * 获取车主信息
	 * @param integrityCarowner
	 * @return
	 */
	public IntegrityCarowner findCarowner(IntegrityCarowner integrityCarowner);
}