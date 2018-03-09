/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.CarSource;

/**
 * 车源管理DAO接口
 * @author zyj
 * @version 2016-12-26
 */
@MyBatisDao
public interface CarSourceDao extends CrudDao<CarSource> {

	/**
	 * 修改车源状态为已过期
	 * @return
	 */
	int updateStatus();
}