/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;

/**
 * 企业图片信息DAO接口
 * @author fjc
 * @version 2016-07-27
 */
@MyBatisDao
public interface UserCompanypictureDao extends CrudDao<UserCompanypicture> {

	/**
	 * 获取图片信息
	 * @param usercompanypicture
	 * @return
	 */
	public UserCompanypicture findPicture(UserCompanypicture usercompanypicture);
	

	/**
	 * 根据对象获取信息
	 * @param userCompanypicture
	 * @return
	 */
	public UserCompanypicture getByUserCompanypicture(UserCompanypicture userCompanypicture);
}