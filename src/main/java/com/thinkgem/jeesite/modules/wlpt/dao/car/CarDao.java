/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.CarGroup;

/**
 * 车辆管理DAO接口
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
@MyBatisDao
public interface CarDao extends CrudDao<Car> {

    List<CarGroup> findGroupList(CarGroup cargroup);

    int updateTradeNum(Car car);

    Car gethallinfo(Car car);

    List<Car> findHallList(Car car);

    int getUserCarNum(Car car);
    
    int findByCarnumber(String carnumber);
    
    int updateValidation(Car car);
    
    List<String> findIdByCarnumber(String carnumber);
}