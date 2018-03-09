/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.bid;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;

/**
 * 招标信息DAO接口
 * @author 刘欣
 * @version 2016-08-02
 */
@MyBatisDao
public interface BidinfoDao extends CrudDao<Bidinfo> {

	/**
	 * 获取最新的前几条数据显示在个人中心首页
	 * @param userid
	 * @return
	 */
	public List<Bidinfo> findNewBidList(String userid);
	
}