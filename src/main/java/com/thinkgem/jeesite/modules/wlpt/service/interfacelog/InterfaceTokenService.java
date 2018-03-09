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
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.dao.interfacelog.InterfaceTokenDao;

/**
 * 接口令牌生成Service
 * @author qiao
 * @version 2017-11-13
 */
@Service
@Transactional(readOnly = true)
public class InterfaceTokenService extends CrudService<InterfaceTokenDao, InterfaceToken> {

	@Autowired
	private InterfaceTokenDao interfaceTokenDao;

	public InterfaceToken get(String id) {
		return super.get(id);
	}



	public List<InterfaceToken> findList(InterfaceToken interfaceToken) {
		return super.findList(interfaceToken);
	}
	
	public Page<InterfaceToken> findPage(Page<InterfaceToken> page, InterfaceToken interfaceToken) {
		return super.findPage(page, interfaceToken);
	}
	
	@Transactional(readOnly = false)
	public void save(InterfaceToken interfaceToken) {
		super.save(interfaceToken);
	}
	
	@Transactional(readOnly = false)
	public void delete(InterfaceToken interfaceToken) {
		super.delete(interfaceToken);
	}
	
}