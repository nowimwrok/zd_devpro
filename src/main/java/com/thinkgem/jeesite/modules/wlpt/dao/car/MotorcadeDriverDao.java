/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeDriver;


/**
 * 车队与司机关联DAO接口
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@MyBatisDao
public interface MotorcadeDriverDao extends CrudDao<MotorcadeDriver> {

    void deleteMotorcadeDriver(String motorcadeDriverId);

    int getBindingDriverNum(String motorcadeId);

}