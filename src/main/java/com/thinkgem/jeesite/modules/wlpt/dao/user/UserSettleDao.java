/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserSettle;

/**
 * 用户结算资金－－招标结算资金DAO接口
 * @author 饶江龙
 * @version 2016-07-24
 */
@MyBatisDao
public interface UserSettleDao extends CrudDao<UserSettle> {

	/**
 	* 查找条件参数对象
 	*/
	public List<UserSettle> findByCondition(UserSettle userSettle);
	
}