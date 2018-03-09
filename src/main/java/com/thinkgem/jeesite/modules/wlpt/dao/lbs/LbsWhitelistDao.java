/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.lbs;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsWhitelist;

/**
 * LBS白名单DAO接口
 * @author zyj
 * @version 2016-10-10
 */
@MyBatisDao
public interface LbsWhitelistDao extends CrudDao<LbsWhitelist> {

	
}