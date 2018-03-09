/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.collection;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;

/**
 * 我关注的路线信息DAO接口
 * @author zyj
 * @version 2017-04-19
 */
@MyBatisDao
public interface WlptCollectionDao extends CrudDao<WlptCollection> {

	/***
	 * 获取当前条数
	 * @return  获取条数:int类型
	 */
	public int countcollection(WlptCollection wlptCollection);
}