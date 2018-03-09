/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.exchange;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchange;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchangeRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;
import com.thinkgem.jeesite.modules.wlpt.dao.exchange.UserPetrolExchangeRecordDao;

/**
 * 油气兑换余额关系表Service
 * @author zyj
 * @version 2017-02-15
 */
@Service
@Transactional(readOnly = true)
public class UserPetrolExchangeRecordService extends CrudService<UserPetrolExchangeRecordDao, UserPetrolExchangeRecord> {

	@Autowired
	private UserPetrolExchangeRecordDao userPetrolExchangeRecordDao;

	public UserPetrolExchangeRecord get(String id) {
		return super.get(id);
	}



	public List<UserPetrolExchangeRecord> findList(UserPetrolExchangeRecord userPetrolExchangeRecord) {
		return super.findList(userPetrolExchangeRecord);
	}
	
	public Page<UserPetrolExchangeRecord> findPage(Page<UserPetrolExchangeRecord> page, UserPetrolExchangeRecord userPetrolExchangeRecord) {
		return super.findPage(page, userPetrolExchangeRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(UserPetrolExchangeRecord userPetrolExchangeRecord) {
		super.save(userPetrolExchangeRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserPetrolExchangeRecord userPetrolExchangeRecord) {
		super.delete(userPetrolExchangeRecord);
	}
	
	/**
	 * 批量添加
	 * @param userPetrolExchangeRecord
	 */
	@Transactional(readOnly = false)
	public void insertExchange(UserPetrolExchangeRecord userPetrolExchangeRecord){
		userPetrolExchangeRecordDao.insertExchange(userPetrolExchangeRecord);
	}
	/**
	 * 修改消费记录状态
	 * @param userPetrolExchangeRecord
	 */
	@Transactional(readOnly = false)
	public void updateUserCardStatus(UserPetrolExchangeRecord userPetrolExchangeRecord){
		userPetrolExchangeRecordDao.updateUserCardStatus(userPetrolExchangeRecord);
	}
	
	/**
	 * 批量修改关系表状态
	 * @param userPetrolExchangeRecord
	 */
	@Transactional(readOnly = false)
	public void updateStatus(UserPetrolExchangeRecord userPetrolExchangeRecord){
		userPetrolExchangeRecordDao.updateStatus(userPetrolExchangeRecord);
	}
	
	/**
	 * 获取消费记录
	 * @param userMetroCardRecord
	 * @return
	 */
	public Page<UserMetroCardRecord> getPetrolExchangeRecordList(Page<UserMetroCardRecord> page, UserMetroCardRecord userMetroCardRecord){
		userMetroCardRecord.setPage(page);
		page.setList(userPetrolExchangeRecordDao.getPetrolExchangeRecordInfo(userMetroCardRecord));
		return page;
	}
	/**
	 * 获取消费记录
	 * @param exchangeNo
	 * @return
	 */
	public List<UserMetroCardRecord> getPetrolExchangeRecordInfo(String exchangeNo){
		UserMetroCardRecord userMetroCardRecord = new UserMetroCardRecord();
		userMetroCardRecord.setExchangeNo(exchangeNo);
		return userPetrolExchangeRecordDao.getPetrolExchangeRecordInfo(userMetroCardRecord);
	}
	/**
	 * 导出消费记录
	 * @param exchangeNo
	 * @return
	 */
	public List<UserMetroCardRecordVO> getPetrolExchangeRecordbyExportList(String exchangeNo){
		return userPetrolExchangeRecordDao.getPetrolExchangeRecordbyExportList(exchangeNo);
	}
		
}