/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;

import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserMessage;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserMessageDao;

/**
 * 用户消息Service
 * @author fjc
 * @version 2017-11-20
 */
@Service
@Transactional(readOnly = true)
public class UserMessageService extends CrudService<UserMessageDao, UserMessage> {

	@Autowired
	private UserMessageDao userMessageDao;

	public UserMessage get(String id) {
		return super.get(id);
	}

	/**
	 * 统计未读消息数
	 *
	 * @return
	 */
	public UserMessage sumUnRead(UserMessage userMessage) {
		return userMessageDao.sumUnRead(userMessage);
	}

	public List<UserMessage> findList(UserMessage userMessage) {
		return super.findList(userMessage);
	}
	
	public Page<UserMessage> findPage(Page<UserMessage> page, UserMessage userMessage) {
		return super.findPage(page, userMessage);
	}
	
	@Transactional(readOnly = false)
	public void save(UserMessage userMessage) {
		super.save(userMessage);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserMessage userMessage) {
		super.delete(userMessage);
	}
	
}