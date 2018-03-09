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
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardLoss;
import com.thinkgem.jeesite.modules.wlpt.dao.card.UserMetroCardLossDao;

/**
 * 一卡通挂失Service
 * 
 * @author fjc
 * @version 2016-10-20
 */
@Service
@Transactional(readOnly = true)
public class UserMetroCardLossService extends CrudService<UserMetroCardLossDao, UserMetroCardLoss> {

	@Autowired
	private UserMetroCardLossDao userMetroCardLossDao;

	public UserMetroCardLoss get(String id) {
		return super.get(id);
	}

	public UserMetroCardLoss getByUserMetroCardLoss(UserMetroCardLoss cardLoss) {
		return userMetroCardLossDao.getByUserMetroCardLoss(cardLoss);
	}

	public List<UserMetroCardLoss> findList(UserMetroCardLoss userMetroCardLoss) {
		return super.findList(userMetroCardLoss);
	}

	public Page<UserMetroCardLoss> findPage(Page<UserMetroCardLoss> page, UserMetroCardLoss userMetroCardLoss) {
		return super.findPage(page, userMetroCardLoss);
	}

	@Transactional(readOnly = false)
	public void save(UserMetroCardLoss userMetroCardLoss) {
		super.save(userMetroCardLoss);
	}

	@Transactional(readOnly = false)
	public void delete(UserMetroCardLoss userMetroCardLoss) {
		super.delete(userMetroCardLoss);
	}

}