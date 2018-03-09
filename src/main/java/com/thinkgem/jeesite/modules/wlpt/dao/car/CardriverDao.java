/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Cardriver;

/**
 * 司机管理DAO接口
 * @author 饶江龙
 * @version 2016-07-26
 */
@MyBatisDao
public interface CardriverDao extends CrudDao<Cardriver> {

	
}