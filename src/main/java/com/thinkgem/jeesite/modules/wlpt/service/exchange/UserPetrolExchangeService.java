/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.exchange;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchange;
import com.thinkgem.jeesite.modules.wlpt.dao.exchange.UserPetrolExchangeDao;

/**
 * 油气兑换余额审核Service
 * @author zyj
 * @version 2017-02-15
 */
@Service
@Transactional(readOnly = true)
public class UserPetrolExchangeService extends CrudService<UserPetrolExchangeDao, UserPetrolExchange> {

	@Autowired
	private UserPetrolExchangeDao userPetrolExchangeDao;

	public UserPetrolExchange get(String id) {
		return super.get(id);
	}



	public List<UserPetrolExchange> findList(UserPetrolExchange userPetrolExchange) {
		return super.findList(userPetrolExchange);
	}
	
	public Page<UserPetrolExchange> findPage(Page<UserPetrolExchange> page, UserPetrolExchange userPetrolExchange) {
		return super.findPage(page, userPetrolExchange);
	}
	
	@Transactional(readOnly = false)
	public void save(UserPetrolExchange userPetrolExchange) {
		super.save(userPetrolExchange);
	}
	/**
	 * 修改开票状态
	 * @param userPetrolExchange
	 * @return
	 */
	@Transactional(readOnly = false)
	public int updateInvoiceStatus(UserPetrolExchange userPetrolExchange){
		return userPetrolExchangeDao.updateInvoiceStatus(userPetrolExchange);
	}
	@Transactional(readOnly = false)
	public void delete(UserPetrolExchange userPetrolExchange) {
		super.delete(userPetrolExchange);
	}
	
}