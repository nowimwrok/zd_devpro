/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.card;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;

/**
 * 用户一卡通DAO接口
 * @author 刘欣
 * @version 2016-09-18
 */
@MyBatisDao
public interface UserMetroCardDao extends CrudDao<UserMetroCard> {

    public UserMetroCard getUserMetroCardByCardId(String cardId);
	
    /**
     * 根据对象获取最新一条数据
     * @param userMetroCard
     * @return
     */
    public UserMetroCard getUserMetroCardByUserId(UserMetroCard userMetroCard);
}