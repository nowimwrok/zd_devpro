package com.thinkgem.jeesite.modules.wlpt.biz.carBiz;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Motorcade;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeCar;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeDriver;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeCarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeDriverService;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional(readOnly = true)
public class MotorcadeBiz {

    @Autowired
    private MotorcadeService motorcadeService;

    @Autowired
    private MotorcadeCarService motorcadeCarService;

    @Autowired
    private MotorcadeDriverService motorcadeDriverService;

    @Autowired
    private DriverService driverService;

    @Autowired
    private UserBiz userBiz;

    public Page<Motorcade> findPage(Page<Motorcade> page, Motorcade motorcade) {
        Page<Motorcade> motorcadePage = motorcadeService.findPage(page, motorcade);
        List<Motorcade> motorcadeList = motorcadePage.getList();
        for (Motorcade motorcade1 : motorcadeList) {
            if (motorcade1.getCar().getStatus().equals(DataDic.AUTHENSUCCES)) {
                motorcade1.getCar().setStatus(DataDic.AUTHENSUCCES_STR);
            } else if (motorcade1.getCar().getStatus().equals(DataDic.AUTHENWAITING)) {
                motorcade1.getCar().setStatus(DataDic.AUTHENWAITING_STR);
            } else {
                motorcade1.getCar().setStatus(DataDic.UNAUTHEN_STR);
            }
        }
        motorcadePage.setList(motorcadeList);
        return motorcadePage;
    }

    @Transactional(readOnly = false)
    public Object saveMotorcade(Motorcade motorcade) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";
        User currentUser = UserUtils.getUser();
        if (currentUser == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if (!userBiz.getUser().getUserinfo().getStatus().equals("2")) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
        if (StringUtils.isBlank(motorcade.getNo()) || StringUtils.isBlank(motorcade.getName()) ||
                StringUtils.isBlank(motorcade.getFromCity()) || StringUtils.isBlank(motorcade.getToCity())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "缺失发布信息！";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            motorcadeService.save(motorcade);
        }
        return Tools.getMapResult(state, message, null);
    }

    @Transactional(readOnly = false)
    public Object deleteMotorcade(String motorcadeId) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "删除成功";
        User currentUser = UserUtils.getUser();
        if (currentUser == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if (!userBiz.getUser().getUserinfo().getStatus().equals("2")) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
        if (StringUtils.isBlank(motorcadeId)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "参数错误！";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            Motorcade motorcade = motorcadeService.get(motorcadeId);
            if (motorcade != null) {
                MotorcadeCar motorcadeCar = new MotorcadeCar();
                motorcadeCar.setMotorcadeId(motorcadeId);
                List<MotorcadeCar> motorcadeCars = motorcadeCarService.findList(motorcadeCar);
                for (int i = 0; i < motorcadeCars.size(); i++) {
                    motorcadeCarService.deleteMotorcadeCar(motorcadeCars.get(i).getId());
                }
                MotorcadeDriver motorcadeDriver = new MotorcadeDriver();
                motorcadeDriver.setMotorcadeId(motorcadeId);
                List<MotorcadeDriver> motorcadeDrivers = motorcadeDriverService.findList(motorcadeDriver);
                for (int i = 0; i < motorcadeDrivers.size(); i++) {
                    motorcadeDriverService.deleteMotorcadeDriver(motorcadeDrivers.get(i).getId());
                }
                motorcadeService.delete(motorcade);
            } else {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "该车队不存在！";
            }
        }
        return Tools.getMapResult(state, message, null);
    }

    @Transactional(readOnly = false)
    public Object bindingCar(MotorcadeCar motorcadeCar) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";
        User currentUser = UserUtils.getUser();
        if (currentUser == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if (!userBiz.getUser().getUserinfo().getStatus().equals("2")) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }

        if (state == DataDic.RETURN_STATUS_NORMAL) {
            MotorcadeCar motorcadeCar1 = motorcadeCarService.getByCarId(motorcadeCar.getCarId());
            if (motorcadeCar1 != null) {
                motorcadeCar.setId(motorcadeCar1.getId());
            }
            motorcadeCarService.save(motorcadeCar);
        }
        return Tools.getMapResult(state, message, null);
    }

    @Transactional(readOnly = false)
    public Object bindingDriver(MotorcadeDriver motorcadeDriver) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "删除成功";
        User currentUser = UserUtils.getUser();
        if (currentUser == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if (!userBiz.getUser().getUserinfo().getStatus().equals("2")) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }

        if (state == DataDic.RETURN_STATUS_NORMAL) {

            MotorcadeDriver motorcadeDriver1 = motorcadeDriverService.getByDriverId(motorcadeDriver.getDriverId());
            if (motorcadeDriver1 != null) {
                motorcadeDriver.setId(motorcadeDriver1.getId());
            }
            motorcadeDriverService.save(motorcadeDriver);

        }
        return Tools.getMapResult(state, message, null);
    }


}



