/**
 *
 */
package com.thinkgem.jeesite.modules.sys.utils;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.dao.*;
import com.thinkgem.jeesite.modules.sys.entity.*;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserStatisticsBiz;
import com.thinkgem.jeesite.modules.wlpt.dao.user.AddressDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserBankinfoDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserCompanyDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserPurseDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseAdvertisement;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseAdvertisementService;


import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;

/**
 * 用户工具类
 *
 * @author
 * @version 2013-12-05
 */
public class UserUtils {

    private static UserDao userDao = SpringContextHolder.getBean(UserDao.class);
    private static RoleDao roleDao = SpringContextHolder.getBean(RoleDao.class);
    private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
    private static UserBankinfoDao bankinfoDao = SpringContextHolder.getBean(UserBankinfoDao.class);
    private static UserPurseDao userPurseDao = SpringContextHolder.getBean(UserPurseDao.class);
    private static UserCompanyDao userCompanyDao = SpringContextHolder.getBean(UserCompanyDao.class);
    private static UserinfoDao userinfoDao = SpringContextHolder.getBean(UserinfoDao.class);
    private static AreaDao areaDao = SpringContextHolder.getBean(AreaDao.class);
    private static AddressDao addressDao = SpringContextHolder.getBean(AddressDao.class);
    private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);
    private static BaseAdvertisementService adverService = SpringContextHolder.getBean(BaseAdvertisementService.class);
    private static UserStatisticsBiz statisticsBiz = SpringContextHolder.getBean(UserStatisticsBiz.class);
    public static final String USER_CACHE = "userCache";
    public static final String USER_CACHE_ID_ = "id_";
    public static final String USER_CACHE_LOGIN_NAME_ = "ln";
    public static final String USER_CACHE_LIST_BY_OFFICE_ID_ = "oid_";

    public static final String CACHE_ROLE_LIST = "roleList";
    public static final String CACHE_MENU_LIST = "menuList";
    ///个人中心菜单
    public static final String CACHE_WLPT_MENU_PERSONAL = "wlptPersonalMenu";
    ///平台导航菜单
    public static final String CACHE_WLPT_MENU_NAVL = "wlptNavMenu";
    public static final String CACHE_WLPT_MENU_WX = "wlptMenuWx";
    public static final String CACHE_WLPT_INDEXBANNER = "wlptindebanner";
    public static final String CACHE_AREA_LIST = "areaList";
    public static final String CACHE_OFFICE_LIST = "officeList";
    public static final String CACHE_OFFICE_ALL_LIST = "officeAllList";


    /**
     * 检验用户角色是否可用
     *
     * @param enname
     * @return
     */
    public static Boolean vialedRole(String enname) {
        List<Role> roleList = UserUtils.getRoleList();
        if (enname.equals(DataDic.ROLE_SYSADMIN)) {
            return true;
        }
        for (Role role : roleList) {
            if (role.getEnname().equals(enname)) {
                return true;
            }
        }
        for (int i = 0; i < roleList.size(); i++) {
            if (roleList.get(i).getEnname().equals(enname)) {
                return true;
            }
        }
        return false;
    }

    /***
     * 校验一组角色
     *
     * @param enname
     * @return
     */
    public static Boolean vialedRole(String[] enname) {
        List<Role> roleList = UserUtils.getRoleList();
        for (int i = 0; i < enname.length; i++) {
            for (Role role : roleList) {
                if (role.getEnname().equals(enname[i])) {
                    return true;
                }
            }
        }
        return false;
    }

    /***
     * 用户发货地址管理
     * Boolean reset 是否重置
     *
     * @return
     */
    public static List<Address> getUserSendAddress() {
        User user = UserUtils.getUser();
        if (user == null) {
            return null;
        }
        List<Address> reslut = new ArrayList<>();
        Address address = new Address();
        address.setUser(user);
        address.setType("0");
        reslut = addressDao.findAllList(address);

        return reslut;
    }

    /***
     * 用户发货地址管理
     *
     * @param
     * @return
     */
    public static List<Address> getUserRevAddress() {
        User user = UserUtils.getUser();
        if (user == null) {
            return null;
        }
        List<Address> reslut = new ArrayList<>();

        Address address = new Address();
        address.setUser(user);
        address.setType("1");
        reslut = addressDao.findAllList(address);


        return reslut;
    }

    /**
     * 根据ID获取用户
     *
     * @param id
     * @return 取不到返回null
     */
    public static User get(String id) {
        User user = (User) CacheUtils.get(USER_CACHE, USER_CACHE_ID_ + id);
        if (user == null) {
            ///当前登录用户
            User curuser = userDao.get(id);
            if (curuser == null) {
                return null;
            } else {
                Userinfo userinfo = curuser.getUserinfo();
                if (userinfo != null) {
                    /////获取用户,判断用户是否是子账户
                    if (!Tools.IsNullOrWhiteSpace(userinfo.getAssociatedId())) {
                        ///父账户的信息 
                        user = userDao.get(userinfo.getAssociatedId());
                        user.setIschild(true);
                        curuser.setRoleList(roleDao.findList(new Role(curuser)));
                        
                        curuser.setRole(curuser.getRoleList().get(0));
                        ///将子账户信息存到父对象中
                        user.setChildUser(curuser);
                    } else {
                    	curuser.setIschild(false);
                        user = curuser;
                    }
                } else {
                    user = curuser;
                }
            }
            user.setRoleList(roleDao.findList(new Role(user)));
            user.setRole(user.getRoleList().get(0));
            CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
            CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
        }
        return user;
    }

    public static User get(String id, Boolean isreload) {
        User user = (User) CacheUtils.get(USER_CACHE, USER_CACHE_ID_ + id);
        if (isreload) {
            ///当前登录用户
            User curuser = userDao.get(id);
            if (curuser == null) {
                return null;
            } else {
                Userinfo userinfo = curuser.getUserinfo();
                if (userinfo != null) {
                    /////获取用户,判断用户是否是子账户
                    if (!Tools.IsNullOrWhiteSpace(userinfo.getAssociatedId())) {
                        ///父账户的信息
                        user = userDao.get(userinfo.getAssociatedId());
                        user.setIschild(true);
                        curuser.setRoleList(roleDao.findList(new Role(curuser)));
                        curuser.setRole(curuser.getRoleList().get(0));
                        ///将子账户信息存到父对象中
                        user.setChildUser(curuser);
                    } else {
                        user = curuser;
                    }
                } else {
                    user = curuser;
                }
            }
            user.setRoleList(roleDao.findList(new Role(user)));
            user.setRole(user.getRoleList().get(0));
            CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
            CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
        }
        return user;
    }

    /**
     * 根据登录名获取用户
     *
     * @param loginName
     * @return 取不到返回null
     */
    public static User getByLoginName(String loginName) {
        User user = (User) CacheUtils.get(USER_CACHE, USER_CACHE_LOGIN_NAME_ + loginName);
        if (user == null) {
            user = userDao.getByLoginName(new User(null, loginName));
            if (user == null) {
                return null;
            }
            user.setRoleList(roleDao.findList(new Role(user)));
            user.setRole(user.getRoleList().get(0));
            CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
            CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
        }
        return user;
    }

    /***
     * 获取系统账户信息
     *
     * @return user 用户对象
     */
    public static User getSysAccount() {
        ////系统账户
        String sysaccount_phone = Tools.readTxtFile(Const.SYSACCOUNT);
        User sysaccount = UserUtils.getUserBySearch(sysaccount_phone);
        return sysaccount;
    }

    /***
     * 获取用户条件查询
     * 通过手机或者用户登录名
     *
     * @param searchinfo
     * @return
     */
    public static User getUserBySearch(String searchinfo) {
        User user = new User();
        user.setSearchinfo(searchinfo);
        List<User> listvuser = userDao.getByUser(user);
        if (listvuser.size() <= 0) {
            return null;
        }
        user = listvuser.get(0);
        user.setRoleList(roleDao.findList(new Role(user)));
        CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
        CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
        /*user.setUserinfo(userinfoDao.get(user.getUserinfo()));*/
        /* user.setUserPurse(userPurseDao.get(user.getUserPurse()));*/
        UserBankinfo bankinfo = new UserBankinfo();
        bankinfo.setUser(user);
        user.setBankinfo(bankinfoDao.getBankByConditon(bankinfo));
        if(user.getRoleList() !=null && user.getRoleList().size()>0){
        	user.setRole(user.getRoleList().get(0));
        }else{
        	user.setRole(new Role());
        }
        
        return user;
    }

    /***
     * 获取用户条件查询
     * 通过手机或者用户登录名
     *
     * @param id
     * @return
     */
    public static User getUserById(String id) {
        User user = new User();
        user.setId(id);
        List<User> listvuser = userDao.getByUser(user);
        if (listvuser.size() <= 0) {
            return null;
        }
        user = listvuser.get(0);
        user.setRoleList(roleDao.findList(new Role(user)));
        /*user.setUserinfo(userinfoDao.get(user.getUserinfo()));
        user.setUserPurse(userPurseDao.get(user.getUserPurse()));*/
        UserBankinfo bankinfo = new UserBankinfo();
        bankinfo.setUser(user);
        user.setBankinfo(bankinfoDao.getBankByConditon(bankinfo));
        user.setRole(user.getRoleList().get(0));
        return user;
    }

    /***
     * 查找用户
     *
     * @param user
     * @return
     */
    public static User findUser(User user) {
        List<User> listvuser = userDao.getByUser(user);
        if (listvuser.size() <= 0) {
            return null;
        }
        user = listvuser.get(0);

        user.setRoleList(roleDao.findList(new Role(user)));
        /*user.setUserinfo(userinfoDao.get(user.getUserinfo()));
        user.setUserPurse(userPurseDao.get(user.getUserPurse()));*/
        UserBankinfo bankinfo = new UserBankinfo();
        bankinfo.setUser(user);
        bankinfo = bankinfoDao.getBankByConditon(bankinfo);
        if(bankinfo!=null){
        	user.setBankinfo(bankinfoDao.getBankByConditon(bankinfo));
        }
        if(user.getRoleList().size()>0){
        	user.setRole(user.getRoleList().get(0));
        }else{
        	user.setRole(new Role());
        }
        
        if (user.getRole()!=null && DataDic.ROLE_ENTERPRISE.equals(user.getRole().getEnname())) {
            user.setUserCompany(userCompanyDao.get((user.getUserinfo().getUserCompany() == null ? new UserCompany() : user.getUserinfo().getUserCompany())));
        }
        return user;
    }

    /***
     * 获取用户信息通过手机号
     *
     * @param phone
     * @return
     */
    public static User getByPhone(String phone) {
        User user = new User();
        user.setPhone(phone);
        List<User> listvuser = userDao.getByUser(user);
        if (listvuser.size() <= 0) {
            return null;
        }
        user = listvuser.get(0);
        user.setRoleList(roleDao.findList(new Role(user)));
        /*user.setUserinfo(userinfoDao.get(user.getUserinfo()));
        user.setUserPurse(userPurseDao.get(user.getUserPurse()));*/
        UserBankinfo bankinfo = new UserBankinfo();
        bankinfo.setUser(user);
        user.setBankinfo(bankinfoDao.getBankByConditon(bankinfo));
        user.setRole(user.getRoleList().get(0));

        return user;
    }


    /**
     * 获取用户数据，获取的数据较少，只获取用户表、用户信息表和金额表的数据
     *
     * @param user
     * @return
     */
    public static User getByCondition(User user) {
        user = userDao.getByCondition(user);
        if (user == null || Tools.IsNullOrWhiteSpace(user.getId())) {
            return null;
        }
        return get(user.getId(), true);
    }

    /**
     * 清除当前用户缓存
     */
    public static void clearCache() {
        removeCache(CACHE_ROLE_LIST);
        removeCache(CACHE_MENU_LIST);
        removeCache(CACHE_WLPT_MENU_PERSONAL);
        removeCache(CACHE_AREA_LIST);
        removeCache(CACHE_OFFICE_LIST);
        removeCache(USER_CACHE);
        removeCache(CACHE_OFFICE_ALL_LIST);
        removeCache(CACHE_WLPT_MENU_WX);
        UserUtils.clearCache(getUser());
    }

    /**
     * 清除指定用户缓存
     *
     * @param user
     */
    public static void clearCache(User user) {
        CacheUtils.remove(USER_CACHE, USER_CACHE_ID_ + user.getId());
        removeCache(CACHE_WLPT_MENU_PERSONAL);
        removeCache(CACHE_WLPT_MENU_WX);
        removeCache(USER_CACHE);
        CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName());
        CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getOldLoginName());
        if (user.getOffice() != null && user.getOffice().getId() != null) {
            CacheUtils.remove(USER_CACHE, USER_CACHE_LIST_BY_OFFICE_ID_ + user.getOffice().getId());
        }
    }

    /**
     * 获取当前用户
     *
     * @return 取不到返回 new User()
     */
    public static User getUser() {
        Principal principal = getPrincipal();
        if (principal != null) {
            User user = get(principal.getId(),true);
            if (user != null) {
                return user;
            }
            return new User();
        }
        // 如果没有登录，则返回实例化空的User对象。
        return new User();
    }

    public static User getUser(Boolean isreload) {
        Principal principal = getPrincipal();
        if (principal != null) {
            User user = get(principal.getId(), isreload);
            if (user != null) {
                return user;
            }
            return new User();
        }
        // 如果没有登录，则返回实例化空的User对象。
        return new User();
    }

    /**
     * 获取当前用户角色列表
     *
     * @return
     */
    public static List<Role> getRoleList() {
        @SuppressWarnings("unchecked")
        List<Role> roleList = (List<Role>) getCache(CACHE_ROLE_LIST);
        if (roleList == null || roleList.size()==0) {
            User user = getUser();
            if (user.isAdmin()) {
                roleList = roleDao.findAllList(new Role());
            } else {
                Role role = new Role();
                role.getSqlMap().put("dsf", BaseService.dataScopeFilter(user.getCurrentUser(), "o", "u"));
                roleList = roleDao.findList(role);
            }
            putCache(CACHE_ROLE_LIST, roleList);
        }
        return roleList;
    }

    /**
     * 获取当前用户授权菜单
     *
     * @return
     */
    public static List<Menu> getMenuList() {
        @SuppressWarnings("unchecked")
        List<Menu> menuList = (List<Menu>) getCache(CACHE_MENU_LIST);
        if (menuList == null || menuList.size()==0) {
            User user = getUser();
            if (user.isAdmin()) {
                menuList = menuDao.findAllList(new Menu());
            } else {
                Menu m = new Menu();
                m.setUserId(user.getId());
                menuList = menuDao.findByUserId(m);
            }
            putCache(CACHE_MENU_LIST, menuList);
        }
        return menuList;
    }

    /***
     * 获取用户中心菜单
     *
     * @return
     */
    public static List<Menu> getWlptPersonalnMenu() {
        @SuppressWarnings("unchecked")
        List<Menu> menuList = (List<Menu>) getCache(CACHE_WLPT_MENU_PERSONAL);
        if (menuList == null || menuList.size()==0) {
            User user = getUser(true);
            ///判断是否是子账户
            if (user.getIschild()) {
                ///复制子账户信息,获取子账户菜单
                user = user.getChildUser();
            }
            if (user.isAdmin()) { 
                menuList = menuDao.findAllList(new Menu());
            } else {
                Menu m = new Menu();
                m.setUserId(user.getId());
                //用户中心菜单主键
                m.setParentIds(DataDic.MUNE_PERSONAL_ID);
                menuList = menuDao.findByUserId(m);
            }
            putCache(CACHE_WLPT_MENU_PERSONAL, menuList);
        }
        return menuList;
    }

    /***
     * 获取用户微信菜单
     *
     * @return
     */
    public static List<Menu> getWlptWeixinMenu() {
        @SuppressWarnings("unchecked")
        List<Menu> menuList = (List<Menu>) getCache(CACHE_WLPT_MENU_WX);
        if (menuList == null || menuList.size()==0) {
            User user = getUser(true);
            ///判断是否是子账户
            if (user.getIschild()) {
                ///复制子账户信息,获取子账户菜单
                user = user.getChildUser();
            }
            Menu m = new Menu();
            m.setUserId(user.getId());
            //用户中心菜单主键
            m.setParentIds(DataDic.MUNE_WEIXIN_ID);
            menuList = menuDao.findByUserId(m);

            putCache(CACHE_WLPT_MENU_WX, menuList);
        }
        return menuList;
    }

    /***
     * 获取平台网页导航菜单
     *
     * @return
     */
    public static List<Menu> getWlptNavMenu() {
        @SuppressWarnings("unchecked")
        List<Menu> menuList = (List<Menu>) getCache(CACHE_WLPT_MENU_NAVL);
        if (menuList == null || menuList.size()==0) {

            Menu m = new Menu();
            //物流平台导航菜单主键
            m.setParentIds(DataDic.MUNE_NAV_ID);
            menuList = menuDao.findNavByParentIdsLike(m);
            putCache(CACHE_WLPT_MENU_NAVL, menuList);
        }
        return menuList;
    }

    /***
     * 获取数据分析菜单
     *
     * @return
     */
    public static List<Menu> getAnalysisMenu() {
        Menu m = new Menu();
        m.setParentIds(DataDic.DATA_ANALYSIS_ID);
        List<Menu> menuList = menuDao.findNavByParentIdsLike(m);
        return menuList;
    }

    /***
     * 获取首页轮播图片
     *
     * @param
     * @return
     */
    public static List<BaseAdvertisement> getWlptBanner() {
        List<BaseAdvertisement> varlist = (List<BaseAdvertisement>) getCache(CACHE_WLPT_INDEXBANNER);
        if (varlist == null ||varlist.size()==0) {
            varlist = adverService.getAdvertisementList("wlpt_index");
            UserUtils.putCache(CACHE_WLPT_INDEXBANNER, varlist);
        }
        return varlist;
    }

    /**
     * 获取当前用户授权的区域
     *
     * @return
     */
    public static List<Area> getAreaList() {
        @SuppressWarnings("unchecked")
        List<Area> areaList = (List<Area>) getCache(CACHE_AREA_LIST);
        if (areaList == null || areaList.size()==0) {
            areaList = areaDao.findAllList(new Area());
            putCache(CACHE_AREA_LIST, areaList);
        }
        return areaList;
    }

    /**
     * 获取当前用户有权限访问的部门
     *
     * @return
     */
    public static List<Office> getOfficeList() {
        @SuppressWarnings("unchecked")
        List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_LIST);
        if (officeList == null || officeList.size()==0) {
            User user = getUser();
            if (user.isAdmin()) {
                officeList = officeDao.findAllList(new Office());
            } else {
                Office office = new Office();
                office.getSqlMap().put("dsf", BaseService.dataScopeFilter(user, "a", ""));
                officeList = officeDao.findList(office);
            }
            putCache(CACHE_OFFICE_LIST, officeList);
        }
        return officeList;
    }

    /**
     * 获取当前用户有权限访问的部门
     *
     * @return
     */
    public static List<Office> getOfficeAllList() {
        @SuppressWarnings("unchecked")
        List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_ALL_LIST);
        if (officeList == null || officeList.size()==0) {
            officeList = officeDao.findAllList(new Office());
        }
        return officeList;
    }

    /**
     * 获取授权主要对象
     */
    public static Subject getSubject() {
        return SecurityUtils.getSubject();
    }

    /**
     * 获取当前登录者对象
     */
    public static Principal getPrincipal() {
        try {
            Subject subject = SecurityUtils.getSubject();
            Principal principal = (Principal) subject.getPrincipal();
            if (principal != null) {
                return principal;
            }
//			subject.logout();
        } catch (UnavailableSecurityManagerException e) {

        } catch (InvalidSessionException e) {

        }
        return null;
    }


    public static User setSessionUser(String userId) {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User us = new User();
        us.setId(userId);

        try {
            us = userDao.getByCondition(us);
            if (us != null) {
                session.removeAttribute("USER");
                session.setAttribute("USER", us);
            } else {
                session.removeAttribute("USER");
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return us;
    }

    /**
     * 获取用户session中的用户信息
     *
     * @return
     */
    public static User getSessionUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute("USER");
        return user;
    }


    /**
     * 获取明文密码，该方法只用于 微信绑定自动登录功能其他地方慎用
     *
     * @param openid
     * @return
     */
    public static String getPlainpwd(String openid) {

        return userDao.getPlainpwd(openid);
    }

    public static Session getSession() {
        try {
            Subject subject = SecurityUtils.getSubject();
            Session session = subject.getSession(false);
            if (session == null) {
                session = subject.getSession();
            }
            if (session != null) {
                return session;
            }
//			subject.logout();
        } catch (InvalidSessionException e) {

        }
        return null;
    }

    //统计用户数据记录
    public static void userDataSourceCount(UserStatistics statistics) {
        statisticsBiz.saveUserStatistics(statistics);
    }
    // ============== User Cache ==============
    /**
	 * 得到request对象
	 */
	public static HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		return request;
	}
    public static Object getCache(String key) {
        return getCache(key, null);
        
    }

    public static Object getCache(String key, Object defaultValue) {
//		Object obj = getCacheMap().get(key);
        Object obj = getSession().getAttribute(key);
        return obj == null ? defaultValue : obj;
    }

    public static void putCache(String key, Object value) {
//		getCacheMap().put(key, value);
        getSession().setAttribute(key, value);
    }

    public static void removeCache(String key) {
//		getCacheMap().remove(key);
        getSession().removeAttribute(key);
    }

//	public static Map<String, Object> getCacheMap(){
//		Principal principal = getPrincipal();
//		if(principal!=null){
//			return principal.getCacheMap();
//		}
//		return new HashMap<String, Object>();
//	}

}
