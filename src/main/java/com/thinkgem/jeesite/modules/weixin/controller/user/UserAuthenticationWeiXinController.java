/**
 *
 */
package com.thinkgem.jeesite.modules.weixin.controller.user;
     
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
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
 * 微信用户实名认证Controller
 *
 * @author fjc
 * @version 2016-08-22
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/authentication")
public class UserAuthenticationWeiXinController extends BaseController {

	@Autowired
	private QualityCertifyBiz qualityCertifyBiz;

	/**
	 * 去实名认证
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "goauthentication", "" })
	public String goauthentication(HttpServletRequest request, HttpServletResponse response, Model model) {

		return "mobile/modules/wx_front/authentication/authentication";
	}

	/**
	 * 去实名认证
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toAuthentication", "" })
	public String toAuthentication(HttpServletRequest request, HttpServletResponse response, Model model) {
		String veiw = "";
		String toPage = "";
		String certifyId = "";
		User user = UserUtils.getUser();
		String rolename = user.getRole().getEnname();
		if (user != null && rolename != null) {
			if (rolename.equals(DataDic.ROLE_ENTERPRISE)) {// 企业
				UserCompany userCompany = qualityCertifyBiz.getCompanyAndPictureInfo();
				if (userCompany.getUsercompanypicture() != null
						&& userCompany.getUsercompanypicture().getIdcardimg() != null
						&& userCompany.getUsercompanypicture().getIdcardimg().indexOf("|") != -1) {
					String idcard[] = (userCompany.getUsercompanypicture().getIdcardimg()).split("\\|");
					if (idcard.length > 2) {
						model.addAttribute("idcard1", idcard[1]);
						model.addAttribute("idcard2", idcard[2]);
					}
				}
				model.addAttribute("userCompany", userCompany);
				veiw = "modules/wx_front/authentication/authentication";
				toPage = "企业";
				certifyId = user.getUserinfo().getUserCompany().getId();
			} else if (rolename.equals(DataDic.ROLE_CAROWNER)) {// 车主
				User userCar = qualityCertifyBiz.getUserAndDriverInfo();
				if (userCar.getDriver() != null && userCar.getDriver().getIdcardimg() != null
						&& userCar.getDriver().getIdcardimg().indexOf("|") != -1) {
					String idcard[] = (userCar.getDriver().getIdcardimg()).split("\\|");
					if (idcard.length > 2) {
						model.addAttribute("idcard1", idcard[1]);
						model.addAttribute("idcard2", idcard[2]);
					}
				}
				if (userCar.getDriver() != null && userCar.getDriver().getDriverlicimg() != null
						&& userCar.getDriver().getDriverlicimg().indexOf("|") != -1) {
					String driverlic[] = (userCar.getDriver().getDriverlicimg()).split("\\|");
					if (driverlic.length > 2) {
						model.addAttribute("driverlic1", driverlic[1]);
						model.addAttribute("driverlic2", driverlic[2]);
					}
				}
				model.addAttribute("user", userCar);
				veiw = "modules/wx_front/authentication/carOwner_Authen";
				toPage = "车主";
				certifyId = user.getId();
			} else if (rolename.equals(DataDic.ROLE_GOODSOWNER)) {// 货主
				User userGoods = qualityCertifyBiz.getUserPersonalInfo();
				model.addAttribute("user", userGoods);
				veiw = "modules/wx_front/authentication/authentication";
				toPage = "货主";
				certifyId = user.getId();
			} else {
				veiw = "modules/wx_front/infoHall/infoHall_list";
			}
			if(!Tools.IsNullOrWhiteSpace(certifyId)){
				UserQualitycertify quality = qualityCertifyBiz.get(certifyId);
				model.addAttribute("quality", quality);
			}
			user=UserUtils.findUser(user);
			model.addAttribute("roleCode", rolename);
			model.addAttribute("STATUS", user.getUserinfo().getStatus());
			model.addAttribute("toPage", toPage);
		}
		return veiw;
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
	@RequestMapping(value = "companyAuthentication")
	public Object companyAuthentication(UserCompany userCompany, Model model, RedirectAttributes redirectAttributes) {

		Boolean result = qualityCertifyBiz.cpy_authen(userCompany.getCompanyname(),
				userCompany.getProvinceCityDistrict(), userCompany.getCompanyaddress(), userCompany.getLegalperson(),
				userCompany.getBusinesslicencenum(), userCompany.getUsercompanypicture().getBusinesslicencenumimg(),
				userCompany.getHeadermobile(), userCompany.getUsercompanypicture().getIdcardimg(),
				userCompany.getUsercompanypicture().getTransportcardimg());

		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "保存成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "保存失败", null);
		}
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
	@RequestMapping(value = "personalAuthentication")
	public Object personalAuthentication(User user, Model model, RedirectAttributes redirectAttributes) {

		Boolean result = qualityCertifyBiz.personalAuthen(user.getName(), user.getUserinfo().getIdentitycard(),
				user.getUserinfo().getUserIdcard().getSlocalphoto());

		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "保存成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "保存失败", null);
		}
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
	@RequestMapping(value = "percarAuthentication")
	public Object perCarAuthentication(User user, Model model, RedirectAttributes redirectAttributes) {
		Boolean result = qualityCertifyBiz.percar_authens(user.getDriver().getDrivername(),
				user.getDriver().getIdcardnum(), user.getDriver().getDrivermobile(),
				user.getDriver().getDriverheadimg(), user.getDriver().getIdcardimg(),
				user.getDriver().getDriverlicimg());
		if (result) {
			return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "保存成功", null);
		} else {
			return this.getMapResult(DataDic.RETURN_STATUS_SYSBUG, "保存失败", null);
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