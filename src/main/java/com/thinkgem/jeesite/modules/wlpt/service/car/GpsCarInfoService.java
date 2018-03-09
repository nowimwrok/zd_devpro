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
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.dao.car.GpsCarInfoDao;

/**
 * 车辆gps数据，获取keyService
 * @author 饶江龙
 * @version 2016-08-17
 */
@Service
@Transactional(readOnly = true)
public class GpsCarInfoService extends CrudService<GpsCarInfoDao, GpsCarInfo> {

	@Autowired
	private GpsCarInfoDao gpsCarInfoDao;

	public GpsCarInfo get(String id) {
		return super.get(id);
	}



	public List<GpsCarInfo> findList(GpsCarInfo gpsCarInfo) {
		return super.findList(gpsCarInfo);
	}
	public List<GpsCarInfo> findByGroup(String [] gpsCarInfo) {
		return gpsCarInfoDao.findByGroup(gpsCarInfo);
	}

	public Page<GpsCarInfo> findPage(Page<GpsCarInfo> page, GpsCarInfo gpsCarInfo) {
		return super.findPage(page, gpsCarInfo);
	}
	
	public GpsCarInfo findByCondition(GpsCarInfo gpsCarInfo){
		return gpsCarInfoDao.findByCondition(gpsCarInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(GpsCarInfo gpsCarInfo) {
		super.save(gpsCarInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(GpsCarInfo gpsCarInfo) {
		super.delete(gpsCarInfo);
	}
	
}