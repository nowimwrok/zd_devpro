/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.trade;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeReceipt;

/**
 * 运单证明DAO接口
 * @author 饶江龙
 * @version 2016-07-28
 */
@MyBatisDao
public interface TradeReceiptDao extends CrudDao<TradeReceipt> {

	/**
	 * 通过对象条件获取运单证明信息
	 * @param tradeReceipt
	 * @return
	 */
	TradeReceipt getByorderidAndtype(TradeReceipt tradeReceipt);
}