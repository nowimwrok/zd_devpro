/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.interfacelog;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceLog;
import com.thinkgem.jeesite.modules.wlpt.dao.interfacelog.InterfaceLogDao;

/**
 * 接口调用日志信息Service
 * @author W
 * @version 2017-10-16
 */
@Service
@Transactional(readOnly = true)
public class InterfaceLogService extends CrudService<InterfaceLogDao, InterfaceLog> {

	@Autowired
	private InterfaceLogDao interfaceLogDao;

	public InterfaceLog get(String id) {
		return super.get(id);
	}



	public List<InterfaceLog> findList(InterfaceLog interfaceLog) {
		return super.findList(interfaceLog);
	}
	
	public Page<InterfaceLog> findPage(Page<InterfaceLog> page, InterfaceLog interfaceLog) {
		return super.findPage(page, interfaceLog);
	}
	
	
	@Transactional(readOnly = false)
	public void save(InterfaceLog interfaceLog) {
		super.save(interfaceLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(InterfaceLog interfaceLog) {
		super.delete(interfaceLog);
	}
	
}