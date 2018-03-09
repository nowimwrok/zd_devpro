/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.trade;

import java.util.List;

import com.thinkgem.jeesite.modules.wlpt.dao.trade.TradeReceiptDao;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeReceipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 运单证明Service
 * @author 饶江龙
 * @version 2016-07-28
 */
@Service
@Transactional(readOnly = true)
public class TradeReceiptService extends CrudService<TradeReceiptDao, TradeReceipt> {

	@Autowired
	private TradeReceiptDao tradereceiptDao;

	public TradeReceipt get(String id) {
		return super.get(id);
	}

	/**
	 * 通过对象条件获取运单证明信息
	 * @param tradeReceipt
	 * @return
	 */
	public TradeReceipt getByorderidAndtype(TradeReceipt tradeReceipt){
		return tradereceiptDao.getByorderidAndtype(tradeReceipt);
	}

	public List<TradeReceipt> findList(TradeReceipt tradeReceipt) {
		return super.findList(tradeReceipt);
	}
	
	public Page<TradeReceipt> findPage(Page<TradeReceipt> page, TradeReceipt tradeReceipt) {
		return super.findPage(page, tradeReceipt);
	}
	
	@Transactional(readOnly = false)
	public void save(TradeReceipt tradeReceipt) {
		super.save(tradeReceipt);
	}
	
	@Transactional(readOnly = false)
	public void delete(TradeReceipt tradeReceipt) {
		super.delete(tradeReceipt);
	}
	
}