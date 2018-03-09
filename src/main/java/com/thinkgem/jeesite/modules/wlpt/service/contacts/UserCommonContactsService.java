/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.contacts;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.contacts.UserCommonContacts;
import com.thinkgem.jeesite.modules.wlpt.dao.contacts.UserCommonContactsDao;

/**
 * 常用联系人Service
 * @author zyj
 * @version 2017-04-11
 */
@Service
@Transactional(readOnly = true)
public class UserCommonContactsService extends CrudService<UserCommonContactsDao, UserCommonContacts> {

	@Autowired
	private UserCommonContactsDao userCommonContactsDao;

	public UserCommonContacts get(String id) {
		return super.get(id);
	}



	public List<UserCommonContacts> findList(UserCommonContacts userCommonContacts) {
		return super.findList(userCommonContacts);
	}
	
	public Page<UserCommonContacts> findPage(Page<UserCommonContacts> page, UserCommonContacts userCommonContacts) {
		return super.findPage(page, userCommonContacts);
	}
	
	@Transactional(readOnly = false)
	public void save(UserCommonContacts userCommonContacts) {
		super.save(userCommonContacts);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserCommonContacts userCommonContacts) {
		super.delete(userCommonContacts);
	}
	
}