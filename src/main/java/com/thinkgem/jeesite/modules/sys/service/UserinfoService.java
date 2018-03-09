/**
 * 
 */
package com.thinkgem.jeesite.modules.sys.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

import com.thinkgem.jeesite.modules.sys.dao.UserinfoDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户管理Service
 * @author 饶江龙
 * @version 2016-07-13
 */
@Service
@Transactional(readOnly = true)
public class UserinfoService extends CrudService<UserinfoDao, Userinfo> {

	@Autowired
	private SystemService systemService;

	@Autowired
	private UserinfoDao userinfoDao;

	public Userinfo get(String id) {
		return super.get(id);
	}

	public List<Userinfo> findAll(){
		return super.findList(new Userinfo());
	}
	
	public List<Userinfo> findList(Userinfo Userinfo) {
		return super.findList(Userinfo);
	}
	
	public Page<Userinfo> findPage(Page<Userinfo> page, Userinfo Userinfo) {
		return super.findPage(page, Userinfo);
	}

	public Userinfo ValidateQQ(Userinfo userinfo){
		return userinfoDao.ValidateQQ(userinfo);
	}
	public Userinfo ValidateLoginName(Userinfo userinfo){
		return userinfoDao.ValidateLoginName(userinfo);
	}
	/***
	 * 更改用提现密码
	 * @param id  用户表主键ID
	  登录名  更新缓存
	 * @param newPassword  新密码
     */
	@Transactional(readOnly = false)
	public void updateCashPwdById(String id, String newPassword) {
		Userinfo userinfo=get(id);
		String password = systemService.entryptPassword(newPassword);
		userinfo.setCashpassword(password);
		userinfoDao.updateCashPwdById(userinfo);
		// 清除用户缓存
		User user =new User(UserUtils.getUser().getId());
		user.setLoginName(user.getLoginName());
		UserUtils.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}


	@Transactional(readOnly = false)
	public void save(Userinfo Userinfo) {

		super.save(Userinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Userinfo Userinfo) {
		super.delete(Userinfo);
	}
	
	/**
	 * 通过userinfoid获取包括idcard信息
	 * @param id
	 * @return
	 */
	public Userinfo getAndIdcard(String id){
		return userinfoDao.getAndIdcard(id);
	}
	
	/**
	 * 清空openid
	 * @return
	 */
	@Transactional(readOnly = false)
	public void updateOpenIdByOpenId(String openId){
		 userinfoDao.updateOpenIdByOpenId(openId);
	}
}