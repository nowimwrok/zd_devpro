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
import com.thinkgem.jeesite.modules.wlpt.entity.comment.Ratingscale;
import com.thinkgem.jeesite.modules.wlpt.dao.comment.RatingscaleDao;

/**
 * 总体交易评分表Service
 * @author 王铸
 * @version 2016-08-31
 */
@Service
@Transactional(readOnly = true)
public class RatingscaleService extends CrudService<RatingscaleDao, Ratingscale> {

	@Autowired
	private RatingscaleDao RatingscaleDao;

	public Ratingscale get(String id) {
		return super.get(id);
	}



	public List<Ratingscale> findList(Ratingscale ratingscale) {
		return super.findList(ratingscale);
	}
	
	public Page<Ratingscale> findPage(Page<Ratingscale> page, Ratingscale ratingscale) {
		return super.findPage(page, ratingscale);
	}
	
	@Transactional(readOnly = false)
	public void save(Ratingscale ratingscale) {
		super.save(ratingscale);
	}
	
	@Transactional(readOnly = false)
	public void delete(Ratingscale ratingscale) {
		super.delete(ratingscale);
	}
	
}