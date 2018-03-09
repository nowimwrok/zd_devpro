/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.activity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.common.persistence.Page;

/**
 * 奖品列表DAO接口
 * @author 曾煜佳
 * @version 2016-08-04
 */
@MyBatisDao
public interface ActivityWxgiftDao extends CrudDao<ActivityWxgift> {

	/**
	 * 获取奖品列表
	 * @param entity
	 * @return
	 */
	public List<ActivityWxgift> findGiftByActivityId(List ids);
	/**
	 * 通过奖品ID货物活动内容信息和礼品信息
	 * @param entity
	 * @return
	 */
	public Page<ActivityWxgift> findActivityGiftInfo(ActivityWxgift activityWxgift);
	
	/**
	 * 更新中奖次数
	 * @param id
	 * @return
	 */
	public int updateWinNum(String id);
	
}