/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.activity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;

/**
 * 中奖记录DAO接口
 * @author 曾煜佳
 * @version 2016-08-04
 */
@MyBatisDao
public interface ActivityAwardrecordDao extends CrudDao<ActivityAwardrecord> {
    /**
     * 根据用户手机和活动id获取中奖记录
     * @param activityAwardrecord
     * @return
     */
    public ActivityAwardrecord getAwardlistInfo(ActivityAwardrecord activityAwardrecord);

    /**
     * 更新已过期的奖品
     */
    public void updateIsSueInvalid();

    /**
     * 更新为已发放状态
     */
    public void updateIsSueGrant();

    /**
     * 更新奖品状态
     * @param activityAwardrecord
     */
    public void updateIsSue(ActivityAwardrecord activityAwardrecord);

    /**
     * 根据中奖编号获取中奖记录
     * @param awardno
     * @return
     */
    public ActivityAwardrecord getAwardlistInfoByAwardNo(String awardno);
}