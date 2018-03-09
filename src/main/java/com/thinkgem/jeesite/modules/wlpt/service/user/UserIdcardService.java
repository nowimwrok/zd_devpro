/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserIdcard;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserIdcardDao;

/**
 * 用户身份证Service
 * 
 * @author fjc
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class UserIdcardService extends CrudService<UserIdcardDao, UserIdcard> {

	@Autowired
	private UserIdcardDao userIdcardDao;

	public UserIdcard get(String id) {
		return super.get(id);
	}

	/**
	 * 获取单条数据
	 */
	public UserIdcard get(UserIdcard idcard) {
		return super.get(idcard);
	}

	public List<UserIdcard> findList(UserIdcard userIdcard) {
		return super.findList(userIdcard);
	}

	public Page<UserIdcard> findPage(Page<UserIdcard> page, UserIdcard userIdcard) {
		return super.findPage(page, userIdcard);
	}

	@Transactional(readOnly = false)
	public void save(UserIdcard userIdcard) {
		super.save(userIdcard);
	}

	@Transactional(readOnly = false)
	public void delete(UserIdcard userIdcard) {
		super.delete(userIdcard);
	}

	/**
	 * 通过idcardnum获取数据
	 * 
	 * @param idcardnum
	 * @return
	 */
	public UserIdcard getByIdcard(String idcardnum) {
		return userIdcardDao.getByIdcard(idcardnum);
	}
}