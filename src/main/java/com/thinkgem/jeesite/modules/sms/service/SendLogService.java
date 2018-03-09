/**
 * 
 */
package com.thinkgem.jeesite.modules.sms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sms.dao.SendLogDao;
import com.thinkgem.jeesite.modules.sms.entity.SendLog;

/**
 * 消息发送日志Service
 * @author 饶江龙
 * @version 2016-07-20
 */
@Service
@Transactional(readOnly = true)
public class SendLogService extends CrudService<SendLogDao, SendLog> {

	@Autowired
	private SendLogDao sendLogDao;


	public SendLog get(String id) {
		return super.get(id);
	}

	public SendLog findByPhoneVerCodeAndFun(SendLog smssendlog) {
		return sendLogDao.findByPhoneVerCodeAndFun(smssendlog);
	}

	public List<SendLog> findList(SendLog smssendlog) {
		return super.findList(smssendlog);
	}
	
	public Page<SendLog> findPage(Page<SendLog> page, SendLog smssendlog) {
		return super.findPage(page, smssendlog);
	}
	
	@Transactional(readOnly = false)
	public void save(SendLog smssendlog) {
		super.save(smssendlog);
	}
	
	@Transactional(readOnly = false)
	public void delete(SendLog smssendlog) {
		super.delete(smssendlog);
	}
	
}