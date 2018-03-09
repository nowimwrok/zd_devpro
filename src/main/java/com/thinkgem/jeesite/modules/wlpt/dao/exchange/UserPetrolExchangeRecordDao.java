/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.exchange;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchange;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchangeRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;

/**
 * 油气兑换余额关系表DAO接口
 * @author zyj
 * @version 2017-02-15
 */
@MyBatisDao
public interface UserPetrolExchangeRecordDao extends CrudDao<UserPetrolExchangeRecord> {

	/**
	 * 批量添加
	 * @param userPetrolExchangeRecord
	 */
	void insertExchange(UserPetrolExchangeRecord userPetrolExchangeRecord);
	/**
	 * 修改消费记录状态
	 * @param userPetrolExchangeRecord
	 */
	void updateUserCardStatus(UserPetrolExchangeRecord userPetrolExchangeRecord);
	
	/**
	 * 批量修改关系表状态
	 * @param userPetrolExchangeRecord
	 */
	void updateStatus(UserPetrolExchangeRecord userPetrolExchangeRecord);
	
	/**
	 * 获取消费记录
	 * @param userMetroCardRecord
	 * @return
	 */
	List<UserMetroCardRecord> getPetrolExchangeRecordInfo(UserMetroCardRecord userMetroCardRecord);
	
	/*导出消费记录
	 * @param exchangeNo
	 * @return
	 */
	List<UserMetroCardRecordVO> getPetrolExchangeRecordbyExportList(String exchangeNo);
	
	
	
}