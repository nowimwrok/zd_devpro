/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.security.shiro.session.SessionDAO;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.security.UsernamePasswordToken;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * 用户表Controller
 *
 * @author 饶江龙
 * @version 2016-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user")
public class WlptUserController extends BaseController {

    @Autowired
    private WlptUserService wlptUserService;
    @Autowired
    private SessionDAO sessionDAO;
    @Autowired
    private SystemService systemService;

    @Autowired
    private UserinfoService userinfoService;


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

    /***
     * 修改
     *
     * @param userinfo
     * @param model
     * @param redirectAttributes
     * @return
     */

    @RequestMapping(value = "save")
    public String save(Userinfo userinfo, Model model, RedirectAttributes redirectAttributes) {
        /*if (!beanValidator(model, userinfo)) {
            return form(userinfo, model);
        }*/
        wlptUserService.editUserInfo(userinfo);
        addMessage(redirectAttributes, "保存用户信息成功");
        return "redirect:" + Global.getAdminPath() + "/modules/sys/userInfo";
    }

    /***
     * 去修改页面
     *
     * @param userinfo
     * @param model
     * @return
     */

    @RequestMapping(value = "form")
    public String form(Userinfo userinfo, Model model) {
        User user = UserUtils.getUser();
        userinfo = wlptUserService.getUserInfo(user.getUserinfo().getId());
        model.addAttribute("Userinfo", userinfo);
        return "modules/wlpt/userinfo/userinfoForm";
    }

    /***
     * 注册
     *
     * @param user
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"registerSave", ""})
    public String registerSave(User user, HttpServletRequest request, HttpServletResponse response, Model model) {

        if (!beanValidator(model, user)) {
            return registerView(user.getRole(), model);
        }
        if (user.getRole() == null) {//判断用户是否选择角色
            model.addAttribute("message", "未选择用户角色");
            return registerView(user.getRole(), model);
        } else if (systemService.getSysUserByPhone(user.getPhone())>0) {///判断用户是否存在
            model.addAttribute("message", "用户已存在");
            return registerView(user.getRole(), model);
        }
        if (StringUtils.isNotBlank(user.getNewPassword())) {///判断密码
            user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
        } else {
            model.addAttribute("message", "请填写密码");
            return registerView(user.getRole(), model);
        }
        wlptUserService.registerSave(user);
        return "modules/wlpt/user/login";
    }

    /***
     * 注册
     *
     * @param user
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"registerSaveAll", ""})
    public String registerSaveAll(User user, HttpServletRequest request, HttpServletResponse response, Model model, String phone, String regcode) {
        int result = SmsUtil.judgeSmsVerCode(phone, regcode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
        if (result != 1) {
            String message = "验证码与手机不匹配";
            model.addAttribute("message", message);
            return "modules/wlpt_front/admin/register";
        }
        if (!beanValidator(model, user)) {
            return register(user.getRole(), model, request);
        }
        if (user.getRole() == null) {//判断用户是否选择角色
            model.addAttribute("message", "未选择用户角色");
            return register(user.getRole(), model, request);
        } else if (systemService.getSysUserByPhone(user.getPhone())>0) {///判断用户是否存在
            model.addAttribute("message", "用户已存在");
            return "modules/wlpt_front/admin/per_index";
        }
        if (StringUtils.isNotBlank(user.getNewPassword())) {///判断密码
            user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
        } else {
            model.addAttribute("message", "请填写密码");
            return register(user.getRole(), model, request);
        }
        String enname = request.getParameter("role");
        user.setLoginName(user.getPhone());
        if (enname != null) {
            user.getRole().setEnname(enname);
        }
        wlptUserService.registerSave(user);
        return "modules/wlpt_front/admin/per_index";
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
     * 发送验证码==发送注册验证码
     *
     * @param phone 手机号码
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "sendRegCode")
    public String checkRegCode(String phone,RedirectAttributes redirectAttributes) {
        if ("".equals(phone.trim()) || phone.trim() == null) {
            return "false";
        } else if (systemService.getUserByPhone(phone.trim()) != null) {
            return "false";
        }
        String tempSmsCode = String.valueOf(Tools.getRandomNum()); //获取验证码
        System.out.println(tempSmsCode);
        String[] keyword = {tempSmsCode};
        int result = SmsUtil.sendSmsMesge(null, "registerSMS", phone, Const.System_Module_Enum.CeShi, Const.SMSFUN_REGCODE, keyword, null, null, true, SmsConfig.smsValidateCode);
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
    	if ("".equals(phone.trim()) || phone.trim() == null) {
            return "false";
        }
    	if ("".equals(regcode.trim()) || regcode.trim() == null) {
            return "false";
        }
        int result = SmsUtil.judgeSmsVerCode(phone, regcode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);

        if (result == 1) {
            return "true";
        }
        return "false";
    }

    /***
     * 修改账户提现密码--支付秘密啊
     *
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @param model       对象
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "modifyCashPwd")
    public String modifyPwd(String oldPassword, String newPassword, Model model) {
        User user = UserUtils.getUser();
        Userinfo userinfo = user.getUserinfo();
        if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)) {
            if (Global.isDemoMode()) {
                model.addAttribute("message", "演示模式，不允许操作！");
                return "modules/wlpt/user/userModifyCashPwd";
            }
            if (userinfo == null || Tools.IsNullOrWhiteSpace(userinfo.getCashpassword())) {
                model.addAttribute("message", "请先绑定银行卡！");
                return "modules/wlpt/user/userModifyCashPwd";
            }
            if (SystemService.validatePassword(oldPassword, userinfo.getCashpassword())) {
                userinfoService.updateCashPwdById(userinfo.getId(), newPassword);
                model.addAttribute("message", "修改提现密码成功");
            } else {
                model.addAttribute("message", "修改提现密码失败，旧密码错误");
            }
        } else {
            model.addAttribute("message", "请填写修改信息");
        }
        model.addAttribute("userinfo", userinfo);
        return "modules/wlpt/user/userModifyCashPwd";
    }

    /***
     * 验证登录密码
     *
     * @param loginPwd
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "validateLoginPwd")
    public Boolean validateLoginPwd(String loginPwd) {
        ////获取当前数据库用户最新的信息
        Userinfo userinfo = wlptUserService.getUserInfo(UserUtils.getUser().getPassword());
        /***
         * 对比结果
         * iseq :true 相等
         * :false:不等
         */
        Boolean iseq = systemService.validatePassword(loginPwd, userinfo.getCashpassword());
        return iseq;
    }

    /****
     * 验证提现密码--支付密码
     *
     * @param cashPwd
     * @param isSave  是否是修改,如果是修改则验证支付密码
     *                如果是保存新增,则返回true
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "validateCashPwd")
    public Boolean validateCashPwd(String cashPwd, Boolean isSave) {
        if (isSave) {
            return true;
        }
        ////获取当前数据库用户最新的信息
        Userinfo userinfo = wlptUserService.getUserInfo(UserUtils.getUser().getUserinfo().getId());
        /***
         * 对比结果
         * iseq :true 相等
         * :false:不等
         */
        Boolean iseq = true;
        if(StringUtils.isNotBlank(userinfo.getCashpassword())){
        	iseq = systemService.validatePassword(cashPwd, userinfo.getCashpassword());
        }else{
        	iseq=false;
        }
        return iseq;
    }

    /**
     * 校验子帐户的支付密码
     * @param cashPwd
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "vadChildCashPwd")
    public Boolean vadChildCashPwd(String cashPwd) {
        User user=UserUtils.getUser();
        Userinfo userinfo=new Userinfo();
        ///是否是子帐户
        if (user.getIschild()){
            userinfo=user.getChildUser().getUserinfo();
        }else{
            userinfo= wlptUserService.getUserInfo(UserUtils.getUser().getUserinfo().getId());
        }
        /***
         * 对比结果
         * iseq :true 相等
         * :false:不等
         */
        Boolean iseq = true;
        if(StringUtils.isNotBlank(userinfo.getCashpassword())){
            iseq = systemService.validatePassword(cashPwd, userinfo.getCashpassword());
        }else{
            iseq=false;
        }
        return iseq;
    }

    /***
     * 去注册页面
     *
     * @param role  角色编码
     * @param model
     * @return
     */
    @RequestMapping(value = {"registerView", ""})
    public String registerView(Role role, Model model) {
        model.addAttribute("role", role);
        return "modules/wlpt/user/registerView";
    }

    /***
     * 去首页注册页面
     *
     * @param role  角色编码
     * @param model
     * @return
     */
    @RequestMapping(value = {"toRegister", ""})
    public String register(Role role, Model model, HttpServletRequest req) {
        role.setEnname(req.getParameter("ename"));
        model.addAttribute("role", role);
        return "modules/wlpt_front/admin/register";
    }


    /***
     * 主页登录
     *
     * @param role  角色编码
     * @param model
     * @return
     */
    @RequestMapping(value = {"login", ""}, method = RequestMethod.POST)
    public String login(Model model, HttpServletRequest req, HttpServletResponse response) {
        String loginName = req.getParameter("username");
        String password = req.getParameter("password");
        if (password != null) {
            password = password.trim();
        }
        
        User user = new User();
        user = UserUtils.getByLoginName(loginName);
        String message = "登录成功";
        if (user == null) {
            message = "用户名不存在";
            model.addAttribute("message", message);
            return "modules/wlpt_front/admin/login";
        } else {
            if (!SystemService.validatePassword(password, user.getPassword())) {
                message = "密码不正确";
                model.addAttribute("message", message);
                return "modules/wlpt_front/admin/login";
            }
        }
        //清除緩存
        UserUtils.clearCache();

        //记录登录
        UserStatistics statistics = new UserStatistics();
        statistics.setAccruelogincount("1");
        statistics.setUser(user);
        UserUtils.userDataSourceCount(statistics);
        //自定义登录
        //创建用户名和密码的令牌
        UsernamePasswordToken token = new UsernamePasswordToken(loginName, password.toCharArray(), false, "", "", false);
        //记录该令牌，如果不记录则类似购物车功能不能使用。 
        token.setRememberMe(true);
        //subject理解成权限对象。类似user
        Subject subject = SecurityUtils.getSubject();
        subject.login(token); //保存登录
        UserUtils.putCache(UserUtils.USER_CACHE, user);

        return "modules/wlpt_front/admin/per_index";
    }

    /***
     * 退出登录
     *
     * @param role  角色编码
     * @param model
     * @return
     */
    @RequestMapping(value = {"registerDown", ""})
    public String registerDown(Model model, HttpServletRequest req, HttpServletResponse res) {
        //清除緩存
        UserUtils.clearCache();
        UserUtils.removeCache(UserUtils.USER_CACHE);
        return "modules/wlpt_front/admin/unlogin";
    }

    /***
     * 跳转到主页登录页面
     *
     * @param role  角色编码
     * @param model
     * @return
     */
    @RequestMapping(value = {"toLogin", ""})
    public String toLogin(Model model, HttpServletRequest req) {
        String message = req.getParameter("login");
        model.addAttribute("login", message);
        return "modules/wlpt_front/admin/login";
    }

    /***
     * 登录成功跳转
     *
     * @param role  角色编码
     * @param model
     * @return
     */
    @RequestMapping(value = {"loginSucceed", ""})
    public String LoginSucceed(Model model) {
        UserUtils.putCache(UserUtils.USER_CACHE, UserUtils.getUser());
        return "modules/wlpt_front/admin/per_index";
    }

    /***
     * 去选择用户角色
     *
     * @return
     */
    @RequestMapping(value = {"selectRole", ""})
    public String selectRole() {

        return "modules/wlpt/user/selectRole";
    }

    @RequiresPermissions("wlpt:user:view")
    @RequestMapping(value = {"list", ""})
    public String list(User User, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<User> page = wlptUserService.findPage(new Page<User>(request, response), User);
        model.addAttribute("page", page);
        return "modules/wlpt/user/UserList";
    }


    @RequiresPermissions("wlpt:user:edit")
    @RequestMapping(value = "delete")
    public String delete(User User, RedirectAttributes redirectAttributes) {
        wlptUserService.delete(User);
        addMessage(redirectAttributes, "删除用户信息成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/user/User/?repage";
    }

    /**
     * 是否是验证码登录
     *
     * @param useruame 用户名
     * @param isFail   计数加1
     * @param clean    计数清零
     * @return
     */
    @SuppressWarnings("unchecked")
    public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean) {
        Map<String, Integer> loginFailMap = (Map<String, Integer>) CacheUtils.get("loginFailMap");
        if (loginFailMap == null) {
            loginFailMap = Maps.newHashMap();
            CacheUtils.put("loginFailMap", loginFailMap);
        }
        Integer loginFailNum = loginFailMap.get(useruame);
        if (loginFailNum == null) {
            loginFailNum = 0;
        }
        if (isFail) {
            loginFailNum++;
            loginFailMap.put(useruame, loginFailNum);
        }
        if (clean) {
            loginFailMap.remove(useruame);
        }
        return loginFailNum >= 3;
    }

}