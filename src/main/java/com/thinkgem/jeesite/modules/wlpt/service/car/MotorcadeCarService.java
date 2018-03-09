/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.car;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.car.MotorcadeCarDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeCar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 车队与车辆关联Service
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@Service
@Transactional(readOnly = true)
public class MotorcadeCarService extends CrudService<MotorcadeCarDao, MotorcadeCar> {

    @Autowired
    private MotorcadeCarDao motorcadeCarDao;

    public MotorcadeCar get(String id) {
        return super.get(id);
    }

    public MotorcadeCar getByCarId(String carId) {
        MotorcadeCar motorcadeCar = new MotorcadeCar();
        motorcadeCar.setCarId(carId);
        return motorcadeCarDao.get(motorcadeCar);
    }

    public List<MotorcadeCar> findList(MotorcadeCar motorcadeCar) {
        return super.findList(motorcadeCar);
    }

    public Page<MotorcadeCar> findPage(Page<MotorcadeCar> page, MotorcadeCar motorcadeCar) {
        return super.findPage(page, motorcadeCar);
    }

    @Transactional(readOnly = false)
    public void save(MotorcadeCar motorcadeCar) {
        super.save(motorcadeCar);
    }

    @Transactional(readOnly = false)
    public void delete(MotorcadeCar motorcadeCar) {
        super.delete(motorcadeCar);
    }

    @Transactional(readOnly = false)
    public void deleteMotorcadeCar(String motorcadeCarId) {
        motorcadeCarDao.deleteMotorcadeCar(motorcadeCarId);
    }

}