/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.integrity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityEnterprise;

/**
 * 诚信企业DAO接口
 * @author fjc
 * @version 2016-07-27
 */
@MyBatisDao
public interface IntegrityEnterpriseDao extends CrudDao<IntegrityEnterprise> {

	/**
	 * 获取企业诚信信息
	 * @param integrityEnterprise
	 * @return
	 */
	public IntegrityEnterprise findEnterprise(IntegrityEnterprise integrityEnterprise);
}