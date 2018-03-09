/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Motorcade;

import java.util.List;


/**
 * 车队DAO接口
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@MyBatisDao
public interface MotorcadeDao extends CrudDao<Motorcade> {

    List<Motorcade> findMotorcadeList(Motorcade motorcade);
}