/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.insur;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurancelist;
import com.thinkgem.jeesite.modules.wlpt.dao.insur.UserInsurancelistDao;

/**
 * 保险品种管理Service
 * @author zyj
 * @version 2017-03-09
 */
@Service
@Transactional(readOnly = true)
public class UserInsurancelistService extends CrudService<UserInsurancelistDao, UserInsurancelist> {

	@Autowired
	private UserInsurancelistDao userInsurancelistDao;

	public UserInsurancelist get(String id) {
		return super.get(id);
	}



	public List<UserInsurancelist> findList(UserInsurancelist userInsurancelist) {
		return super.findList(userInsurancelist);
	}
	
	public Page<UserInsurancelist> findPage(Page<UserInsurancelist> page, UserInsurancelist userInsurancelist) {
		return super.findPage(page, userInsurancelist);
	}
	
	@Transactional(readOnly = false)
	public void save(UserInsurancelist userInsurancelist) {
		super.save(userInsurancelist);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserInsurancelist userInsurancelist) {
		super.delete(userInsurancelist);
	}
	
}