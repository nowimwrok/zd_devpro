/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;

import java.util.List;

/**
 * gps车辆定位信息DAO接口
 * @author 王铸
 * @version 2016-09-06
 */
@MyBatisDao
public interface GpsCarLocsDao extends CrudDao<GpsCarLocs> {

    public List<GpsCarLocs> findByGroup(String[] GpsCarLocs);
    
    public String  maxid();
    
    public int insert(GpsCarLocs gpsCarLocs);
    
    public int update(GpsCarLocs gpsCarLocs);
}