/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;

/**
 * 车辆gps数据，获取keyDAO接口
 * @author 饶江龙
 * @version 2016-08-17
 */
@MyBatisDao
public interface GpsCarInfoDao extends CrudDao<GpsCarInfo> {

	public GpsCarInfo findByCondition(GpsCarInfo gpsCarInfo);

	public List<GpsCarInfo> findByGroup(String[] gpsCarInfo);

}