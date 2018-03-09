/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.trade;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.trade.TradePayinfoDao;

/**
 * 运单支付信息Service
 * @author 饶江龙
 * @version 2016-07-28
 */
@Service
@Transactional(readOnly = true)
public class TradePayinfoService extends CrudService<TradePayinfoDao, TradePayinfo> {

	@Autowired
	private TradePayinfoDao tradePayinfoDao;

	public TradePayinfo get(String id) {
		return super.get(id);
	}
	public TradePayinfo getByorderId(String orderid){
		return tradePayinfoDao.getByorderId(orderid);
	}


	public List<TradePayinfo> findList(TradePayinfo tradePayinfo) {
		return super.findList(tradePayinfo);
	}
	
	public Page<TradePayinfo> findPage(Page<TradePayinfo> page, TradePayinfo tradePayinfo) {
		return super.findPage(page, tradePayinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(TradePayinfo tradePayinfo) {
		super.save(tradePayinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(TradePayinfo tradePayinfo) {
		super.delete(tradePayinfo);
	}
	
}