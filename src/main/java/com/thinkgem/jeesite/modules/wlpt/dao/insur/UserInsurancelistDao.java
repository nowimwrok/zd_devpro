/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.insur;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurancelist;

/**
 * 保险品种管理DAO接口
 * @author zyj
 * @version 2017-03-09
 */
@MyBatisDao
public interface UserInsurancelistDao extends CrudDao<UserInsurancelist> {

	
}