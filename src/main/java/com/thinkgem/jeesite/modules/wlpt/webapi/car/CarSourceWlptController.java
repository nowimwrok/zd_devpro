package com.thinkgem.jeesite.modules.wlpt.webapi.car;

import java.util.ArrayList;
import java.util.List;

import javax.mail.search.DateTerm;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarSourceBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.CarSource;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;

/**
 * @author zyj
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/carsource")
public class CarSourceWlptController {
	@Autowired
    private CarSourceBiz  carSourceBiz;
	
	@Autowired
    private CarBiz carBiz;
	
	@Autowired 
    private UserBiz userBiz;
	
	/**
     * 车源管理页面
     *
     * @param request、response
     * @return
     */
    @RequestMapping(value = {"carSource_list", ""})
    public String carSource_list(HttpServletRequest request, HttpServletResponse response, Model model) {
    	User user = userBiz.getUser();
        if (user.getId() == null) {
        	return "modules/wlpt_front/admin/login";
        }
        model.addAttribute("user", user);
        return "modules/user_front/car/carsource_list";
        //return "modules/wlpt_front/car/carsource_list";
    }

    /***
     * 获取车源列表
     * @param carsource实体
     * @param 当前页
     * @param 页大小
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarSourceList")
    public Object getCarSourceList(CarSource carsource, int pageNo, int pageSize, Model model) {
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
        carsource.setUser(curUser);
        Page<CarSource> page = carSourceBiz.findPage(pg, carsource);
        for (CarSource cs : page.getList()) {
        	cs.setStatus(DictUtils.getDictLabel(cs.getStatus(), "carsources_tatus", ""));
        	Car c = cs.getCar();
        	c.setIssocialcar(DictUtils.getDictLabel(c.getIssocialcar(), "issocialcar", ""));
            if(c.getStatus().equals(DataDic.AUTHENSUCCES)){
            	c.setStatus(DataDic.AUTHENSUCCES_STR);
            }
            else if(c.getStatus().equals(DataDic.AUTHENWAITING)){
            	c.setStatus(DataDic.AUTHENWAITING_STR);
            }else{
            	c.setStatus(DataDic.UNAUTHEN_STR);
            }
            cs.setCar(c);
            
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    
    /**
     * 到车源编辑页面
     *
     * @param carsource实体
     * @param type
     * @param carid
     * @param model
     * @return
     */
    @RequestMapping(value = "toSave")
    public String toSave(CarSource carsource,String type,String carid,Model model) {
    	CarSource cs = carsource;
        if (!Tools.IsNullOrWhiteSpace(cs.getId())) {//编辑车辆还是发布车辆
        	cs = carSourceBiz.get(cs.getId());//获取需要编辑的车辆
            String mainroad = cs.getMainroad();
            
            if (mainroad != null && !mainroad.equals("")) {//编辑车源
                int index = mainroad.indexOf("-");
                if(!Tools.IsNullOrWhiteSpace(type)&&type.equals("2")){//返程发布
                	cs.setFromaddress(mainroad.substring(index + 1));
                    cs.setToaddress(mainroad.substring(0, index));
                    cs.setId("");//设置车源id为空
                }else{
                	cs.setFromaddress(mainroad.substring(0, index));
                    cs.setToaddress(mainroad.substring(index + 1));
                }
                
            }
        }else if(!Tools.IsNullOrWhiteSpace(carid)){
        	Car c = carBiz.get(carid);//获取发布车源的车辆
        	if(c!=null){
        		String mainroad = c.getMainroad();
                
                if (mainroad != null && !mainroad.equals("")) {
                    int index = mainroad.indexOf("-");
                    cs.setFromaddress(mainroad.substring(0, index));
                    cs.setToaddress(mainroad.substring(index + 1));
                }
                cs.setContactname(c.getOwnername());
                cs.setContactmobile(c.getOwnermobile());
                cs.setCar(c);
        	}
        }
        model.addAttribute("carsource", cs);
        //return "modules/wlpt_front/car/carsource_add";
        return "modules/user_front/car/carsource_add";
    }

    /***
     * 发布车源
     *
     * @param carsource实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveCarSource")
    public Object saveCarSource(CarSource carsource,String departure, Model model) {
    	carsource.setDeparturetime(DateUtil.fomatDate(departure));
        Object result = carSourceBiz.saveCarSourceBiz(carsource, UserUtils.getUser());
        return new JSONPObject("callback",result);
    }

    /***
     * 删除车源
     *
     * @param carsource id
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteCarSource")
    public Object deleteCarSource(@RequestParam(required = false) String id, Model model) {
    	CarSource carsource = carSourceBiz.get(id);
        //删除货源
        carSourceBiz.delete(carsource);
        return new JSONPObject("callback", "删除成功");
    }

    
    /***
     * 获取车源详情
     * @param 当前carsource id
     * @param model
     * @return
     */
    @RequestMapping(value = "getCarSourceInfo")
    public String getCarSourceInfo(@RequestParam(required = false) String id, HttpServletRequest request, HttpServletResponse response,Model model){
    	if(UserUtils.getUser().getId()==null){
    		request.setAttribute("login", "login");
    		return "modules/wlpt_front/admin/login";
    	}
    	CarSource carsource = carSourceBiz.get(id);
    	if(carsource!=null&&carsource.getCar()!=null){
    		Car car = carsource.getCar();
    		car.setIssocialcar(DictUtils.getDictLabel(car.getIssocialcar(), "issocialcar", ""));
    		carsource.setCar(car);
    	}
    	
        model.addAttribute("carsource", carsource);
    	//return "modules/wlpt_front/car/carsourceInfo";
        return "modules/user_front/car/carsourceInfo";
    }
}
