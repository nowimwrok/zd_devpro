/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.service.interfacelog;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.interfacelog.TravelinformationDao;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.Travelinformation;

/**
 * 存储信息Service
 * @author qiao
 * @version 2017-09-29
 */
@Service
@Transactional(readOnly = true)
public class TravelinformationService extends CrudService<TravelinformationDao, Travelinformation> {
	@Autowired
	private TravelinformationDao travedao;
	
	public Travelinformation get(String id) {
		return super.get(id);
	}
	
	public List<Travelinformation> findList(Travelinformation travelinformation) {
		return super.findList(travelinformation);
	}
	
	public Page<Travelinformation> findPage(Page<Travelinformation> page, Travelinformation travelinformation) {
		return super.findPage(page, travelinformation);
	}
	
	@Transactional(readOnly = false)
	public void save(Travelinformation travelinformation) {
		super.save(travelinformation);
	}
	
	@Transactional(readOnly = false)
	public void delete(Travelinformation travelinformation) {
		super.delete(travelinformation);
	}
	
	public Travelinformation getBycarid(Travelinformation travelinformation) {
		return travedao.getBycarid(travelinformation);
	}
	
}