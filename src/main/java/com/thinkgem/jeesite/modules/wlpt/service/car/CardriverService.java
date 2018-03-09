/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.car;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Cardriver;
import com.thinkgem.jeesite.modules.wlpt.dao.car.CardriverDao;

/**
 * 司机管理Service
 * @author 饶江龙
 * @version 2016-07-26
 */
@Service
@Transactional(readOnly = true)
public class CardriverService extends CrudService<CardriverDao, Cardriver> {

	@Autowired
	private CardriverDao cardriverDao;

	public Cardriver get(String id) {
		return super.get(id);
	}



	public List<Cardriver> findList(Cardriver cardriver) {
		return super.findList(cardriver);
	}
	
	public Page<Cardriver> findPage(Page<Cardriver> page, Cardriver cardriver) {
		return super.findPage(page, cardriver);
	}
	
	@Transactional(readOnly = false)
	public void save(Cardriver cardriver) {
		super.save(cardriver);
	}
	
	@Transactional(readOnly = false)
	public void delete(Cardriver cardriver) {
		super.delete(cardriver);
	}
	
}