/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserMessage;

/**
 * 用户消息DAO接口
 * @author fjc
 * @version 2017-11-20
 */
@MyBatisDao
public interface UserMessageDao extends CrudDao<UserMessage> {

    /**
     * 统计未读消息数
     * @return
     */
    public UserMessage sumUnRead(UserMessage userMessage);
}