/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.collection;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import com.thinkgem.jeesite.modules.wlpt.dao.collection.WlptCollectionDao;

/**
 * 我关注的路线信息Service
 * @author zyj
 * @version 2017-04-19
 */
@Service
@Transactional(readOnly = true)
public class WlptCollectionService extends CrudService<WlptCollectionDao, WlptCollection> {

	@Autowired
	private WlptCollectionDao wlptCollectionDao;

	public WlptCollection get(String id) {
		return super.get(id);
	}

	/***
	 * 获取当前条数
	 * @return  获取条数:int类型
	 */
	public int countcollection(WlptCollection wlptCollection){
		return wlptCollectionDao.countcollection(wlptCollection);
	}

	public List<WlptCollection> findList(WlptCollection wlptCollection) {
		return super.findList(wlptCollection);
	}
	
	public Page<WlptCollection> findPage(Page<WlptCollection> page, WlptCollection wlptCollection) {
		return super.findPage(page, wlptCollection);
	}
	
	@Transactional(readOnly = false)
	public void save(WlptCollection wlptCollection) {
		super.save(wlptCollection);
	}
	
	@Transactional(readOnly = false)
	public void delete(WlptCollection wlptCollection) {
		super.delete(wlptCollection);
	}
	
}