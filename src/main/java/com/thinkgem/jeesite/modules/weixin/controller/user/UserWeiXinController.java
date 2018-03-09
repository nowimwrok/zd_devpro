/**
 *
 */
package com.thinkgem.jeesite.modules.weixin.controller.user;

import com.alibaba.druid.stat.TableStat.Mode;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.dao.UserinfoDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.security.UsernamePasswordToken;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 微信信息大厅Controller
 *
 * @author fjc
 * @version 2016-08-22
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/user")
public class UserWeiXinController extends BaseController {

	@Autowired
	private UserinfoDao userinfoDao;

	@Autowired
	private UserBiz userBiz;

	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;
	
	@Autowired
    private WlptUserService wlptUserService;
	
	
	@Autowired
	private MetroCardBiz metroCardBiz;

	/**  
	 * 去个人中心
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "userHome", "" })
	public String bids_hall( Model model,String openID) {
		User user = UserUtils.findUser(UserUtils.getUser());
		if(user!=null&& user.getUserinfo()!=null&&!Tools.IsNullOrWhiteSpace(user.getUserinfo().getOpenid())){
			model.addAttribute("user", user);
			return "modules/wx_front/home/userHome";
		}
		if(!Tools.IsNullOrWhiteSpace(openID)){
			model.addAttribute("openID",openID);
		}
		return "modules/wx_front/user/login";
	}

	/**
	 * 去登陆页
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @returne
	 */
	@RequestMapping(value = { "tologin", "" })
	public String toLogin( Model model,String openID) {
		
		User user = UserUtils.getUser();
		if(user !=null && !Tools.IsNullOrWhiteSpace(user.getId())){
			user=UserUtils.findUser(UserUtils.getUser());
		}
		/*
		 * UserWeiXin userInfo = OAuthService.getUserInfoOauth("",
		 * user.getUserinfo().getOpenid());
		 */
		if (user != null&&user.getUserinfo()!=null&&user.getUserinfo().getOpenid()!=null) {
			model.addAttribute("openID", user.getUserinfo().getOpenid());
		}
		if(!Tools.IsNullOrWhiteSpace(openID)){
			model.addAttribute("openID",openID);
		}
		return "modules/wx_front/user/login";
	}

	/**
	 * 更换登陆页
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "changeLogin", "" })
	public String changeLogin(Model model) {
		User user = UserUtils.getByCondition(UserUtils.getUser());
		/*
		 * UserWeiXin userInfo = OAuthService.getUserInfoOauth("",
		 * user.getUserinfo().getOpenid());
		 */
		
		if (user != null&&user.getUserinfo()!=null&&user.getUserinfo().getOpenid()!=null) {
			model.addAttribute("openID", user.getUserinfo().getOpenid());
		}
		/*// 清除之前用户緩存
		UserUtils.clearCache();*/
		return "modules/wx_front/user/login";
	}

	/**
	 * 注册-选择用户类型
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "chooseusertype", "" })
	public String chooseUserType(HttpServletRequest request,Model model) {
		String openId = request.getParameter("openID");
		model.addAttribute("openId", openId);
		return "modules/wx_front/user/chooseusertype";
	}

	/**
	 * 注册-去注册页
	 * 
	 * @param request
	 * @param response 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toregister", "" })
	public String toRegister(HttpServletRequest request, HttpServletResponse response, Model model) {
		String openId = request.getParameter("openId");
		String userType = request.getParameter("type");// 用户类型
		model.addAttribute("openID", openId);
		model.addAttribute("type", userType);
		return "modules/wx_front/user/register";
	}

	/**
	 * 发送注册验证码
	 * 
	 * @param phone
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "sendRegCode", "" })
	public Object sendRegCode(String phone, HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		int state = DataDic.RETURN_STATUS_NORMAL;
		if (!userBiz.sendRegCode(phone)) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
		}
		map.put("state", state);
		return map;
	}

	/**
	 * 验证手机号
	 * 
	 * @param phone
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "checkPhone", "" })
	public Boolean checkPhone(String phone, HttpServletRequest request, HttpServletResponse response, Model model) {
		return userBiz.checkPhone(phone);
	}

	/**
	 * 验证登陆名
	 * 
	 * @param loginName
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "checkLoginName", "" })
	public Boolean checkLoginName(String loginName, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		return userBiz.checkLoginName(loginName);
	}

	/**
	 * 注册用户
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = { "registeruser", "" })
	public Object registerUser(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User uc = new User();
		uc.setPhone(user.getPhone());
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "注册成功";
		int result = SmsUtil.judgeSmsVerCode(user.getPhone(), request.getParameter("SmsCode"),
				Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
		if (result != 1) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "验证码与手机不匹配";

		}
		if (!beanValidator(model, user)) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
		}
		if (user.getRole() == null) {// 判断用户是否选择角色
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "未选择用户角色";
		} else if (UserUtils.getByCondition(uc) != null) {/// 判断用户是否存在
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "用户已存在";
		}
		if (StringUtils.isNotBlank(user.getNewPassword())) {/// 判断密码
			user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
		} else {
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "请填写密码";
		}
		if (state == DataDic.RETURN_STATUS_NORMAL) {
			if (user.getLoginName() == null) {
				user.setLoginName(user.getPhone());
			}
			userBiz.registerUser(user);// 注册用户
		}
		map.put("state", state);
		map.put("message", message);
		return map;
	}

	/**
	 * 用户登陆
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	/*@ResponseBody*/
	@RequestMapping(value = { "loginuser", "" })
	public String loginuser(User user,String openid,Model model) {

		Map<String, Object> map = new HashMap<String, Object>();

		String loginName = user.getLoginName();// 登陆名
		String passWord = user.getPassword();// 密码
		String openId = openid;// openid
		int state = DataDic.RETURN_STATUS_NORMAL;
		User u = new User();
		u.setSearchinfo(loginName);
		user = UserUtils.getByCondition(u);// 根据用户名查询用户信息
		String message = "登录成功";
		if (user == null) {
			message = "用户名或密码错误";
			state = DataDic.RETURN_STATUS_INFOBUG;
		}
		if(!StringUtils.isNoneBlank(passWord)){
			message = "用户名或密码错误";
			state = DataDic.RETURN_STATUS_INFOBUG;
		}else if (user != null && !SystemService.validatePassword(passWord, user.getPassword())) {
			message = "用户名或密码错误";
			state = DataDic.RETURN_STATUS_AUTHBUG;
		}
		if (state == DataDic.RETURN_STATUS_NORMAL) {
			Boolean deOpenId = userBiz.deleteOpenId(openId);// 清空openid后
			if (deOpenId) {
				Userinfo userinfo = new Userinfo();
				userinfo.setId(user.getUserinfo().getId());
				userinfo.setOpenid(openId);
				userinfo.preUpdate();
				userinfoDao.update(userinfo);// 更新用户的openid
				wlptUserService.updateplainpwd(passWord, user.getId());//保存明文密码，用于微信绑定自动登录
				// 清除之前用户緩存
				UserUtils.clearCache();
				
				//记录登录
		        UserStatistics statistics = new UserStatistics();
		        statistics.setAccruelogincount("1");
		        statistics.setUser(user);
		        UserUtils.userDataSourceCount(statistics);
				// 自定义登录
				// 创建用户名和密码的令牌
				UsernamePasswordToken token = new UsernamePasswordToken(loginName, passWord.toCharArray(), false, "",
						"", false);
				// 记录该令牌，如果不记录则类似购物车功能不能使用。
				token.setRememberMe(true);
				// subject理解成权限对象。类似user
				Subject subject = SecurityUtils.getSubject();
				subject.login(token); // 保存登录	
				}

		}
		
		/*return state;*/
		if(state==1){
			return bids_hall( model,"");
		}
		model.addAttribute("message", message);
		model.addAttribute("state", state);
		model.addAttribute("user", user);
		return toLogin( model,openId);
	}

	/**
	 * 修改密码
	 * 
	 * @return
	 */
	@RequestMapping(value = { "changepassword", "" })
	public String changepassword() {
		return "modules/wx_front/user/changepassword";
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
	@RequestMapping(value = "changePwd")
	public Object changePwd(String oldpassword, String password, String confirmpwd, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		// 处理密码修改
		return userBiz.changePwd(oldpassword, password, confirmpwd);
	}

	/**
	 * 去账户余额
	 * 
	 * @return
	 */
	@RequestMapping(value = { "toAccountBalance", "" })
	public String toAccountBalance(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.findUser(UserUtils.getUser());
		model.addAttribute("user", user);
		return "modules/wx_front/pay/accountBalance";
	}

	/**
	 * 去账户提现
	 * 
	 * @return
	 */
	@RequestMapping(value = { "toAccountCash", "" })
	public String toAccountCash(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.findUser(UserUtils.getUser());
		UserBankinfo userBankInfo=userBiz.getUserBankInfo(user);
		if(userBankInfo!=null){
			userBankInfo.setCard(userBankInfo.getBankcard().substring(0, 4)+" **** **** "+userBankInfo.getBankcard().substring(userBankInfo.getBankcard().length()-4, userBankInfo.getBankcard().length()));
		}
		user.setBankinfo(userBankInfo);
		model.addAttribute("user", user);
		return "modules/wx_front/pay/cash";
	}

//	/**
//	 * 申请提现
//	 * 
//	 * @param passWord
//	 * @param cashMoney
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @param redirectAttributes
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value = { "accountCash", "" })
//	public Object accountCash(String passWord, String cashMoney) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		int state = DataDic.RETURN_STATUS_NORMAL;
//    	String message = "";
//
//		UserBankinfo userbank=new UserBankinfo();
//		userbank.setUser(UserUtils.getUser());	
//		userbank = userBiz.getUserBankInfo(userbank);
//		
//		if(passWord==null||cashMoney==null){
//			state = DataDic.RETURN_STATUS_AUTHBUG;
//			message = "信息缺失";
//		}
//		if(UserUtils.getUser().getId()==null){
//			state = DataDic.RETURN_STATUS_AUTHBUG;
//			message = "登陆失效,请重新登陆";
//		}
//		if(userbank==null){
//			state = DataDic.RETURN_STATUS_AUTHBUG;
//			message = "请先去绑定银行卡信息";
//		}
//		if(state==DataDic.RETURN_STATUS_NORMAL){
//			
//			Consumerecod accountCode = new Consumerecod();
//			accountCode.setCashpassword(passWord);
//			accountCode.setConsumemony(cashMoney);
//			state=consumeRecodBiz.chashConsumeCodesBiz(accountCode);
//			if(state==2){
//				message = "信息缺失";
//			}else if(state==4){
//				message = "提现密码错误";
//			}else if(state==5){
//				message = "您的账户余额不足";
//			}
//		}
//		map.put("state", state);
//		map.put("message", message);
//		return map;
//	}
	
	/**
	 * 申请提现
	 * 
	 * @param passWord
	 * @param cashMoney
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "accountCash", "" })
	public Object accountCash(String bankid,String passWord, String cashMoney,String payway) {
		Map<String, Object> map = new HashMap<String, Object>();
		int state = DataDic.RETURN_STATUS_NORMAL;
    	String message = "";

		UserBankinfo userbank = userBiz.getBankById(bankid);
		
		if(passWord==null||cashMoney==null){
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "信息缺失";
		}
		if(UserUtils.getUser().getId()==null){
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "登陆失效,请重新登陆";
		}
		if(userbank==null){
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "请先去绑定银行卡信息";
		}
		if(state==DataDic.RETURN_STATUS_NORMAL){
			
			Consumerecod accountCode = new Consumerecod();
			accountCode.setCashpassword(passWord);
			accountCode.setConsumemony(cashMoney);
			accountCode.setUserBankinfo(userbank);
			accountCode.setConsumeway(payway);
			state=consumeRecodBiz.chashConsumeCodesBiz(accountCode);
			if(state==2){
				message = "信息缺失";
			}else if(state==4){
				message = "提现密码错误";
			}else if(state==5){
				message = "您的账户余额不足";
			}else if(state==8){
				message = "提现金额大于单笔交易最高限额";
			}
			else if(state==10){
				message = "电子钱包最低留存额度不足";
			}else if(state==11){
				message = "提现金额大于单日交易最高限额";
			}else if(state==12){
				message = "提现金额大于单日累计提现限额";
			}else if(state==-1){
				message = "账户系统异常";
			}else if(state==7){
				message = "操作频繁";
			}
		}
		map.put("state", state);
		map.put("message", message);
		return map;
	}

	/**
	 * 提现记录列表
	 * 
	 * @param consumerecod
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getCashList")
	public Object getCashList(Consumerecod consumerecod, int pageNo, int pageSize, Model model) {
		Page<Consumerecod> pg = new Page<>();
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		Page<Consumerecod> page = consumeRecodBiz.cashListFindPage(pg, consumerecod);
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/**
	 * 去账户充值
	 * 
	 * @return
	 */
	@RequestMapping(value = { "toAccountPay", "" })
	public String toAccountPay(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user =UserUtils.findUser(UserUtils.getUser());
		model.addAttribute("user", user);
		return "modules/wx_front/pay/pay";
	}

	/**
	 * 去用户编辑个人信息
	 * 
	 * @return
	 */
	@RequestMapping(value = { "toEditUserInfo", "" })
	public String toEditUserInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(UserUtils.getUser().getId()!=null){
			User user = UserUtils.findUser(UserUtils.getUser());
			model.addAttribute("user", user);
		}
		return "modules/wx_front/user/editpersonalinfo";
	}

	/**
	 * 编辑个人信息
	 * 
	 * @param userinfo
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "editUserInfo", "" })
	public Object editUserInfo(Userinfo userinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Boolean result = false;
		Map<String, Object> map = new HashMap<String, Object>();
		userinfo = userBiz.editUserInfo(userinfo);
		if (userinfo != null) {
			result = true;
		}
		map.put("result", result);
		return map;
	}
	
	 /**
     * 忘记会员密码
     * @param user
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"resetpassword", ""})
    public String resetpassword( User user,HttpServletRequest request, HttpServletResponse response, Model model) {
        user = new User();
        model.addAttribute("user", user);
        return "modules/wx_front/user/resetpassword";
    }
	
	/**
     * 忘记会员密码
     * @param user
     * @param oldpassword
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "resetpwd")
    public Object resetpwd(String phone,String password,String repassword, HttpServletRequest request, HttpServletResponse response,Model model) {
    	User us= UserUtils.getByPhone(phone);
    	int state = DataDic.RETURN_STATUS_NORMAL;
    	String message = "修改成功";
    	if(us!=null){
    		if(password.equals(repassword)){
    			wlptUserService.updatePasswordById(us.getId(),password);
    			message = "修改成功";
    		}else{
    			state = DataDic.RETURN_STATUS_INFOBUG;
    			message ="两次密码不一致";
    		}
    		
    	}else{
    		state = DataDic.RETURN_STATUS_AUTHBUG;
    		message ="手机号码错误";
    	}
    	
    	return this.getMapResult(state,message,us);
    }
    
	/**
	 * 查询是否绑定银行卡
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "isBindingBankCard", "" })
	public Object isBindingBankCard(Model model) {
		Boolean result = false;
		Map<String, Object> map = new HashMap<String, Object>();
		UserBankinfo userbank=new UserBankinfo();
		userbank.setUser(UserUtils.getUser());	
		userbank = userBiz.getUserBankInfo(userbank);
		if (userbank != null) {
			result = true;
		}
		map.put("result", result);
		return map;
	}
	
    /**
	 * 验证提现密码
	 * 
	 * @param cashpassword
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkCashPwdbyCash")
	public Object checkCashPwdbyCash(String cashpassword) {
		return userBiz.checkCashPwdbyCash(cashpassword);
	}
	
	
	/**
     * 去转账页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toTransfer")
    public String toTransfer(Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        model.addAttribute("user", user);
        return "modules/wx_front/pay/transfer";
        
    }

    /**
     * 转账
     *
     * @param consumerecod
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "transfer")
    public Object transfer(Consumerecod consumerecod,String payway,Model model){
    	User target = UserUtils.findUser(consumerecod.getTarget());
    	if(target==null||UserUtils.getUser().getId()==null){
    		return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
    	}
    	if(UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE)||
    			UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_CAROWNER)||
    			UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
                UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)){
    		String accountid=UserUtils.getUser().getId();
        	String targetid=target.getId();
        	double consumemony=Double.parseDouble(consumerecod.getConsumemony());
        	int result=consumeRecodBiz.transferBiz(accountid,consumemony,targetid,payway);
        	return new JSONPObject("callback", result);
    	}else{
    		return new JSONPObject("callback", 3);
    	}
    	
    }
	
	
    /***
     * 卓币转账
     *
     * @param consumerecod
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "transferCoin")
    public Object transferCoin(Consumerecod consumerecod, Model model) {
        User target = UserUtils.findUser(consumerecod.getTarget());
        if (target == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }

        if (target.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
        		target.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
        		target.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
        		target.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
        	String accountid = UserUtils.getUser().getId();
            String targetid = target.getId();
            double consumemony = Double.parseDouble(consumerecod.getConsumemony());
            int result = consumeRecodBiz.transferCoinBiz(accountid, consumemony, targetid);
            return new JSONPObject("callback", result);
        } else {
            return new JSONPObject("callback", 3);
        }
    }

    /**
     * 去卓币转账页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toTransferCoin")
    public String toTransferCoin(Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        model.addAttribute("user", user);
        return "modules/wx_front/pay/transfer_coin";
    }
    
    /**
     * 去油气转账页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toTransferpetro")
    public String toTransferpetro(Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        model.addAttribute("user", user);
        return "modules/wx_front/pay/transfer_petro";
    }
    /***
     * 油气转账
     *
     * @param consumerecod
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "transferPetro")
    public Object transferPetro(Consumerecod consumerecod, Model model) {
        User target = UserUtils.findUser(consumerecod.getTarget());
        if (target == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }
        if (target.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
        		target.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
        		target.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
        		target.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
        	String accountid = UserUtils.getUser().getId();
            String targetid = target.getId();
            double consumemony = Double.parseDouble(consumerecod.getConsumemony());
            int result = consumeRecodBiz.transferPetroBiz(accountid, consumemony, targetid);
            return new JSONPObject("callback", result);
        } else {
            return new JSONPObject("callback", 3);
        }
    }
	
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
		return "modules/wx_front/user/applycard";
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
		return "modules/wx_front/user/losscard";
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
		return "modules/wx_front/user/updatecardpassword";
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
	
	

	/**
	 * 修改支付密码
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
		return "modules/wx_front/user/updatecashpassword";
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
	public Object saveCashPass(Userinfo userinfo,String recashpassword, HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String msgs = "修改支付密码成功";
		if (!StringUtils.isNotBlank(recashpassword)||!StringUtils.isNotBlank(userinfo.getCashpassword())) {
			state = DataDic.RETURN_STATUS_SYSBUG;
			msgs = "信息缺失";
			return this.getMapResult(state, msgs, null);
		}
		if(!userinfo.getCashpassword().equals(recashpassword)){
			state = DataDic.RETURN_STATUS_SYSBUG;
			msgs = "两次密码不一致";
			return this.getMapResult(state, msgs, null);
		}
		
		// 修改提现密码
		msgs = userBiz.modifyPwd(userinfo.getCashpassword());
		return this.getMapResult(state, msgs, null);
	}

	
}