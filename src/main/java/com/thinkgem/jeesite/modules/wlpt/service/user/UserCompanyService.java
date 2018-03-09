/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserCompanyDao;

/**
 * 用户公司信息Service
 * @author 饶江龙
 * @version 2016-07-18
 */
@Service
@Transactional(readOnly = true)
public class UserCompanyService extends CrudService<UserCompanyDao, UserCompany> {

	public UserCompany get(String id) {
		return super.get(id);
	}
	
	/**
	 * 获取用户信息 
	 */
	public UserCompany get(UserCompany userCompany) {
		return super.get(userCompany);
	}
	
	public List<UserCompany> findList(UserCompany userCompany) {
		return super.findList(userCompany);
	}
	
	public Page<UserCompany> findPage(Page<UserCompany> page, UserCompany userCompany) {
		return super.findPage(page, userCompany);
	}
	
	@Transactional(readOnly = false)
	public void save(UserCompany userCompany) {
		super.save(userCompany);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserCompany userCompany) {
		super.delete(userCompany);
	}
	
}