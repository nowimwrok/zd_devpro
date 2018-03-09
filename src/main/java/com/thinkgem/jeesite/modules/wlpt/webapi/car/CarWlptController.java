package com.thinkgem.jeesite.modules.wlpt.webapi.car;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarLocsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 王铸
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/car")
public class CarWlptController extends BaseController {

    @Autowired
    private CarBiz carBiz;
    @Autowired
    private UserBiz userBiz;
    @Autowired
    private GpsCarLocsService gpsCarLocsService;
    @Autowired
    private CarService carService;

    /**
     * 车队管理页面
     *
     * @param request、response
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"car_list", ""})
    public String goods_list(HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = userBiz.getUser();
        if (user.getId() == null) {
            return "modules/wlpt_front/admin/login";
        }
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("user", user);
        return "modules/user_front/car/car_list";
        //return "modules/wlpt_front/car/car_list";
    }

    /***
     * 获取车辆列表
     * @param car 实体
     * @param pageNo 当前页
     * @param pageSize 页大小
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarList")
    public Object getCarList(Car car, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            return null;
        }
        car.setUser(curUser);
        Page<Car> page = carBiz.findPage(pg, car);
        GpsCarLocs gpsCarLocs = new GpsCarLocs();
        List<GpsCarLocs> gpsCarList = gpsCarLocsService.findList(gpsCarLocs);
        for (Car c : page.getList()) {
            c.setIssocialcar(DictUtils.getDictLabel(c.getIssocialcar(), "issocialcar", ""));
            if (c.getStatus().equals(DataDic.AUTHENSUCCES)) {
                c.setStatus(DataDic.AUTHENSUCCES_STR);
            } else if (c.getStatus().equals(DataDic.AUTHENWAITING)) {
                c.setStatus(DataDic.AUTHENWAITING_STR);
            } else {
                c.setStatus(DataDic.UNAUTHEN_STR);
            }

            for (GpsCarLocs loc : gpsCarList) {
                if (loc.getName().equals(c.getCarnumber())) {
                    c.setGpsloc(loc);
                }
            }
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /**
     * 到车辆编辑页面
     *
     * @param car实体
     * @param model
     * @return
     */
    @RequestMapping(value = "toSave")
    public String toSave(Car car, Model model) {
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        Car c = car;
        if (c.getId() != null) {//编辑车辆还是发布车辆
            c = carBiz.get(car.getId());//获取需要编辑的车辆
            String carnumber = c.getCarnumber();
            String mainroad = c.getMainroad();
            if (carnumber != null && !carnumber.equals("")) {
                c.setMininame(carnumber.substring(0, 1));
                c.setNumber(carnumber.substring(1));
            }
            if (mainroad != null && !mainroad.equals("")) {
                int index = mainroad.indexOf("-");
                c.setFromaddress(mainroad.substring(0, index));
                c.setToaddress(mainroad.substring(index + 1));
            }
        }
        model.addAttribute("car", c);
        return "modules/user_front/car/car_add";
    }

    /***
     * 发布车辆
     *
     * @param car实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveCar")
    public Object save(Car car, Model model) {
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        car.setCarnumber(car.getMininame() + car.getNumber());
        car.setMainroad(car.getFromaddress() + "-" + car.getToaddress());
        Object result = carBiz.saveCarBiz(car, UserUtils.getUser());
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("user", userBiz.getUser());
        return new JSONPObject("callback", result);
    }

    /***
     * 删除车辆
     *
     * @param car id
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteCar")
    public Object deleteCar(@RequestParam(required = false) String id, Model model) {
        Car car = carBiz.get(id);
        //删除货源
        carBiz.delete(car);
        return new JSONPObject("callback", "删除成功");
    }


    /**
     * @param car实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "validCarnumber", produces = "application/json;charset=UTF-8")
    public Object validCarnumber(Car car, Model model) {
        car.setDelFlag("0");
        List<Car> result = carBiz.findList(car);
        String flag = "0";
        if (result.size() > 0) {
            for (Car c : result) {
                if (c.getUser().getId().equals(UserUtils.getUser().getId())) {
                    flag = "1";
                    break;
                }
            }
        }
        return new JSONPObject("callback", flag);
    }

    /***
     * 获取车辆详情
     * @param 当前car id
     * @param model
     * @return
     */
    @RequestMapping(value = "getCarInfo")
    public String getCarInfo(@RequestParam(required = false) String id, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (UserUtils.getUser().getId() == null) {
            request.setAttribute("login", "login");
            return "modules/wlpt_front/admin/login";
        }
        Car car = carBiz.get(id);
        String picture = car.getCarsurfaceimg();
        List<String> list = new ArrayList<String>();
        if (picture != null && !picture.equals("")) {
            String[] pictures = picture.split("\\|");
            for (int i = 0; i < pictures.length; i++) {
                if (!"".equals(pictures[i])) {
                    list.add(pictures[i]);
                }
            }
        }
        car.setIssocialcar(DictUtils.getDictLabel(car.getIssocialcar(), "issocialcar", ""));
        model.addAttribute("list", list);
        model.addAttribute("car", car);
        return "modules/user_front/car/carInfo";
    }

    /***
     * 车辆详情
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDetail")
    public Object getDetail(String id) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        Map<String, Object> map = new HashMap<String, Object>();

        if (id != null && !StringUtils.isEmpty(id)) {
            Car car = carBiz.get(id);

            ////行驶证
            List<String> travelList = new ArrayList<String>();
            ///车辆外观
            List<String> surfaceList = new ArrayList<String>();
            List<String> cardList = new ArrayList<String>();
            List<String> transportList = new ArrayList<String>();
            String picture = car.getCarsurfaceimg();
            if (picture != null && !picture.equals("")) {
                String[] pictures = picture.split("\\|");
                for (int i = 0; i < pictures.length; i++) {
                    if (!"".equals(pictures[i])) {
                        surfaceList.add(pictures[i]);
                    }
                }
            }
            String card = car.getOwneridcardimg();
            if (card != null && !card.equals("")) {
                String[] cards = card.split("\\|");
                for (int i = 0; i < cards.length; i++) {
                    if (!"".equals(cards[i])) {
                        travelList.add(cards[i]);
                    }
                }
            }
            String travellicimg = car.getTravellicimg();
            if (travellicimg != null && !travellicimg.equals("")) {
                String[] travellicimgs = travellicimg.split("\\|");
                for (int i = 0; i < travellicimgs.length; i++) {
                    if (!"".equals(travellicimgs[i])) {
                        travelList.add(travellicimgs[i]);
                    }
                }
            }
            String transport = car.getTransportcardimg();
            if (transport != null && !transport.equals("")) {
                String[] transports = transport.split("\\|");
                for (int i = 0; i < transports.length; i++) {
                    if (!"".equals(transports[i])) {
                        transportList.add(transports[i]);
                    }
                }
            }
            car.setIssocialcar(DictUtils.getDictLabel(car.getIssocialcar(), "issocialcar", ""));
            map.put("entity", car);
            map.put("surfaceList", surfaceList);
            map.put("transportList", transportList);
            map.put("travelList", travelList);
            map.put("cardList", cardList);
        } else {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "未查询到数据";
        }
        return this.getMapResult(state, message, map);
    }

    /**
     * 获取该用户的车辆总数
     *
     * @param car
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getUserCarNum")
    public Object getUserCarNum(Car car) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        Map<String, Object> result = new HashMap<>();
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "获取用户失败";
        } else {
            car.setUser(curUser);
            int i = carService.getUserCarNum(car);
            result.put("totalCarNum", i);
        }
        return this.getMapResult(state, message, result);
    }
}