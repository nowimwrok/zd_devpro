/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.trade;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoExcelVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoNewVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.StatisticsBusinessVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserBalanceVO;

/**
 * 运单信息DAO接口
 *
 * @author 饶江龙
 * @version 2016-07-28
 */
@MyBatisDao
public interface OrderinfoDao extends CrudDao<Orderinfo> {

    /**
     * 根据运单对象获取运单信息
     *
     * @return
     */
    public Orderinfo getByOrderinfo(Orderinfo orderinfo);


    /**
     * 根据招标合同中的货源取运单信息
     *
     * @return
     */
    public List<Orderinfo> findBidOrderList(Orderinfo orderinfo);

    /**
     * 获取数据统计信息
     *
     * @param orderinfo
     * @return
     */
    public List<Orderinfo> getEverData(Orderinfo orderinfo);

    /**
     * 根据条件统计运单信息
     *
     * @param orderinfo
     * @return
     */
    public Orderinfo sumOrderinfo(Orderinfo orderinfo);

    /**
     * 仅用于获取开通定位的运单
     *
     * @param orderinfo
     * @return
     */
    public List<Orderinfo> findLocationOrder(Orderinfo orderinfo);

    /**
     * 仅用于后台运单管理导出
     *
     * @param orderinfo
     * @return
     */
    public List<OrderinfoNewVO> findOrderList(Orderinfo orderinfo);

    /**
     * 更新打印时间
     *
     * @param id
     * @return
     */
    public int updatePrintcount(String id);

    /**
     * 获取用户今天的运单交易金额   货主或物流企业
     *
     * @param userid
     * @return
     */
    public Double priceNum(String userid);

    /**
     * 获取用户今天的运单交易金额     车主
     *
     * @param userid
     * @return
     */
    public Double carUserPriceNum(String userid);

    /**
     * 获取今天的运单待付金额  车主  还未完成交易  线上支付    未上传提货单
     *
     * @param userid
     * @return
     */
    public Double carUserDaiPrice1(String userid);

    /**
     * 获取今天的运单待付金额  车主  还未完成交易  线上支付   已上传提货单  线上金额已预支付
     *
     * @param userid
     * @return
     */
    public Double carUserDaiPrice2(String userid);

    /**
     * 获取今天的运单待付金额  车主  还未完成交易  线上支付   已上传提货单    线上金额未预支付
     *
     * @param userid
     * @return
     */
    public Double carUserDaiPrice3(String userid);

    /**
     * 获取今天的运单待付金额  车主  还未完成交易  线上支付+卓币支付   已上传提货单  卓币和线上已预支付
     *
     * @param userid
     * @return
     */
    public Double carUserDaiPrice4(String userid);

    /**
     * 获取今天的运单待付金额  车主  还未完成交易  线上支付+卓币支付   已上传提货单  卓币已预支付  线上未预支付
     *
     * @param userid
     * @return
     */
    public Double carUserDaiPrice5(String userid);

    /**
     * 获取今天的运单待付金额  车主  还未完成交易  线上支付+卓币支付   已上传提货单  线上已预支付  卓币未预支付
     *
     * @param userid
     * @return
     */
    public Double carUserDaiPrice6(String userid);

    /**
     * 获取今天的运单待付金额  货主或物流企业  线上支付  还未完成交易
     *
     * @param userid
     * @return
     */
    public Double daiPrice1(String userid);

    /**
     * 获取今天的运单已付金额  货主或物流企业  线上支付  还未完成交易
     *
     * @param userid
     * @return
     */
    public Double yiPrice1(String userid);

    /**
     * 获取今天的运单已付金额  货主或物流企业  线上支付+卓币  还未完成交易
     *
     * @param userid
     * @return
     */
    public Double yiPrice2(String userid);

    /**
     * 获取今天的运单已付金额  货主或物流企业  完成交易
     *
     * @param userid
     * @return
     */
    public Double yiPrice3(String userid);

    /**
     * 获取今天的运单已付金额    车主  还未完成交易  线上支付    上传提货单    线上已预支付
     *
     * @param userid
     * @return
     */
    public Double carUserYiPrice1(String userid);

    /**
     * 获取今天的运单已付金额    车主  完成交易
     *
     * @param userid
     * @return
     */
    public Double carUserYiPrice2(String userid);

    /**
     * 获取今天的运单已付金额    车主  还未完成交易  线上支付+卓币    上传提货单     线上和卓币已预支付
     *
     * @param userid
     * @return
     */
    public Double carUserYiPrice3(String userid);

    /**
     * 获取今天的运单已付金额    车主  还未完成交易  线上支付+卓币    上传提货单     卓币已预支付   线上未预支付
     *
     * @param userid
     * @return
     */
    public Double carUserYiPrice4(String userid);

    /**
     * 获取今天的运单已付金额    车主  还未完成交易  线上支付+卓币    上传提货单     线上已预支付  卓币未预支付
     *
     * @param userid
     * @return
     */
    public Double carUserYiPrice5(String userid);

    /**
     * 获取用户各状态的订单数目
     *
     * @param orderinfo
     * @return
     */
    int getOrdersStatusNum(Orderinfo orderinfo);

    /**
	 * 获取所有车辆和对应的运单信息
	 * @param orderinfo
	 * @return
	 */
	public List<Orderinfo> findCarAndTradeList(Orderinfo orderinfo);
	
	/**
	 * 根据userid获取订单
	 */
	public long findByUserid(String userid);
		
    /**
     * 获取应收运单统计列表
     * @param statisticsTradetype
     * @return
     */
    public List<StatisticsTradetype> findBuyerOrderList(StatisticsTradetype statisticsTradetype);

    /**
     * 获取应付运单统计列表
     * @param statisticsTradetype
     * @return
     */
    public List<StatisticsTradetype> findSllerOrderList(StatisticsTradetype statisticsTradetype);

    /**
     * 获取应收运单统计统计
     * @param statisticsTradetype
     * @return
     */
    public StatisticsTradetype getBuyerOrderCount(StatisticsTradetype statisticsTradetype);

    /**
     * 获取应付运单统计统计
     * @param statisticsTradetype
     * @return
     */
    public StatisticsTradetype getSllerOrderCount(StatisticsTradetype statisticsTradetype);

    /**
     * 获取应付运单状态统计
     * @param userBalanceVO
     * @return
     */
    public List<UserBalanceVO> getOrderStatusCount(UserBalanceVO userBalanceVO);

    /**
     * 获取应付运单业务统计分析
     * @param statisticsTradetype
     * @return
     */
    public List<StatisticsTradetype> getOrderBusinessList(StatisticsTradetype statisticsTradetype);

    /**
     * 获取导出应付运单业务统计分析
     * @param orderinfoExcelVO
     * @return
     */
    public List<OrderinfoExcelVO> findFinancialOrderExcel(OrderinfoExcelVO orderinfoExcelVO);


    /**
     * 获取应收-应收运单统计列表
     * @param orderinfo
     * @return
     */
    public List<Orderinfo> findFinancialOrderList(Orderinfo orderinfo);
    /**
     * 获取运单统计
     * @param userBalanceVO
     * @return
     */
    public UserBalanceVO getOrderCount(UserBalanceVO userBalanceVO);

    /**
     * 获取运单信息
     * @param statisticsBusiness
     * @return
     */
    List<StatisticsBusinessVO> findOrderInfoList(StatisticsBusinessVO statisticsBusiness);

    /**
     * 获取已回单的数据
     * @return
     */
    List<StatisticsBusinessVO> findReceiptOrderInfoList(StatisticsBusinessVO statisticsBusiness);
    
	/**
	 * 获取调用接口定时任务信息
	 */
	public List<Orderinfo> findInterfaceFlag(Orderinfo Orderinfo);
	
	/**
	 * 修改围栏状态
	 */
	public void updateRailState(Orderinfo orderinfo);


}