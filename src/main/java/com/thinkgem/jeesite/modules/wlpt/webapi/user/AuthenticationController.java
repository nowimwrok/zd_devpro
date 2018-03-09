 package com.thinkgem.jeesite.modules.wlpt.webapi.user;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.qualitycertifyBiz.QualityCertifyBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserQualitycertify;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 申请认证controller
 * Created by fjc on 16/8/13.
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/authentication")
public class AuthenticationController extends BaseController {

	@Autowired
	private QualityCertifyBiz qualityCertifyBiz;

	/***
	 * 去企业认证页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "tocpy_authentication", "" })
	public String toCompanyAuthentication(HttpServletRequest request, HttpServletResponse response, Model model) {
		UserCompany userCompany = qualityCertifyBiz.getCompanyAndPictureInfo();
		User user = UserUtils.getUser();
		if(user!=null && user.getId() != null){
			UserQualitycertify quality = qualityCertifyBiz.get(user.getUserinfo().getUserCompany().getId());
			model.addAttribute("quality", quality);
			model.addAttribute("us", user);
		}
		
		model.addAttribute("userCompany", userCompany);
		//return "modules/wlpt_front/authentication/company";
		return "modules/user_front/authentication/company";
	}

	/**
	 * 企业申请认证
	 * 
	 * @param userCompanypicture
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "company_authentication")
	public Object companyAuthentication(UserCompany userCompany, Model model, RedirectAttributes redirectAttributes) {

		Boolean result = qualityCertifyBiz.cpy_authen(userCompany.getCompanyname(),userCompany.getProvinceCityDistrict(),
				userCompany.getCompanyaddress(), userCompany.getLegalperson(),
				userCompany.getBusinesslicencenum(), userCompany.getUsercompanypicture().getBusinesslicencenumimg(),
				userCompany.getHeadermobile(), userCompany.getUsercompanypicture().getIdcardimg(),
				userCompany.getUsercompanypicture().getTransportcardimg());

		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "申请认证成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "申请认证失败", null);
		}
	}

	/***
	 * 去个人认证页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "topersonal_authentication", "" })
	public String toPersonalAuthentication(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = qualityCertifyBiz.getUserPersonalInfo();
		model.addAttribute("user", user);
		User us = UserUtils.getUser();
		if(us!=null && us.getId() != null){
			UserQualitycertify qf = new UserQualitycertify();
			qf.setTargetid(us.getId());
			UserQualitycertify quality = qualityCertifyBiz.getQualitycertifyInfo(qf);
			model.addAttribute("quality", quality);
			model.addAttribute("us", us);
		}
		//return "modules/wlpt_front/authentication/personal";
		return "modules/user_front/authentication/personal";
	}

	/**
	 * 个人申请认证
	 * 
	 * @param user
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "personal_authentication")
	public Object personalAuthentication(User user, Model model, RedirectAttributes redirectAttributes) {

		Boolean result = qualityCertifyBiz.personalAuthen(user.getName(), user.getUserinfo().getIdentitycard(),
				user.getUserinfo().getUserIdcard().getSlocalphoto());

		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "申请认证成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "申请认证失败", null);
		}
	}

	/***
	 * 去车主认证页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "tocar_authentication", "" })
	public String toCardriverAuthentication(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user= qualityCertifyBiz.getUserAndDriverInfo();
		model.addAttribute("user", user);
		User us = UserUtils.getUser();
		if(us!=null && us.getId() != null){
			UserQualitycertify qf = new UserQualitycertify();
			qf.setTargetid(us.getId());
			UserQualitycertify quality = qualityCertifyBiz.getQualitycertifyInfo(qf);
			model.addAttribute("quality", quality);
			model.addAttribute("us", us);
		}
		//return "modules/wlpt_front/authentication/owner";
		return "modules/user_front/authentication/owner";
	}

	/**
	 * 车主申请认证
	 * 
	 * @param driver
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "percar_authentication")
	public Object perCarAuthentication(User user, Model model, RedirectAttributes redirectAttributes) {
		Boolean result = qualityCertifyBiz.percar_authens(user.getDriver().getDrivername(), user.getDriver().getIdcardnum(),
				user.getDriver().getDrivermobile(), user.getDriver().getDriverheadimg(), user.getDriver().getIdcardimg(), user.getDriver().getDriverlicimg());
		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "申请认证成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "申请认证失败", null);
		}
	}
	
	/**
	 * 车辆申请认证
	 * 
	 * @param car
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "car_authentication")
	public Object carAuthentication(Car car, Model model, RedirectAttributes redirectAttributes) {
		Boolean result = qualityCertifyBiz.car_authens(car);
		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "申请认证成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "申请认证失败", null);
		}
	}
}
