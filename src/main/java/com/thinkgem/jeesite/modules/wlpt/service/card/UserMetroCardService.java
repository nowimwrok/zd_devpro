/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.card;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.dao.card.UserMetroCardDao;

/**
 * 用户一卡通Service
 * @author 刘欣
 * @version 2016-09-18
 */
@Service
@Transactional(readOnly = true)
public class UserMetroCardService extends CrudService<UserMetroCardDao, UserMetroCard> {

	@Autowired
	private UserMetroCardDao userMetroCardDao;

	public UserMetroCard get(String id) {
		return super.get(id);
	}

	public UserMetroCard getUserMetroCardByCardId(String cardId){
		return userMetroCardDao.getUserMetroCardByCardId(cardId);
	}
	
	/**
	 * 通过对象获取最新一条数据
	 * @param userMetroCard
	 * @return
	 */
	public UserMetroCard getUserMetroCardByUserId(UserMetroCard userMetroCard){
		return userMetroCardDao.getUserMetroCardByUserId(userMetroCard);
	}

	public List<UserMetroCard> findList(UserMetroCard userMetroCard) {
		return super.findList(userMetroCard);
	}
	
	public Page<UserMetroCard> findPage(Page<UserMetroCard> page, UserMetroCard userMetroCard) {
		return super.findPage(page, userMetroCard);
	}
	
	@Transactional(readOnly = false)
	public void save(UserMetroCard userMetroCard) {
		super.save(userMetroCard);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserMetroCard userMetroCard) {
		super.delete(userMetroCard);
	}
	
}