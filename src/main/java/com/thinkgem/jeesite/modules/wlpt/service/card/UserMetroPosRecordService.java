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
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPosRecord;
import com.thinkgem.jeesite.modules.wlpt.dao.card.UserMetroPosRecordDao;

/**
 * 一卡通pos机绑定记录Service
 * @author zyj
 * @version 2016-12-22
 */
@Service
@Transactional(readOnly = true)
public class UserMetroPosRecordService extends CrudService<UserMetroPosRecordDao, UserMetroPosRecord> {

	@Autowired
	private UserMetroPosRecordDao userMetroPosRecordDao;

	public UserMetroPosRecord get(String id) {
		return super.get(id);
	}



	public List<UserMetroPosRecord> findList(UserMetroPosRecord userMetroPosRecord) {
		return super.findList(userMetroPosRecord);
	}
	
	public Page<UserMetroPosRecord> findPage(Page<UserMetroPosRecord> page, UserMetroPosRecord userMetroPosRecord) {
		return super.findPage(page, userMetroPosRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(UserMetroPosRecord userMetroPosRecord) {
		super.save(userMetroPosRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserMetroPosRecord userMetroPosRecord) {
		super.delete(userMetroPosRecord);
	}
	
}