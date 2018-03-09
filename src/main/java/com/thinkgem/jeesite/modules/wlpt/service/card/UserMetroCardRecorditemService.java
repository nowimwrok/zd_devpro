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
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecorditem;
import com.thinkgem.jeesite.modules.wlpt.dao.card.UserMetroCardRecorditemDao;

/**
 * 一卡通消费记录明细Service
 * @author zyj
 * @version 2016-11-24
 */
@Service
@Transactional(readOnly = true)
public class UserMetroCardRecorditemService extends CrudService<UserMetroCardRecorditemDao, UserMetroCardRecorditem> {

	@Autowired
	private UserMetroCardRecorditemDao userMetroCardRecorditemDao;

	public UserMetroCardRecorditem get(String id) {
		return super.get(id);
	}



	public List<UserMetroCardRecorditem> findList(UserMetroCardRecorditem userMetroCardRecorditem) {
		return super.findList(userMetroCardRecorditem);
	}
	
	public Page<UserMetroCardRecorditem> findPage(Page<UserMetroCardRecorditem> page, UserMetroCardRecorditem userMetroCardRecorditem) {
		return super.findPage(page, userMetroCardRecorditem);
	}
	
	@Transactional(readOnly = false)
	public void save(UserMetroCardRecorditem userMetroCardRecorditem) {
		super.save(userMetroCardRecorditem);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserMetroCardRecorditem userMetroCardRecorditem) {
		super.delete(userMetroCardRecorditem);
	}
	
}