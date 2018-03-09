/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;

/**
 * 司机信息DAO接口
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
@MyBatisDao
public interface DriverDao extends CrudDao<Driver> {

    /**
     * 根据用户id获取司机信息
     *
     * @param userId
     * @return
     */
    public Driver getDriverByUserId(String userId);


}