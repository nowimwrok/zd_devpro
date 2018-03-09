/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.bid;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.OrderGoods;

/**
 * &nbsp;招标合同与货源关联信息DAO接口
 * @author 饶江龙
 * @version 2016-08-19
 */
@MyBatisDao
public interface OrderGoodsDao extends CrudDao<OrderGoods> {

	
}