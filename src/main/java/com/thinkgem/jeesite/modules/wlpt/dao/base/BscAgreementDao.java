/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.base;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.Map;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscAgreement;

/**
 * 系统文案DAO接口
 * @author 王铸
 * @version 2016-08-03
 */
@MyBatisDao
public interface BscAgreementDao extends CrudDao<BscAgreement> {

	/**
	 * 批量删除
	 * @param map
	 * @return
	 */
	public void deleteAll(Map<String,String> map);
}