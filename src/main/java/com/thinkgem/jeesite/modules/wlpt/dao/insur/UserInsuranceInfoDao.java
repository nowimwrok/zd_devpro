/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.insur;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsuranceInfo;

/**
 * 保险险种记录DAO接口
 * @author zyj
 * @version 2017-11-17
 */
@MyBatisDao
public interface UserInsuranceInfoDao extends CrudDao<UserInsuranceInfo> {

	
}