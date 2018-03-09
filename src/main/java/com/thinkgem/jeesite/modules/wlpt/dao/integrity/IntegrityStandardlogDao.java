/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.integrity;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandardlog;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.IntegrityRecordVO;

/**
 * 诚信积分日志DAO接口
 * @author 刘欣
 * @version 2016-09-13
 */
@MyBatisDao
public interface IntegrityStandardlogDao extends CrudDao<IntegrityStandardlog> {

    /**
     * 获取积分统计
     * @param integrityStandardlog
     * @return
     */
	public List<IntegrityStandardlog> findSumPointvalueData(IntegrityStandardlog integrityStandardlog);

    /**
     * 获取积分统计报表
     * @param integrityRecordVO
     * @return
     */
    public List<IntegrityRecordVO> findSumPointvalueList(IntegrityRecordVO integrityRecordVO);

}