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
import com.thinkgem.jeesite.modules.wlpt.dao.car.GpsCarLocsDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;

/**
 * gps车辆定位信息Service
 * @author 王铸
 * @version 2016-09-06
 */
@Service
@Transactional(readOnly = true)
public class GpsCarLocsService extends CrudService<GpsCarLocsDao, GpsCarLocs> {

	@Autowired
	private GpsCarLocsDao gpsCarLocsDao;

	public GpsCarLocs get(String id) {
		return super.get(id);
	}

	public int insert(GpsCarLocs gpsCarLocs) {
		return gpsCarLocsDao.insert(gpsCarLocs);
	}
	
	public int update(GpsCarLocs gpsCarLocs) {
		return gpsCarLocsDao.update(gpsCarLocs);
	}
	
	public String getmaxid() {
		return gpsCarLocsDao.maxid();
	}
	public List<GpsCarLocs> findByGroup(String [] gpsCarLocs) {
		return gpsCarLocsDao.findByGroup(gpsCarLocs);
	}

	public List<GpsCarLocs> findList(GpsCarLocs gpsCarLocs) {
		return super.findList(gpsCarLocs);
	}
	
	public Page<GpsCarLocs> findPage(Page<GpsCarLocs> page, GpsCarLocs gpsCarLocs) {
		return super.findPage(page, gpsCarLocs);
	}
	
	@Transactional(readOnly = false)
	public void save(GpsCarLocs gpsCarLocs) {
		super.save(gpsCarLocs);
	}
	
	@Transactional(readOnly = false)
	public void delete(GpsCarLocs gpsCarLocs) {
		super.delete(gpsCarLocs);
	}
	
}