/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeCar;


/**
 * 车队与车辆关联DAO接口
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@MyBatisDao
public interface MotorcadeCarDao extends CrudDao<MotorcadeCar> {

    int getBindingCarNum(String motorcadeId);

    void deleteMotorcadeCar(String motorcadeCarId);

}