/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.consume;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumeaudit;

/**
 * 后台账户充值，管理审核DAO接口
 * @author 饶江龙
 * @version 2016-08-02
 */
@MyBatisDao
public interface ConsumeauditDao extends CrudDao<Consumeaudit> {

	
}