/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.wlpt.biz.qualitycertifyBiz.QualityCertifyBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserQualitycertify;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanyService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanypictureService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserQualitycertifyService;

/**
 * 后台资质认证Controller
 * @author fjc
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userQualitycertify")
public class UserQualitycertifyController extends BaseController {

	@Autowired
	private UserQualitycertifyService userQualitycertifyService;
	@Autowired
	private CarService carService;
	@Autowired
	private UserinfoService userinfoService;
	@Autowired
	private UserCompanypictureService userCompanypictureService;

	@Autowired
	private UserCompanyService userCompanyService;
	@Autowired
	private DriverService driverService;
	@Autowired
	private QualityCertifyBiz qualityCertifyBiz;
	
	@ModelAttribute
	public UserQualitycertify get(@RequestParam(required=false) String id) {
		UserQualitycertify entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userQualitycertifyService.get(id);
		}
		if (entity == null){
			entity = new UserQualitycertify();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userQualitycertify:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserQualitycertify userQualitycertify, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(userQualitycertify.getTargetInfo()==null||userQualitycertify.getTargetInfo().equals("")){
			
		}else{
			userQualitycertify.setCarInfo(userQualitycertify.getTargetInfo());
			userQualitycertify.setDriverInfo(userQualitycertify.getTargetInfo());
			userQualitycertify.setCompanyInfo(userQualitycertify.getTargetInfo());
			User user=new User();
			user.setLoginName(userQualitycertify.getTargetInfo());
			userQualitycertify.setRequestuser(user);
			
			Page<UserQualitycertify> page = userQualitycertifyService.findPage(new Page<UserQualitycertify>(request, response), userQualitycertify);
			model.addAttribute("page", page);
			return "modules/wlpt/user/userQualitycertifyList";
		}
		Page<UserQualitycertify> page = userQualitycertifyService.findPage(new Page<UserQualitycertify>(request, response), userQualitycertify); 
		List<Car> cars=carService.findList(new Car());
		List<UserCompany> companys=userCompanyService.findList(new UserCompany());
		List<Driver> drivers=driverService.findList(new Driver());
		for(UserQualitycertify qualitycertify:page.getList()){
			if(qualitycertify.getCertifytype().equals(DataDic.AUTHEN_CAR)){
				for(Car car:cars){
					if(car.getId().equals(qualitycertify.getTargetid())){
						qualitycertify.setCarInfo(car.getCarnumber());
					}
				}
			}
			if(qualitycertify.getCertifytype().equals(DataDic.AUTHEN_COMPANY)){
				for(UserCompany company:companys){
					if(company.getId().equals(qualitycertify.getTargetid())){
						UserCompanypicture userCompanypicture = new UserCompanypicture();
						userCompanypicture.setUserCompany(company);
						userCompanypicture = userCompanypictureService.get(userCompanypicture);
						qualitycertify.setCompanyInfo(userCompanypicture.getUserCompany().getCompanyname());
					}
				}
			}
			if(qualitycertify.getCertifytype().equals(DataDic.AUTHEN_DRIVER)){
				for(Driver driver:drivers){
					if(driver.getId().equals(qualitycertify.getTargetid())){
						qualitycertify.setDriverInfo(driver.getDrivername());
					}
				}
			}
			
		}
		model.addAttribute("page", page);
		return "modules/wlpt/user/userQualitycertifyList";
	} 

	@RequiresPermissions("wlpt:user:userQualitycertify:view")
	@RequestMapping(value = "form")
	public String form(UserQualitycertify userQualitycertify, Model model) {
		Map<String, Object> map=new HashMap<String,Object>();
		String redirectView="modules/wlpt/qualitycertify/";
		map=qualityCertifyBiz.goAudit(userQualitycertify.getId(), userQualitycertify.getTargetid(), userQualitycertify.getCertifytype());
		redirectView=redirectView+map.get("redirectView").toString();
		model.addAttribute("userQualitycertify", userQualitycertify);
		model.addAttribute("info",map.get("info"));
		return redirectView;
	}

	@RequiresPermissions("wlpt:user:userQualitycertify:edit")
	@RequestMapping(value = "save")
	public String save(UserQualitycertify userQualitycertify, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, userQualitycertify)){
			return form(userQualitycertify, model);
		}*/
		Boolean result=false;
		result=qualityCertifyBiz.editCertify(userQualitycertify.getId(), userQualitycertify.getCertifystatus(),userQualitycertify.getCertifycomment());
		if(result){
			addMessage(redirectAttributes, "保存认证信息成功");
		}else{
			addMessage(redirectAttributes, "保存认证信息失败");
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userQualitycertify/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userQualitycertify:edit")
	@RequestMapping(value = "delete")
	public String delete(UserQualitycertify userQualitycertify, RedirectAttributes redirectAttributes) {
		userQualitycertifyService.delete(userQualitycertify);
		addMessage(redirectAttributes, "删除认证信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userQualitycertify/?repage";
	}

}