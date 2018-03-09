/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.activity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;

/**
 * 活动信息DAO接口
 * @author 曾煜佳
 * @version 2016-08-04
 */
@MyBatisDao
public interface ActivityWxinfoDao extends CrudDao<ActivityWxinfo> {

	/**
	 * 更新中奖次数
	 * @param id
	 * @return
	 */
	public int updateWinNum(String id);
	
	/**
	 * 更新浏览次数
	 * @param id
	 * @return
	 */
	public int updateScanNum(String id);
}