/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.dao.interfacelog;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.Travelinformation;


/**
 * 存储信息DAO接口
 * @author qiao
 * @version 2017-09-29
 */
@MyBatisDao
public interface TravelinformationDao extends CrudDao<Travelinformation> {
	
	Travelinformation getBycarid(Travelinformation travelinformation);
}