package com.thinkgem.jeesite.modules.wlpt.webapi.car;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.MotorcadeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Motorcade;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeCar;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeDriver;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeService;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 车队管理
 *
 * @author liangweishen
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/motorcade")
public class MotorcadeWlptController extends BaseController {

    @Autowired
    private MotorcadeService motorcadeService;

    @Autowired
    private MotorcadeBiz motorcadeBiz;


    /**
     * 获取车队列表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getMotorcadeList")
    public Object getMotorcadeList() {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "";
        Map<String, Object> map = new HashMap<String, Object>();
        Motorcade motorcade = new Motorcade();
        motorcade.setCreateBy(UserUtils.getUser());
        List<Motorcade> motorcades = motorcadeService.findList(motorcade);
        map.put("motorcades", motorcades);
        return this.getMapResult(state, message, map);
    }


    @ResponseBody
    @RequestMapping(value = "getMotorcade")
    public Object getMotorcade(String motorcadeId) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "";
        Map<String, Object> map = new HashMap<String, Object>();
        Motorcade motorcade = motorcadeService.get(motorcadeId);
        if (motorcade == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "该车队不存在";
        }
        map.put("motorcade", motorcade);
        return this.getMapResult(state, message, map);
    }

    /**
     * 获取车队以及相关车辆的列表
     *
     * @param motorcade
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getMotorcadeCarPage")
    public Object getMotorcadeCarPage(Motorcade motorcade, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);

        User currentUser = UserUtils.getUser();
        motorcade.setCreateBy(currentUser);
        Page<Motorcade> page = motorcadeBiz.findPage(pg, motorcade);

        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /**
     * 新增、编辑车队
     *
     * @param motorcade
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveMotorcade")
    public Object saveMotorcade(Motorcade motorcade) {
        Object result = motorcadeBiz.saveMotorcade(motorcade);
        return new JSONPObject("callback", result);
    }

    /**
     * 删除车队
     *
     * @param motorcadeId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteMotorcade")
    public Object deleteMotorcade(String motorcadeId) {
        Object result = motorcadeBiz.deleteMotorcade(motorcadeId);
        return new JSONPObject("callback", result);
    }

    /**
     * 车辆绑定
     *
     * @param motorcadeCar
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "bindingCar")
    public Object bindingCar(MotorcadeCar motorcadeCar) {
        Object result = motorcadeBiz.bindingCar(motorcadeCar);
        return new JSONPObject("callback", result);
    }

    /**
     * 司机绑定
     *
     * @param motorcadeDriver
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "bindingDriver")
    public Object bindingDriver(MotorcadeDriver motorcadeDriver) {
        Object result = motorcadeBiz.bindingDriver(motorcadeDriver);
        return new JSONPObject("callback", result);
    }


}