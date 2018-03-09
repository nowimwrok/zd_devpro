package com.thinkgem.jeesite.modules.weixin.controller.car;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;

/**
 * 我的车辆Controller
 *
 * @author
 * @version 2016-08-23
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/car")
public class CarWeiXinController extends BaseController {
	@Autowired
	private CarBiz carBiz;
	
	@Autowired 
	private UserBiz userBiz;

	/**
	 * 车队管理页面
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(value = { "car_list", "" })
	public String goods_list(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/wx_front/car/mycar_list";
	}

	/***
	 * 获取车辆列表
	 * 
	 * @param car
	 * @param pageNo
	 * @param pageSize
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
		// 获取当前用户
		car.setUser(UserUtils.getUser());
		Page<Car> page = carBiz.findPage(pg, car);
		for (Car c : page.getList()) {
			c.setIssocialcar(DictUtils.getDictLabel(c.getIssocialcar(), "issocialcar", ""));
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/**
	 * 到车辆详情页面
	 * 
	 * @param car
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "car_detail")
	public String car_detail(Car car, Model model) {
		Car c = car;
		if (c.getId() != null) {
			c = carBiz.get(car.getId());// 获取车辆
			String carnumber = c.getCarnumber();
			String mainroad = c.getMainroad();

			if (mainroad != null && !mainroad.equals("")) {
				int index = mainroad.indexOf("-");
				if (index != -1) {
					c.setFromaddress(mainroad.substring(0, index));
					c.setToaddress(mainroad.substring(index + 1));
				}

			}
		}
		model.addAttribute("car", c);
		return "modules/wx_front/car/car_detail";
	}
	
    /**
     * 到车辆编辑页面
     *
     * @param car实体
     * @param model
     * @return
     */
    @RequestMapping(value = "toSave")
    public String toSave(Car car,Model model) {

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
            
            if (c.getTravellicimg()!= null) {
            	if(c.getTravellicimg().indexOf("|") != -1){
            		String travellicimg[] = (c.getTravellicimg()).split("\\|");
    				if (travellicimg != null && travellicimg.length == 1) {
    					model.addAttribute("travellicimg1", travellicimg[0]);
    					model.addAttribute("travellicimg2", "");
    				}else if (travellicimg != null && travellicimg.length == 2) {
    					model.addAttribute("travellicimg1", travellicimg[0]);
    					model.addAttribute("travellicimg2", travellicimg[1]);
    				}
            	}else{
            		model.addAttribute("travellicimg1", c.getTravellicimg());
					model.addAttribute("travellicimg2", "");
            	}
				
			} 
            if (c.getCarsurfaceimg()!= null) {
            	if(c.getCarsurfaceimg().indexOf("|") != -1){
            		String carsurfaceimg[] = (c.getCarsurfaceimg()).split("\\|");
    				if (carsurfaceimg!=null && carsurfaceimg.length == 1) {
    					model.addAttribute("carsurfaceimg1", carsurfaceimg[0]);
    					model.addAttribute("carsurfaceimg2", "");
    				}else if (carsurfaceimg!=null && carsurfaceimg.length == 2) {
    					model.addAttribute("carsurfaceimg1", carsurfaceimg[0]);
    					model.addAttribute("carsurfaceimg2", carsurfaceimg[1]);
    				}
            	}else{
            		model.addAttribute("carsurfaceimg1", c.getCarsurfaceimg());
					model.addAttribute("carsurfaceimg2", "");
            	}
				
			} 
        }
        model.addAttribute("user", userBiz.getUser());
        model.addAttribute("car", c);
        return "modules/wx_front/car/car_add";
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

        car.setCarnumber(car.getMininame() + car.getNumber());
        car.setMainroad(car.getFromaddress() + "-" + car.getToaddress());
        Object result=carBiz.saveCarBiz(car, UserUtils.getUser());
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("user", userBiz.getUser());
        return new JSONPObject("callback", result);
    }

   /**
    * 验证车牌号码
    * @param car
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
    * @param  car
    * @param model
    * @return
    */
   @RequestMapping(value = "carApply")
   public String carApply(Car car,Model model){
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
           
           if (c.getTravellicimg()!= null) {
           	if(c.getTravellicimg().indexOf("|") != -1){
           		String travellicimg[] = (c.getTravellicimg()).split("\\|");
   				if (travellicimg != null && travellicimg.length == 1) {
   					model.addAttribute("travellicimg1", travellicimg[0]);
   					model.addAttribute("travellicimg2", "");
   				}else if (travellicimg != null && travellicimg.length == 2) {
   					model.addAttribute("travellicimg1", travellicimg[0]);
   					model.addAttribute("travellicimg2", travellicimg[1]);
   				}
           	}else{
           		model.addAttribute("travellicimg1", c.getTravellicimg());
					model.addAttribute("travellicimg2", "");
           	}
				
			} 
           if (c.getCarsurfaceimg()!= null) {
           	if(c.getCarsurfaceimg().indexOf("|") != -1){
           		String carsurfaceimg[] = (c.getCarsurfaceimg()).split("\\|");
   				if (carsurfaceimg!=null && carsurfaceimg.length == 1) {
   					model.addAttribute("carsurfaceimg1", carsurfaceimg[0]);
   					model.addAttribute("carsurfaceimg2", "");
   				}else if (carsurfaceimg!=null && carsurfaceimg.length == 2) {
   					model.addAttribute("carsurfaceimg1", carsurfaceimg[0]);
   					model.addAttribute("carsurfaceimg2", carsurfaceimg[1]);
   				}
           	}else{
           		model.addAttribute("carsurfaceimg1", c.getCarsurfaceimg());
					model.addAttribute("carsurfaceimg2", "");
           	}
				
			} 
       }
       model.addAttribute("user", userBiz.getUser());
       model.addAttribute("car", c);
       return "modules/wx_front/car/car_apply";
   }

	/***
	 * 周边车辆
	 * 
	 * @return
	 */
	@RequestMapping(value = { "around_car", "" })
	public String around_car() {
		return "modules/wx_front/car/lbs_car";
	}
	
}
