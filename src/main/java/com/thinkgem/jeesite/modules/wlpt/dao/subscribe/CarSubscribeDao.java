/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.subscribe;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.subscribe.CarSubscribe;

/**
 * 车辆与自定义区域绑定DAO接口
 * @author 车辆订阅
 * @version 2017-10-10
 */
@MyBatisDao
public interface CarSubscribeDao extends CrudDao<CarSubscribe> {
	//回调用
	public List<CarSubscribe> findByCallback(CarSubscribe carSubscribe);
}