/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserAccount;

/**
 * 用户账户系统会员管理DAO接口
 * @author zyj
 * @version 2017-05-17
 */
@MyBatisDao
public interface UserAccountDao extends CrudDao<UserAccount> {

	/**
	 * 根据会员id查找账户系统数据
	 * @param memberId
	 * @return
	 */
	UserAccount getUserAccount(String memberId);
}