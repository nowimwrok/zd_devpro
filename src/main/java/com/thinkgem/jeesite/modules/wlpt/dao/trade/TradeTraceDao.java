/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.trade;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeTrace;

/**
 * 运单操作日志记录DAO接口
 * @author 饶江龙
 * @version 2016-07-28
 */
@MyBatisDao
public interface TradeTraceDao extends CrudDao<TradeTrace> {

	
}