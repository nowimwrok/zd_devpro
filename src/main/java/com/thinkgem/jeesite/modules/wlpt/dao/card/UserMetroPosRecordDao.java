/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.card;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPosRecord;

/**
 * 一卡通pos机绑定记录DAO接口
 * @author zyj
 * @version 2016-12-22
 */
@MyBatisDao
public interface UserMetroPosRecordDao extends CrudDao<UserMetroPosRecord> {

	
}