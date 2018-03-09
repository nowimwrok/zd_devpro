/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.service.gps;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.gps.GpsUpdateDao;
import com.thinkgem.jeesite.modules.wlpt.entity.gps.GpsUpdate;

/**
 * 这是个测试类Service
 * @author leifeng
 * @version 2017-09-05
 */
@Service
@Transactional(readOnly = true)
public class GpsUpdateService extends CrudService<GpsUpdateDao, GpsUpdate> {
	@Autowired
	private GpsUpdateDao gpsUpdateDao;

	public GpsUpdate get(String id) {
		return super.get(id);
	}
	
	public List<GpsUpdate> findList(GpsUpdate gpsUpdate) {
		return super.findList(gpsUpdate);
	}
	
	public Page<GpsUpdate> findPage(Page<GpsUpdate> page, GpsUpdate gpsUpdate) {
		return super.findPage(page, gpsUpdate);
	}
	
	@Transactional(readOnly = false)
	public void save(GpsUpdate gpsUpdate) {
		gpsUpdateDao.insert(gpsUpdate);
	}
	
	@Transactional(readOnly = false)
	public void delete(GpsUpdate gpsUpdate) {
		super.delete(gpsUpdate);
	}
	
}