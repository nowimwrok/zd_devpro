/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.consume;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Deallog;

/**
 * 后台充值账户审核日志记录DAO接口
 * @author 饶江龙
 * @version 2016-08-02
 */
@MyBatisDao
public interface DeallogDao extends CrudDao<Deallog> {

	
}