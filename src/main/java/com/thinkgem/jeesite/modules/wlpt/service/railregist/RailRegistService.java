/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.railregist;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.railregist.RailRegist;
import com.thinkgem.jeesite.modules.wlpt.dao.railregist.RailRegistDao;

/**
 * 自定义区域注册Service
 * @author renshuai
 * @version 2017-10-10
 */
@Service
@Transactional(readOnly = true)
public class RailRegistService extends CrudService<RailRegistDao, RailRegist> {

	@Autowired
	private RailRegistDao railRegistDao;

	public RailRegist get(String id) {
		return super.get(id);
	}



	public List<RailRegist> findList(RailRegist railRegist) {
		return super.findList(railRegist);
	}
	
	public Page<RailRegist> findPage(Page<RailRegist> page, RailRegist railRegist) {
		return super.findPage(page, railRegist);
	}
	
	@Transactional(readOnly = false)
	public void save(RailRegist railRegist) {
		super.save(railRegist);
	}
	
	@Transactional(readOnly = false)
	public void delete(RailRegist railRegist) {
		super.delete(railRegist);
	}
	/**
	 * 通过自定义区域id删除
	 * @param railRegist
	 * @return
	 */
	@Transactional(readOnly = false)
	public int deleteByAreaid(RailRegist railRegist){
		return railRegistDao.deleteByAreaid(railRegist);
	}
	/**
	 * 通过运单id查询数据
	 * @param railRegist
	 * @return
	 */
	@Transactional(readOnly = false)
	public List<RailRegist> findByOrderid(RailRegist railRegist){
		return railRegistDao.findByOrderid(railRegist);
	}
	/**
	 * 回调用
	 * @param railRegist
	 * @return
	 */
	@Transactional(readOnly = false)
	public RailRegist findByCallback(RailRegist railRegist){
		return railRegistDao.findByCallback(railRegist);
	}
	/**
	 * 通过围栏名称查找围栏
	 * @param railRegist
	 * @return
	 */
	@Transactional(readOnly = false)
	public List<RailRegist> findByRailName(RailRegist railRegist){
		return railRegistDao.findByRailName(railRegist);
	}
}