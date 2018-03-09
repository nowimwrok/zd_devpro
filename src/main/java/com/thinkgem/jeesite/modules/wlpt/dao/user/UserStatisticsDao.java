/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;

import java.util.List;

/**
 * 用户统计功能DAO接口
 * @author 曾煜佳
 * @version 2016-08-31
 */
@MyBatisDao
public interface UserStatisticsDao extends CrudDao<UserStatistics> {

	/**
	 * 根据对象获取信息
	 * @param userStatistics
	 * @return
	 */
	public UserStatistics getConditon(UserStatistics userStatistics);

	/**
	 * 根据对象获取信息用于诚信等级
	 * @param userStatistics
	 * @return
	 */
	public UserStatistics findIntegrityinfo(UserStatistics userStatistics);
	
	/**
	 * 获取当天登陆用户列表
	 * @return
	 */
	public List<UserStatistics> getLoginUsers();
	/**
	 * 获取当天没有登陆登陆用户列表
	 * @return
	 */
	public List<UserStatistics> getWithLoginUsers();
	/**
	 * 更新不登陆天数，已登陆天数请空
	 * @param userStatistics
	 * @return
	 */
	int updateDaysWithoutLogin(UserStatistics userStatistics);
	
	/**
	 * 查找用户信息
	 * @param userStatistics
	 * @return
     */
	public List<UserStatistics> findUinfoList(UserStatistics userStatistics);
	
	/**
	 * 获取记录数据信息--该方法仅用于获取数据统计历史记录
	 * @param userStatistics
	 * @return
     */
	public List<UserStatistics> findrecordList(UserStatistics userStatistics);
	
	/**
	 * 根据对象记录获取信息--该方法仅用于获取数据统计历史记录
	 * @param userStatistics
	 * @return
	 */
	public UserStatistics getRecordConditon(UserStatistics userStatistics);
	/**
	 * 调用存储过程定时去备份统计记录
	 */
	public void editRecord();

}