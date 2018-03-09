/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.lbs;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsRecentlocationinfo;

/**
 * LBS历史定位表DAO接口
 * @author zyj
 * @version 2016-10-10
 */
@MyBatisDao
public interface LbsRecentlocationinfoDao extends CrudDao<LbsRecentlocationinfo> {

	/**
	 * 获取定位数据
	 * @param lbsRecentlocationinfo
	 * @return
	 */
	public LbsRecentlocationinfo findByCondition(LbsRecentlocationinfo lbsRecentlocationinfo);
}