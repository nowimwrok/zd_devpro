/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserIdcard;

/**
 * 用户身份证DAO接口
 * @author fjc
 * @version 2016-08-02
 */
@MyBatisDao
public interface UserIdcardDao extends CrudDao<UserIdcard> {

	
	/**
	 * 通过idcardnum获取数据
	 * @param idcardnum
	 * @return
	 */
	public UserIdcard getByIdcard(String idcardnum);
}