/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.freightrate;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;

/**
 * 线路DAO接口
 * @author 曾煜佳
 * @version 2016-08-03
 */
@MyBatisDao
public interface FreightrateLineDao extends CrudDao<FreightrateLine> {

	/**
	 * 根据地址获取最新的线路运价信息
	 * @param freightrateLine
	 * @return
	 */
	FreightrateLine getLineInfo(FreightrateLine freightrateLine);
}