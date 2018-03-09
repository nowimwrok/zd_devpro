/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.interfacelog;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;

/**
 * 接口令牌生成DAO接口
 * @author qiao
 * @version 2017-11-13
 */
@MyBatisDao
public interface InterfaceTokenDao extends CrudDao<InterfaceToken> {

	
}