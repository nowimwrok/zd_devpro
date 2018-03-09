package com.thinkgem.jeesite.modules.wlpt.webapi.user;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BidOrderBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserStatisticsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ForHeart on 16/8/10.
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/personal")
public class PersonalController extends BaseController {

	@Autowired
	private WlptUserService wlptUserService;
	@Autowired
	private UserinfoService userinfoService;
	@Autowired
	private UserBiz userBiz;

	@Autowired
	private SystemService systemService;

	@Autowired
	private UserStatisticsBiz userStatisticsBiz;

	@Autowired
	private TradeBiz tradeBiz;

	@Autowired
	private BidOrderBiz bidOrderBiz;

	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;

	@Autowired
	private MetroCardBiz metroCardBiz;
	
	@Autowired
	private BidinfoService bidinfoService;
	
	@Autowired
	private BiddinginfoService biddinginfoService;

	/**
	 * 去申请一卡通页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toApplyCard", "" })
	public String toApplyCard(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.findUser(UserUtils.getUser());
		Boolean isenterprise = false;
		UserMetroCard userMetroCard=new UserMetroCard();
		if (user.getId() != null) {
			model.addAttribute("user", user);
			if (user.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE)) {
				isenterprise = true;
			}
			userMetroCard=metroCardBiz.getUserMetroCardByUserid(user.getId());
			if(userMetroCard!=null){
				model.addAttribute("userMetroCard", userMetroCard);
			}
		}
		model.addAttribute("isenterprise", isenterprise);
		return "modules/user_front/finance/card_apply";
	}

	/***
	 * 保存申请一卡通
	 * 
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveCard")
	public Object saveCard(Address address, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		address.setId(null);
		map= metroCardBiz.applicationMetroCard(address);
		return this.getMapResult((Integer)map.get("state"),map.get("message").toString(), null);
	}

	/**
	 * 去一卡通更改密码页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toUpdatePasswordCard", "" })
	public String toUpdatePasswordCard(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.findUser(UserUtils.getUser());
		UserMetroCard userMetroCard=new UserMetroCard();
		if (user.getId() != null) {
			model.addAttribute("user", user);		
			userMetroCard=metroCardBiz.getUserMetroCardByUserid(user.getId());
			if(userMetroCard!=null){
				model.addAttribute("userMetroCard", userMetroCard);
			}
		}
		return "modules/wlpt_front/user/updatecardpassword";
	}

	/***
	 * 一卡通密码修改
	 * 
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "updatePasswordCard")
	public Object updatePasswordCard(String cardid,String oldpassword,String password,String repassword) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= (UserUtils.findUser(UserUtils.getUser()));
		if(user!=null&&!Tools.IsNullOrWhiteSpace(user.getId())){
			map= metroCardBiz.updateCardPassWord(user.getId(),cardid, password,oldpassword);
		}else{
			return null;
		}
		return this.getMapResult((Integer)map.get("state"),map.get("message").toString(), null);
	}
	
	/***
	 * 一卡通密码重置
	 * 
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "rePasswordCard")
	public Object rePasswordCard() {
		Map<String, Object> map = new HashMap<String, Object>();
		User user= (UserUtils.findUser(UserUtils.getUser()));
		if(user!=null&&!Tools.IsNullOrWhiteSpace(user.getId())){
			map= metroCardBiz.resavePassWordCard(user.getId());
		}else{
			return null;
		}
		return this.getMapResult((Integer)map.get("state"),map.get("message").toString(), null);
	}
	
	
	/**
	 * 去挂失一卡通页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toLossCard", "" })
	public String toLossCard(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.findUser(UserUtils.getUser());
		Boolean isenterprise = false;
		UserMetroCard userMetroCard=new UserMetroCard();
		if (user.getId() != null) {
			model.addAttribute("user", user);
			if (user.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE)) {
				isenterprise = true;
			}
			userMetroCard=metroCardBiz.getUserMetroCardByUserid(user.getId());
			if(userMetroCard!=null){
				model.addAttribute("userMetroCard", userMetroCard);
			}
		}
		model.addAttribute("isenterprise", isenterprise);
		return "modules/wlpt_front/user/losscard";
	}
	
	
	/***
	 * 保存挂失一卡通
	 * 
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "lossCard")
	public Object lossCard(Address address, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<String, Object>();
		address.setId(null);
		map= metroCardBiz.lossMetroCardSave(address);
		return this.getMapResult((Integer)map.get("state"),map.get("message").toString(), null);
	}
	
	
	/***
	 * 保存用户基本信息资料
	 * 
	 * @param userinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveUserInfo")
	public Object save(Userinfo userinfo, Model model, RedirectAttributes redirectAttributes) {
		if (userinfo.getUser() != null && userinfo.getUser().getLoginName() != null) {
			Userinfo info = userinfoService.ValidateLoginName(userinfo);
			if (info != null && userinfo.getUser().getLoginName().equals(info.getUser().getLoginName())
					&& !userinfo.getId().equals(info.getId())) {
				return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "用户名已存在", userinfo);
			}
		}
		if (userinfo.getQq() != null && !"".equals(userinfo.getQq())) {
			Userinfo info = userinfoService.ValidateQQ(userinfo);
			if (info != null && userinfo.getQq().equals(info.getQq()) && !userinfo.getId().equals(info.getId())) {
				return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "QQ号已存在", userinfo);
			}
		}
		userinfo.setIscompleteinfo(DataDic.YES);// 已完善个人资料
		userinfo = wlptUserService.editUserInfo(userinfo);

		return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "保存成功", userinfo);
	}

	/**
	 * 监听用户登录
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "listener")
	public boolean isLogin() {
		User user = UserUtils.getUser();
        return user.getId() != null;
	}

	/***
	 * 验证QQ
	 * 
	 *
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "validateQQ")
	public boolean validateQQ(Model model, RedirectAttributes redirectAttributes, HttpServletRequest req) {
		String id = req.getParameter("ID");
		String qq = req.getParameter("QQ");
		if (qq == null || "".equals(qq)) {
			qq = "default";// 填充默认值
		}
		Userinfo userinfo = new Userinfo();
		userinfo.setQq(qq);
		Userinfo info = userinfoService.ValidateQQ(userinfo);
		boolean message = true;
		if (info != null && qq.equals(info.getQq()) && !id.equals(info.getId())) {
			message = false;
		}
		return message;
	}

	/***
	 * 验证登录名 ID 用户id 判断是否修改自己信息 LoginName 登陆名
	 * 
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "validateLoginName")
	public boolean validateLoginName(Model model, RedirectAttributes redirectAttributes, HttpServletRequest req) {
		String id = req.getParameter("ID");
		String loginName = req.getParameter("LoginName");
		if (loginName == null || "".equals(loginName)) {
			loginName = "default";// 填充默认值
		}
		Userinfo userinfo = new Userinfo();
		User user = new User();
		user.setLoginName(loginName);
		userinfo.setUser(user);
		Userinfo info = userinfoService.ValidateLoginName(userinfo);
		boolean message = true;
		if (info != null && loginName.equals(info.getUser().getLoginName()) && !id.equals(info.getId())) {
			message = false;
		}
		return message;
	}

	/***
	 * 用户基本资料信息
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */

	@RequestMapping(value = { "userinfo", "" })
	public String userinfo(Userinfo userinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		/*
		 * if((User)UserUtils.getSession().getAttribute("user")!=null&&!"".
		 * equals((User)UserUtils.getSession().getAttribute("user"))){
		 * user=(User)UserUtils.getSession().getAttribute("user"); }
		 */

		// 判断用户是否为空
		if (user != null && user.getUserinfo() != null) {
			// 获取用户资料信息
			userinfo = wlptUserService.getUserInfo(user.getUserinfo().getId());
		}
		// 判断用户资料信息是否为空，如为空重新实例化
		if (userinfo == null) {
			userinfo = new Userinfo();
		}
		model.addAttribute("userinfo", userinfo);
		return "modules/user_front/account/user_info";
	}

	/**
	 * 修改密码
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "updatepass", "" })
	public String updatepass(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
		user = UserUtils.getUser();
		if (user == null) {
			user = new User();
		}

		model.addAttribute("user", user);
		UserMetroCard userMetroCard=metroCardBiz.getUserMetroCardByUserid(user.getId());
		if(userMetroCard!=null){
			model.addAttribute("userMetroCard", userMetroCard);
		}
		return "modules/user_front/account/account_security";
	}

	/**
	 * 修改会员密码
	 * 
	 * @param user
	 * @param oldpassword
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveUpdatePass")
	public Object saveUpdatePass(User user, String oldpassword, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		User us = UserUtils.getUser();
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "修改成功";
		if (SystemService.validatePassword(oldpassword, us.getPassword())) {
			if (!user.getPassword().equals(oldpassword)) {
				wlptUserService.updatePasswordById(us.getId(), user.getPassword());
				message = "修改成功";
			} else {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "新密码不能与旧密码一样";
			}

		} else {
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "旧密码错误";
		}
		return this.getMapResult(state, message, user);
	}

	/**
	 * 忘记会员密码
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "forgetpass", "" })
	public String forgetpass(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
		user = UserUtils.getUser();
		if (user == null) {
			user = new User();
		}

		model.addAttribute("user", user);
		return "modules/wlpt_front/user/forgetpassword";
	}

	/**
	 * 忘记会员密码
	 * 
	 * @param user
	 * @param oldpassword
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveForgetPass")
	public Object saveForgetPass(String phone, String password, String repassword, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User us = UserUtils.getByPhone(phone);
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "修改成功";
		if (us != null) {
			if (password.equals(repassword)) {
				wlptUserService.updatePasswordById(us.getId(), password);
				message = "修改成功";
			} else {
				state = DataDic.RETURN_STATUS_NORMAL;
				message = "两次密码不一致";
			}

		} else {
			state = DataDic.RETURN_STATUS_NORMAL;
			message = "手机号码错误";
		}

		return this.getMapResult(state, message, us);
	}

	/**
	 * 修改提现密码
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "updatecashpass", "" })
	public String updatecashpass(Userinfo userinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		userinfo = userBiz.getUserInfo(userinfo);

		model.addAttribute("user", userinfo);
		return "modules/wlpt_front/user/updatecashpassword";
	}

	/**
	 * 修支付密码
	 * 
	 * @param user
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveCashPass")
	public Object saveCashPass(Userinfo userinfo, HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		// 修改提现密码
		String msgs = userBiz.modifyPwd(userinfo.getCashpassword());
		return this.getMapResult(state, msgs, null);
	}

	/***
	 * 个人中心首页
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "index", "" })
	public String index(@RequestParam(required = false) String flag, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		if (user.getId() != null) {
			model.addAttribute("flag", flag);
			model.addAttribute("isShowAt", true);
			model.addAttribute("tpl_id", Global.CATEGORY_NOTICE_ID);
			model.addAttribute("site_id", Global.SITE_NOTICE_ID);
			
			return "modules/wlpt_front/hall/home_default";
		} else {
			UserUtils.getSession().setAttribute(Const.LOGIN_SUCCEED_RETURN_URL, frontPath + "/wlpt/personal/list");
			String login = "login";
			request.setAttribute("login", login);
			return "modules/wlpt_front/admin/login";
		}
	}
	@RequestMapping(value = { "home_index", "" })
	public String home_index(@RequestParam(required = false) String flag, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		User user = UserUtils.getUser();
		if (user.getId() != null) {
			UserStatistics userStatistics=new UserStatistics();
	        if (user.getId() != null){
	    		userStatistics.setUser(user);
	    		userStatistics=userStatisticsBiz.getConditon(userStatistics);
	        }
	        UserPurse up = user.getUserPurse();
			up.setWebbalance(PreciseCompute.round(up.getWebbalance().doubleValue(), 2));
			up.setAvailablebalance(PreciseCompute.round(up.getAvailablebalance().doubleValue(), 2));
			up.setWebcoin(PreciseCompute.round(up.getWebcoin().doubleValue(), 2));
			up.setAvailablecoin(PreciseCompute.round(up.getAvailablecoin().doubleValue(), 2));
			up.setPetrolbalance(PreciseCompute.round(up.getPetrolbalance().doubleValue(), 2));
			user.setUserPurse(up);
			model.addAttribute("statistics", userStatistics);
			model.addAttribute("user", user);
			model.addAttribute("flag", flag);
			model.addAttribute("isShowAt", true);
			return "modules/wlpt_front/hall/per_index";
		} else {
			UserUtils.getSession().setAttribute(Const.LOGIN_SUCCEED_RETURN_URL, frontPath + "/wlpt/personal/list");
			String login = "login";
			request.setAttribute("login", login);
			return "modules/wlpt_front/admin/login";
		}
	}
	/***
	 * 运单列表
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "trade_list")
	public String trade_list(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (user.getId() != null) {

			return "modules/wlpt_front/admin/trade_list";
		} else {
			UserUtils.getSession().setAttribute(Const.LOGIN_SUCCEED_RETURN_URL, frontPath + "/wlpt/personal/list");
			String login = "login";
			request.setAttribute("login", login);
			return "modules/wlpt_front/admin/login";
		}
	}

	/**
	 * 左侧菜单
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */

	@RequestMapping(value = { "side_bar", "" })
	public String topnav(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/wlpt_front/admin/side_bar";
	}

	/***
	 * 资质认证页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "authentication", "" })
	public String authentication(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = new User();
		if (UserUtils.getUser().getId() != null) {
			user = UserUtils.findUser(UserUtils.getUser());
			model.addAttribute("user", user);
			//return "modules/wlpt_front/authentication/jump";
			return "modules/user_front/authentication/jump";
		} else {
			UserUtils.getSession().setAttribute(Const.LOGIN_SUCCEED_RETURN_URL, frontPath + "/wlpt/personal/list");
			String login = "login";
			request.setAttribute("login", login);
			return "modules/wlpt_front/admin/login";
		}
	}

	/***
	 * 验证手机号码是否存在
	 *
	 * @param phone
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkPhone")
	public String checkPhone(String phone) {

		if (phone.trim() != null && systemService.getUserByPhone(phone.trim()) == null) {
			return "false";
		}
		return "true";
	}

	// ========================================发送普通短信验证码====================================
	/***
	 * 发送验证码
	 * 
	 * @param phone
	 *            手机号码
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "sendRegCode")
	public String sendRegCode(String phone, RedirectAttributes redirectAttributes) {
		if ("".equals(phone.trim()) || phone.trim() == null) {
			return "false";
		} else if (systemService.getUserByPhone(phone.trim()) == null) {
			return "false";
		}
		String tempSmsCode = String.valueOf(Tools.getRandomNum()); // 获取验证码
		System.out.println(tempSmsCode);
		String[] keyword = { tempSmsCode };
		int result = SmsUtil.sendSmsMesge(null, "registerSMS", phone, Const.System_Module_Enum.CeShi,
				Const.SMSFUN_REGCODE, keyword, null, null, true,SmsConfig.smsValidateCode);
		if (result == 1) {
			return "true";
		}
		return "false";
	}

	/***
	 * 发送验证码
	 * 
	 * @param phone
	 *            手机号码
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "sendCode")
	public String sendCode(String phone, RedirectAttributes redirectAttributes) {
		if ("".equals(phone.trim()) || phone.trim() == null) {
			return "false";
		} 
		String tempSmsCode = String.valueOf(Tools.getRandomNum()); // 获取验证码
		System.out.println(tempSmsCode);
		String[] keyword = { tempSmsCode };
		int result = SmsUtil.sendSmsMesge(null, "registerSMS", phone, Const.System_Module_Enum.CeShi,
				Const.SMSFUN_REGCODE, keyword, null, null, true,SmsConfig.smsValidateCode);
		if (result == 1) {
			return "true";
		}
		return "false";
	}

	
	
	/**
	 * 验证注册验证码
	 *
	 * @param phone
	 *            注册手机号码
	 * @param regcode
	 *            短信验证码
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkRegCode")
	public String checkRegCode(String phone, String regcode) {
		if ("".equals(phone.trim()) || phone.trim() == null) {
			return "false";
		} 
		if ("".equals(regcode.trim()) || regcode.trim() == null) {
			return "false";
		} 
		int result = SmsUtil.judgeSmsVerCode(phone.trim(), regcode.trim(), Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);

		if (result == 1) {
			return "true";
		}
		return "false";
	}

	// ============================================个人==================================================
	// 展现个账户基本信息

	@RequestMapping(value = { "persional_index", "" })
	public String persional(User user, HttpServletRequest request, HttpServletResponse response, Model model) {

		user = UserUtils.getUser();
		try {
			if (user.getId() != null) {
				user = UserUtils.findUser(user);
				UserStatistics userStatistics = new UserStatistics();
				userStatistics.setUser(user);
				userStatistics = userStatisticsBiz.getConditon(userStatistics);
				if (user.getUserPurse() == null) {
					user.setUserPurse(new UserPurse());
				}
				UserPurse up = user.getUserPurse();
				up.setWebbalance(PreciseCompute.round(up.getWebbalance().doubleValue(), 2));
				up.setAvailablebalance(PreciseCompute.round(up.getAvailablebalance().doubleValue(), 2));
				up.setWebcoin(PreciseCompute.round(up.getWebcoin().doubleValue(), 2));
				up.setAvailablecoin(PreciseCompute.round(up.getAvailablecoin().doubleValue(), 2));
				up.setPetrolbalance(PreciseCompute.round(up.getPetrolbalance().doubleValue(), 2));
				user.setUserPurse(up);
				model.addAttribute("userStatistics", userStatistics);
				model.addAttribute("user", user);
				
				//运单
				Page pg = new Page();
		        pg.setPageNo(1);
		        pg.setPageSize(3);
		        Page<Orderinfo> page = tradeBiz.findPage(pg, new Orderinfo(), user);
		        List<String> gpslist=new ArrayList<>();
		        for (Orderinfo order : page.getList()) {
		            if (UserUtils.getUser().getId().equals(order.getSeller().getId())) {
		                order.setFlag(true);
		            } else {
		                order.setFlag(false);
		            }
		            gpslist.add(order.getQuoteinfo().getCar().getCarnumber());
		            order.getQuoteinfo().getGoods().setGsoddtype(DictUtils.getDictLabel(order.getQuoteinfo().getGoods().getGsoddtype(), "gsoddtype", ""));
		            
		        }
		        model.addAttribute("orderinfolist", page.getList());
				
		        Map<String,Double> map = null;
		        if(user.getRole().getName().equals("车主")){
		        	map = tradeBiz.getCarUserPriceNum(user.getId());
		        }else if(user.getRole().getName().equals("货主")){
		        	map = tradeBiz.getGoodPriceNum(user.getId());
		        }else{
		        	map = tradeBiz.getGoodPriceNum(user.getId());
		        	//最新招标
			        List<Bidinfo> bidlist = bidinfoService.getNewBidList(user.getId());
			        if(bidlist != null){
			        	for(Bidinfo binfo : bidlist){
			        		binfo.setBidstatus(DictUtils.getDictLabel(binfo.getBidstatus(), "bid_status", ""));
			        	}
			        }
			        //最新竞标
			        List<Biddinginfo> biddinglist = biddinginfoService.getNewBiddingList(user.getId());
			        if(biddinglist != null){
			        	for(Biddinginfo bidinginfo : biddinglist){
			        		bidinginfo.setBiddingstatus(DictUtils.getDictLabel(bidinginfo.getBiddingstatus(), "bidding_status", ""));
			        	}
			        }
			        model.addAttribute("bidlist", bidlist);
			        model.addAttribute("biddinglist", biddinglist);
			        model.addAttribute("contracttotalNum",bidOrderBiz.getContracttotalNum(user.getId()));  //获取今天的竞标金额  
			        model.addAttribute("weiContracttotal",bidOrderBiz.getWeiNum(user.getId()));  //获取今天的竞标待结算金额
			        model.addAttribute("yiContracttotal",bidOrderBiz.getYiNum(user.getId()));  //获取今天的竞标已结算金额
			        model.addAttribute("daiyun",bidOrderBiz.getDaiNum(user.getId()));  //获取今天的待运输总吨数
			        model.addAttribute("yiyun",bidOrderBiz.getYunNum(user.getId()));  //获取今天的已运输总吨数-
			        model.addAttribute("countNum",biddinginfoService.getCountNum(user.getId()));  //获取今天的投标的总吨数
		        }
		        model.addAttribute("priceNum", map.get("pricenum").doubleValue());  //获取今天的运单交易金额
		        model.addAttribute("daiPrice", map.get("daipricenum").doubleValue());  //获取今天的运单待付金额
		        model.addAttribute("yiPrice", map.get("yipircenum").doubleValue());  //获取今天的运单已付金额
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		//return "modules/wlpt_front/user/personal_index";
		return "modules/wlpt_front/user/persional";
	}

	/***
	 * 业务分析
	 * 
	 * @return
	 */
	@RequestMapping(value = { "business_trend", "" })
	public String business_trend(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/wlpt_front/persional/business_trend";
	}

	/***
	 * 财务报表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/financial_statement")
	public String financial_statement() {
		return "modules/wlpt_front/persional/financial_statement";
	}

	/***
	 * 运单报表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/order_statement")
	public String order_statement() {
		return "modules/wlpt_front/persional/order_statement";
	}

	/***
	 * 财务分析
	 * 
	 * @return
	 */
	@RequestMapping(value = "/financial_trend")
	public String financial_trend(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/wlpt_front/persional/financial_trend";
	}

	/***
	 * 查询用户信息 searchinfo
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "searchInfo")
	public Object searchInfo(User user, Model model) {
		User newuser = UserUtils.findUser(user);
		Map map = new HashMap();
		if (newuser != null) {
			Userinfo info = newuser.getUserinfo();
			Role role = newuser.getRole();
			map.put("role", role);
			map.put("info", info);
			map.put("user", newuser);
			return new JSONPObject("callback", map);
		} else {
			return new JSONPObject("callback", "未查到指定用户");
		}

	}
	
	/***
	 * 查询用户信息 searchinfo
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "searchpetroInfo")
	public Object searchpetroInfo(User user, Model model) {
		User newuser = UserUtils.findUser(user);
		Map map = new HashMap();
		if (newuser != null) {
			Userinfo info = newuser.getUserinfo();
			Role role = newuser.getRole();
			map.put("role", role);
			map.put("info", info);
			map.put("user", newuser);
			return new JSONPObject("callback", map);
		} else {
			return new JSONPObject("callback", "未查到指定用户");
		}

	}

	@RequestMapping(value = "/getEveryVolum")
	@ResponseBody
	public Object getEveryDayVolum(HttpServletRequest request, HttpServletResponse response) {
		String dataName = request.getParameter("dataName");
		if ("everyDay".equals(dataName) || dataName == null) {
			return null;
		} else if ("everyWeek".equals(dataName)) {
			return null;
		} else if ("everyMoth".equals(dataName)) {
			return null;
		} else if ("everyYear".equals(dataName)) {
			return null;
		} else {
			return null;
		}
	}

	/***
	 * 获取运费交易信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getOrderCount")
	@ResponseBody
	public Object getOrderCount(HttpServletRequest request, HttpServletResponse response) {
		String dataName = request.getParameter("dataName");
		if ("everyDay".equals(dataName) || dataName == null) {
			return null;
		} else if ("everyWeek".equals(dataName)) {
			return null;
		} else if ("everyMoth".equals(dataName)) {
			return null;
		} else if ("everyYear".equals(dataName)) {
			return null;
		} else {
			return null;
		}
	}

	/**
	 * 运单统计信息
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getOrderinfoSum")
	public Object getOrderinfoSum(HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		User user = UserUtils.getUser();
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (user.getId() != null) {
			map.put("newOrder", tradeBiz.getSumOrderinfoByRoleEname(user.getRole().getEnname(), DataDic.ORDER_SUM_NEW));// 新运单
			map.put("intransitOrder",
					tradeBiz.getSumOrderinfoByRoleEname(user.getRole().getEnname(), DataDic.ORDER_SUM_INTRANSIT));// 运输中
			map.put("nopaymentOrder",
					tradeBiz.getSumOrderinfoByRoleEname(user.getRole().getEnname(), DataDic.ORDER_SUM_NOPAYMENT));// 待支付
			map.put("endOrder", tradeBiz.getSumOrderinfoByRoleEname(user.getRole().getEnname(), DataDic.ORDER_SUM_END));// 已支付
		} else {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "登陆失效,请重新登陆";
		}
		map.put("state", state);
		map.put("message", message);
		return map;
	}

	/**
	 * 招标统计信息
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getBidOrderinfoSum")
	public Object getBidOrderinfoSum(HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		User user = UserUtils.getUser();
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (user.getId() != null) {
			map.put("bidOrderEnd", bidOrderBiz.sumBidOrderinfoTotalEnd(new BidOrderinfo()));
			map.put("bidOrderNo", bidOrderBiz.sumBidOrderinfoTotalNo(new BidOrderinfo()));
		} else {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "登陆失效,请重新登陆";
		}
		map.put("state", state);
		map.put("message", message);
		return map;
	}

	/**
	 * 个人中心首页财务列表对账单报表
	 * 
	 * @param account
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "exportFinance")
	public String exportFinanceFile(Account account, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			User user = UserUtils.getUser();
			if (user.getId() != null) {
				String fileName = "用户账户统计信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
				Page<Account> page = consumeRecodBiz.findUserAccount(new Page<Account>(), account);

				new ExportExcel("账户信息统计数据", Account.class).setDataList(page.getList()).write(response, fileName)
						.dispose();
			}
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}
