
/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.car;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.dao.car.CarDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserQualitycertifyDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.CarGroup;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserQualitycertify;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * 车辆管理Service
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
@Service
@Transactional(readOnly = true)
public class CarService extends CrudService<CarDao, Car> {

    @Autowired
    private CarDao carDao;

    @Autowired
    private UserQualitycertifyDao userQualitycertifyDao;

    public Car get(String id) {
        return super.get(id);
    }

    public Car get(Car car) {
        return super.get(car);
    }

    //车源大厅获取车源信息
    public Car gethallinfo(Car car) {
        return carDao.gethallinfo(car);
    }

    /***
     * 获取当前用户的车辆
     * @return
     */
    public List<Car> getMyCar() {
        Car car = new Car();
        car.setUser(UserUtils.getUser());
        return super.findList(car);
    }

    public List<Car> findList(Car car) {
        return super.findList(car);
    }

    public List<Car> findAllList(Car car) {
        return carDao.findAllList(car);
    }

    public Page<Car> findPage(Page<Car> page, Car car) {
        return super.findPage(page, car);
    }

    //车源大厅获取车源列表
    public Page<Car> findHallList(Page<Car> page, Car car) {
        car.setPage(page);
        page.setList(carDao.findHallList(car));
        return page;
    }


    //查找车队信息
    public Page<CarGroup> findGroupList(Page<CarGroup> page, CarGroup cargroup) {
        cargroup.setPage(page);
        page.setList(carDao.findGroupList(cargroup));
        return page;
    }

    @Transactional(readOnly = false)
    public void save(Car car) {
        super.save(car);
    }

    @Transactional(readOnly = false)
    public void delete(Car car) {
        super.delete(car);
    }

    /**
     * 保存车辆信息
     *
     * @param car
     * @return
     */
    @Transactional(readOnly = false)
    public Boolean saveCar(Car car) {
        Boolean result = false;
        if (car != null) {
            if (car.getId() != null && !car.getId().equals("")) {
                super.save(car);
                result = true;
            } else {
                car.setStatus(DataDic.UNAUTHEN);
                car.setUser(UserUtils.getUser());
                super.save(car);
                User user = new User();
                user.setId(UserUtils.getUser().getId());
                UserQualitycertify userQualitycertify = new UserQualitycertify();
                userQualitycertify.preInsert();
                userQualitycertify.setRequesttime(new Date());
                userQualitycertify.setRequestuser(user);
                userQualitycertify.setCertifytype(DataDic.AUTHEN_CAR);
                userQualitycertify.setTargetid(car.getId());
                userQualitycertify.setCertifystatus(DataDic.QUALITY_SUCCES);
                userQualitycertifyDao.insert(userQualitycertify);
                result = true;
            }

        }
        return result;
    }

    /**
     * 更新车辆成功交易数
     *
     * @param car
     * @return
     */
    @Transactional(readOnly = false)
    public void updateTradeNum(Car car) {
        carDao.updateTradeNum(car);
    }

    public int getUserCarNum(Car car) {
        return carDao.getUserCarNum(car);
    }

    
    //往车辆表中插入验证数据
    @Transactional(readOnly = false)
    public int updateValidation(Car car) {
    	return carDao.updateValidation(car);
    }


/*	public Car getBy(String userId){
		return carDao.getCarByUserId(userId);
	}*/
    
    public int findByCarnumber(String carnumber){
    	return carDao.findByCarnumber(carnumber);
    }
    
    public List<String> findIdByCarnumber(String carnumber){
    	return carDao.findIdByCarnumber(carnumber);
    }
    
}