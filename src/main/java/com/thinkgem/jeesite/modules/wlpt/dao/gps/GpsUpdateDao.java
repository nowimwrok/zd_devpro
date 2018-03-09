/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.dao.gps;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.gps.GpsUpdate;

/**
 * 这是个测试类DAO接口
 * @author leifeng
 * @version 2017-09-05
 */
@MyBatisDao
public interface GpsUpdateDao extends CrudDao<GpsUpdate> {
//	public int insert(GpsUpdate gpsUpdate);
	public List<GpsUpdate> getByPushFlag(@Param("pushFlag") String pushFlag);
}