/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.exchange;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchange;

/**
 * 油气兑换余额审核DAO接口
 * @author zyj
 * @version 2017-02-15
 */
@MyBatisDao
public interface UserPetrolExchangeDao extends CrudDao<UserPetrolExchange> {

	/**
	 * 修改开票状态
	 * @param userPetrolExchange
	 * @return
	 */
	public int updateInvoiceStatus(UserPetrolExchange userPetrolExchange);
}