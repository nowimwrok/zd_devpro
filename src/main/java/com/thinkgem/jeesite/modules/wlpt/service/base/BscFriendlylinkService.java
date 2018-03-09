/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscFriendlylink;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BscFriendlylinkDao;

/**
 * 友情链接Service
 * @author 王铸
 * @version 2016-08-09
 */
@Service
@Transactional(readOnly = true)
public class BscFriendlylinkService extends CrudService<BscFriendlylinkDao, BscFriendlylink> {

	@Autowired
	private BscFriendlylinkDao bscFriendlylinkDao;

	public BscFriendlylink get(String id) {
		return super.get(id);
	}



	public List<BscFriendlylink> findList(BscFriendlylink bscFriendlylink) {
		return super.findList(bscFriendlylink);
	}
	
	public Page<BscFriendlylink> findPage(Page<BscFriendlylink> page, BscFriendlylink bscFriendlylink) {
		return super.findPage(page, bscFriendlylink);
	}
	
	@Transactional(readOnly = false)
	public void save(BscFriendlylink bscFriendlylink) {
		super.save(bscFriendlylink);
	}
	
	@Transactional(readOnly = false)
	public void delete(BscFriendlylink bscFriendlylink) {
		super.delete(bscFriendlylink);
	}
	
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		bscFriendlylinkDao.deleteAll(map);
	}
}