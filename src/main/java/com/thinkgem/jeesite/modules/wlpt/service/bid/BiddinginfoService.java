/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.bid;

import java.util.List;

import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.bid.BiddinginfoDao;

/**
 * 竞标信息Service
 * @author 刘欣
 * @version 2016-08-03
 */
@Service
@Transactional(readOnly = true)
public class BiddinginfoService extends CrudService<BiddinginfoDao, Biddinginfo> {

	@Autowired
	private BiddinginfoDao biddinginfoDao;

	public Biddinginfo get(String id) {
		return super.get(id);
	}
	
	/**
	 * 获取最新的三条竞标信息
	 * @param userid
	 * @return
	 */
	public List<Biddinginfo> getNewBiddingList(String userid){
		return biddinginfoDao.findNewBiddingList(userid);
	}
	
	/**
	 * 获取当前用户今天投标的总吨数 
	 * @param userid
	 * @return
	 */
	public double getCountNum(String userid){
		Double value = biddinginfoDao.countNum(userid);
		return value==null?0:value.doubleValue();
	}
	
	public Biddinginfo findByBidIdAndUserId(String bidId,String userId){
		return biddinginfoDao.findByBidIdAndUserId(bidId, userId);
	}

	public List<Biddinginfo> findList(Biddinginfo biddinginfo) {
		return super.findList(biddinginfo);
	}
	
	public List<Biddinginfo> findByBidId(String bidId){
		return biddinginfoDao.findByBidId(bidId);
	}
	
	public Page<Biddinginfo> findPage(Page<Biddinginfo> page, Biddinginfo biddinginfo) {
		return super.findPage(page, biddinginfo);
	}
	
	@Transactional(readOnly = false)
	public void save(Biddinginfo biddinginfo) {
		super.save(biddinginfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Biddinginfo biddinginfo) {
		super.delete(biddinginfo);
	}
	
}