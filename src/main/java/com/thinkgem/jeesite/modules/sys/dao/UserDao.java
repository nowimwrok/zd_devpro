/**
 * 
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;

/**
 * 用户DAO接口
 * 
 * @author
 * @version 2014-05-16
 */
@MyBatisDao
public interface UserDao extends CrudDao<User> {

	/**
	 * 根据登录名称查询用户
	 * 
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(User user);
	
	/**
	 * 根据登录名称查询用户(导入)
	 * 
	 * @param loginName
	 * @return
	 */
	public User getImportUserByLoginName(User user);

	/**
	 * 获取用户数据，获取的数据较少，只获取用户表、用户信息表和金额表的数据
	 * 
	 * @param user
	 * @return
	 */
	public User getByCondition(User user);
	
	/**
	 * 获取明文密码，该接口只用于 微信绑定自动登录功能其他地方慎用
	 * @param openid
	 * @return
	 */
	public String getPlainpwd(String openid);
	
	/***
	 * 根据用户对象中的唯一性参数获取用户 loginName phone email
	 * 
	 * @param user
	 * @return
	 */
	public List<User> getByUser(User user);

	/**
	 * 通过OfficeId获取用户列表，仅返回用户id和name（树查询用户时用）
	 * 
	 * @param user
	 * @return
	 */
	public List<User> findUserByOfficeId(User user);

	/**
	 * 查询全部用户数目
	 * 
	 * @return
	 */
	public long findAllCount(User user);

	/**
	 * 更新用户密码
	 * 
	 * @param user
	 * @return
	 */
	public int updatePasswordById(User user);

	/**
	 * 更新登录信息，如：登录IP、登录时间
	 * 
	 * @param user
	 * @return
	 */
	public int updateLoginInfo(User user);

	/**
	 * 删除用户角色关联数据
	 * 
	 * @param user
	 * @return
	 */
	public int deleteUserRole(User user);

	/**
	 * 插入用户角色关联数据
	 * 
	 * @param user
	 * @return
	 */
	public int insertUserRole(User user);

	public int insertUserInfo(User user);

	/**
	 * 更新用户信息
	 * 
	 * @param user
	 * @return
	 */
	public int updateUserInfo(User user);
	
	/**
	 * 更新用户明文密码
	 * @param user
	 * @return
	 */
	public int updateplainpwd(User user);
	
	/**
	 * 更新用户是否绑定pos机
	 * @param user
	 * @return
	 */
	public int updateisposuser(User user);
	

	/**
	 * 获取子账户信息
	 * 
	 * @param user
	 * @return
	 */
	public List<User> getMyuserfindList(User user);
	
	/**
	 * 查询用户登录 数
	 * 
	 * @param user
	 * @return
	 */
	public int findLoginCount(User user);
	
	/**
	 * 根据手机号码查询系统用户
	 * 
	 * @param user
	 * @return
	 */
	public long getSysUserByPhone(User user);
	
	/**
	 * 查询Member用户
	 * 
	 * @param user
	 * @return
	 */
	public List<User> getMemberList();

}
