/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;

/**
 * 用户地址管理DAO接口
 * @author 饶江龙
 * @version 2016-07-24
 */
@MyBatisDao
public interface AddressDao extends CrudDao<Address> {
	
}