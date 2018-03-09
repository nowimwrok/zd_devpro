/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.integrity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandard;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandarditems;

/**
 * 诚信标准评分项DAO接口
 * @author 刘欣
 * @version 2016-09-13
 */
@MyBatisDao
public interface IntegrityStandarditemsDao extends CrudDao<IntegrityStandarditems> {

	List<IntegrityStandarditems> findList(IntegrityStandarditems integrityStandarditems);
	
	List<IntegrityStandarditems> getByName(IntegrityStandarditems integrityStandarditems);
}