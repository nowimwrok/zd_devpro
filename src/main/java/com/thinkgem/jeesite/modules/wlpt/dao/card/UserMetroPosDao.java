/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.card;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPos;

/**
 * 一卡通POS机列表DAO接口
 * @author 曾煜佳
 * @version 2016-11-30
 */
@MyBatisDao
public interface UserMetroPosDao extends CrudDao<UserMetroPos> {

	/**
	 * 获取POS机信息
	 * @param userMetroPos
	 * @return
	 */
	UserMetroPos getMetroPosInfo(UserMetroPos userMetroPos);
}