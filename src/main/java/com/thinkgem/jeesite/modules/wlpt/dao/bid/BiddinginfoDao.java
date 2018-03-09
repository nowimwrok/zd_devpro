/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.bid;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;

/**
 * 竞标信息DAO接口
 * @author 刘欣
 * @version 2016-08-03
 */
@MyBatisDao
public interface BiddinginfoDao extends CrudDao<Biddinginfo> {

	public List<Biddinginfo> findByBidId(String bidId);
	
	public Biddinginfo findByBidIdAndUserId(String bidId,String userId);
	
	/**
	 * 获取最新的前几条数据显示在个人中心首页
	 * @param userid
	 * @return
	 */
	public List<Biddinginfo> findNewBiddingList(String userid);
	
	/**
	 * 获取当前用户今天投标的总吨数 
	 * @param userid
	 * @return
	 */
	public Double countNum(String userid);
}