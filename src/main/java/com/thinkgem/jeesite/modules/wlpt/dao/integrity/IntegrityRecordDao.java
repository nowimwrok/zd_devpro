/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.integrity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityRecord;

/**
 * 诚信积分DAO接口
 * @author 刘欣
 * @version 2016-09-13
 */
@MyBatisDao
public interface IntegrityRecordDao extends CrudDao<IntegrityRecord> {

	
}