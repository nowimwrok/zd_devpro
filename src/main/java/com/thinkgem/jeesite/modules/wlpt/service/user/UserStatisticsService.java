/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserStatisticsDao;

/**
 * 用户统计功能Service
 * @author 曾煜佳
 * @version 2016-08-31
 */
@Service
@Transactional(readOnly = true)
public class UserStatisticsService extends CrudService<UserStatisticsDao, UserStatistics> {

	@Autowired
	private UserStatisticsDao userStatisticsDao;

	public UserStatistics get(String id) {
		return super.get(id);
	}
	public UserStatistics getConditon(UserStatistics userStatistics) {
		return userStatisticsDao.getConditon(userStatistics);
	}
	
	//获取诚信统计数据
	public UserStatistics findIntegrityinfo(UserStatistics userStatistics) {
		return userStatisticsDao.findIntegrityinfo(userStatistics);
	}
	/**
	 * 获取当天登陆的用户
	 * @return
	 */
	public  List<UserStatistics> getLoginUsers() {
		return userStatisticsDao.getLoginUsers();
	}
	/**
	 * 获取当天没有登陆的用户
	 * @return
	 */
	public  List<UserStatistics> getWithLoginUsers() {
		return userStatisticsDao.getWithLoginUsers();
	}
	
	public int updateDaysWithoutLogin(UserStatistics userStatistics) {
		return userStatisticsDao.updateDaysWithoutLogin(userStatistics);
	}
	
	public List<UserStatistics> findList(UserStatistics userStatistics) {
		return super.findList(userStatistics);
	}

	public Page<UserStatistics> findPage(Page<UserStatistics> page, UserStatistics userStatistics) {
		return super.findPage(page, userStatistics);
	}

	/**
	 * 查找用户信息
	 * @param page
	 * @param userStatistics
     * @return
     */
	public Page<UserStatistics> findUinfoPage(Page<UserStatistics> page, UserStatistics userStatistics) {
		userStatistics.setPage(page);
		page.setList(userStatisticsDao.findUinfoList(userStatistics));
		return page;
	}
	@Transactional(readOnly = false)
	public void save(UserStatistics userStatistics) {
		super.save(userStatistics);
	}

	@Transactional(readOnly = false)
	public void delete(UserStatistics userStatistics) {
		super.delete(userStatistics);
	}

	/**
	 * 获取记录数据信息--该方法仅用于获取数据统计历史记录
	 * @param userStatistics
	 * @return
     */
	public List<UserStatistics> findrecordList(UserStatistics userStatistics){
		return userStatisticsDao.findrecordList(userStatistics);
	}
	
	/**
	 * 根据对象记录获取信息--该方法仅用于获取数据统计历史记录
	 * @param userStatistics
	 * @return
	 */
	public UserStatistics getRecordConditon(UserStatistics userStatistics){
		return userStatisticsDao.getRecordConditon(userStatistics);
	}
	
	/**
	 * 调用存储过程定时去备份统计记录
	 */
	@Transactional(readOnly = false)
	public void editRecord(){
		userStatisticsDao.editRecord();
	}

}