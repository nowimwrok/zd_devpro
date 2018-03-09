/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.car;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.car.MotorcadeCarDao;
import com.thinkgem.jeesite.modules.wlpt.dao.car.MotorcadeDriverDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 车队与司机关联Service
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@Service
@Transactional(readOnly = true)
public class MotorcadeDriverService extends CrudService<MotorcadeDriverDao, MotorcadeDriver> {

    @Autowired
    private MotorcadeDriverDao motorcadeDriverDao;

    @Autowired
    private MotorcadeCarDao motorcadeCarDao;

    public MotorcadeDriver get(String id) {
        return super.get(id);
    }

    public MotorcadeDriver getByDriverId(String driverId) {
        MotorcadeDriver motorcadeDriver = new MotorcadeDriver();
        motorcadeDriver.setDriverId(driverId);
        return motorcadeDriverDao.get(motorcadeDriver);
    }


    public List<MotorcadeDriver> findList(MotorcadeDriver motorcadeDriver) {
        return super.findList(motorcadeDriver);
    }

    public Page<MotorcadeDriver> findPage(Page<MotorcadeDriver> page, MotorcadeDriver motorcadeDriver) {
        return super.findPage(page, motorcadeDriver);
    }

    @Transactional(readOnly = false)
    public void save(MotorcadeDriver motorcadeDriver) {
        super.save(motorcadeDriver);
    }

    @Transactional(readOnly = false)
    public void delete(MotorcadeDriver motorcadeDriver) {
        super.delete(motorcadeDriver);
    }

    @Transactional(readOnly = false)
    public void deleteMotorcadeDriver(String motorcadeDriverId) {
        motorcadeDriverDao.deleteMotorcadeDriver(motorcadeDriverId);
    }

}