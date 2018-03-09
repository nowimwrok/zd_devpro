/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.bid;

import java.util.List;

import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BidOrderinfoExcelVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.bid.BidOrderinfoDao;

/**
 * 招标合同Service
 * @author fjc
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class BidOrderinfoService extends CrudService<BidOrderinfoDao, BidOrderinfo> {

	@Autowired
	private BidOrderinfoDao bidOrderinfoDao;

	public BidOrderinfo get(String id) {
		return super.get(id);
	}



	public List<BidOrderinfo> findList(BidOrderinfo bidOrderinfo) {
		return super.findList(bidOrderinfo);
	}
	
	public Page<BidOrderinfo> findPage(Page<BidOrderinfo> page, BidOrderinfo bidOrderinfo) {
		return super.findPage(page, bidOrderinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(BidOrderinfo bidOrderinfo) {
		super.save(bidOrderinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(BidOrderinfo bidOrderinfo) {
		super.delete(bidOrderinfo);
	}
	
	/**
	 * 统计招标结算金额
	 * @param bidOrderinfo
	 * @return
	 */
	public BidOrderinfo sumBidOrderinfo(BidOrderinfo bidOrderinfo){
		return bidOrderinfoDao.sumBidOrderinfo(bidOrderinfo);
	}

	/**
	 * 招标流水
	 * @param bidOrderinfo
	 * @return
     */
	public List<BidOrderinfo> findBidOrderVo(BidOrderinfo bidOrderinfo) {
		return bidOrderinfoDao.datalistPage(bidOrderinfo);
	}
	public Page<BidOrderinfo> datalistPage(Page<BidOrderinfo> page, BidOrderinfo bidOrderinfo) {
		bidOrderinfo.setPage(page);
		page.setList(bidOrderinfoDao.datalistPage(bidOrderinfo));
		return page;
	}
	
	/**
	 * 获取当前用户今天的竞标金额 
	 * @param userid
	 * @return
	 */
	public double getContracttotalNum(String userid){
		Double value = bidOrderinfoDao.contracttotalNum(userid);
		return value==null?0:value.doubleValue();
	}
	
	/**
	 * 获取当前用户今天的竞标待结算金额 
	 * @param userid
	 * @return
	 */
	public double getWeiNum(String userid){
		Double value = bidOrderinfoDao.weiNum(userid);
		return value==null?0:value.doubleValue();
	}
	
	/**
	 * 获取当前用户今天的竞标已结算金额 
	 * @param userid
	 * @return
	 */
	public double getYiNum(String userid){
		Double value =  bidOrderinfoDao.yiNum(userid);
		return value==null?0:value.doubleValue();
	}
	
	/**
	 * 获取当前用户今天的待运输总吨数 
	 * @param userid
	 * @return
	 */
	public double getDaiNum(String userid){
		Double value =  bidOrderinfoDao.daiNum(userid);
		return value==null?0:value.doubleValue();
	}
	
	/**
	 * 获取当前用户今天的已运输总吨数 
	 * @param userid
	 * @return
	 */
	public double getYunNum(String userid){
		Double value =  bidOrderinfoDao.yunNum(userid);
		return value==null?0:value.doubleValue();
	}

	/**
	 * 招标应付-应收数据列表
	 * @param bidOrderinfo
	 * @return
	 */
	public Page<BidOrderinfo> findFinancialBidOrderList(Page<BidOrderinfo> page, BidOrderinfo bidOrderinfo) {
		bidOrderinfo.setPage(page);
		page.setList(bidOrderinfoDao.findFinancialBidOrderList(bidOrderinfo));
		return page;
	}
	/**
	 * 获取合同统计统计
	 * @param statisticsTradetype
	 * @return
	 */
	public StatisticsTradetype findFinancialBidOrderCount(StatisticsTradetype statisticsTradetype){
		return bidOrderinfoDao.findFinancialBidOrderCount(statisticsTradetype);
	}

	/**
	 * 招标导出应付-应收数据列表
	 * @param bidOrderinfoExcelVO
	 * @return
	 */
	public List<BidOrderinfoExcelVO> findFinancialBidOrderExcel(BidOrderinfoExcelVO bidOrderinfoExcelVO){
		return bidOrderinfoDao.findFinancialBidOrderExcel(bidOrderinfoExcelVO);
	}
	/**
	 * 招标应付-应收数据列表
	 * @param bidOrderinfoExcelVO
	 * @return
	 */
	public Page<BidOrderinfoExcelVO> getFinancialBidOrderList(Page<BidOrderinfoExcelVO> page,BidOrderinfoExcelVO bidOrderinfoExcelVO){
		bidOrderinfoExcelVO.setPage(page);
		page.setList(bidOrderinfoDao.findFinancialBidOrderExcel(bidOrderinfoExcelVO));
		return page;
	}
}