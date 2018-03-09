/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.trade;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;

/**
 * 运单支付信息DAO接口
 * @author 饶江龙
 * @version 2016-07-28
 */
@MyBatisDao
public interface TradePayinfoDao extends CrudDao<TradePayinfo> {

	/**
	 * 根据orderid获取
	 * @param orderid
	 * @return
	 */
	public TradePayinfo getByorderId(String orderid);
}