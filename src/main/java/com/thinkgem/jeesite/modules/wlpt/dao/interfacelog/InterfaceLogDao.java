/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.interfacelog;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceLog;

/**
 * 接口调用日志信息DAO接口
 * @author W
 * @version 2017-10-16
 */
@MyBatisDao
public interface InterfaceLogDao extends CrudDao<InterfaceLog> {

	public List<InterfaceLog> findcount ();
	
}