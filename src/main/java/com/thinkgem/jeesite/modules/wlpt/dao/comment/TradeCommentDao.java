/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.comment;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.TradeComment;

/**
 * 交易评论DAO接口
 * @author 王铸
 * @version 2016-08-31
 */
@MyBatisDao
public interface TradeCommentDao extends CrudDao<TradeComment> {

	public List<TradeComment> findByUser(User user);
}