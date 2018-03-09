/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BcIdGenerator;

/**
 * 业务结算单号DAO接口
 * @author zyj
 * @version 2017-05-18
 */
@MyBatisDao
public interface BcIdGeneratorDao extends CrudDao<BcIdGenerator> {

	/**
	 * 获取新的业务结算单号
	 * @param bcIdGenerator
	 * @return
	 */
	BcIdGenerator getNewIdGeneratorInfo(BcIdGenerator bcIdGenerator);
	
	/**
	 * 获取最新的业务结算单号
	 * @param bcIdGenerator
	 * @return
	 */
	BcIdGenerator getIdGeneratorByPrefix(String prefix);
}