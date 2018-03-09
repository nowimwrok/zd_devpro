/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.rule;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.rule.SysTradeRule;

/**
 * 规则管理DAO接口
 * @author fjc
 * @version 2016-10-12
 */
@MyBatisDao
public interface SysTradeRuleDao extends CrudDao<SysTradeRule> {

	/**
	 * 根据对象查询
	 * @param sysTradeRule
	 * @return
	 */
	public SysTradeRule getBySysTradeRule(SysTradeRule sysTradeRule);
}