/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.ArrayList;
import java.util.List;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.service.ServiceException;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.dao.RoleDao;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.dao.UserinfoDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserCompanyDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserFlowDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserPurseDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserFlow;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;
import org.activiti.engine.IdentityService;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 用户表Service
 * @author 饶江龙
 * @version 2016-07-18
 */
@Service
@Transactional(readOnly = true)
public class WlptUserService extends CrudService<UserDao, User>{

	@Autowired
	private IdentityService identityService;///身份

	@Autowired
	private RoleDao roleDao;  ///用户角色

	@Autowired
	private OfficeDao officeDao;  //机构

	@Autowired
	private UserDao userDao;

	@Autowired
	private UserinfoDao userinfoDao;  ///用户基本信息Dao

	@Autowired
	private UserPurseDao userPurseDao;   ///用户钱包账户

	@Autowired
	private UserCompanyDao userCompanyDao;  //用户公司信息资料

	@Autowired
	private SystemService systemService;  //后台用户接口
	
	@Autowired
	private UserFlowDao userFlowDao;
	@Autowired
	private IntegrityBiz integrityBiz;
	@Autowired
	private DriverService driverService;

	/***
	 * 修改用户信息
	 * @param userinfo
	 * @return
     */

	@Transactional(readOnly = false)
	public Userinfo  editUserInfo(Userinfo userinfo){
		//完善企业/个人资料    可获得100积分,尽第一次有效
		User curUser = UserUtils.getUser();
		System.out.println("+++++++++++++++++++++修改前的积分传入积分Biz"+curUser.getUserinfo().getPoint()+"+++++++++++++++++++++");
		userinfo.setIscompleteinfo("0");
		if(null==userinfo.getIscompleteinfo()||"0".equals(userinfo.getIscompleteinfo())) {
			integrityBiz.updateIntegrityPoint(curUser.getUserinfo(),DataDic.INTEGRITY_POINT_PERFECTING,userinfo.getUser().getUserType());
			userinfo.setIscompleteinfo("1");
		}
		
		//判断修改用户信息是否包含用户主信息
		if (StringUtils.isNoneBlank(userinfo.getUser().getId())){
			userinfo.getUser().setUpdateBy(userinfo.getUser());
			userDao.updateUserInfo(userinfo.getUser());
		}
		///判断用户信息表数据是否修改
		if (StringUtils.isNoneBlank(userinfo.getId())){
			userinfo.setUpdateBy(userinfo.getUser());
			userinfoDao.update(userinfo);
		}
		//判断用户公司信息是否改变
		if (StringUtils.isNotBlank(userinfo.getUserCompany().getId())){
			userinfo.getUserCompany().setUpdateBy(userinfo.getUser());
			userinfo.getUserCompany().setUser(userinfo.getUser());
			userinfo.getUserCompany().setCompanyname(userinfo.getCompanyname());
			userCompanyDao.update(userinfo.getUserCompany());
		}
		// 清除用户缓存
		UserUtils.clearCache(userinfo.getUser());
		UserUtils.get(userinfo.getUser().getId());
		userinfo=userinfoDao.get(userinfo.getId());
	
		return userinfo;
	}

	/***
	 * 获取当前用户详细信息
	 * @param id
	 * @return 用户信息对象
     */
	public Userinfo getUserInfo(String id){
		return userinfoDao.get(id);
	}

	/**
	 * 修改用户登录密码
	 * @param id
	 * @param newPassword
	 */
	@Transactional(readOnly = false)
	public void updatePasswordById(String id, String newPassword) {
		
		User us=new User(id);
		us.setPassword(systemService.entryptPassword(newPassword));
		userDao.updatePasswordById(us);
		// 清除用户缓存
		User user =new User(UserUtils.getUser().getId());
		user.setLoginName(user.getLoginName());
		UserUtils.clearCache(user);
	}

	/***
	 * 注册用户
	 * @param user
	 * @return
     */
	@Transactional(readOnly = false)
	public List<Role> registerSave(User user){
		List<Role> varList=new ArrayList<>();
		if (StringUtils.isBlank(user.getId())) {
			user.preInsert();
			///获取角色信息
			Role userRole=roleDao.getByEnname(user.getRole());
			user.setRole(userRole);
			user.setOffice(userRole.getOffice());
			Office office=officeDao.get(DataDic.COMPANYID);

			////赋值所属模块公司
			user.setCompany(office);
			user.getRoleList().add(user.getRole());
			user.setCreateBy(user);
			user.setUpdateBy(user);
			user.setUserType(user.getRole().getEnname());
			userDao.insert(user);

			////赋值用户基本信息保存
			Userinfo userinfo = new Userinfo();
			userinfo.setId(IdGen.uuid());
			userinfo.setUser(user);
			userinfo.setStatus(DataDic.UNAUTHEN);
			userinfo.setIscompleteinfo(DataDic.ISCOMPLETEINFO);
			userinfo.setCreateDate(user.getCreateDate());
			userinfo.setUpdateDate(user.getUpdateDate());
			userinfo.setRegisterway(DataDic.REG_WLPT);
			userinfo.setCreateBy(user);
			userinfo.setUpdateBy(user);
			user.setUserinfo(userinfo);
			
			////如果是企业信息则保存一条公司记录信息
			if (DataDic.ROLE_ENTERPRISE.equals(user.getRole().getEnname())){
				UserCompany userCompany=new UserCompany();
				userCompany.setId(IdGen.uuid());
				userCompany.setUser(user);
				userCompany.setCreateDate(user.getCreateDate());
				userCompany.setUpdateDate(user.getUpdateDate());
				userCompany.setUpdateBy(user);
				userCompany.setCreateBy(user);
				userCompanyDao.insert(userCompany);
				userinfo.setUserCompany(userCompany);
			}
			//新用户注册获得积分
			userinfoDao.insert(userinfo);
			integrityBiz.updateIntegrityPoint(userinfo,DataDic.INTEGRITY_POINT_REGISTRATION,user.getUserType());
			///初始化账户钱包信息
			UserPurse userPurse=new UserPurse();
			userPurse.setId(IdGen.uuid());
			userPurse.setUser(user);
			userPurse.setCreateDate(user.getCreateDate());
			userPurse.setUpdateDate(user.getUpdateDate());
			userPurse.setUpdateBy(user);
			userPurse.setCreateBy(user);
			userPurse.setSettlestatus(DataDic.SETTLESTATUS);

			userPurseDao.insert(userPurse);

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
			//systemService.saveActivitiUser(user);
			// 清除用户缓存
			UserUtils.clearCache(user);
			UserUtils.putCache(UserUtils.USER_CACHE, user);
//			// 清除权限缓存
//			systemRealm.clearAllCachedAuthorizationInfo();
		}
		return varList;
	}

	/***
	 * 注册用户
	 * @param user
	 * @return
	 */
	@Transactional(readOnly = false)
	public List<Role> userRegisterSave(User user,Driver driver){
		List<Role> varList=new ArrayList<>();
		if (StringUtils.isBlank(user.getId())) {
			user.preInsert();
			///获取角色信息
			Role userRole=roleDao.getByEnname(user.getRole());
			user.setRole(userRole);
			user.setOffice(userRole.getOffice());
			Office office=officeDao.get(DataDic.COMPANYID);

			////赋值所属模块公司
			user.setCompany(office);
			user.getRoleList().add(user.getRole());
			user.setCreateBy(user);
			user.setUpdateBy(user);
			user.setUserType(user.getRole().getEnname());
			userDao.insert(user);

			////赋值用户基本信息保存
			Userinfo userinfo = new Userinfo();
			userinfo.setId(IdGen.uuid());
			userinfo.setUser(user);
			userinfo.setStatus(DataDic.UNAUTHEN);
			userinfo.setIscompleteinfo(DataDic.ISCOMPLETEINFO);
			userinfo.setCreateDate(user.getCreateDate());
			userinfo.setUpdateDate(user.getUpdateDate());
			userinfo.setRegisterway(DataDic.REG_WLPT);
			userinfo.setCreateBy(user);
			userinfo.setUpdateBy(user);
			user.setUserinfo(userinfo);
			////如果是企业信息则保存一条公司记录信息
			if (DataDic.ROLE_ENTERPRISE.equals(user.getRole().getEnname())){
				UserCompany userCompany=new UserCompany();
				userCompany.setId(IdGen.uuid());
				userCompany.setUser(user);
				userCompany.setCreateDate(user.getCreateDate());
				userCompany.setUpdateDate(user.getUpdateDate());
				userCompany.setUpdateBy(user);
				userCompany.setCreateBy(user);
				userCompanyDao.insert(userCompany);
				userinfo.setUserCompany(userCompany);
			}

			userinfoDao.insert(userinfo);
			///初始化账户钱包信息
			UserPurse userPurse=new UserPurse();
			userPurse.setId(IdGen.uuid());
			userPurse.setUser(user);
			userPurse.setCreateDate(user.getCreateDate());
			userPurse.setUpdateDate(user.getUpdateDate());
			userPurse.setUpdateBy(user);
			userPurse.setCreateBy(user);
			userPurse.setSettlestatus(DataDic.SETTLESTATUS);

			userPurseDao.insert(userPurse);

			if(driver!=null){
				driver.setId(IdGen.uuid());
				driver.setUser(user);
				driver.setCreateBy(user);
				driver.setUpdateBy(user);
				driverService.save(driver);
			}

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
			//systemService.saveActivitiUser(user);
			// 清除用户缓存
			UserUtils.clearCache(user);
			UserUtils.putCache(UserUtils.USER_CACHE, user);
//			// 清除权限缓存
//			systemRealm.clearAllCachedAuthorizationInfo();
		}
		return varList;
	}


	/***
	 * 根据用户对象中的唯一性参数获取用户
	 * loginName
	 * phone
	 * email
	 * @param user
	 * @return
     */
	public List<User> getByUser(User user){
		return userDao.getByUser(user);
	}
	
	public User getById(String id){
		return userDao.get(id);
	}

	/**
	 * 查询用户登录 数
	 * 
	 * @param user
	 * @return
	 */
	public int findLoginCount(User user){
		return userDao.findLoginCount(user);
	}
	
	/**
	 * 更新用户明文密码
	 * @param plainpwd
	 * @param id
	 * @return
	 */
    @Transactional(readOnly = false)
	public void updateplainpwd(String plainpwd,String id){
    	User user = new User();
    	user.setId(id);
    	user.setSearchinfo(plainpwd);
		userDao.updateplainpwd(user);
	}
    
    /**
	 * 更新用户是否绑定pos机
	 * @param isposuser
	 * @param id
	 * @return
	 */
    @Transactional(readOnly = false)
	public void updateisposuser(String isposuser,String id){
    	User user = new User();
    	user.setId(id);
    	user.setIsposuser(isposuser);
		userDao.updateisposuser(user);
	}
    
    /**
	 * 查询Member用户
	 * 
	 * @param user
	 * @return
	 */
	public List<User> getMemberList(){
		return userDao.getMemberList();
	}
    
	public UserFlow getByFlowId(UserFlow userFlow){
		return userFlowDao.getByFlowId(userFlow);
	}
	@Transactional(readOnly = false)
	public void saveFlow(UserFlow userFlow){
		userFlowDao.saveFlow(userFlow);
	}
	
	/*public User get(String id) {
		return super.get(id);
	}
	
	public List<User> findList(User User) {
		return super.findList(User);
	}
	
	public Page<User> findPage(Page<User> page, User User) {
		return super.findPage(page, User);
	}
	
	@Transactional(readOnly = false)
	public void save(User User) {
		super.save(User);
	}
	
	@Transactional(readOnly = false)
	public void delete(User User) {
		super.delete(User);
	}*/
	
}