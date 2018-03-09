/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.goods;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;

/**
 * 货源报价管理DAO接口
 * @author 饶江龙
 * @version 2016-07-25
 */
@MyBatisDao
public interface QuoteinfoDao extends CrudDao<Quoteinfo> {

    /**
     * 修改报价信息为报价失败
     * @param quoteinfo
     * @return
     */
    int updateQuoteFiled(Quoteinfo quoteinfo);
}