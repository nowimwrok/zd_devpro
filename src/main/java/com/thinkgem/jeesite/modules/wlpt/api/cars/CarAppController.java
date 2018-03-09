package com.thinkgem.jeesite.modules.wlpt.api.cars;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jws.soap.SOAPBinding.Use;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.wlpt.biz.qualitycertifyBiz.QualityCertifyBiz;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;

@Controller
@RequestMapping("${appPath}/api/cars")
public class CarAppController extends BaseController {

    @Autowired
    private CarBiz carBiz;

    @Autowired
    private QualityCertifyBiz qualityCertifyBiz;


    /**
     * 获取车辆列表
     *
     * @param car
     * @param pageNo
     * @param pageSize
     * @param model
     * @param request
     * @param response
     * @return
     */

    @ResponseBody
    @RequestMapping(value = "carList", method = RequestMethod.GET)
    public Object getCarList(Car car, int pageNo, int pageSize, Model model, HttpServletRequest request, HttpServletResponse response) {


        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        Page<Car> pg = new Page<Car>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {
            car.setUser(UserUtils.getUser());// 获取当前登录用户
            Page<Car> page = carBiz.findPage(pg, car);
            for (Car c : page.getList()) {
                c.setIssocialcar(DictUtils.getDictLabel(c.getIssocialcar(), "issocialcar", ""));
            }
            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }


    /**
     * 根据ID车辆详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "carInfo", method = RequestMethod.GET)
    public Object carInfo(String id, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(id)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else {
            try {
                Car car = new Car();
                car.setId(id);
                car = carBiz.get(id);
                if (car == null) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "车辆不存在";
                } else {
                    result.put("car", car);
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 发布/编辑车辆
     *
     * @param car
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveCar", method = RequestMethod.POST)
    public Object saveCar(Car car) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            return carBiz.saveCarBiz(car, UserUtils.getUser());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }

        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 删除车辆
     *
     * @param car
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteCar", method = RequestMethod.POST)
    public Object deleteCar(Car car) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(car.getId())) {
            map.put("state", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "车辆id信息缺失");
            return map;
        }
        try {
            carBiz.delete(car);
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }

        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 车辆申请认证
     *
     * @param car
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "carAuthentication", method = RequestMethod.POST)
    public Object carAuthentication(Car car) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(car.getId())) {
            map.put("state", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "车辆id信息缺失");
            return map;
        }
        try {
            qualityCertifyBiz.car_authens(car);
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }

        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 获取车辆车型
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarType")
    public Object getCarType() {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";

        try {
            List list = DictUtils.getDictList("car_type");
            result.put("list", list);
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }

        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

}
