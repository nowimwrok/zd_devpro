/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.comment;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.Ratingscale;

/**
 * 总体交易评分表DAO接口
 * @author 王铸
 * @version 2016-08-31
 */
@MyBatisDao
public interface RatingscaleDao extends CrudDao<Ratingscale> {

	
}