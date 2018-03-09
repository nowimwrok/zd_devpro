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
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserSettle;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserSettleDao;

/**
 * 用户结算资金－－招标结算资金Service
 * @author 饶江龙
 * @version 2016-07-24
 */
@Service
@Transactional(readOnly = true)
public class UserSettleService extends CrudService<UserSettleDao, UserSettle> {

	@Autowired
	private UserSettleDao userSettleDao;

	public UserSettle get(String id) {
		return super.get(id);
	}

	/***
	*通过参数UserSettle对象获取数据列表
	*/
	public List<UserSettle> findByCondition(UserSettle userSettle) {
		return  userSettleDao.findByCondition(userSettle);
	}


	public List<UserSettle> findList(UserSettle userSettle) {
		return super.findList(userSettle);
	}
	
	public Page<UserSettle> findPage(Page<UserSettle> page, UserSettle userSettle) {
		return super.findPage(page, userSettle);
	}
	
	@Transactional(readOnly = false)
	public void save(UserSettle userSettle) {
		super.save(userSettle);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserSettle userSettle) {
		super.delete(userSettle);
	}
	
}