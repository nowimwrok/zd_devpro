/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.car;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.car.MotorcadeCarDao;
import com.thinkgem.jeesite.modules.wlpt.dao.car.MotorcadeDao;
import com.thinkgem.jeesite.modules.wlpt.dao.car.MotorcadeDriverDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Motorcade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 车队Service
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@Service
@Transactional(readOnly = true)
public class MotorcadeService extends CrudService<MotorcadeDao, Motorcade> {

    @Autowired
    private MotorcadeDao motorcadeDao;

    @Autowired
    private MotorcadeCarDao motorcadeCarDao;

    @Autowired
    private MotorcadeDriverDao motorcadeDriverDao;

    public Motorcade get(String id) {
        Motorcade motorcade = new Motorcade();
        motorcade.setId(id);
        return super.get(motorcade);
    }


    public List<Motorcade> findList(Motorcade motorcade) {

        List<Motorcade> motorcades = motorcadeDao.findMotorcadeList(motorcade);
        for (Motorcade motorcade1 : motorcades) {
            motorcade1.setCarNum(getBindingCarNum(motorcade1.getId()));
            motorcade1.setDriverNum(getBindingDriverNum(motorcade1.getId()));
        }
        return motorcades;
    }


    public Page<Motorcade> findPage(Page<Motorcade> page, Motorcade motorcade) {
        return super.findPage(page, motorcade);
    }

    @Transactional(readOnly = false)
    public void save(Motorcade motorcade) {
        super.save(motorcade);
    }

    @Transactional(readOnly = false)
    public void delete(Motorcade motorcade) {
        super.delete(motorcade);
    }

    public int getBindingCarNum(String motorcadeId) {
        return motorcadeCarDao.getBindingCarNum(motorcadeId);
    }

    public int getBindingDriverNum(String motorcadeId) {
        return motorcadeDriverDao.getBindingDriverNum(motorcadeId);
    }

}