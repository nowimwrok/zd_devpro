/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.card;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.card.AccountUserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;

/**
 * 一卡通消费记录明细DAO接口
 * @author fjc
 * @version 2016-09-29
 */
@MyBatisDao
public interface UserMetroCardRecordDao extends CrudDao<UserMetroCardRecord> {

	 /**
     * 一卡通用户消费统计列表
     * @param accountUserMetroCard
     * @return
     */
    public List<AccountUserMetroCard>  findAccountList(AccountUserMetroCard accountUserMetroCard);
    
    /**
     * 一卡通POS机消费统计列表
     * @param accountUserMetroCard
     * @return
     */
    public List<AccountUserMetroCard>  findPOSAccountList(AccountUserMetroCard accountUserMetroCard);
    
    
    /**
     * 更新记录的卡号
     * @param userMetroCardRecord
     * @return
     */
    public int updateCarId(UserMetroCardRecord userMetroCardRecord);
    
    /**
     * 一卡通用户消费明细列表
     * @param userMetroCardRecord
     * @return
     */
    public List<UserMetroCardRecord>  finditemList(UserMetroCardRecord userMetroCardRecord);
    
    /**
     * 一卡通用户消费明细列表导出
     * @param recordVO
     * @return
     */
    public List<UserMetroCardRecordVO>  finditembyexportList(UserMetroCardRecordVO recordVO);
    
    
}