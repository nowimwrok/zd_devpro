package com.thinkgem.jeesite.modules.wlpt.api.user;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.security.UsernamePasswordToken;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.api.FileUploadUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.activity.ActivityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.bankBiz.UserBankBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.qualitycertifyBiz.QualityCertifyBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.user.*;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping(value = "${appPath}/api/user")
public class UserAppController extends BaseController {

    @Autowired
    private SystemService systemService;

    @Autowired
    private WlptUserService wlptUserService;

    @Autowired
    private ConsumeRecodBiz consumeRecodBiz;

    @Autowired
    private QualityCertifyBiz qualityCertifyBiz;

    @Autowired
    private UserBiz userBiz;

    @Autowired
    private UserBankBiz userBankBiz;

    @Autowired
    private UserinfoService userinfoService;

    @Autowired
    private MetroCardBiz metroCardBiz;

    @Autowired
    private ActivityBiz activityBiz;

    private static final String REX = "^[0-9]+(.[0-9]{0,2})?$";

    /**
     * 用户登陆
     *
     * @param loginName
     * @param passWord
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"loginuser", ""})
    public Object loginuser(String loginName, String passWord, String openid, Model model) {

        Map<String, Object> map = new HashMap<String, Object>();
        String message = "登录成功";
        int state = DataDic.RETURN_STATUS_NORMAL;
        if (StringUtils.isBlank(loginName)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "loginName为空";
        } else if (StringUtils.isBlank(passWord)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "passWord为空";
        } else {
            try {
                User u = new User();
                u.setSearchinfo(loginName);
                User user = UserUtils.getByCondition(u);// 根据用户名查询用户信息
                passWord = SystemService.decodeBase64Pwd(passWord);
                if (user == null) {
                    message = "用户名或密码错误";
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                }
                if (!com.thinkgem.jeesite.common.utils.StringUtils.isNoneBlank(passWord)) {
                    message = "用户名或密码错误";
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                } else if (user != null && !SystemService.validatePassword(passWord, user.getPassword())) {
                    message = "用户名或密码错误";
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                }
                if (state == DataDic.RETURN_STATUS_NORMAL) {
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
                    map.put("data", user);
                    map.put("_sid", UserUtils.getPrincipal().getSessionid());
                }

            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
                message = "服务器异常";
                state = DataDic.RETURN_STATUS_SYSBUG;
            }


        }
        map.put("message", message);
        map.put("state", state);

        return map;
    }


    /**
     * 用户注册-司机
     *
     * @param user
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "register", method = RequestMethod.POST)
    public Object register(User user, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "注册成功";
        if (user == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "用户名密码为空";
        } else if (StringUtils.isBlank(user.getLoginName())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "用户名为空";
        } else if (StringUtils.isBlank(user.getPhone())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "手机号为空";
        } else if (StringUtils.isBlank(user.getPassword())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "密码为空";
        } else if (StringUtils.isBlank(request.getParameter("SmsCode"))) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "验证码为空";
        } else {
            try {
                int code = SmsUtil.judgeSmsVerCode(user.getPhone(), request.getParameter("SmsCode"),
                        Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
                if (code == -1) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "验证码为空";
                } else if (code == 0) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码与手机不匹配,请再试";
                } else if (code == 2) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码超时";
                } else if (code == 3) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "发生错误，请再试";
                } else if (systemService.getSysUserByPhone(user.getPhone()) > 0) {/// 判断用户是否存在
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "用户已存在";
                } else {
                    user.setPassword(SystemService.entryptPassword(SystemService.decodeBase64Pwd(user.getPassword())));
                    Role role = new Role();
                    role.setEnname("carowner");// 车主
                    user.setRole(role);
                    user.setUserType("carowner");

                    Driver driver = new Driver();
                    driver.setIsNewRecord(true);
                    driver.setDrivermobile(user.getPhone());
                    driver.setCreateDate(new Date());
                    driver.setUpdateDate(new Date());
                    wlptUserService.userRegisterSave(user, driver);// 注册
                }
            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    //===================================================密码修改===================================================

    /**
     * 忘记会员密码
     *
     * @param phone
     * @param repassword
     * @param SmsCode
     * @param request
     * @param response
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveForgetPass", method = RequestMethod.POST)
    public Object saveForgetPass(String phone, String repassword, String SmsCode, HttpServletRequest request,
                                 HttpServletResponse response, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "修改密码成功";
        if (StringUtils.isBlank(phone)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "phone为空";
        } else if (StringUtils.isBlank(repassword)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "repassword为空";
        } else if (StringUtils.isBlank(SmsCode)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "SmsCode为空";
        } else {
            int code = SmsUtil.judgeSmsVerCode(phone, SmsCode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
            if (code == -1) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "验证码为空";
            } else if (code == 0) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "验证码与手机不匹配,请再试";
            } else if (code == 2) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "验证码超时";
            } else if (code == 3) {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "发生错误，请再试";
            } else {
                try {
                    User us = UserUtils.getByPhone(phone);
                    if (us != null) {
                        wlptUserService.updatePasswordById(us.getId(), SystemService.decodeBase64Pwd(repassword));
                    } else {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = "手机号码错误";
                    }
                } catch (Exception e) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "服务器异常";
                }
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 修改用户登录密码
     *
     * @param phone
     * @param oldPassword
     * @param newPassword
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "changePass", method = RequestMethod.POST)
    public Object changePass(String phone, String SmsCode, String oldPassword, String newPassword) {
        Map<String, Object> map = new HashMap<>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "修改成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(phone)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "phone为空";
        } else if (StringUtils.isBlank(SmsCode)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "code为空";
        } else if (StringUtils.isBlank(oldPassword)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "oldPassword为空";
        } else if (StringUtils.isBlank(newPassword)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "newPassword为空";
        } else {
            try {
                int smsResult = SmsUtil.judgeSmsVerCode(phone, SmsCode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
                if (smsResult == -1) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "验证码为空";
                } else if (smsResult == 0) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码与手机不匹配,请再试";
                } else if (smsResult == 2) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码超时";
                } else if (smsResult == 3) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "发生错误，请再试";
                } else {
                    oldPassword = SystemService.decodeBase64Pwd(oldPassword);
                    newPassword = SystemService.decodeBase64Pwd(newPassword);
                    User us = UserUtils.getUser();
                    if (SystemService.validatePassword(oldPassword, us.getPassword())) {
                        if (!newPassword.equals(oldPassword)) {
                            wlptUserService.updatePasswordById(us.getId(), newPassword);
                            message = "修改成功";
                        } else {
                            state = DataDic.RETURN_STATUS_AUTHBUG;
                            message = "新密码不能与旧密码一样";
                        }
                    } else {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = "旧密码错误";
                    }
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }


        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 修改用户支付密码
     *
     * @param phone
     * @param newCashPassword
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "changeCashPass", method = RequestMethod.POST)
    public Object changeCashPass(String phone, String SmsCode, String newCashPassword) {
        Map<String, Object> map = new HashMap<>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "修改成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(phone)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "phone为空";
        } else if (StringUtils.isBlank(SmsCode)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "code为空";
        } else if (StringUtils.isBlank(newCashPassword)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "newCashPassword为空";
        } else {
            try {
                int smsResult = SmsUtil.judgeSmsVerCode(phone, SmsCode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
                if (smsResult == -1) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "验证码为空";
                } else if (smsResult == 0) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码与手机不匹配,请再试";
                } else if (smsResult == 2) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码超时";
                } else if (smsResult == 3) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "发生错误，请再试";
                } else {
                    message = userBiz.modifyPwdForApp(phone, SystemService.decodeBase64Pwd(newCashPassword));
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }


        map.put("state", state);
        map.put("message", message);
        return map;
    }

    //==========================================================一卡通==================================================

    /***
     * 我的油气消费记录数据
     *
     * @param userMetroCardRecord
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "getPetrolconsumeList", method = RequestMethod.GET)
    public Object getPetrolconsumeList(UserMetroCardRecord userMetroCardRecord, int pageNo, int pageSize, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Page pg = new Page();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {

            if (StringUtils.isBlank(UserUtils.getUser().getId())) {
                map.put("state", "1006");
                map.put("message", "登录过期");
                return map;
            }
            //
            ////获取当前用户
            User user = UserUtils.getUser();
            userMetroCardRecord.setPosuser("");
            userMetroCardRecord.setUser(user);
            Page<UserMetroCardRecord> page = metroCardBiz.finditemList(pg, userMetroCardRecord);

            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            e.printStackTrace();
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 修改用户一卡通密码
     *
     * @param cardid
     * @param SmsCode
     * @param newPassword
     * @param oldPassword
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updatePasswordCard", method = RequestMethod.POST)
    public Object updatePasswordCard(String cardid, String SmsCode, String newPassword, String oldPassword) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> result = new HashMap<>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "修改成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(cardid)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "cardid为空";
        } else if (StringUtils.isBlank(SmsCode)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "code为空";
        } else if (StringUtils.isBlank(newPassword)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "newPassword为空";
        } else if (StringUtils.isBlank(oldPassword)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "oldPassword为空";
        } else {
            try {
                User user = UserUtils.getUser();
                int smsResult = SmsUtil.judgeSmsVerCode(user.getPhone(), SmsCode, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
                if (smsResult == -1) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "验证码为空";
                } else if (smsResult == 0) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码与手机不匹配,请再试";
                } else if (smsResult == 2) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "验证码超时";
                } else if (smsResult == 3) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "发生错误，请再试";
                } else {
                    result = metroCardBiz.updateCardPassWord(user.getId(), cardid, SystemService.decodeBase64Pwd(newPassword), SystemService.decodeBase64Pwd(oldPassword));
                    state = Integer.valueOf(result.get("state").toString());
                    message = result.get("message").toString();
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }


        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 获取一卡通卡信息
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getMetroCardInfo", method = RequestMethod.GET)
    public Object getMetroCardInfo(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            User user = UserUtils.getUser();

            UserMetroCard userMetroCard = metroCardBiz.getUserMetroCardByUserid(user.getId());
            if (userMetroCard != null) {
                map.put("data", userMetroCard);
            } else {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "该用户没有申请一卡通";
            }

        } catch (Exception e) {
            e.printStackTrace();
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }

        map.put("state", state);
        map.put("message", message);
        return map;
    }


    /***
     * 保存申请一卡通
     *
     * @param address
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveCard", method = RequestMethod.POST)
    public Object saveCard(Address address) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(address.getLinkman())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "linkman为空";
        } else if (StringUtils.isBlank(address.getLinkmobile())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "linkmobile为空";
        } else if (StringUtils.isBlank(address.getProvince())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "province为空";
        } else if (StringUtils.isBlank(address.getCity())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "city为空";
        } else if (StringUtils.isBlank(address.getDistrict())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "district为空";
        } else if (StringUtils.isBlank(address.getAddress())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "address为空";
        } else if (StringUtils.isBlank(address.getPostcode())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "postcode为空";
        } else {
            try {
                address.setId(null);
                result = metroCardBiz.applicationMetroCard(address);
                state = (Integer) result.get("state");
                message = result.get("message").toString();
            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /***
     * 保存挂失一卡通
     *
     * @param address
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveLossCard", method = RequestMethod.POST)
    public Object saveLossCard(Address address) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(address.getLinkman())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "linkman为空";
        } else if (StringUtils.isBlank(address.getLinkmobile())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "linkmobile为空";
        } else if (StringUtils.isBlank(address.getProvince())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "province为空";
        } else if (StringUtils.isBlank(address.getCity())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "city为空";
        } else if (StringUtils.isBlank(address.getDistrict())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "district为空";
        } else if (StringUtils.isBlank(address.getAddress())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "address为空";
        } else if (StringUtils.isBlank(address.getPostcode())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "postcode为空";
        } else {
            try {
                address.setId(null);
                result = metroCardBiz.lossMetroCardSave(address);
                state = (Integer) result.get("state");
                message = result.get("message").toString();
            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }


    //=====================================================用户信息================================================

    /**
     * 查询用户
     *
     * @param phone
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "userInfo", method = RequestMethod.GET)
    public Object searchInfo(String phone, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(phone)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "验证码为空";
        } else {
            try {
                result = (Map<String, Object>) systemService.getUserBySearch(phone, model);
                if (result == null) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "用户不存在";
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }


    /**
     * 查询用户基本资料
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "baseInfo", method = RequestMethod.GET)
    public Object baseInfo(Userinfo userinfo, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            User user = UserUtils.getUser();
            // 获取用户资料信息
            userinfo = wlptUserService.getUserInfo(user.getUserinfo().getId());


            // 判断用户资料信息是否为空，如为空重新实例化
            if (userinfo != null) {
                if (StringUtils.isBlank(userinfo.getQq())) {
                    userinfo.setQq("");
                }
                if (StringUtils.isBlank(userinfo.getCompanyname())) {
                    userinfo.setCompanyname("");
                }
                if (StringUtils.isBlank(userinfo.getContactaddress())) {
                    userinfo.setContactaddress("");
                }
                if (StringUtils.isBlank(user.getPhoto())) {
                    user.setPhoto("");
                }
                userinfo.setUser(user);
                map.put("data", userinfo);
            } else {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "用户信息不存在";
            }
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);

        return map;
    }

    /**
     * 保存用户基本资料
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveBaseInfo", method = RequestMethod.POST)
    public Object saveBaseInfo(Userinfo userinfo, String userId, String userName, String userEmail, String userPhoto, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (userinfo == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "用户信息缺失";
        } else if (StringUtils.isBlank(userId)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "userId为空";
        } else if (StringUtils.isBlank(userName)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "userName为空";
        } else {
            try {
                if (userinfo.getQq() != null && !"".equals(userinfo.getQq())) {
                    Userinfo info = userinfoService.ValidateQQ(userinfo);
                    if (info != null && userinfo.getQq().equals(info.getQq()) && !userinfo.getId().equals(info.getId())) {
                        state = DataDic.RETURN_STATUS_INFOBUG;
                        message = "qq号已存在";
                    }
                }
                if (state == DataDic.RETURN_STATUS_NORMAL) {
                    User user = new User();
                    user.setId(userId);
                    user.setLoginName(userName);
                    user.setEmail(userEmail);
                    user.setPhoto(userPhoto);
                    userinfo.setUser(user);
                    /*User us = UserUtils.getUser();
                    userinfo.setId(us.getUserinfo().getId());*/
                    userinfo.setUserCompany(new UserCompany());
                    userinfo.setIscompleteinfo(DataDic.YES);// 已完善个人资料
                    userinfo = wlptUserService.editUserInfo(userinfo);
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", userinfo);

        return map;
    }

    //=============================================================财务模块=============================================


    /***
     * 获取平台资金流水数据
     * @param consumerecod
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "getRecodeList", method = RequestMethod.GET)
    public Object getRecodeList(Consumerecod consumerecod, int pageNo, int pageSize, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";

        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {

            if (StringUtils.isBlank(UserUtils.getUser().getId())) {
                map.put("state", "1006");
                map.put("message", "登录过期");
                return map;
            }
            ////获取当前用户
            consumerecod.setAccount(UserUtils.getUser());

            // 查询用户交易流水--除去系统记录
            consumerecod.setIssysrecode(DataDic.ISSYSRECODE_NO);

            Page<Consumerecod> page = consumeRecodBiz.findPage(pg, consumerecod);
            for (Consumerecod var : page.getList()) {
                // gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
                var.setConsumetype(DictUtils.getDictLabel(var.getConsumetype(), "consumerecode_type", null));
                var.setConsumeway(DictUtils.getDictLabel(var.getConsumeway(), "consumerecode_way", null));
                var.setConsumestatus(DictUtils.getDictLabel(var.getConsumestatus(), "consume_status", null));
                var.setPlusStatus(Double.valueOf(var.getAftermony()) - Double.valueOf(var.getBeforemony()) > 0 ? "-" : "+");
            }
            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            e.printStackTrace();
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }


    /**
     * 用户钱包
     *
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "purse", method = RequestMethod.GET)
    public Object purse(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            User user = UserUtils.getUser();

            UserPurse up = user.getUserPurse();
            up.setWebbalance(PreciseCompute.round(up.getWebbalance().doubleValue(), 2));
            up.setAvailablebalance(PreciseCompute.round(up.getAvailablebalance().doubleValue(), 2));
            up.setWebcoin(PreciseCompute.round(up.getWebcoin().doubleValue(), 2));
            up.setAvailablecoin(PreciseCompute.round(up.getAvailablecoin().doubleValue(), 2));
            up.setPetrolbalance(PreciseCompute.round(up.getPetrolbalance().doubleValue(), 2));

            result.put("webbalance", up.getWebbalance());
            result.put("availablebalance", up.getAvailablebalance());
            result.put("webcoin", up.getWebcoin());
            result.put("availablecoin", up.getAvailablecoin());
            result.put("petrolbalance", up.getPetrolbalance());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
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
    @RequestMapping(value = "getCashList", method = RequestMethod.GET)
    public Object getCashList(Consumerecod consumerecod, int pageNo, int pageSize, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            Page<Consumerecod> pg = new Page<>();
            pg.setPageNo(pageNo);
            pg.setPageSize(pageSize);

            Page<Consumerecod> page = consumeRecodBiz.cashListFindPage(pg, consumerecod);
            for (Consumerecod var : page.getList()) {
                // gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
                var.setConsumetype(DictUtils.getDictLabel(var.getConsumetype(), "consumerecode_type", null));
                var.setConsumeway(DictUtils.getDictLabel(var.getConsumeway(), "consumerecode_way", null));
                var.setConsumestatus(DictUtils.getDictLabel(var.getConsumestatus(), "consume_status", null));
                var.setPlusStatus(Double.valueOf(var.getAftermony()) - Double.valueOf(var.getBeforemony()) > 0 ? "-" : "+");
            }
            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }


    /**
     * 申请提现
     *
     * @param bankid
     * @param passWord
     * @param cashMoney
     * @param payway    0平台余额，10账户系统
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "accountCash", method = RequestMethod.POST)
    public Object accountCash(String bankid, String passWord, String cashMoney, String payway) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        //
        if (StringUtils.isBlank(bankid)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "请选择银行卡为空";
        } else if (StringUtils.isBlank(cashMoney)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "cashMoney提现金额为空";
        } else if (!cashMoney.matches(REX)) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "cashMoney格式错误";
        } else if (StringUtils.isBlank(passWord)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "passWord支付密码为空";
        } else if (StringUtils.isBlank(payway)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "payway交易方式为空";
        } else {
            try {
                UserBankinfo userbank = userBiz.getBankById(bankid);
                User user = UserUtils.getUser();
                if (userbank == null) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "请先去绑定银行卡信息";
                } else if (StringUtils.isBlank(user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "请先设置支付密码";
                } else {
                    Consumerecod accountCode = new Consumerecod();
                    // 交易密码
                    accountCode.setCashpassword(SystemService.decodeBase64Pwd(passWord));
                    // 提现金额
                    accountCode.setConsumemony(cashMoney);
                    // 提现银行卡
                    accountCode.setUserBankinfo(userbank);
                    // 交易方式
                    accountCode.setConsumeway(DataDic.CONSUMERECODE_WAY_BALANCE);// 账户余额
                    state = consumeRecodBiz.chashConsumeCodesBiz(accountCode);
                    if (state == 2) {
                        message = "信息缺失";
                    } else if (state == 4) {
                        message = "提现密码错误";
                    } else if (state == 5) {
                        message = "您的账户余额不足";
                    } else if (state == 8) {
                        message = "提现金额大于单笔交易最高限额";
                    } else if (state == 10) {
                        message = "电子钱包最低留存额度不足";
                    } else if (state == 11) {
                        message = "提现金额大于单日交易最高限额";
                    } else if (state == 12) {
                        message = "提现金额大于单日累计提现限额";
                    } else if (state == -1) {
                        message = "账户系统异常";
                    } else if (state == 7) {
                        message = "操作频繁";
                    }
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        //
        map.put("state", state);
        map.put("message", message);
        return map;
    }


    /**
     * 转账
     *
     * @param consumeMoney
     * @param payway       交易方式：10账户系统 ，0平台余额
     * @param passWord
     * @param targetId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "transfer", method = RequestMethod.POST)
    public Object transfer(String consumeMoney, String payway, String passWord, String targetId) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        //
        if (StringUtils.isBlank(targetId)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "targetId为空";
        } else if (StringUtils.isBlank(consumeMoney)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "consumeMoney为空";
        } else if (!consumeMoney.matches(REX)) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "cashMoney格式错误";
        } else if (StringUtils.isBlank(passWord)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "passWord为空";
        } else if (StringUtils.isBlank(payway)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "payway为空";
        } else {
            try {
                User target = UserUtils.findUser(new User(targetId));
                User user = UserUtils.getUser();
                String accountid = user.getId();
                if (target == null) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "用户不存在";
                } else if (targetId == accountid) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "不能给自己转账";
                } else if (StringUtils.isBlank(user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "请先设置支付密码";
                } else if (!Tools.validatePassword(SystemService.decodeBase64Pwd(passWord), user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "支付密码错误";
                } else {
                    if (UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                            UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                            UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
                            UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {

                        double money = Double.parseDouble(consumeMoney);
                        int result = consumeRecodBiz.transferBiz(accountid, money, targetId, payway);
                        if (result == DataDic.RETURN_STATUS_NORMAL) {
                            message = "转账成功";
                        } else if (result == DataDic.RETURN_STATUS_PAYBUG) {
                            message = "交易中";
                        } else {
                            state = DataDic.RETURN_STATUS_AUTHBUG;
                            message = "转账失败";
                        }
                    } else {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = "不能给该用户转账";
                    }
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        //
        map.put("state", state);
        map.put("message", message);
        return map;
    }


    /**
     * 卓币转账
     *
     * @param consumeMoney
     * @param passWord
     * @param targetId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "transferCoin", method = RequestMethod.POST)
    public Object transferCoin(String consumeMoney, String passWord, String targetId) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        //
        if (StringUtils.isBlank(targetId)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "targetId为空";
        } else if (StringUtils.isBlank(consumeMoney)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "consumeMoney为空";
        } else if (!consumeMoney.matches(REX)) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "cashMoney格式错误";
        } else if (StringUtils.isBlank(passWord)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "passWord为空";
        } else {
            try {
                User target = UserUtils.findUser(new User(targetId));
                User user = UserUtils.getUser();
                String accountid = user.getId();
                if (target == null) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "用户不存在";
                } else if (targetId == accountid) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "不能给自己转账";
                } else if (StringUtils.isBlank(user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "请先设置支付密码";
                } else if (!Tools.validatePassword(SystemService.decodeBase64Pwd(passWord), user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "支付密码错误";
                } else {
                    if (target.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                            target.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                            target.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
                            target.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {

                        String targetid = target.getId();
                        double money = Double.parseDouble(consumeMoney);
                        int result = consumeRecodBiz.transferCoinBiz(accountid, money, targetid);
                        if (result != DataDic.RETURN_STATUS_NORMAL) {
                            state = DataDic.RETURN_STATUS_AUTHBUG;
                            message = "转账失败";
                        }
                    } else {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = "不能给该用户转账";
                    }
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        //
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 油气转账
     *
     * @param consumeMoney
     * @param passWord
     * @param targetId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "transferPetro", method = RequestMethod.POST)
    public Object transferPetro(String consumeMoney, String passWord, String targetId) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        //
        if (StringUtils.isBlank(targetId)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "targetId为空";
        } else if (StringUtils.isBlank(consumeMoney)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "consumeMoney为空";
        } else if (!consumeMoney.matches(REX)) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "cashMoney格式错误";
        } else if (StringUtils.isBlank(passWord)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "passWord为空";
        } else {
            try {
                User target = UserUtils.findUser(new User(targetId));
                User user = UserUtils.getUser();
                String accountid = user.getId();
                if (target == null) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "用户不存在";
                } else if (targetId == accountid) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "不能给自己转账";
                } else if (StringUtils.isBlank(user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "请先设置支付密码";
                } else if (!Tools.validatePassword(SystemService.decodeBase64Pwd(passWord), user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "支付密码错误";
                } else {
                    if (target.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                            target.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                            target.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
                            target.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
                        String targetid = target.getId();
                        double money = Double.parseDouble(consumeMoney);
                        result = (Map<String, Object>) consumeRecodBiz.transferPetroAppBiz(accountid, money, targetid);
                        state = (int) result.get("state");
                        state = (int) result.get("state");
                        message = (String) result.get("message");
                    } else {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = "不能给该用户转账";
                    }
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        //
        map.put("state", state);
        map.put("message", message);
        return map;
    }
    //=======================================================认证==============================================

    /**
     * 实名认证
     *
     * @param driver
     * @param phone
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "authDriverInfo", method = RequestMethod.POST)
    public Object authDriverInfo(Driver driver, String phone) {
        Map<String, Object> map = new HashMap<>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "申请认证成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(driver.getDrivername())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "drivername为空";
        } else if (StringUtils.isBlank(driver.getIdcardnum())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "idcardnum为空";
        } else if (StringUtils.isBlank(driver.getDrivermobile())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "drivermobile为空";
        } else if (StringUtils.isBlank(driver.getDriverheadimg())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "driverheadimg为空";
        } else if (StringUtils.isBlank(driver.getIdcardimg())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "idcardimg为空";
        } else if (StringUtils.isBlank(driver.getDriverlicimg())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "driverlicimg为空";
        } else {
            try {
                Boolean result = qualityCertifyBiz.percar_authens(driver.getDrivername(), driver.getIdcardnum(),
                        driver.getDrivermobile(), driver.getDriverheadimg(), driver.getIdcardimg(), driver.getDriverlicimg());
                if (result) {
                    state = DataDic.RETURN_STATUS_NORMAL;
                    message = "申请认证成功";
                } else {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "申请认证失败";
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 获取司机认证信息
     *
     * @param phone
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDriverInfo", method = RequestMethod.GET)
    public Object getDriverInfo(String phone) {
        Map<String, Object> map = new HashMap<>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            Driver driver = qualityCertifyBiz.getDriverInfo();
            if (driver != null) {
                map.put("data", driver);
            } else {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "请求失败";
            }
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 获取司机认证信息
     *
     * @param phone
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCompanyInfo", method = RequestMethod.GET)
    public Object getCompanyInfo(String phone) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            UserCompany userCompany = qualityCertifyBiz.getCompanyAndPictureInfo();
            User user = UserUtils.getUser();
            if (user != null && user.getId() != null) {
                UserQualitycertify quality = qualityCertifyBiz.get(user.getUserinfo().getUserCompany().getId());
                result.put("quality", quality);
                result.put("user", user);
            }
            result.put("userCompany", userCompany);
            map.put("data", result);
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    //========================================================银行卡=================================================


    /**
     * 用户银行卡列表
     *
     * @param userBankinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "bankList", method = RequestMethod.GET)
    public Object bankList(UserBankinfo userBankinfo) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            userBankinfo.setUser(UserUtils.getUser());
            List<UserBankinfo> bankList = userBankBiz.findBankList(userBankinfo);
            if (CollectionUtils.isEmpty(bankList)) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "暂无银行卡";
            } else {
                map.put("data", bankList);
            }
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        //
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 银行卡删除方法
     *
     * @param userBankinfo
     * @param code
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deteleBank", method = RequestMethod.POST)
    public Object deteleBank(UserBankinfo userBankinfo, String code) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (userBankinfo == null || StringUtils.isBlank(userBankinfo.getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else if (StringUtils.isBlank(code)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "code验证码为空";
        } else if (StringUtils.isBlank(userBankinfo.getPassword())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "password支付密码为空";
        } else {
            try {
                User user = UserUtils.getUser();
                UserBankinfo ub = userBankBiz.get(userBankinfo);
                int smsResult = SmsUtil.judgeSmsVerCode(ub.getBindphone(), code, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
                if (smsResult == -1) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "验证码为空";
                } else if (smsResult == 0) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "验证码与手机不匹配,请再试";
                } else if (smsResult == 2) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "验证码超时";
                } else if (smsResult == 3) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "发生错误，请再试";
                } else if (StringUtils.isBlank(user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "请先设置支付密码";
                } else if (!Tools.validatePassword(SystemService.decodeBase64Pwd(userBankinfo.getPassword()), user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "支付密码错误";
                } else {
                    if (ub == null) {
                        state = DataDic.RETURN_STATUS_INFOBUG;
                        message = "id错误";
                    } else {
                        ub.setDelFlag(DataDic.DEL_FLAG_DELETE);
                        userBankBiz.deteleBank(ub);
                        if (ub.getIsdefault() == 1) {
                            UserBankinfo ubk = new UserBankinfo();
                            ubk.setUser(ub.getUser());
                            List<UserBankinfo> ubkList = userBankBiz.findBankList(ubk);
                            if (ubkList.size() > 0) {
                                ubk = ubkList.get(0);
                                ubk.setIsdefault(1);
                                userBankBiz.saveBank(ubk);
                            }
                        }
                    }
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        //
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 设置默认方法
     *
     * @param userBankinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "isDefault", method = RequestMethod.POST)
    public Object isDefault(UserBankinfo userBankinfo) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        //
        if (userBankinfo == null || StringUtils.isBlank(userBankinfo.getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else {
            try {
                UserBankinfo ub = userBankBiz.get(userBankinfo);
                if (ub == null) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "id错误";
                } else if ("0".equals(String.valueOf(ub.getIsdefault()))) {
                    UserBankinfo newUserBankInfo = new UserBankinfo();
                    newUserBankInfo.setUser(ub.getUser());
                    List<UserBankinfo> bankList1 = userBankBiz.findBankList(newUserBankInfo);
                    if (bankList1.size() > 1) {
                        for (UserBankinfo u : bankList1) {
                            if (u.getIsdefault() == 1) {
                                u.setIsdefault(0);
                                userBankBiz.saveBank(u);
                            }
                        }
                    }
                    ub.setIsdefault(1);
                    userBankBiz.saveBank(ub);
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        //
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 银行卡绑定方法
     *
     * @param userBankinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "bankBind", method = RequestMethod.POST)
    public Object bankBind(UserBankinfo userBankinfo, String code, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        //
        if (userBankinfo == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "银行信息为空";
        } else if (StringUtils.isBlank(userBankinfo.getAccountName())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "accountName银行卡账户名为空";
        } else if (StringUtils.isBlank(userBankinfo.getBankcard())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "bankcard银行卡号为空";
        } else if (StringUtils.isBlank(userBankinfo.getBindphone())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "bindphone绑卡手机为空";
        } else if (StringUtils.isBlank(code)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "code验证码为空";
        } else if (StringUtils.isBlank(userBankinfo.getBanktype())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "banktype银行卡类型为空";
        } else if (StringUtils.isBlank(userBankinfo.getBankname())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "bankname支行信息为空";
        } else if (StringUtils.isBlank(userBankinfo.getUnionpayNo())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "unionpayNo银联号为空";
        } else if (StringUtils.isBlank(userBankinfo.getPassword())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "password支付密码为空";
        } else {
            try {
                int smsResult = SmsUtil.judgeSmsVerCode(userBankinfo.getBindphone(), code, Const.SMSFUN_REGCODEVALITY, Const.SMSFUN_REGCODE);
                if (smsResult == -1) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "验证码为空";
                } else if (smsResult == 0) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "验证码与手机不匹配,请再试";
                } else if (smsResult == 2) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "验证码超时";
                } else if (smsResult == 3) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "发生错误，请再试";
                } else {
                    userBankinfo.setPassword(SystemService.decodeBase64Pwd(userBankinfo.getPassword()));
                    Map<String, Object> result = (Map<String, Object>) userBankBiz.bankBind(userBankinfo);
                    state = (int) result.get("state");
                    message = (String) result.get("message");
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 获取账户系统银行卡信息列表
     *
     * @param keyword
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getBankinfoList", method = RequestMethod.GET)
    public Object getBankinfoList(String keyword, String pageNo, String pageSize, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            //
            Page<AccountBankinfo> page = userBankBiz.findBankinfoPage(keyword, pageNo, pageSize);
            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 获取账户系统银行支行信息列表
     *
     * @param name
     * @param keyword
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getBranchBankinfoList", method = RequestMethod.GET)
    public Object getBranchBankinfoList(String name, String keyword, String pageNo, String pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(name)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "name为空";
        } else {
            try {
                //
                Page<AccountBranchBankinfo> page = userBankBiz.findBranchBankinfoPage(name, keyword, pageNo, pageSize);
                int totlaCount = (int) page.getCount();

                map.put("totlaCount", totlaCount);
                map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
                map.put("pageNo", pageNo);
                map.put("pageSize", pageSize);

                result.put("list", page.getList());
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 提现获取默认银行卡信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDefaultBankinfo", method = RequestMethod.GET)
    public Object getDefaultBankinfo(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            User user = UserUtils.getUser();

            UserPurse up = user.getUserPurse();
            UserBankinfo userBankInfo = userBiz.getUserBankInfo(user);
            result.put("bankinfo", userBankInfo);
            result.put("purse", up);
            user.setBankinfo(null);
            result.put("user", user);
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("data", result);
        map.put("state", state);
        map.put("message", message);
        return map;
    }


    /**
     * 获取银行卡信息
     *
     * @param id
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getBankinfo", method = RequestMethod.GET)
    public Object getBankinfo(String id, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(id)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else {
            try {
                User user = UserUtils.getUser();

                UserBankinfo userBankInfo = userBiz.getUserBankInfo(new UserBankinfo(id));
                if (userBankInfo != null) {
                    map.put("data", userBankInfo);
                } else {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "银行卡不存在";
                }

            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    //=======================================================优惠券===============================================

    /**
     * 获取中奖记录
     *
     * @param activityAwardrecord
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getAwardrecordList", method = RequestMethod.GET)
    public Object getAwardrecordList(ActivityAwardrecord activityAwardrecord, int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            ////获取当前用户
            User curUser = UserUtils.getUser();
            activityAwardrecord.setPhone(curUser.getPhone());
            Page<ActivityAwardrecord> page = activityBiz.awardrecordFindPage(pg, activityAwardrecord);
            for (ActivityAwardrecord awardrecord : page.getList()) {
                awardrecord.setIssuename(DictUtils.getDictLabel(awardrecord.getIssue(), "issue", ""));
                awardrecord.setGifttypename((DictUtils.getDictLabel(awardrecord.getWxgift().getGifttype(), "gifttype", "")));
            }
            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }


    //========================================================验证=================================================

    /***
     * 发送验证码
     *
     * @param phone
     *            手机号码
     * @param type
     *            0注册（判断用户不存在）、1忘记密码（判断用户存在）、2不检查
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "sendRegCode", method = RequestMethod.POST)
    public Object checkRegCode(String phone, String type) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "发送成功";
        String[] statusStr = {"0", "1", "2"};
        List<String> strList = Arrays.asList(statusStr);
        if (StringUtils.isBlank(phone)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "手机号为空";
        } else if (StringUtils.isBlank(type)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "type为空";
        } else if (!strList.contains(type)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "type参数错误";
        } else if ("0".equals(type) && systemService.getUserByPhone(phone.trim()) != null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "用户已存在";
        } else if ("1".equals(type) && systemService.getUserByPhone(phone.trim()) == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "用户不存在";
        } else {
            try {
                String tempSmsCode = String.valueOf(Tools.getRandomNum()); // 获取验证码
                String[] keyword = {tempSmsCode};
                int result = SmsUtil.sendSmsMesge(null, "registerSMS", phone.trim(), Const.System_Module_Enum.CeShi,
                        Const.SMSFUN_REGCODE, keyword, null, null, true, SmsConfig.smsValidateCode);
                if (result != 1) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "发送失败";
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
            // map.put("tempSmsCode", tempSmsCode);
        }
        map.put("state", state);
        map.put("message", message);
        return map;
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
    @RequestMapping(value = {"checkLoginName", ""})
    public Object checkLoginName(String loginName, HttpServletRequest request, HttpServletResponse response,
                                 Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(loginName)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "loginName为空";
        } else {
            try {
                Boolean falg = false;
                User user = UserUtils.getUser();
                if (user != null && user.getUserinfo() != null && !Tools.IsNullOrWhiteSpace(user.getUserinfo().getId())) {
                    Userinfo userinfo = new Userinfo();
                    userinfo.setId(user.getUserinfo().getId());
                    userinfo.setUser(user);
                    Userinfo info = userinfoService.ValidateLoginName(userinfo);
                    if (info != null && userinfo.getUser().getLoginName().equals(info.getUser().getLoginName())
                            && !userinfo.getId().equals(info.getId())) {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = "用户名已存在";
                    } else {
                        falg = true;
                    }
                } else {
                    falg = userBiz.checkLoginName(loginName);
                }

                map.put("data", falg);
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    //========================================================文件上传=================================================

    /**
     * 文件上传,只支持上传1张
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public Object uploadFile(String target, MultipartFile file, HttpServletRequest request,
                             HttpServletResponse response) throws IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, String> result = new HashMap<String, String>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(target)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "target为空";
        } else if (file == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "图片为空";
        } else {
            User user = UserUtils.getUser();
            String url = user.getId();
            url += "/images/" + target + "/";
            result = FileUploadUtils.upload(url, file, request);
        }

        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /***
     * 获取系统参数
     *
     * @param
     * @return
     *//*
    @ResponseBody
    @RequestMapping(value = "getConfig", method = RequestMethod.GET)
    public Object getConfig(HttpServletRequest request, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Site site = CmsUtils.getSite(Site.defaultSiteId());

        result.put("site_logo", Global.getRootContextPath(request) + Global.USERFILES_BASE_URL + site.getLogo());
        result.put("site_name", site.getName());
        result.put("kf_phone", site.getCustomerServiceTel());
        result.put("kf_qq", site.getQq());

        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }
*/

}
