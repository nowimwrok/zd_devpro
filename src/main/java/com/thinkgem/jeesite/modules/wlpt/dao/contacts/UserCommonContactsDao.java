/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.contacts;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.contacts.UserCommonContacts;

/**
 * 常用联系人DAO接口
 * @author zyj
 * @version 2017-04-11
 */
@MyBatisDao
public interface UserCommonContactsDao extends CrudDao<UserCommonContacts> {

	
}