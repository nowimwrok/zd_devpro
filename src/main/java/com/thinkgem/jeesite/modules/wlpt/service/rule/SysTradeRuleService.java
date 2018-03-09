/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.rule;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.rule.SysTradeRule;
import com.thinkgem.jeesite.modules.wlpt.dao.rule.SysTradeRuleDao;

/**
 * 规则管理Service
 * @author fjc
 * @version 2016-10-12
 */
@Service
@Transactional(readOnly = true)
public class SysTradeRuleService extends CrudService<SysTradeRuleDao, SysTradeRule> {

	@Autowired
	private SysTradeRuleDao sysTradeRuleDao;

	public SysTradeRule get(String id) {
		return super.get(id);
	}

	public SysTradeRule get(SysTradeRule sysTradeRule) {
		return sysTradeRuleDao.getBySysTradeRule(sysTradeRule);
	}


	public List<SysTradeRule> findList(SysTradeRule sysTradeRule) {
		return super.findList(sysTradeRule);
	}
	
	public Page<SysTradeRule> findPage(Page<SysTradeRule> page, SysTradeRule sysTradeRule) {
		return super.findPage(page, sysTradeRule);
	}
	
	@Transactional(readOnly = false)
	public void save(SysTradeRule sysTradeRule) {
		super.save(sysTradeRule);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysTradeRule sysTradeRule) {
		super.delete(sysTradeRule);
	}
	
}