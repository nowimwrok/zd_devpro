/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.bid;

import com.thinkgem.jeesite.common.persistence.CrudDao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BidBlinfoCountVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BidBlinfoVO;

/**
 * 提货单DAO接口
 *
 * @author 刘欣
 * @version 2016-08-02
 */
@MyBatisDao
public interface BidBlinfoDao extends CrudDao<BidBlinfo> {

    /**
     * 根据ids获取提货单列表
     *
     * @param ids
     * @return
     */
    public List<BidBlinfo> getBLListData(String[] ids);

    /**
     * 修改提货单列表为关闭状态
     *
     * @param blinfo 通过货源ID
     * @return
     */
    public int updateCancelByGoods(BidBlinfo blinfo);

    /**
     * 批量修改提货单状态为已完成
     *
     * @param blinfoList
     * @return
     */
    public int updateTradeSuccess(String[] blinfoList);

    /**
     * 批量修改提货单状态为运输中
     *
     * @param blinfoList
     * @return
     */
    public int updateTradeFreighting(String[] blinfoList);

    /**
     * 批量修改提货单状态为未运输
     *
     * @param blinfoList
     * @return
     */
    public int updateTradeCancel(String[] blinfoList);

    /**
     * 批量修改提货单状态为已发布
     *
     * @param blinfoList
     * @return
     */
    public int updateTradePubGds(String[] blinfoList);

    /**
     * 批量修改提货单状态未发布 招标合同除外
     *
     * @param blinfoList
     * @return
     */
    public int updateTradeUnPub(String[] blinfoList);

    public List<BidBlinfo> findByBidId(String bidId);

    /**
     * 修改提货单竞标方仓库状态
     * @param blinfo
     * @return
     */
    public int updateBiddingstatusByGoods(BidBlinfo blinfo);

    /**
     * 批量修改提货单招标仓库状态未发布 招标合同除外
     * @param blinfoList
     * @return
     */
    public int updateBidStatusUnPubone(String[] blinfoList);

    /**
     * 批量修改提货单招标仓库状态未发布 招标合同除外
     * @param blinfoList
     * @return
     */
    public int updateBidStatusUnPubtow(String[] blinfoList);

    /**
     * 批量修改提货单招标仓库状态未发布 招标合同除外
     * @param blinfoList
     * @return
     */
    public int updateBidStatusUnPubtree(String[] blinfoList);

    /**
     * 自发仓库状态统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBidStatusCount(BidBlinfoCountVO bidBlinfoCountVO);

    /**
     * 接单仓库状态统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBiddingStatusCount(BidBlinfoCountVO bidBlinfoCountVO);

    /**
     * 仓库状态总统计
     * @param bidBlinfoCountVO
     * @return
     */
    public BidBlinfoCountVO findBidBlinfoCount(BidBlinfoCountVO bidBlinfoCountVO);

    /**
     * 交易状态统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBlinfoTradeStatusCount(BidBlinfoCountVO bidBlinfoCountVO);

    /**
     * 各个仓库统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBlinfoWarehouseList(BidBlinfoCountVO bidBlinfoCountVO);

    /**
     * 仓库每日运输分析统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBlinfoDayList(BidBlinfoCountVO bidBlinfoCountVO);

    /**
     * 仓库报表统计
     * @param bidBlinfoVO
     * @return
     */
    public List<BidBlinfoVO> findBlinfoList(BidBlinfoVO bidBlinfoVO);
}