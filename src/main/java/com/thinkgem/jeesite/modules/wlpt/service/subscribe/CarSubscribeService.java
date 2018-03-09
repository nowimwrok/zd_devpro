/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.subscribe;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.subscribe.CarSubscribe;
import com.thinkgem.jeesite.modules.wlpt.dao.subscribe.CarSubscribeDao;

/**
 * 车辆与自定义区域绑定Service
 * @author 车辆订阅
 * @version 2017-10-10
 */
@Service
@Transactional(readOnly = false)
public class CarSubscribeService extends CrudService<CarSubscribeDao, CarSubscribe> {

	@Autowired
	private CarSubscribeDao carSubscribeDao;

	public CarSubscribe get(String id) {
		return super.get(id);
	}



	public List<CarSubscribe> findList(CarSubscribe carSubscribe) {
		return super.findList(carSubscribe);
	}
	
	public Page<CarSubscribe> findPage(Page<CarSubscribe> page, CarSubscribe carSubscribe) {
		return super.findPage(page, carSubscribe);
	}
	
	@Transactional(readOnly = false)
	public void save(CarSubscribe carSubscribe) {
		super.save(carSubscribe);
	}
	
	@Transactional(readOnly = false)
	public void delete(CarSubscribe carSubscribe) {
		super.delete(carSubscribe);
	}

	@Transactional(readOnly = false)
	public List<CarSubscribe> findByCallback(CarSubscribe carSubscribe){
		return carSubscribeDao.findByCallback(carSubscribe);
	}

}