/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.activity;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.activity.ActivityWxgiftDao;

/**
 * 奖品列表Service
 * @author 曾煜佳
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class ActivityWxgiftService extends CrudService<ActivityWxgiftDao, ActivityWxgift> {

	@Autowired
	private ActivityWxgiftDao activityWxgiftDao;

	public ActivityWxgift get(String id) {
		return super.get(id);
	}



	public List<ActivityWxgift> findList(ActivityWxgift activityWxgift) {
		return super.findList(activityWxgift);
	}
	
	public Page<ActivityWxgift> findPage(Page<ActivityWxgift> page, ActivityWxgift activityWxgift) {
		return super.findPage(page, activityWxgift);
	}
	
	public Page<ActivityWxgift> findActivityGiftInfo(Page<ActivityWxgift> page, ActivityWxgift activityWxgift) {
		activityWxgift.setPage(page);
		return activityWxgiftDao.findActivityGiftInfo(activityWxgift);
	}
	
	/**
	 * 获取奖品列表
	 * @param ids
	 * @return
	 */
	public List<ActivityWxgift> findGiftByActivityId(List ids) {
		
		return activityWxgiftDao.findGiftByActivityId(ids);
	}
	
	/**
	 * 获取奖品列表
	 * @param ids
	 * @return
	 */
	public List<ActivityWxgift> findGiftByActivityListId(Page<ActivityWxinfo> page) {
		List<ActivityWxgift> groupList = new ArrayList<>();
		if (page.getList().size()>0) {
            List<String> Ids = new ArrayList<>();
            //获取
            for (ActivityWxinfo ax : page.getList()) {
                Ids.add(ax.getId());
            }
            ///获取车辆组
            groupList = findGiftByActivityId(Ids);
        }
		return groupList;
	}
	
	@Transactional(readOnly = false)
	public void save(ActivityWxgift activityWxgift) {
		super.save(activityWxgift);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActivityWxgift activityWxgift) {
		super.delete(activityWxgift);
	}
	/**
	 * 更新中奖次数
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void updateWinNum(String id) {
		activityWxgiftDao.updateWinNum(id);
	}
	
}