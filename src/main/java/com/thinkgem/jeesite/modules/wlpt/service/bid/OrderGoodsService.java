/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.bid;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.OrderGoods;
import com.thinkgem.jeesite.modules.wlpt.dao.bid.OrderGoodsDao;

/**
 * &nbsp;招标合同与货源关联信息Service
 * @author 饶江龙
 * @version 2016-08-19
 */
@Service
@Transactional(readOnly = true)
public class OrderGoodsService extends CrudService<OrderGoodsDao, OrderGoods> {

	@Autowired
	private OrderGoodsDao orderGoodsDao;

	public OrderGoods get(String id) {
		return super.get(id);
	}



	public List<OrderGoods> findList(OrderGoods orderGoods) {
		return super.findList(orderGoods);
	}
	
	public Page<OrderGoods> findPage(Page<OrderGoods> page, OrderGoods orderGoods) {
		return super.findPage(page, orderGoods);
	}
	
	@Transactional(readOnly = false)
	public void save(OrderGoods orderGoods) {
		super.save(orderGoods);
	}
	
	@Transactional(readOnly = false)
	public void delete(OrderGoods orderGoods) {
		super.delete(orderGoods);
	}
	
}