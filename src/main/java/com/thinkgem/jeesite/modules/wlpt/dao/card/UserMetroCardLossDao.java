/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.card;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardLoss;

/**
 * 一卡通挂失DAO接口
 * 
 * @author fjc
 * @version 2016-10-20
 */
@MyBatisDao
public interface UserMetroCardLossDao extends CrudDao<UserMetroCardLoss> {

	/**
	 * 根据对象查询
	 * 
	 * @param cardLoss
	 * @return
	 */
	public UserMetroCardLoss getByUserMetroCardLoss(UserMetroCardLoss cardLoss);
}