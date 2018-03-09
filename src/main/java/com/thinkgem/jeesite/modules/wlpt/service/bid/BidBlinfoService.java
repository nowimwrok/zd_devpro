/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.bid;

import java.util.ArrayList;
import java.util.List;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BidBlinfoCountVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BidBlinfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.dao.bid.BidBlinfoDao;
import com.thinkgem.jeesite.modules.wlpt.dao.goods.GoodsDao;

/**
 * 提货单Service
 *
 * @author 刘欣
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class BidBlinfoService extends CrudService<BidBlinfoDao, BidBlinfo> {

    @Autowired
    private BidBlinfoDao bidBlinfoDao;

    @Autowired
    private GoodsDao goodsDao;

    /***
     * 提货单状态为关闭状态
     *
     * @param goods_id
     */
    public void updateCancelByGoods(String goods_id) {
        BidBlinfo blinfo = new BidBlinfo();
        Goods goods = new Goods();
        goods.setId(goods_id);
        blinfo.setGoods(goods);
        bidBlinfoDao.updateCancelByGoods(blinfo);
    }

    /**
     * 批量修改提货单状态为已完成
     *
     * @param blinfoList
     * @return
     */
    public void updateTradeSuccess(String[] blinfoList) {
        bidBlinfoDao.updateTradeSuccess(blinfoList);
    }

    /**
     * 批量修改提货单状态为运输中
     *
     * @param blinfoList
     * @return
     */
    public void updateTradeFreighting(String[] blinfoList) {
        bidBlinfoDao.updateTradeFreighting(blinfoList);
    }

    /**
     * 批量修改提货单状态为未运输
     *
     * @param blinfoList
     * @return
     */
    public void updateTradeCancel(String[] blinfoList) {
        bidBlinfoDao.updateTradeCancel(blinfoList);
    }

    /**
     * 批量修改提货单状态为已发布
     *
     * @param blinfoList
     * @return
     */
    public void updateTradePubGds(String[] blinfoList) {
        bidBlinfoDao.updateTradePubGds(blinfoList);
    }

    /**
     * 批量修改提货单状态未发布 招标合同除外
     *
     * @param blinfoList
     * @return
     */
    public void updateTradeUnPub(String[] blinfoList) {
        bidBlinfoDao.updateTradeUnPub(blinfoList);
    }

    public BidBlinfo get(String id) {
        return super.get(id);
    }

    public List<BidBlinfo> findList(BidBlinfo bidBlinfo) {
        return super.findList(bidBlinfo);
    }

    public Page<BidBlinfo> findPage(Page<BidBlinfo> page, BidBlinfo bidBlinfo) {
        return super.findPage(page, bidBlinfo);
    }

    @Transactional(readOnly = false)
    public void save(BidBlinfo bidBlinfo) {
        super.save(bidBlinfo);
    }

    @Transactional(readOnly = false)
    public void delete(BidBlinfo bidBlinfo) {
        super.delete(bidBlinfo);
    }


    /**
     * 获取提货单的招标源发布信息，填充到发布零担货源页面
     */
    public Model getGoodsDetail(String ids) {
        Model model = null;
        Goods goods = new Goods();
        List<BidBlinfo> blList = new ArrayList<>();
        try {
            String blid = ids;
            String[] strs = null;
            String[] strsplit = null;
            if (blid.indexOf(",") != -1) {
                strsplit = blid.split(",");
                int[] strLengths = new int[strsplit.length];
                for (int i = 0; i < strsplit.length; i++) {
                    strLengths[i] = strsplit[i].length();
                    if (strLengths[i] > 10) {
                        strs = strsplit;
                    }
                }
            } else {
                strs = new String[]{blid};
            }

            blList = bidBlinfoDao.getBLListData(strs);//提货单列表

            if (blList != null) {
                String USERID = blList.get(0).getBiduser().getId();
                String GOODSID = blList.get(0).getGoods().getId();
                goods = goodsDao.getBLgoodsData(USERID, GOODSID);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        model.addAttribute("goods", goods);
        model.addAttribute("blList", blList);
        return model;
    }

    public List<BidBlinfo> findByBidId(String bidId) {
        return bidBlinfoDao.findByBidId(bidId);
    }

    /**
     * 修改提货单竞标方仓库状态
     * @param blinfo
     * @return
     */
    @Transactional(readOnly = false)
    public void updateBiddingstatusByGoods(BidBlinfo blinfo){
        bidBlinfoDao.updateBiddingstatusByGoods(blinfo);
    }

    /**
     * 批量修改提货单招标仓库状态未发布 招标合同除外
     * @param bidstatus
     * @param blinfoList
     * @return
     */
    @Transactional(readOnly = false)
    public void updateBidStatusUnPub(String bidstatus,String[] blinfoList){
        if(bidstatus.equals(DataDic.BL_WAREHOUSE_STATUS_YRK)){
            bidBlinfoDao.updateBidStatusUnPubone(blinfoList);
        }else if(bidstatus.equals(DataDic.BL_WAREHOUSE_STATUS_DCK)){
            bidBlinfoDao.updateBidStatusUnPubtow(blinfoList);
        }else if(bidstatus.equals(DataDic.BL_WAREHOUSE_STATUS_YCK)){
            bidBlinfoDao.updateBidStatusUnPubtree(blinfoList);
        }

    }

    /**
     * 自发仓库状态统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBidStatusCount(BidBlinfoCountVO bidBlinfoCountVO){
        return bidBlinfoDao.findBidStatusCount(bidBlinfoCountVO);
    }

    /**
     * 接单仓库状态统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBiddingStatusCount(BidBlinfoCountVO bidBlinfoCountVO){
        return bidBlinfoDao.findBiddingStatusCount(bidBlinfoCountVO);
    }

    /**
     * 仓库状态总统计
     * @param bidBlinfoCountVO
     * @return
     */
    public BidBlinfoCountVO findBidBlinfoCount(BidBlinfoCountVO bidBlinfoCountVO){
        return bidBlinfoDao.findBidBlinfoCount(bidBlinfoCountVO);
    }

    /**
     * 交易状态统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBlinfoTradeStatusCount(BidBlinfoCountVO bidBlinfoCountVO){
        return bidBlinfoDao.findBlinfoTradeStatusCount(bidBlinfoCountVO);
    }

    /**
     * 各个仓库统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBlinfoWarehouseList(BidBlinfoCountVO bidBlinfoCountVO){
        return bidBlinfoDao.findBlinfoWarehouseList(bidBlinfoCountVO);
    }

    /**
     * 仓库每日运输分析统计
     * @param bidBlinfoCountVO
     * @return
     */
    public List<BidBlinfoCountVO> findBlinfoDayList(BidBlinfoCountVO bidBlinfoCountVO){
        return bidBlinfoDao.findBlinfoDayList(bidBlinfoCountVO);
    }

    /**
     * 仓库报表统计
     * @param bidBlinfoVO
     * @return
     */
    public Page<BidBlinfoVO> findBlinfoList(Page<BidBlinfoVO> page,BidBlinfoVO bidBlinfoVO){
        bidBlinfoVO.setPage(page);
        page.setList(bidBlinfoDao.findBlinfoList(bidBlinfoVO));
        return page;
    }
    /**
     * 仓库报表统计导出
     * @param bidBlinfoVO
     * @return
     */
    public List<BidBlinfoVO> findBlinfoAllList(BidBlinfoVO bidBlinfoVO){
        return bidBlinfoDao.findBlinfoList(bidBlinfoVO);
    }
}