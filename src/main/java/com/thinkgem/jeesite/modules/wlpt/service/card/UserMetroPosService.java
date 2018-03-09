/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.card;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPos;
import com.thinkgem.jeesite.modules.wlpt.dao.card.UserMetroPosDao;

/**
 * 一卡通POS机列表Service
 * @author 曾煜佳
 * @version 2016-11-30
 */
@Service
@Transactional(readOnly = true)
public class UserMetroPosService extends CrudService<UserMetroPosDao, UserMetroPos> {

	@Autowired
	private UserMetroPosDao userMetroPosDao;

	public UserMetroPos get(String id) {
		return super.get(id);
	}


	/**
	 * 获取POS机信息
	 * @param userMetroPos
	 * @return
	 */
	public UserMetroPos getMetroPosInfo(UserMetroPos userMetroPos){
		return userMetroPosDao.getMetroPosInfo(userMetroPos);
	}
	
	public List<UserMetroPos> findList(UserMetroPos userMetroPos) {
		return super.findList(userMetroPos);
	}
	
	public Page<UserMetroPos> findPage(Page<UserMetroPos> page, UserMetroPos userMetroPos) {
		return super.findPage(page, userMetroPos);
	}
	
	@Transactional(readOnly = false)
	public void save(UserMetroPos userMetroPos) {
		super.save(userMetroPos);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserMetroPos userMetroPos) {
		super.delete(userMetroPos);
	}
	
}