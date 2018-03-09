/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.freightrate;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightratePriceinfo;

/**
 * 历史运价DAO接口
 * @author 曾煜佳
 * @version 2016-08-03
 */
@MyBatisDao
public interface FreightratePriceinfoDao extends CrudDao<FreightratePriceinfo> {
	//平均价格
public List<FreightratePriceinfo> findPrices(FreightratePriceinfo freightratePriceinfo);
	
}