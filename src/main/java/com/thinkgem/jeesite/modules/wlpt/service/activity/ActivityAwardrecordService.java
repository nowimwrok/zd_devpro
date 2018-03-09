/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.activity;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserPurseService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.dao.activity.ActivityAwardrecordDao;

/**
 * 中奖记录Service
 * @author 曾煜佳
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class ActivityAwardrecordService extends CrudService<ActivityAwardrecordDao, ActivityAwardrecord> {

	@Autowired
	private ActivityAwardrecordDao activityAwardrecordDao;

	
	
	public ActivityAwardrecord get(String id) {
		return super.get(id);
	}



	public List<ActivityAwardrecord> findList(ActivityAwardrecord activityAwardrecord) {
		return super.findList(activityAwardrecord);
	}
	
	public Page<ActivityAwardrecord> findPage(Page<ActivityAwardrecord> page, ActivityAwardrecord activityAwardrecord) {
		return super.findPage(page, activityAwardrecord);
	}
	
	@Transactional(readOnly = false)
	public void save(ActivityAwardrecord activityAwardrecord) {
		super.save(activityAwardrecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActivityAwardrecord activityAwardrecord) {
		super.delete(activityAwardrecord);
	}


	/**
	 * 根据用户手机和活动id获取中奖记录
	 * @param activityAwardrecord
	 * @return
	 */
	public ActivityAwardrecord getAwardlistInfo(ActivityAwardrecord activityAwardrecord){
		return activityAwardrecordDao.getAwardlistInfo(activityAwardrecord);
	}
	/**
	 * 更新已过期的奖品
	 */
	@Transactional(readOnly = false)
	public void updateIsSueInvalid(){
		activityAwardrecordDao.updateIsSueInvalid();
	}
	/**
	 * 更新为已发放状态
	 */
	@Transactional(readOnly = false)
	public void updateIsSueGrant(){
		activityAwardrecordDao.updateIsSueGrant();
	}
	/**
	 * 更新奖品状态
	 */
	@Transactional(readOnly = false)
	public void updateIsSue(ActivityAwardrecord activityAwardrecord){

		activityAwardrecordDao.updateIsSue(activityAwardrecord);
	}

	/**
	 * 根据中奖编号获取中奖记录
	 * @param awardno
	 * @return
	 */
	public ActivityAwardrecord getAwardlistInfoByAwardNo(String awardno){
		return activityAwardrecordDao.getAwardlistInfoByAwardNo(awardno);
	}
}