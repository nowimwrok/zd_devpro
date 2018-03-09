/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.ChinaArea;

import java.util.List;

/**
 * 获取中国地址信息DAO接口
 * @author 饶江龙
 * @version 2016-07-24
 */
@MyBatisDao
public interface BaseChinaAreaDao extends CrudDao<ChinaArea> {

    /***
     * 通过 chinaarea获取信息列表
     * @param chinaarea
     * @return
     */
    List<ChinaArea> getAreaByCondition(ChinaArea chinaarea);
}