/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.comment;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.dao.comment.TradeCommentDao;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.TradeComment;

/**
 * 交易评论Service
 * @author 王铸
 * @version 2016-08-31
 */
@Service
@Transactional(readOnly = true)
public class TradeCommentService extends CrudService<TradeCommentDao, TradeComment> {

	@Autowired
	private TradeCommentDao tradeCommentDao;

	public TradeComment get(String id) {
		return super.get(id);
	}



	public List<TradeComment> findList(TradeComment tradeComment) {
		return super.findList(tradeComment);
	}
	
	public Page<TradeComment> findPage(Page<TradeComment> page, TradeComment tradeComment) {
		return super.findPage(page, tradeComment);
	}
	
	@Transactional(readOnly = false)
	public void save(TradeComment tradeComment) {
		super.save(tradeComment);
	}
	
	@Transactional(readOnly = false)
	public void delete(TradeComment tradeComment) {
		super.delete(tradeComment);
	}
	
	public List<TradeComment> findByUser(User user){
		return tradeCommentDao.findByUser(user);
	}
}