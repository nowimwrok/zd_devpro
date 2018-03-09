/**
 * 
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Menu;

/**
 * 菜单DAO接口
 * @author 
 * @version 2014-05-16
 */
@MyBatisDao
public interface MenuDao extends CrudDao<Menu> {

	public List<Menu> findByParentIdsLike(Menu menu);

	public List<Menu> findByUserId(Menu menu);

	/**
	 * 获取平台用户中心菜单
	 * @param menu
	 * @return
     */
	public List<Menu> findByWlptUserMenu(Menu menu);

	/***
	 * 获取导航菜单
	 * @param menu
	 * @return
     */
	public List<Menu> findNavByParentIdsLike(Menu menu);

	
	public int updateParentIds(Menu menu);
	
	public int updateSort(Menu menu);
	
}
