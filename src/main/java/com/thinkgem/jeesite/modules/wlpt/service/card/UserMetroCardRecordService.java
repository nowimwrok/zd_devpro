/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.card;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.card.AccountUserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;
import com.thinkgem.jeesite.modules.wlpt.dao.card.UserMetroCardRecordDao;

/**
 * 一卡通消费记录明细Service
 * 
 * @author fjc
 * @version 2016-09-29
 */
@Service
@Transactional(readOnly = true)
public class UserMetroCardRecordService extends CrudService<UserMetroCardRecordDao, UserMetroCardRecord> {

	@Autowired
	private UserMetroCardRecordDao userMetroCardRecordDao;

	public UserMetroCardRecord get(String id) {
		return super.get(id);
	}

	public List<UserMetroCardRecord> findList(UserMetroCardRecord userMetroCardRecord) {
		return super.findList(userMetroCardRecord);
	}

	public Page<UserMetroCardRecord> findPage(Page<UserMetroCardRecord> page, UserMetroCardRecord userMetroCardRecord) {
		return super.findPage(page, userMetroCardRecord);
	}
	
	/**
	 * 一卡通消费记录明细列表
	 * @param page
	 * @param userMetroCardRecord
	 * @return
	 */
	public Page<UserMetroCardRecord> finditemList(Page<UserMetroCardRecord> page, UserMetroCardRecord userMetroCardRecord) {
		userMetroCardRecord.setPage(page);
		// 执行分页查询
		List<UserMetroCardRecord> list = new ArrayList<UserMetroCardRecord>();
		list = userMetroCardRecordDao.finditemList(userMetroCardRecord);
		page.setList(list);
		return page;
	}
	
	/**
     * 一卡通用户消费明细列表导出
     * @param recordVO
     * @return
     */
    public List<UserMetroCardRecordVO>  finditembyexportList(UserMetroCardRecordVO recordVO){
	
		return userMetroCardRecordDao.finditembyexportList(recordVO);
	}

	/**
	 * 一卡通消费统计列表
	 * @param page
	 * @param accountUserMetroCard
	 * @return
	 */
	public Page<AccountUserMetroCard> findAccountPage(Page<AccountUserMetroCard> page,
			AccountUserMetroCard accountUserMetroCard) {
		accountUserMetroCard.setPage(page);
		// 执行分页查询
		List<AccountUserMetroCard> list = new ArrayList<AccountUserMetroCard>();
		list = userMetroCardRecordDao.findAccountList(accountUserMetroCard);
		page.setList(list);
		return page;
	}
	
	/**
	 * 一卡通POS消费统计列表
	 * @param page
	 * @param accountUserMetroCard
	 * @return
	 */
	public List<AccountUserMetroCard> findPOSAccountList(AccountUserMetroCard accountUserMetroCard) {
		return userMetroCardRecordDao.findPOSAccountList(accountUserMetroCard);
	}

	@Transactional(readOnly = false)
	public void save(UserMetroCardRecord userMetroCardRecord) {
		super.save(userMetroCardRecord);
	}

	@Transactional(readOnly = false)
	public void delete(UserMetroCardRecord userMetroCardRecord) {
		super.delete(userMetroCardRecord);
	}
	
	/**
	 * 更新记录卡号
	 * @param userMetroCardRecord
	 */
	@Transactional(readOnly = false)
	public void updateCarId(UserMetroCardRecord userMetroCardRecord) {
		userMetroCardRecordDao.updateCarId(userMetroCardRecord);
	}

}