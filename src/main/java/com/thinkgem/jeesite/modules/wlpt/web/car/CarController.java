/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.car;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;

/**
 * 车辆管理Controller
 * @author 饶江龙
 * @version 2016-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/car")
public class CarController extends BaseController {

	@Autowired
	private CarService carService;
	
	@Autowired
	private CarBiz carBiz;
	
	@ModelAttribute
	public Car get(@RequestParam(required=false) String id) {
		Car entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = carService.get(id);
		}
		if (entity == null){
			entity = new Car();
		}
		return entity;
	}

	
	@RequiresPermissions("wlpt:car:view")
	@RequestMapping(value = {"list", ""})
	public String list(Car car, HttpServletRequest request, HttpServletResponse response, Model model) {
		/*car.setUser(UserUtils.getUser());*/
		Page<Car> page = carService.findPage(new Page<Car>(request, response), car);
		model.addAttribute("page", page);
		return "modules/wlpt/car/carList";
	}
	
	@RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Car car, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "车辆列表数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Car> page = carService.findPage(new Page<Car>(), car);
    		new ExportExcel("车辆列表数据", Car.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/car/";
    }



	@RequiresPermissions("wlpt:car:view")
	@RequestMapping(value = "form")
	public String form(Car car, Model model) {
		model.addAttribute("car", car);
		return "modules/wlpt/car/carForm";
	}

	@RequiresPermissions("wlpt:car:edit")
	@RequestMapping(value = "save")
	public String save(Car car, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, car)){
			return form(car, model);
		}
		carService.save(car);
		addMessage(redirectAttributes, "保存车辆成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/list?repage";
	}
	
	@RequiresPermissions("wlpt:car:edit")
	@RequestMapping(value = "delete")
	public String delete(Car car, RedirectAttributes redirectAttributes) {
		carService.delete(car);
		addMessage(redirectAttributes, "删除车辆成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/car/?repage";
	}

	
	//---------------------------------------------------------车源大厅---------------------------------------------------------
	
	/***
	 * 去车源大厅
	 * @param car  查询对象
	 * @param request
	 * @param response
	 * @param model
     * @return
     */
	@RequestMapping(value = {"carHall", ""})
	public String goodsHall(Car car, HttpServletRequest request, HttpServletResponse response, Model model) {

		Page<Car> page = carService.findPage(new Page<Car>(request, response), car);
		model.addAttribute("page", page);
		return "modules/wlpt/car/carHallList";
	}
	@RequiresPermissions("wlpt:car:view")
	@RequestMapping(value = "detail")
	public String detail(Car car, Model model) {
		model.addAttribute("car", car);
		return "modules/wlpt/car/carDetail";
	}
	
	
}