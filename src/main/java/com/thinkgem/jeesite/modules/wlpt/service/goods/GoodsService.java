/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.goods;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.dao.goods.GoodsDao;

/**
 * 货源管理数据Service
 * @author 饶江龙
 * @version 2016-07-25
 */
@Service
@Transactional(readOnly = true)
public class GoodsService extends CrudService<GoodsDao, Goods> {

	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private BidBlinfoService bidBlinfoService;
	
	@Autowired
	private BidOrderinfoService bidOrderinfoService;

	public Goods get(String id) {
		return super.get(id);
	}

	/**
	 * 报价次数更新
	 * @param goods
     */
	@Transactional(readOnly = false)
	public void updateQuoteCount(Goods goods) {
		goodsDao.updateQuoteCount(goods);
	}

	/**
	 * 更新浏览次数
	 * @param goods
     */
	@Transactional(readOnly = false)
	public void updatePageViews(Goods goods) {
		goodsDao.updatePageViews(goods);
	}

	/**
	 * 更新点击次数
	 * @param goods
     */
	@Transactional(readOnly = false)
	public void updatePraiseNumber(Goods goods) {
		goodsDao.updatePraiseNumber(goods);
	}

	/**
	 * 发布零担货源页面 获取提货单关联的招标信息数据
	 * @param userId
	 * @param goodsId
	 * @return
	 */
	public Goods getBLgoodsData(String userId,String goodsId) {
		return goodsDao.getBLgoodsData(userId, goodsId);
	}

		/*public Boolean saveGoodsSource(Goods goods,String ids,String orderid){
		Boolean result=false;
		if(goods.getId()==null){
			goods.preInsert();
			User user= UserUtils.getUser();
			goods.setUser(user);
			//货源有明细
			if(goods.getDatasource()!=null){
				String blid=ids;
				String[] strs=null;
				if(blid.indexOf(",")!=-1){
					strs=blid.split(",");
				}else{
					strs=new String[]{blid};
				}
				BidBlinfo bidBlinfo= new BidBlinfo();
				bidBlinfo.preUpdate();
				bidBlinfo.setBlstatus("2");
				if(goods.getDatasource().equals("")){//货源类型设置 
					bidBlinfo.setBltype(1);
				}
				//更改提货单的信息
				for (String Blid : strs) {
					bidBlinfo.setId(Blid);
					bidBlinfoService.save(bidBlinfo);
				}
				//更改招标合同交易状态
				if(orderid!=null){
					BidOrderinfo bidOrderinfo= new BidOrderinfo();
					bidOrderinfo.setId(orderid);
					bidOrderinfo.setContractstatus("2");
					bidOrderinfoService.save(bidOrderinfo);
				}
				super.save(goods);
			}
		}else{
			goods.preUpdate();
			super.save(goods);
		}
		
		return result;
	}
	*/
	public List<Goods> findList(Goods goods) {
		return super.findList(goods);
	}
	
	public Page<Goods> findPage(Page<Goods> page, Goods goods) {
		return super.findPage(page, goods);
	}

	/**
     * 货源统计
     * @param page
     * @param goods
     * @return
     */
	public Page<Goods> findSumGoodsList(Page<Goods> page, Goods goods) {
		goods.setPage(page);
		page.setList(goodsDao.findSumGoodsList(goods));
		return page;
	}
    
	/***
	 * 保存货源zd-logistics
	 * @param goods
     */
	@Transactional(readOnly = false)
	public void save(Goods goods) {
		super.save(goods);
	}
	
	@Transactional(readOnly = false)
	public void delete(Goods goods) {
		super.delete(goods);
	}
	
}