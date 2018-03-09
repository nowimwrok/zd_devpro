/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.comment;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.StatisticsOwner;

/**
 * 用户信息统计表DAO接口
 * @author 王铸
 * @version 2016-08-31
 */
@MyBatisDao
public interface StatisticsOwnerDao extends CrudDao<StatisticsOwner> {

	
}