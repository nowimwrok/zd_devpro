/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.car;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.car.DriverDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 司机信息Service
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
@Service
@Transactional(readOnly = true)
public class DriverService extends CrudService<DriverDao, Driver> {

    @Autowired
    private DriverDao driverDao;

    public Driver get(String id) {
        return super.get(id);
    }

    public Driver get(Driver driver) {
        return super.get(driver);
    }

    public List<Driver> findList(Driver driver) {
        return super.findList(driver);
    }

    public Page<Driver> findPage(Page<Driver> page, Driver driver) {
        return super.findPage(page, driver);
    }

    @Transactional(readOnly = false)
    public void save(Driver driver) {
        super.save(driver);
    }

    @Transactional(readOnly = false)
    public void delete(Driver driver) {
        super.delete(driver);
    }

    /**
     * 根据用户id获取司机信息
     *
     * @param userId
     * @return
     */
    public Driver getDriverByUserId(String userId) {
        return driverDao.getDriverByUserId(userId);
    }


}