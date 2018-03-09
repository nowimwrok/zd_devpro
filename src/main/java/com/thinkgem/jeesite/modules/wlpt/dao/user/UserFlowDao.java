package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserFlow;

@MyBatisDao
public interface UserFlowDao extends CrudDao<UserFlow>{
	/**
	 * 
	 * 根据流水ID获取UserFlow
	 * @param 
	 * @return
	 */
	public UserFlow getByFlowId(UserFlow userFlow);
	
	public void saveFlow(UserFlow userFlow);

}
