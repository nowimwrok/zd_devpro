/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.railregist;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.railregist.RailRegist;

/**
 * 自定义区域注册DAO接口
 * @author renshuai
 * @version 2017-10-10
 */
@MyBatisDao
public interface RailRegistDao extends CrudDao<RailRegist> {
	public int deleteByAreaid(RailRegist railRegist);
	public List<RailRegist> findByOrderid(RailRegist railRegist);
	//回调用
	public RailRegist findByCallback(RailRegist railRegist);
	public List<RailRegist> findByRailName(RailRegist railRegist);
}