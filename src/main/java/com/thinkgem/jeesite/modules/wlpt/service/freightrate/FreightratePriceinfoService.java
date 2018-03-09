/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.freightrate;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightratePriceinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.freightrate.FreightratePriceinfoDao;

/**
 * 历史运价Service
 * @author 曾煜佳
 * @version 2016-08-03
 */
@Service
@Transactional(readOnly = true)
public class FreightratePriceinfoService extends CrudService<FreightratePriceinfoDao, FreightratePriceinfo> {

	@Autowired
	private FreightratePriceinfoDao freightratePriceinfoDao;

	public FreightratePriceinfo get(String id) {
		return super.get(id);
	}



	public List<FreightratePriceinfo> findList(FreightratePriceinfo freightratePriceinfo) {
		return super.findList(freightratePriceinfo);
	}
	
	public Page<FreightratePriceinfo> findPage(Page<FreightratePriceinfo> page, FreightratePriceinfo freightratePriceinfo) {
		page.setOrderBy("updatetime");
		return super.findPage(page, freightratePriceinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(FreightratePriceinfo freightratePriceinfo) {
		super.save(freightratePriceinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(FreightratePriceinfo freightratePriceinfo) {
		super.delete(freightratePriceinfo);
	}
	public List<FreightratePriceinfo> findPrices(FreightratePriceinfo freightratePriceinfo){
		return freightratePriceinfoDao.findPrices(freightratePriceinfo);
	}
}