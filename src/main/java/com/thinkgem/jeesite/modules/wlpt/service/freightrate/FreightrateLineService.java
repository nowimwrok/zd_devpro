/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.freightrate;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;
import com.thinkgem.jeesite.modules.wlpt.dao.freightrate.FreightrateLineDao;

/**
 * 线路Service
 * @author 曾煜佳
 * @version 2016-08-03
 */
@Service
@Transactional(readOnly = true)
public class FreightrateLineService extends CrudService<FreightrateLineDao, FreightrateLine> {

	@Autowired
	private FreightrateLineDao freightrateLineDao;

	public FreightrateLine get(String id) {
		return super.get(id);
	}

	/**
	 * 根据地址获取最新的线路运价信息
	 * @param freightrateLine
	 * @return
	 */
	public FreightrateLine getLineInfo(FreightrateLine freightrateLine){
		return freightrateLineDao.getLineInfo(freightrateLine);
	}

	public List<FreightrateLine> findList(FreightrateLine freightrateLine) {
		return super.findList(freightrateLine);
	}
	
	public Page<FreightrateLine> findPage(Page<FreightrateLine> page, FreightrateLine freightrateLine) {
		page.setOrderBy("updatetime");
		return super.findPage(page, freightrateLine);
	}
	
	@Transactional(readOnly = false)
	public void save(FreightrateLine freightrateLine) {
		super.save(freightrateLine);
	}
	
	@Transactional(readOnly = false)
	public void delete(FreightrateLine freightrateLine) {
		super.delete(freightrateLine);
	}
	/**
	 * 保存最新的运价价格
	 * @param frLineID 保存的线路ID
	 * @param frPriceID 最新的价格ID
	 * @throws Exception
	 */
	@Transactional(readOnly = false)
	public void saveNewPriceID(String frLineID,String frPriceID) throws Exception{
		FreightrateLine line=new FreightrateLine();
		line.setFrlineId(frLineID);
		line.setNewpriceId(frPriceID);
		//更新时间
		line.setUpdatetime(new Date());
		dao.update(line);
	}
	
}