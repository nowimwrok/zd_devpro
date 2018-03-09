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
import com.thinkgem.jeesite.modules.wlpt.entity.car.CarSource;
import com.thinkgem.jeesite.modules.wlpt.dao.car.CarSourceDao;

/**
 * 车源管理Service
 * @author zyj
 * @version 2016-12-26
 */
@Service
@Transactional(readOnly = true)
public class CarSourceService extends CrudService<CarSourceDao, CarSource> {

	@Autowired
	private CarSourceDao carSourceDao;

	public CarSource get(String id) {
		return super.get(id);
	}



	public List<CarSource> findList(CarSource carSource) {
		return super.findList(carSource);
	}
	
	public Page<CarSource> findPage(Page<CarSource> page, CarSource carSource) {
		return super.findPage(page, carSource);
	}
	
	@Transactional(readOnly = false)
	public void save(CarSource carSource) {
		super.save(carSource);
	}
	
	@Transactional(readOnly = false)
	public void delete(CarSource carSource) {
		super.delete(carSource);
	}
	/**
	 * 修改车源为已过期状态
	 */
	@Transactional(readOnly = false)
	public void updateStatus() {
		carSourceDao.updateStatus();
	}
}