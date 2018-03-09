/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.activity;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.activity.ActivityWxinfoDao;

/**
 * 活动信息Service
 * @author 曾煜佳
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class ActivityWxinfoService extends CrudService<ActivityWxinfoDao, ActivityWxinfo> {

	@Autowired
	private ActivityWxinfoDao activityWxinfoDao;

	public ActivityWxinfo get(String id) {
		return super.get(id);
	}



	public List<ActivityWxinfo> findList(ActivityWxinfo activityWxinfo) {
		return super.findList(activityWxinfo);
	}
	
	public Page<ActivityWxinfo> findPage(Page<ActivityWxinfo> page, ActivityWxinfo activityWxinfo) {
		return super.findPage(page, activityWxinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(ActivityWxinfo activityWxinfo) {
		super.save(activityWxinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActivityWxinfo activityWxinfo) {
		super.delete(activityWxinfo);
	}
	
	/**
	 * 更新中奖次数
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void updateWinNum(String id) {
		activityWxinfoDao.updateWinNum(id);
	}
	
	/**
	 * 更新浏览次数
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void updateScanNum(String id) {
		activityWxinfoDao.updateScanNum(id);
	}
	
}