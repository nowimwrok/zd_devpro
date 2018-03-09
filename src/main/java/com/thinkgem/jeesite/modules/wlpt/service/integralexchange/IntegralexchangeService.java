/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.integralexchange;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.integralexchange.IntegralexchangeDao;
import com.thinkgem.jeesite.modules.wlpt.entity.integralexchange.Integralexchange;

/**
 * 积分规则Service
 * @author qiao
 * @version 2017-12-22
 */
@Service
@Transactional(readOnly = true)
public class IntegralexchangeService extends CrudService<IntegralexchangeDao, Integralexchange> {

	@Autowired
	private IntegralexchangeDao integralexchangeDao;

	public Integralexchange get(String id) {
		return super.get(id);
	}

	public List<Integralexchange> findAllList(){
		return integralexchangeDao.findAllList();
	}

	public List<Integralexchange> findList(Integralexchange integralexchange) {
		return super.findList(integralexchange);
	}
	
	public Page<Integralexchange> findPage(Page<Integralexchange> page, Integralexchange integralexchange) {
		return super.findPage(page, integralexchange);
	}
	
	@Transactional(readOnly = false)
	public void save(Integralexchange integralexchange) {
		super.save(integralexchange);
	}
	
	@Transactional(readOnly = false)
	public void delete(Integralexchange integralexchange) {
		super.delete(integralexchange);
	}
	
}