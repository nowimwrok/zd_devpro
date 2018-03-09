/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.bid;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.bid.BidinfoDao;

/**
 * 招标信息Service
 * @author 刘欣
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class BidinfoService extends CrudService<BidinfoDao, Bidinfo> {

	@Autowired
	private BidinfoDao bidinfoDao;

	public Bidinfo get(String id) {
		return super.get(id);
	}

	/**
	 * 获取最新的三条数据显示在个人中心首页
	 * @param userid
	 * @return
	 */
	public List<Bidinfo> getNewBidList(String userid){
		return bidinfoDao.findNewBidList(userid);
	}

	public List<Bidinfo> findList(Bidinfo bidinfo) {
		return super.findList(bidinfo);
	}
	
	public Page<Bidinfo> findPage(Page<Bidinfo> page, Bidinfo bidinfo) {
		return super.findPage(page, bidinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(Bidinfo bidinfo) {
		super.save(bidinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Bidinfo bidinfo) {
		super.delete(bidinfo);
	}
	
}