/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.bid;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BidOrderinfoExcelVO;

/**
 * 招标合同DAO接口
 * @author fjc
 * @version 2016-08-04
 */
@MyBatisDao
public interface BidOrderinfoDao extends CrudDao<BidOrderinfo> {

	/**
	 * 统计招标结算金额
	 * @param bidOrderinfo
	 * @return
	 */
	public BidOrderinfo sumBidOrderinfo(BidOrderinfo bidOrderinfo); 
	
	public List<BidOrderinfo> datalistPage(BidOrderinfo bidOrderinfo);
	
	/**
	 * 获取当前用户今天的竞标金额 
	 * @param userid
	 * @return
	 */
	public Double contracttotalNum(String userid);
	
	/**
	 * 获取当前用户今天的竞标待结算金额 
	 * @param userid
	 * @return
	 */
	public Double weiNum(String userid);
	
	/**
	 * 获取当前用户今天的竞标已结算金额 
	 * @param userid
	 * @return
	 */
	public Double yiNum(String userid);
	
	/**
	 * 获取当前用户今天的待运输总吨数 
	 * @param userid
	 * @return
	 */
	public Double daiNum(String userid);
	
	/**
	 * 获取当前用户今天的已运输总吨数 
	 * @param userid
	 * @return
	 */
	public Double yunNum(String userid);

	/**
	 * 招标应付-应收数据列表
	 * @param bidOrderinfo
	 * @return
	 */
	public List<BidOrderinfo> findFinancialBidOrderList(BidOrderinfo bidOrderinfo);

	/**
	 * 招标导出应付-应收数据列表
	 * @param bidOrderinfoExcelVO
	 * @return
	 */
	public List<BidOrderinfoExcelVO> findFinancialBidOrderExcel(BidOrderinfoExcelVO bidOrderinfoExcelVO);

	/**
	 * 获取合同统计统计
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype findFinancialBidOrderCount(StatisticsTradetype statisticsTradetype);

}