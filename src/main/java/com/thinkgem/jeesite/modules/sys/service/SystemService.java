/**
 *
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.*;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.modules.sys.dao.UserinfoDao;
import com.thinkgem.jeesite.modules.sys.entity.*;
import com.thinkgem.jeesite.modules.wlpt.dao.consume.ConsumerecodDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserBankinfoDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserPurseDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.security.Digests;
import com.thinkgem.jeesite.common.security.shiro.session.SessionDAO;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.service.ServiceException;
import com.thinkgem.jeesite.common.web.Servlets;
import com.thinkgem.jeesite.modules.sys.dao.MenuDao;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.dao.RoleDao;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm;
import com.thinkgem.jeesite.modules.sys.utils.LogUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.ui.Model;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 *
 * @author
 * @version 2013-12-05
 */
@Service
@Transactional(readOnly = true)
public class SystemService extends BaseService implements InitializingBean {

    public static final String HASH_ALGORITHM = "SHA-1";
    public static final int HASH_INTERATIONS = 1024;
    public static final int SALT_SIZE = 8;
    @Autowired
    private UserDao userDao;
    
    @Autowired
    private ConsumerecodDao consumerecodDao;

    @Autowired
    private RoleDao roleDao;
    @Autowired
    private MenuDao menuDao;
    @Autowired
    private SessionDAO sessionDao;
    @Autowired
    private SystemAuthorizingRealm systemRealm;
	@Autowired
	private OfficeDao officeDao;  //机构

    public SessionDAO getSessionDao() {
        return sessionDao;
    }

    @Autowired
    private IdentityService identityService;///身份

    @Autowired
    private UserinfoDao userinfoDao;  ///用户基本信息Dao

    @Autowired
    private UserPurseDao userPurseDao;   ///用户钱包账户

    @Autowired
    private UserBankinfoDao bankinfoDao;  ///银行卡信息




    //-- User Service --//

    /**
     * 获取用户
     *
     * @param id
     * @return
     */
    public User getUser(String id) {
        return UserUtils.get(id);
    }


    /***
     * 获取用户信息和银行卡信息
     * @param searchinfo  查询信息 登录名或者手机号码
     * @return
     */
    public Object getUserBySearch(String searchinfo,Model model) {
        Map<String,Object> map =new HashMap<>();
        User user = new User();
        user.setSearchinfo(searchinfo);
        List<User> listvuser = userDao.getByUser(user);
        if (listvuser.size() <= 0) {
            return null;
        }
        user = listvuser.get(0);
        user.setRoleList(roleDao.findList(new Role(user)));
        UserBankinfo bankinfo=new UserBankinfo();
        bankinfo.setUser(user);
        bankinfo = bankinfoDao.getBankByConditon(bankinfo);
        map.put("userPurse", user.getUserPurse());
        map.put("userinfo",user);
        map.put("company", user.getUserinfo());
        map.put("bankinfo",bankinfo);
        return map;
    }


    /**
     * 根据登录名获取用户
     *
     * @param loginName
     * @return
     */
    public User getUserByLoginName(String loginName) {
        return UserUtils.getUserBySearch(loginName);
    }
    
    /**
     * 根据登录名获取用户(导入验证)
     *
     * @param loginName
     * @return
     */
    public User getImportUserByLoginName(String loginName) {
    	User user = userDao.getImportUserByLoginName(new User(null, loginName));
    	return user; 
    }
    
    /**
	 * 获取用户数据，获取的数据较少，只获取用户表、用户信息表和金额表的数据
	 * 
	 * @param user
	 * @return
	 */
    public User getByCondition(User user) {
        return UserUtils.getByCondition(user);
    }

    /***
     * 根据手机号码获取用户
     * @param phone
     * @return
     */
    public User getUserByPhone(String phone) {
        return UserUtils.getByPhone(phone);
    }
    
    /**
     * 根据手机号码获取用户
     * 
     * @param phone
     * @return
     */
    public long getSysUserByPhone(String phone) {
    	User user = new User();
    	user.setPhone(phone);
    	return userDao.getSysUserByPhone(user);
    }

    public Page<User> findUser(Page<User> page, User user) {
        // 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
        user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "a"));
        // 设置分页参数
        user.setPage(page);
        // 执行分页查询
        page.setList(userDao.findList(user));
        return page;
    }
    


    /**
     * 无分页查询人员列表
     *
     * @param user
     * @return
     */
    public List<User> findUser(User user) {
        // 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
        user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "a"));
        List<User> list = userDao.findList(user);
        for(User u:list){
        	u.setRoleList(roleDao.findList(new Role(u)));
//        	if(u.getRoleList()==null||u.getRoleList().size()==0){
//        		System.out.println("ss");
//        	}
            u.setRole(u.getRoleList().get(0));
        }
        return list;
    }
    /**
     * 无分页查询人员列表
     *
     * @param user
     * @return
     */
    public List<User> findUserList(User user) {
        List<User> list = userDao.findList(user);
        return list;
    }

    /**
     * 通过部门ID获取用户列表，仅返回用户id和name（树查询用户时用）
     *
     * @param officeId
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<User> findUserByOfficeId(String officeId) {
        List<User> list = (List<User>) CacheUtils.get(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId);
        if (list == null) {
            User user = new User();
            user.setOffice(new Office(officeId));
            list = userDao.findUserByOfficeId(user);
            CacheUtils.put(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId, list);
        }
        return list;
    }

    @Transactional(readOnly = false)
    public void saveUser(User user) {

        if (StringUtils.isBlank(user.getId())) {
            user.preInsert();
            userDao.insert(user);
            Userinfo userinfo = new Userinfo();
            userinfo.setId(IdGen.uuid());
            userinfo.setUser(user);
            userinfo.setStatus(DataDic.UNAUTHEN);
            userinfo.setIscompleteinfo(DataDic.ISCOMPLETEINFO);
            userinfo.setCreateDate(user.getCreateDate());
            userinfo.setUpdateDate(user.getUpdateDate());
            user.setUserinfo(userinfo);
            UserPurse userPurse=new UserPurse();
            userPurse.setId(IdGen.uuid());
            userPurse.setUser(user);
            userPurse.setSettlestatus(DataDic.SETTLESTATUS);
            userPurse.setCreateDate(user.getCreateDate());
            userPurse.setUpdateDate(user.getUpdateDate());
            userPurse.setUpdateBy(user);
            userPurse.setCreateBy(user);
            userPurseDao.insert(userPurse);
            userinfo.setCreateBy(user);
            userinfo.setUpdateBy(user);
            userinfoDao.insert(userinfo);
            //userDao.insertUserInfo(user);///保存用户详细信息
        } else {
            // 清除原用户机构用户缓存
            User oldUser = userDao.get(user.getId());
            if (oldUser.getOffice() != null && oldUser.getOffice().getId() != null) {
                CacheUtils.remove(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + oldUser.getOffice().getId());
            }
            // 更新用户数据
            user.preUpdate();
            userDao.update(user);
            //userDao.insertUserInfo(user);
        }
        if (StringUtils.isNotBlank(user.getId())) {
            // 更新用户与角色关联
            userDao.deleteUserRole(user);
            if (user.getRoleList() != null && user.getRoleList().size() > 0) {
                userDao.insertUserRole(user);
            } else {
                throw new ServiceException(user.getLoginName() + "没有设置角色！");
            }
            // 将当前用户同步到Activiti
            saveActivitiUser(user);
            // 清除用户缓存
            UserUtils.clearCache(user);
//			// 清除权限缓存
//			systemRealm.clearAllCachedAuthorizationInfo();
        }
    }

    @Transactional(readOnly = false)
    public void updateUserInfo(User user) {
        user.preUpdate();
        userDao.updateUserInfo(user);
        // 清除用户缓存
        UserUtils.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
    }

    @Transactional(readOnly = false)
    public void deleteUser(User user) {
        userDao.delete(user);
        // 同步到Activiti
        deleteActivitiUser(user);
        // 清除用户缓存
        UserUtils.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
    }

    @Transactional(readOnly = false)
    public void updatePasswordById(String id, String loginName, String newPassword) {
        User user = new User(id);
        user.setPassword(entryptPassword(newPassword));
        userDao.updatePasswordById(user);
        // 清除用户缓存
        user.setLoginName(loginName);
        UserUtils.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
    }

    @Transactional(readOnly = false)
    public void updateUserLoginInfo(User user) {
    	//统计登录
        UserStatistics statistics = new UserStatistics();
        statistics.setAccruelogincount("1");
        statistics.setUser(user);
        UserUtils.userDataSourceCount(statistics);
        
        // 保存上次登录信息
        user.setOldLoginIp(user.getLoginIp());
        user.setOldLoginDate(user.getLoginDate());
        // 更新本次登录信息
        user.setLoginIp(StringUtils.getRemoteAddr(Servlets.getRequest()));
        user.setLoginDate(new Date());
        userDao.updateLoginInfo(user);
    }

    /**
     * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
     */
    public static String entryptPassword(String plainPassword) {
        String plain = Encodes.unescapeHtml(plainPassword);
        byte[] salt = Digests.generateSalt(SALT_SIZE);
        byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
        return Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword);
    }

    /**
     * 验证密码
     *
     * @param plainPassword 明文密码
     * @param password      密文密码
     * @return 验证成功返回true
     */
    public static boolean validatePassword(String plainPassword, String password) {
        String plain = Encodes.unescapeHtml(plainPassword);
        byte[] salt = Encodes.decodeHex(password.substring(0, 16));
        byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
        return password.equals(Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword));
    }

    /****
     * base64 密码加密方式
     *
     * @param plainPassword
     * @return
     */
    public static String encodeBase64Pwd(String plainPassword) {
        return Encodes.encodeBase64(plainPassword);
    }

    /***
     * base64 密码解密
     *
     * @param password
     * @return
     */
    public static String decodeBase64Pwd(String password) {
        return Encodes.decodeBase64String(password);
    }


    /**
     * 获得活动会话
     *
     * @return
     */
    public Collection<Session> getActiveSessions() {
        return sessionDao.getActiveSessions(false);
    }

    //-- Role Service --//

    public Role getRole(String id) {
        return roleDao.get(id);
    }

    public Role getRoleByName(String name) {
        Role r = new Role();
        r.setName(name);
        return roleDao.getByName(r);
    }

    public Role getRoleByEnname(String enname) {
        Role r = new Role();
        r.setEnname(enname);
        return roleDao.getByEnname(r);
    }

    public List<Role> findRole(Role role) {
        return roleDao.findList(role);
    }

    public List<Role> findAllRole() {
        return UserUtils.getRoleList();
    }

    @Transactional(readOnly = false)
    public void saveRole(Role role) {
        if (StringUtils.isBlank(role.getId())) {
            role.preInsert();
            roleDao.insert(role);
            // 同步到Activiti
            saveActivitiGroup(role);
        } else {
            role.preUpdate();
            roleDao.update(role);
        }
        // 更新角色与菜单关联
        roleDao.deleteRoleMenu(role);
        if (role.getMenuList().size() > 0) {
            roleDao.insertRoleMenu(role);
        }
        // 更新角色与部门关联
        roleDao.deleteRoleOffice(role);
        if (role.getOfficeList().size() > 0) {
            roleDao.insertRoleOffice(role);
        }
        // 同步到Activiti
        saveActivitiGroup(role);
        // 清除用户角色缓存
        UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
    }

    @Transactional(readOnly = false)
    public void deleteRole(Role role) {
        roleDao.delete(role);
        // 同步到Activiti
        deleteActivitiGroup(role);
        // 清除用户角色缓存
        UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
    }

    @Transactional(readOnly = false)
    public Boolean outUserInRole(Role role, User user) {
        List<Role> roles = user.getRoleList();
        for (Role e : roles) {
            if (e.getId().equals(role.getId())) {
                roles.remove(e);
                saveUser(user);
                return true;
            }
        }
        return false;
    }

    @Transactional(readOnly = false)
    public User assignUserToRole(Role role, User user) {
        if (user == null) {
            return null;
        }
        List<String> roleIds = user.getRoleIdList();
        if (roleIds.contains(role.getId())) {
            return null;
        }
        user.getRoleList().add(role);
        saveUser(user);
        return user;
    }

    //-- Menu Service --//

    public Menu getMenu(String id) {
        return menuDao.get(id);
    }

    public List<Menu> findAllMenu() {
        return UserUtils.getMenuList();
    }

    @Transactional(readOnly = false)
    public void saveMenu(Menu menu) {

        // 获取父节点实体
        menu.setParent(this.getMenu(menu.getParent().getId()));

        // 获取修改前的parentIds，用于更新子节点的parentIds
        String oldParentIds = menu.getParentIds();

        // 设置新的父节点串
        menu.setParentIds(menu.getParent().getParentIds() + menu.getParent().getId() + ",");

        // 保存或更新实体
        if (StringUtils.isBlank(menu.getId())) {
            menu.preInsert();
            menuDao.insert(menu);
        } else {
            menu.preUpdate();
            menuDao.update(menu);
        }

        // 更新子节点 parentIds
        Menu m = new Menu();
        m.setParentIds("%," + menu.getId() + ",%");
        List<Menu> list = menuDao.findByParentIdsLike(m);
        for (Menu e : list) {
            e.setParentIds(e.getParentIds().replace(oldParentIds, menu.getParentIds()));
            menuDao.updateParentIds(e);
        }
        // 清除用户菜单缓存
        UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
        ///清楚平台网页用户菜单缓存
        UserUtils.removeCache(UserUtils.CACHE_WLPT_MENU_PERSONAL);
        ///清除网页导航菜单
        UserUtils.removeCache(UserUtils.CACHE_WLPT_MENU_NAVL);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
        // 清除日志相关缓存
        CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);

    }

    @Transactional(readOnly = false)
    public void updateMenuSort(Menu menu) {
        menuDao.updateSort(menu);
        // 清除用户菜单缓存
        UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
        // 清除日志相关缓存
        CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
    }

    @Transactional(readOnly = false)
    public void deleteMenu(Menu menu) {
        menuDao.delete(menu);
        // 清除用户菜单缓存
        UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
        // 清除日志相关缓存
        CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
    }

    /**
     * 获取Key加载信息
     */
    public static boolean printKeyLoadMessage() {
        StringBuilder sb = new StringBuilder();
        sb.append("\r\n======================================================================\r\n");
        sb.append("\r\n    欢迎使用 " + Global.getConfig("productName") + "  - Powered By http://www.zhuoda56.com\r\n");
        sb.append("\r\n======================================================================\r\n");
        System.out.println(sb.toString());
        return true;
    }

    ///////////////// Synchronized to the Activiti //////////////////

    // 已废弃，同步见：ActGroupEntityServiceFactory.java、ActUserEntityServiceFactory.java

    /**
     * 是需要同步Activiti数据，如果从未同步过，则同步数据。
     */
    private static boolean isSynActivitiIndetity = true;

    public void afterPropertiesSet() throws Exception {
        if (!Global.isSynActivitiIndetity()) {
            return;
        }
        if (isSynActivitiIndetity) {
            isSynActivitiIndetity = false;
            // 同步角色数据
            List<Group> groupList = identityService.createGroupQuery().list();
            if (groupList.size() == 0) {
                Iterator<Role> roles = roleDao.findAllList(new Role()).iterator();
                while (roles.hasNext()) {
                    Role role = roles.next();
                    saveActivitiGroup(role);
                }
            }
            // 同步用户数据
            List<org.activiti.engine.identity.User> userList = identityService.createUserQuery().list();
            if (userList.size() == 0) {
                Iterator<User> users = userDao.findAllList(new User()).iterator();
                while (users.hasNext()) {
                    saveActivitiUser(users.next());
                }
            }
        }
    }

    private void saveActivitiGroup(Role role) {
        if (!Global.isSynActivitiIndetity()) {
            return;
        }
        String groupId = role.getEnname();

        // 如果修改了英文名，则删除原Activiti角色
        if (StringUtils.isNotBlank(role.getOldEnname()) && !role.getOldEnname().equals(role.getEnname())) {
            identityService.deleteGroup(role.getOldEnname());
        }

        Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
        if (group == null) {
            group = identityService.newGroup(groupId);
        }
        group.setName(role.getName());
        group.setType(role.getRoleType());
        identityService.saveGroup(group);

        // 删除用户与用户组关系
        List<org.activiti.engine.identity.User> activitiUserList = identityService.createUserQuery().memberOfGroup(groupId).list();
        for (org.activiti.engine.identity.User activitiUser : activitiUserList) {
            identityService.deleteMembership(activitiUser.getId(), groupId);
        }

        // 创建用户与用户组关系
        List<User> userList = findUser(new User(new Role(role.getId())));
        for (User e : userList) {
            String userId = e.getLoginName();//ObjectUtils.toString(user.getId());
            // 如果该用户不存在，则创建一个
            org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
            if (activitiUser == null) {
                activitiUser = identityService.newUser(userId);
                activitiUser.setFirstName(e.getName());
                activitiUser.setLastName(StringUtils.EMPTY);
                activitiUser.setEmail(e.getEmail());
                activitiUser.setPassword(StringUtils.EMPTY);
                identityService.saveUser(activitiUser);
            }
            identityService.createMembership(userId, groupId);
        }
    }

    public void deleteActivitiGroup(Role role) {
        if (!Global.isSynActivitiIndetity()) {
            return;
        }
        if (role != null) {
            String groupId = role.getEnname();
            identityService.deleteGroup(groupId);
        }
    }

    private void saveActivitiUser(User user) {
        if (!Global.isSynActivitiIndetity()) {
            return;
        }
        String userId = user.getLoginName();//ObjectUtils.toString(user.getId());
        org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
        if (activitiUser == null) {
            activitiUser = identityService.newUser(userId);
        }
        activitiUser.setFirstName(user.getName());
        activitiUser.setLastName(StringUtils.EMPTY);
        activitiUser.setEmail(user.getEmail());
        activitiUser.setPassword(StringUtils.EMPTY);
        identityService.saveUser(activitiUser);

        // 删除用户与用户组关系
        List<Group> activitiGroups = identityService.createGroupQuery().groupMember(userId).list();
        for (Group group : activitiGroups) {
            identityService.deleteMembership(userId, group.getId());
        }
        // 创建用户与用户组关系
        for (Role role : user.getRoleList()) {
            String groupId = role.getEnname();
            // 如果该用户组不存在，则创建一个
            Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
            if (group == null) {
                group = identityService.newGroup(groupId);
                group.setName(role.getName());
                group.setType(role.getRoleType());
                identityService.saveGroup(group);
            }
            identityService.createMembership(userId, role.getEnname());
        }
    }

    private void deleteActivitiUser(User user) {
        if (!Global.isSynActivitiIndetity()) {
            return;
        }
        if (user != null) {
            String userId = user.getLoginName();//ObjectUtils.toString(user.getId());
            identityService.deleteUser(userId);
        }
    }

    ///////////////// Synchronized to the Activiti end //////////////////
    
    /**
     * 子账户列表
     * @param page
     * @param user
     * @return
     */
    public Page<User> findMyUser(Page<User> page, User user) {
        // 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
       /* user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "a"));*/
        // 设置分页参数
        user.setPage(page);
        User user2=UserUtils.getUser();
        Userinfo userinfo=new Userinfo();
        userinfo.setAssociatedId(user2.getId());
        user.setUserinfo(userinfo);
        // 执行分页查询
        page.setList(userDao.getMyuserfindList(user));
        return page;
    }

    /**
     * 保存子账户
     * @param user
     */
    @Transactional(readOnly = false)
    public void saveMyUser(User user) {

        if (StringUtils.isBlank(user.getId())) {
            user.preInsert();
            String chapwd=user.getUserinfo().getCashpassword();
			///获取角色信息      
			Role userRole=roleDao.getByEnname(user.getRole());
			user.setRole(userRole);
			List<Role> rolelist = new ArrayList<>();
			rolelist.add(user.getRole());
			user.setRoleList(rolelist);
			userDao.insertUserRole(user);//保存角色
			user.setOffice(userRole.getOffice());
			Office office=officeDao.get(DataDic.COMPANYID);

			////赋值所属模块公司
			user.setCompany(office);
			user.getRoleList().add(user.getRole());
			user.setCreateBy(user);
			user.setUpdateBy(user);
            user.setPassword(entryptPassword(user.getPassword()));
            userDao.insert(user);
            Userinfo userinfo = new Userinfo();
            userinfo.setId(IdGen.uuid());
            userinfo.setUser(user);
            userinfo.setAssociatedId(UserUtils.getUser().getId());
            userinfo.setStatus(DataDic.UNAUTHEN);
            userinfo.setIscompleteinfo(DataDic.ISCOMPLETEINFO);
            userinfo.setCreateDate(user.getCreateDate());
            userinfo.setUpdateDate(user.getUpdateDate());
            ////如果用户的用户信息存在
            if (user.getUserinfo()!=null){
                ////提现不为空
                if (!Tools.IsNullOrWhiteSpace(user.getUserinfo().getCashpassword())){
                    userinfo.setCashpassword(entryptPassword(user.getUserinfo().getCashpassword()));
                }
            }
            user.setUserinfo(userinfo);
            UserPurse userPurse=new UserPurse();
            userPurse.setId(IdGen.uuid());
            userPurse.setUser(user);
            userPurse.setSettlestatus(DataDic.SETTLESTATUS);
            userPurse.setCreateDate(user.getCreateDate());
            userPurse.setUpdateDate(user.getUpdateDate());
            userPurse.setUpdateBy(user);
            userPurse.setCreateBy(user);
            userPurseDao.insert(userPurse);
            userinfo.setCreateBy(user);
            userinfo.setUpdateBy(user);
            userinfoDao.insert(userinfo);
        } else {
            // 清除原用户机构用户缓存
            User oldUser = userDao.get(user.getId());
            if (oldUser.getOffice() != null && oldUser.getOffice().getId() != null) {
                CacheUtils.remove(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + oldUser.getOffice().getId());
            }
            // 更新用户数据
            user.preUpdate();
            userDao.update(user);
        }
    }
}
