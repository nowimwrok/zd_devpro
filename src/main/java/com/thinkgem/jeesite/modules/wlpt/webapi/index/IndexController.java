package com.thinkgem.jeesite.modules.wlpt.webapi.index;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.WebUtils;
import org.codehaus.jackson.map.util.JSONPObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.security.shiro.session.SessionDAO;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.CookieUtils;
import com.thinkgem.jeesite.common.utils.PageData;
import com.thinkgem.jeesite.common.utils.SimpleMailSender;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.thinkgem.jeesite.modules.sys.security.UsernamePasswordToken;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserStatisticsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseAdvertisement;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseFeedback;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.security.FrontFormAuthenticationFilter;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseAdvertisementService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseFeedbackService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * IndexController
 * @author 王铸
 * @version 2016-08-06
 */
@Controller
@RequestMapping(value = "${frontPath}")
public class IndexController extends BaseController{
	
	protected Logger logger = LoggerFactory.getLogger(getClass());
	//广告
	@Autowired
	private BaseAdvertisementService baseAdvertisementService;
	@Autowired
	private BaseFeedbackService baseFeedbackService;
	@Autowired
	private SessionDAO sessionDAO;
	@Autowired
    private WlptUserService wlptUserService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private UserStatisticsBiz userStatisticsBiz;
	 
	@ModelAttribute
    public User get(@RequestParam(required = false) String id) {
        User entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = wlptUserService.get(id);
        }
        if (entity == null) {
            entity = new User();
        }
        return entity;
    }


	@RequestMapping(value="home_index")
	public String home_index(Model model,HttpServletRequest req,HttpServletResponse res) {
		/*String rememberUrl=(String) req.getSession().getAttribute("return_url");
		if(rememberUrl!=null){
			model.addAttribute("page_url", rememberUrl);
			return "modules/wlpt_front/admin/redirect";
		}*/
		UserStatistics userStatistics=new UserStatistics();
		User user = UserUtils.getUser();
        if (user.getId() != null){
    		userStatistics.setUser(user);
    		userStatistics=userStatisticsBiz.getConditon(userStatistics);
        }
        req.setAttribute("statistics", userStatistics);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/hall/home_index";
	}
	@RequestMapping(value="demo_index")
	public String demo_index(Model model,HttpServletRequest req,HttpServletResponse res) {
		/*String rememberUrl=(String) req.getSession().getAttribute("return_url");
		if(rememberUrl!=null){
			model.addAttribute("page_url", rememberUrl);
			return "modules/wlpt_front/admin/redirect";
		}*/
		UserStatistics userStatistics=new UserStatistics();
		User user = UserUtils.getUser();
		if (user.getId() != null){
			userStatistics.setUser(user);
			userStatistics=userStatisticsBiz.getConditon(userStatistics);
		}
		req.setAttribute("statistics", userStatistics);

		return "modules/wlpt_front/themes/demo/home_index";
	}

	@RequestMapping(value="goods_add")
	public String goods_add(Model model,HttpServletRequest req,HttpServletResponse res) {

		return "modules/wlpt_front/themes/demo/goods_add";
	}
	@RequestMapping(value="goods_list")
	public String goods_list(HttpServletRequest request, HttpServletResponse response, Model model,String isRedrect) {
		model.addAttribute("user", UserUtils.getUser());
        model.addAttribute("isRedrect", isRedrect);
        if(isRedrect == null || isRedrect ==""){        	
        	Cookie[] cookies = request.getCookies();
        	for(Cookie c :cookies){
        		if(c.getName().equals("goods_tradestatus") ||c.getName().equals("goods_fromprovince")
        				|| c.getName().equals("goods_fromcity") || c.getName().equals("goods_fromdistrict")
        				|| c.getName().equals("goods_toprovince") || c.getName().equals("goods_tocity") || c.getName().equals("goods_todistrict")){
        			c.setValue(null);
        			response.addCookie(c);
        		}
        	}
        }
        return "modules/user_front/goods/goods_list";
	}
	@RequestMapping(value="order_det")
	public String order_det(Model model,HttpServletRequest req,HttpServletResponse res) {

		return "modules/wlpt_front/themes/demo/order_detail";
	}
	@RequestMapping(value="goods_quotelist")
	public String goods_quotelist(Model model,HttpServletRequest req,HttpServletResponse res) {

		return "modules/wlpt_front/themes/demo/goods_quotelist";
	}
	@RequestMapping(value="create_order")
	public String create_order(Model model,HttpServletRequest req,HttpServletResponse res) {

		return "modules/wlpt_front/themes/demo/create_order";
	}
	@RequestMapping(value="user_wallet")
	public String user_wallet(Model model,HttpServletRequest req,HttpServletResponse res) {

		return "modules/wlpt_front/themes/demo/user_wallet";
	}
	/*
	 * 登录成功url跳转控制
	 * 
	 * 
	 * */
	
	@RequestMapping(value="loginSuccess")
	public String toOldURL(Model model,HttpServletRequest req,HttpServletResponse res) {
		String rememberUrl=(String) req.getSession().getAttribute("return_url");
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		/*if(rememberUrl!=null){
			model.addAttribute("page_url", rememberUrl);
			return "modules/wlpt_front/admin/redirect";    
		}*/
		return "modules/wlpt_front/hall/home_default";
		/*return "modules/wlpt_front/themes/basic/layouts/default_targ";*/
	}

	/**
	 * 获取数据字典数据
	 * @param type
	 * @param model
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "getDictListJson")
	public Object getDictListJson(String type, Model model) {
		return DictUtils.getDictList(type);
	}
	
	/**
	 *  显示首页
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping
	public String index(Model model) {
		List<BaseAdvertisement> varlist =baseAdvertisementService.getAdvertisementList("wlpt_index");
		//获取广告信息
		model.addAttribute("adverlist",varlist );
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/admin/index";
	}

	@RequestMapping(value = "/wlpt/solution")
	public String solution(Model model) {
		List<BaseAdvertisement> varlist =baseAdvertisementService.getAdvertisementList("wlpt_index");
		//获取广告信息
		model.addAttribute("adverlist",varlist );
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/hall/new_solution";
	}
	@RequestMapping(value = "/wlpt/about")
	public String about(Model model) {
		List<BaseAdvertisement> varlist =baseAdvertisementService.getAdvertisementList("wlpt_index");
		//获取广告信息
		model.addAttribute("adverlist",varlist );
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/hall/new_about";
	}
	@RequestMapping(value = "/wlpt/shop")
	public String shop(Model model) {
		List<BaseAdvertisement> varlist =baseAdvertisementService.getAdvertisementList("wlpt_index");
		//获取广告信息
		model.addAttribute("adverlist",varlist );
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/hall/new_shop";
	}

	/**
	 * 到意见反馈
	 * 
	 * @return
	 */
	@RequestMapping(value = "/wlpt/feedBack")
	public String feedBack(Model model) {
          return "modules/wlpt_front/admin/feedback";
	}
	
	/**
	 * 意见反馈
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/wlpt/doFeedBack")
	public Object doFeedBack(BaseFeedback baseFeedback,HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) {
		baseFeedback.setFeedbackId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
		baseFeedback.setCreatetime(new Date());
		baseFeedback.setScantype("1");
		String result="";
		try {
			baseFeedbackService.save(baseFeedback);
			SimpleMailSender mail = new SimpleMailSender();
			mail.batchSendMail(UserUtils.getUser().getPhone()+"用户在网页发来反馈信息:", "反馈信息:"+baseFeedback.getContent(), "1",
					this.getInterfaceConfig("SMSMailDestination",session), this.getInterfaceConfig("SMSMailSwitch",session), 0);
			result="反馈成功";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("result", result);
		return new JSONPObject("callback", result);
	}
	public String getInterfaceConfig(String code,HttpSession session) throws Exception {
		ServletContext application = session.getServletContext();
		List<PageData> interfaceconfigList = (List<PageData>) application
				.getAttribute("InterfaceconfigList");
		if (interfaceconfigList != null) {
			for (PageData interfaceconfig : interfaceconfigList) {
				if (interfaceconfig.getString("CODE").equalsIgnoreCase(code))
					return interfaceconfig.getString("CONFIG");
			}
		}
		return "";
	}
	
	/**
	 * 卓大商场
	 * 
	 * @return
	 */
	@RequestMapping(value = "/wlpt/toshop")
	public String toshop(Model model) {
		User user=UserUtils.getUser();
		String flag="";
		if(user.getId()==null){
			flag="flag";
			model.addAttribute("flag",flag);
			model.addAttribute("user",user);
		}else{
			model.addAttribute("flag",flag);
			User newuser = UserUtils.findUser(user);
			model.addAttribute("user",newuser);
		}
		
		
//        return "modules/wlpt_front/shop/shopIndex";
		return "modules/wlpt_front/admin/shop";
	}
	

	/**
	 * 注册页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/wlpt/register")
	public String register(Role role, Model model,HttpServletRequest req) {
		role.setEnname(req.getParameter("ename"));
    	model.addAttribute("role", role);
        return "modules/wlpt_front/admin/register";
	}
	
	/**
	 * 注册页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String toRegister( Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/admin/login";
	}
	
	
	
	/**
	 *  前台登录入口
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();
		//UserUtils.clearCache();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		String isLogin=request.getParameter("login");
		if (logger.isDebugEnabled()){
			logger.debug("login, active session size: {}", sessionDAO.getActiveSessions(false).size());
		}
		
		// 如果已登录，再次访问主页，则退出原账号。
		if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex"))){
			CookieUtils.setCookie(response, "LOGINED", "false");
		}
		
		// 如果已经登录，则跳转到管理首页
		if(principal != null && !principal.isMobileLogin()){
			return "redirect:"+frontPath;
		}
		if(isLogin!=null){
			model.addAttribute("login", isLogin);
		}
		return "modules/wlpt_front/admin/login";
	}
	
	/**
	 * 登录失败，真正登录的POST请求由Filter完成
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginFail(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		// 如果已经登录，则跳转到管理首页
		if(principal != null){
			return "redirect:"+frontPath;
		}
		
		String username = WebUtils.getCleanParam(request, FrontFormAuthenticationFilter.DEFAULT_USERNAME_PARAM);
		boolean rememberMe = WebUtils.isTrue(request, FrontFormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM);
		boolean mobile = WebUtils.isTrue(request, FrontFormAuthenticationFilter.DEFAULT_MOBILE_PARAM);
		String exception = (String)request.getAttribute(FrontFormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
		String message = (String)request.getAttribute(FrontFormAuthenticationFilter.DEFAULT_MESSAGE_PARAM);
		if (StringUtils.isBlank(message) || StringUtils.equals(message, "null")){
			message = "用户或密码错误, 请重试.";
		}
		model.addAttribute(FrontFormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
		model.addAttribute(FrontFormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM, rememberMe);
		model.addAttribute(FrontFormAuthenticationFilter.DEFAULT_MOBILE_PARAM, mobile);
		model.addAttribute(FrontFormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME, exception);
		model.addAttribute(FrontFormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
		
		if (logger.isDebugEnabled()){
			logger.debug("login fail, active session size: {}, message: {}, exception: {}", 
					sessionDAO.getActiveSessions(false).size(), message, exception);
		}
		return "modules/wlpt_front/admin/login";
	}
	
	
	/* *//***
     * 注册
     *
     * @param user
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value ="register", method = RequestMethod.POST)
    public String registerSaveAll(User user, HttpServletRequest request, HttpServletResponse response, Model model,String phone, String regcode) {
    	int result=-1; 
    	if(phone!=null&&regcode!=null){
    	     result = SmsUtil.judgeSmsVerCode(phone, regcode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
    	 }
    	 if (result == -1) {
        	 String message="请输入验证码";
        	 model.addAttribute("message", message);
        	 return "modules/wlpt_front/admin/register";
         }else if (result == 0) {
        	 String message="验证码与手机不匹配,请再试";
        	 model.addAttribute("message", message);
        	 return "modules/wlpt_front/admin/register";
         }else if (result == 2) {
        	 String message="验证码超时";
        	 model.addAttribute("message", message);
        	 return "modules/wlpt_front/admin/register";
         }else if(result == 3){
        	 String message="发生错误，请再试";
        	 model.addAttribute("message", message);
        	 return "modules/wlpt_front/admin/register";
         }
        if (!beanValidator(model, user)) {
            return register(user.getRole(), model,request);
        }
        if (user.getRole() == null) {//判断用户是否选择角色
            model.addAttribute("message", "未选择用户角色");
            return register(user.getRole(), model,request);
        }else if (systemService.getSysUserByPhone(user.getPhone())>0){///判断用户是否存在
            model.addAttribute("message", "用户已存在");
            return "modules/wlpt_front/admin/per_index";
        }
        if (StringUtils.isNotBlank(user.getNewPassword())) {///判断密码
            user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
        }else{
            model.addAttribute("message", "请填写密码");
            return register(user.getRole(), model,request);
        }
        String enname=request.getParameter("role");
        if(!StringUtils.isNotBlank(user.getLoginName())){
        	user.setLoginName(user.getPhone());
        }
        
        if(enname!=null){
        user.getRole().setEnname(enname);
        }
        wlptUserService.registerSave(user);
      //清除緩存
    	UserUtils.clearCache();
    	
    	//自定义登录
    	//创建用户名和密码的令牌 
        UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginName(),user.getNewPassword().toCharArray(), false, "", "", false); 
        //记录该令牌，如果不记录则类似购物车功能不能使用。 
        token.setRememberMe(true); 
        //subject理解成权限对象。类似user
        Subject subject = SecurityUtils.getSubject();
        subject.login(token); //保存登录
        UserUtils.putCache(UserUtils.USER_CACHE, user);
        return "modules/wlpt_front/hall/home_default";
    }

    /***
     * 验证登录名
     *
     * @param oldLoginName
     * @param loginName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "checkLoginName")
    public String checkLoginName(String oldLoginName, String loginName) {

        if (loginName != null && loginName.equals(oldLoginName)) {
            return "true";
        } else if (loginName != null && systemService.getUserByLoginName(loginName) == null) {
            return "true";
        }
        return "false";
    }

    /***
     * 验证手机号码唯一性
     *
     * @param phone
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "checkPhone")
    public String checkPhone(String phone) {

        if (phone != null && systemService.getUserByPhone(phone) == null) {
            return "true";
        }
        return "false";
    }


    /***
     * 发送验证码
     * @param phone 手机号码
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "sendRegCode")
    public String checkRegCode(String phone) {
        if ("".equals(phone) || phone==null){
            return "false";
        }else if (systemService.getUserByPhone(phone)!=null){
            return "false";
        }
        String tempSmsCode = String.valueOf(Tools.getRandomNum()); //获取验证码
        System.out.println(tempSmsCode);
        String[] keyword = {tempSmsCode};
        int result=SmsUtil.sendSmsMesge(null, "registerSMS", phone, Const.System_Module_Enum.CeShi, Const.SMSFUN_REGCODE, keyword, null, null, true,SmsConfig.smsValidateCode);
        if (result == 1) {
            return "true";
        }
        return "false";
    }

    /**
     * 验证注册验证码
     *
     * @param phone   注册手机号码
     * @param regcode 短信验证码
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "checkRegCode")
    public String checkRegCode(String phone, String regcode) {
        if(regcode.length()<6){
        	return "false";
        }
        int result = SmsUtil.judgeSmsVerCode(phone, regcode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);

        if (result == 1) {
            return "true";
        }
        return "false";
    }
	
	
}
