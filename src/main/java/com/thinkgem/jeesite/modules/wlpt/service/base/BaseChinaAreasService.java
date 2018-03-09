/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseChinaAreaDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.ChinaArea;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 获取中国地址信息Service
 * @author 饶江龙
 * @version 2016-07-24
 */
@Service
@Transactional(readOnly = true)
public class BaseChinaAreasService extends CrudService<BaseChinaAreaDao, ChinaArea> {

	@Autowired
	private BaseChinaAreaDao chinaAreaDao;

	public ChinaArea get(String id) {
		return super.get(id);
	}

	/***
	 * 获取列表信息
	 * @param chinaarea
	 * @return
     */
	public List<ChinaArea> getAreaByCondition(ChinaArea chinaarea){
		return chinaAreaDao.getAreaByCondition(chinaarea);
	}
	
	public List<ChinaArea> findList(ChinaArea chinaarea) {
		return super.findList(chinaarea);
	}
	
	public Page<ChinaArea> findPage(Page<ChinaArea> page, ChinaArea chinaarea) {
		return super.findPage(page, chinaarea);
	}
	
	@Transactional(readOnly = false)
	public void save(ChinaArea chinaarea) {
		super.save(chinaarea);
	}
	
	@Transactional(readOnly = false)
	public void delete(ChinaArea chinaarea) {
		super.delete(chinaarea);
	}
	
}