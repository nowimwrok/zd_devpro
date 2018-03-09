/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserScore;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserScoreDao;

/**
 * 用户积分表，相关等级、积分诚信积分Service
 * @author 饶江龙
 * @version 2016-07-22
 */
@Service
@Transactional(readOnly = true)
public class UserScoreService extends CrudService<UserScoreDao, UserScore> {

	public UserScore get(String id) {
		return super.get(id);
	}
	
	public List<UserScore> findList(UserScore userScore) {
		return super.findList(userScore);
	}
	
	public Page<UserScore> findPage(Page<UserScore> page, UserScore userScore) {
		return super.findPage(page, userScore);
	}
	
	@Transactional(readOnly = false)
	public void save(UserScore userScore) {
		super.save(userScore);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserScore userScore) {
		super.delete(userScore);
	}
	
}