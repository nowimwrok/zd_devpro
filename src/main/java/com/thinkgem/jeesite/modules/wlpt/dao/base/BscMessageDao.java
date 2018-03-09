/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;

/**
 * 消息通知DAO接口
 * @author fjc
 * @version 2017-11-15
 */
@MyBatisDao
public interface BscMessageDao extends CrudDao<BscMessage> {

    /**
     * 统计未读消息数
     * @return
     */
    public BscMessage sumUnRead(BscMessage bscMessage);
	
}