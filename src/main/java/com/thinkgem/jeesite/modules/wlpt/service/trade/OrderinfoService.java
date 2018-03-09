/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.trade;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.modules.wlpt.entity.vo.StatisticsBusinessVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.trade.OrderinfoDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoExcelVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoNewVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserBalanceVO;

/**
 * 运单信息Service
 *
 * @author 饶江龙
 * @version 2016-07-28
 */
@Service
@Transactional(readOnly = true)
public class OrderinfoService extends CrudService<OrderinfoDao, Orderinfo> {

    @Autowired
    private OrderinfoDao orderinfoDao;


    /***
     * 获取招标合同的运单信息
     * @param orderinfo
     * @return
     */
    public List<Orderinfo> findBidOrderList(Orderinfo orderinfo) {
        return orderinfoDao.findBidOrderList(orderinfo);
    }

    /**
     * 获取数据统计
     *
     * @param orderinfo
     * @return
     */
    public List<Orderinfo> getEverData(Orderinfo orderinfo) {
        return orderinfoDao.getEverData(orderinfo);
    }


    /***
     * 获取分页信息
     * @param page
     * @param orderinfo
     * @return
     */
    public Page<Orderinfo> findBidOrderPage(Page<Orderinfo> page, Orderinfo orderinfo) {
        orderinfo.setPage(page);
        page.setList(orderinfoDao.findBidOrderList(orderinfo));
        return page;

    }

    /***
     * 获取运单信息
     * @param orderinfo
     * @return
     */
    public Orderinfo getByOrderinfo(Orderinfo orderinfo) {
        return orderinfoDao.getByOrderinfo(orderinfo);
    }


    public Orderinfo get(String id) {
        return super.get(id);
    }

    public List<Orderinfo> findList(Orderinfo orderinfo) {
        return super.findList(orderinfo);
    }

    public Page<Orderinfo> findPage(Page<Orderinfo> page, Orderinfo orderinfo) {

        return super.findPage(page, orderinfo);
    }

    @Transactional(readOnly = false)
    public void save(Orderinfo orderinfo) {
        super.save(orderinfo);
    }

    @Transactional(readOnly = false)
    public void delete(Orderinfo orderinfo) {
        super.delete(orderinfo);
    }

    /**
     * 根据条件统计运单信息
     *
     * @param orderinfo
     * @return
     */
    public Orderinfo sumOrderinfo(Orderinfo orderinfo) {
        return orderinfoDao.sumOrderinfo(orderinfo);
    }

    /**
     * 仅用于获取开通定位的运单
     *
     * @param orderinfo
     * @return
     */
    public List<Orderinfo> findLocationOrder(Orderinfo orderinfo) {
        return orderinfoDao.findLocationOrder(orderinfo);
    }

    /**
     * 仅用于后台运单管理导出
     *
     * @param orderinfo
     * @return
     */
    public List<OrderinfoNewVO> findOrderList(Orderinfo orderinfo) {
        return orderinfoDao.findOrderList(orderinfo);
    }

    /**
     * 更新打印时间
     *
     * @param id
     * @return
     */
    @Transactional(readOnly = false)
    public int updatePrintcount(String id) {
        return orderinfoDao.updatePrintcount(id);
    }

    /**
     * 获取用户今天的运单交易金额  、代付金额和已付金额    货主或物流企业
     *
     * @param userid
     * @return
     */
    public Map<String, Double> getGoodPriceNum(String userid) {
        Map<String, Double> map = new HashMap<String, Double>();
        Double pricenum = orderinfoDao.priceNum(userid);  //运单交易金额
        Double daipricenum = null;  //计算待付金额
        Double value1 = orderinfoDao.daiPrice1(userid);  //获取今天的运单待付金额 货主或物流企业  线上支付  还未完成交易
        double value = value1 == null ? 0 : value1.doubleValue();
        daipricenum = new Double(value);
        Double yipircenum = null;  //计算已付金额
        Double value4 = orderinfoDao.yiPrice1(userid);  //获取今天的运单已付金额 货主或物流企业 线上支付 还未完成交易
        Double value5 = orderinfoDao.yiPrice2(userid);  //获取今天的运单已付金额 货主或物流企业 线上支付+卓币 还未完成交易
        Double value6 = orderinfoDao.yiPrice3(userid);  //获取今天的运单已付金额 货主或物流企业 完成交易
        value = 0 + (value4 == null ? 0 : value4.doubleValue());
        value += value5 == null ? 0 : value5.doubleValue();
        value += value6 == null ? 0 : value6.doubleValue();
        yipircenum = new Double(value);
        map.put("pricenum", pricenum);
        map.put("daipricenum", daipricenum);
        map.put("yipircenum", yipircenum);
        return map;
    }

    /**
     * 获取用户今天的运单交易金额  、代付金额和已付金额      车主
     *
     * @param userid
     * @return
     */
    public Map<String, Double> getCarUserPriceNum(String userid) {
        Map<String, Double> map = new HashMap<String, Double>();
        Double pricenum = orderinfoDao.carUserPriceNum(userid);  //运单交易金额
        Double daipricenum = null;  //计算待付金额
        Double value1 = orderinfoDao.carUserDaiPrice1(userid);  //获取今天的运单待付金额 车主 还未完成交易 线上支付 未上传提货单
        Double value2 = orderinfoDao.carUserDaiPrice2(userid);  //获取今天的运单待付金额 车主 还未完成交易 线上支付 已上传提货单 线上金额已预支付
        Double value3 = orderinfoDao.carUserDaiPrice3(userid);  //获取今天的运单待付金额 车主 还未完成交易 线上支付 已上传提货单 线上金额未预支付
        Double value4 = orderinfoDao.carUserDaiPrice4(userid);  //获取今天的运单待付金额 车主 还未完成交易 线上支付+卓币支付 已上传提货单 卓币和线上已预支付
        Double value5 = orderinfoDao.carUserDaiPrice5(userid);  //获取今天的运单待付金额 车主 还未完成交易 线上支付+卓币支付 已上传提货单 卓币已预支付 线上未预支付
        Double value6 = orderinfoDao.carUserDaiPrice6(userid);  //获取今天的运单待付金额 车主 还未完成交易 线上支付+卓币支付 已上传提货单 线上已预支付 卓币未预支付
        double value = value1 == null ? 0 : value1.doubleValue();
        value += value2 == null ? 0 : value2.doubleValue();
        value += value3 == null ? 0 : value3.doubleValue();
        value += value4 == null ? 0 : value4.doubleValue();
        value += value5 == null ? 0 : value5.doubleValue();
        value += value6 == null ? 0 : value6.doubleValue();
        daipricenum = new Double(value);
        Double yipircenum = null;  //计算已付金额
        Double value8 = orderinfoDao.carUserYiPrice1(userid);  //获取今天的运单已付金额 车主 还未完成交易 线上支付 上传提货单 线上已预支付
        Double value9 = orderinfoDao.carUserYiPrice2(userid);  //获取今天的运单已付金额 车主 完成交易
        Double value10 = orderinfoDao.carUserYiPrice3(userid);  //获取今天的运单已付金额 车主 还未完成交易 线上支付+卓币 上传提货单 线上和卓币已预支付
        Double value11 = orderinfoDao.carUserYiPrice4(userid);  //获取今天的运单已付金额 车主 还未完成交易 线上支付+卓币 上传提货单 卓币已预支付 线上未预支付
        Double value12 = orderinfoDao.carUserYiPrice5(userid);  //获取今天的运单已付金额 车主 还未完成交易 线上支付+卓币 上传提货单 线上已预支付 卓币未预支付
        value = 0 + (value8 == null ? 0 : value8.doubleValue());
        value += value9 == null ? 0 : value9.doubleValue();
        value += value10 == null ? 0 : value10.doubleValue();
        value += value11 == null ? 0 : value11.doubleValue();
        value += value12 == null ? 0 : value12.doubleValue();
        yipircenum = new Double(value);
        map.put("pricenum", pricenum);
        map.put("daipricenum", daipricenum);
        map.put("yipircenum", yipircenum);
        return map;
    }

    /**
     * 获取用户各状态的订单数目
     *
     * @param orderinfo
     * @return
     */
    public int getOrdersStatusNum(Orderinfo orderinfo) {
        return orderinfoDao.getOrdersStatusNum(orderinfo);
    }
    
	/***
     * 运输监控获取分页信息
     * @param page
     * @param orderinfo
     * @return
     */
    public Page<Orderinfo> getCarAndTradeList(Page<Orderinfo> page, Orderinfo orderinfo) {
        orderinfo.setPage(page);
        page.setList(orderinfoDao.findCarAndTradeList(orderinfo));
        return page;

    }

    /**
     * 获取应收运单统计列表
     * @param statisticsTradetype
     * @return
     */
    public Page<StatisticsTradetype> findBuyerOrderList(Page<StatisticsTradetype> page,StatisticsTradetype statisticsTradetype){
        statisticsTradetype.setPage(page);
        page.setList(orderinfoDao.findBuyerOrderList(statisticsTradetype));
        return page;
    }

    /**
     * 获取应付运单统计列表
     * @param statisticsTradetype
     * @return
     */
    public Page<StatisticsTradetype> findSllerOrderList(Page<StatisticsTradetype> page,StatisticsTradetype statisticsTradetype){
        statisticsTradetype.setPage(page);
        page.setList(orderinfoDao.findSllerOrderList(statisticsTradetype));
        return page;
    }



    /**
     * 获取应收运单统计统计
     * @param statisticsTradetype
     * @return
     */
    public StatisticsTradetype getBuyerOrderCount(StatisticsTradetype statisticsTradetype){
        return orderinfoDao.getBuyerOrderCount(statisticsTradetype);
    }

    /**
     * 获取应付运单统计统计
     * @param statisticsTradetype
     * @return
     */
    public StatisticsTradetype getSllerOrderCount(StatisticsTradetype statisticsTradetype){
        return orderinfoDao.getSllerOrderCount(statisticsTradetype);
    }


    /**
     * 获取应付运单状态统计
     * @param userBalanceVO
     * @return
     */
    public List<UserBalanceVO> getOrderStatusCount(UserBalanceVO userBalanceVO){
        return orderinfoDao.getOrderStatusCount(userBalanceVO);
    }

    /**
     * 获取应付运单业务统计分析
     * @param statisticsTradetype
     * @return
     */
    public List<StatisticsTradetype> getOrderBusinessList(StatisticsTradetype statisticsTradetype){
        return orderinfoDao.getOrderBusinessList(statisticsTradetype);
    }

    /**
     * 获取应收-应收运单统计列表
     * @param orderinfo
     * @return
     */
    public Page<Orderinfo> findFinancialOrderList(Page<Orderinfo> page,Orderinfo orderinfo){
        orderinfo.setPage(page);
        page.setList(orderinfoDao.findFinancialOrderList(orderinfo));
        return page;
    }

    /**
     * 获取运单统计
     * @param userBalanceVO
     * @return
     */
    public UserBalanceVO getOrderCount(UserBalanceVO userBalanceVO){
        return orderinfoDao.getOrderCount(userBalanceVO);
    }

    /**
     * 获取运单信息
     * @param statisticsBusinessVO
     * @return
     */
    public Page<StatisticsBusinessVO> findOrderInfoList(Page<StatisticsBusinessVO> page, StatisticsBusinessVO statisticsBusinessVO){
        statisticsBusinessVO.setPage(page);
        page.setList(orderinfoDao.findOrderInfoList(statisticsBusinessVO));
        return page;
    }

    /**
     * 获取已回单的数据
     * @return
     */
    public Page<StatisticsBusinessVO> findReceiptOrderInfoList(Page<StatisticsBusinessVO> page,StatisticsBusinessVO statisticsBusinessVO){
        statisticsBusinessVO.setPage(page);
        page.setList(orderinfoDao.findReceiptOrderInfoList(statisticsBusinessVO));
        return page;
    }


    /**
     * 获取导出应付运单业务统计分析
     * @param orderinfoExcelVO
     * @return
     */
    public List<OrderinfoExcelVO> findFinancialOrderExcel(OrderinfoExcelVO orderinfoExcelVO){
        return orderinfoDao.findFinancialOrderExcel(orderinfoExcelVO);
    }
    /**
     * 获取开启围栏信息
     */
    @Transactional(readOnly = false)
    public List<Orderinfo> findInterfaceFlag(Orderinfo orderinfo){
    	return orderinfoDao.findInterfaceFlag(orderinfo);
    }
    /**
	 * 修改围栏状态
	 */
    @Transactional(readOnly = false)
	public void updateRailState(Orderinfo orderinfo){
		orderinfoDao.updateRailState(orderinfo);
	}
}