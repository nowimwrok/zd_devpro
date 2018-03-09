/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.car;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.CarGroup;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;

/**
 * 车队管理Controller
 * @author lijintao
 * @version 2016-09-30
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/car/group")
public class CarGroupController extends BaseController {

	@Autowired
	private CarService carService;
	
	@ModelAttribute
	public CarGroup get(@RequestParam(required=false) String id) {
		CarGroup entity = null;
		if (StringUtils.isNotBlank(id)){
		}
		if (entity == null){
			entity = new CarGroup();
		}
		return entity;
	}

	
	@RequiresPermissions("wlpt:car:group:view")
	@RequestMapping(value = {"list", ""})
	public String list(CarGroup carGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CarGroup> page = carService.findGroupList(new Page<CarGroup>(request, response), carGroup);
		model.addAttribute("page", page);
		return "modules/wlpt/car/carGroupList";
	}

	@RequestMapping(value = {"detail"})
	public String list(Car car, HttpServletRequest request, HttpServletResponse response, Model model) {
		String userId=request.getParameter("id");
		User user=new User();
		user.setId(userId);
		car.setUser(user);
		Page<Car> page = carService.findPage(new Page<Car>(request, response), car);
		model.addAttribute("page", page);
		return "modules/wlpt/car/carGroupDetail";
	}
	
	@RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CarGroup carGroup, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "车队列表数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<CarGroup> page = carService.findGroupList(new Page<CarGroup>(), carGroup);
    		new ExportExcel("车队列表数据", CarGroup.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/car/group/";
    }

}