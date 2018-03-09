/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.goods;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;

/**
 * 货源管理数据DAO接口
 * @author 饶江龙
 * @version 2016-07-25
 */
@MyBatisDao
public interface GoodsDao extends CrudDao<Goods> {


    /***
     * 更新货源报价次数
     * @param goods
     * @return
     */
    int updateQuoteCount(Goods goods);

    /***
     * 更新货源点击量
     * @param goods
     * @return
     */
    int updatePraiseNumber(Goods goods);

    /***
     * 更新货源浏览量
     * @param goods
     * @return
     */
    int updatePageViews(Goods goods);

    /**
     * 发布零担货源页面 获取提货单关联的招标信息数据
     * @param userId
     * @param goodsId
     * @return
     */
    Goods getBLgoodsData(String userId, String goodsId);
    
    /**
     * 货源统计
     * @param page
     * @param goods
     * @return
     */
    List<Goods> findSumGoodsList(Goods goods);
}