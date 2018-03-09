/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.goods;

import java.util.List;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.wlpt.dao.goods.QuoteBlinfoDao;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.QuoteBlinfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.goods.QuoteinfoDao;

/**
 * 货源报价管理Service
 * @author 饶江龙
 * @version 2016-07-25
 */
@Service
@Transactional(readOnly = true)
public class QuoteinfoService extends CrudService<QuoteinfoDao, Quoteinfo> {

	@Autowired
	private QuoteinfoDao quoteinfoDao;

	@Autowired
	private QuoteBlinfoDao quoteBlinfoDao;

	public Quoteinfo get(String id) {
		return super.get(id);
	}

	/**
	 * 保存报价与提货单列表信息
	 * @param quoteBlinfo
     */
	@Transactional(readOnly = false)
	public void saveQuote_Blinfo(QuoteBlinfo quoteBlinfo) {
		///判断是否是新记录
		if (quoteBlinfo.getIsNewRecord()){
			//赋值主键
			quoteBlinfo.preInsert();
			quoteBlinfoDao.insert(quoteBlinfo);
		}else{
			quoteBlinfo.preUpdate();
			quoteBlinfoDao.update(quoteBlinfo);
		}
	}

	/**
	 * 查找报价生成运单的提货单列表信息--重载后的货源
	 * @param quoteBlinfo
	 * @return
     */
	public List<QuoteBlinfo> findBLinfoList(QuoteBlinfo quoteBlinfo) {
		return quoteBlinfoDao.findList(quoteBlinfo);
	}


	///修改货源报价中的报价为报价失败
	public int updateQuoteFiled(String goods_id){
		int result= DataDic.RETURN_STATUS_NORMAL;
		///货源信息
		Goods goods=new Goods();
		goods.setId(goods_id);
		///报价信息
		Quoteinfo quoteinfo=new Quoteinfo();
		quoteinfo.setGoods(goods);
		quoteinfo.preUpdate();
		quoteinfoDao.updateQuoteFiled(quoteinfo);
		return result;
	}
	
	/**
	 * 该报价是否有运单了
	 * @param
	 * @return
	 */
	public boolean isOrder(Orderinfo orderinfo){
		Quoteinfo quoteinfo=orderinfo.getQuoteinfo();
		if(DataDic.QUOTE_SUCCESS.equals(quoteinfo.getQuotestatus())){
			return true;
		}
		return false;
	}


	public List<Quoteinfo> findList(Quoteinfo quoteinfo) {
		return super.findList(quoteinfo);
	}
	
	public Page<Quoteinfo> findPage(Page<Quoteinfo> page, Quoteinfo quoteinfo) {
		return super.findPage(page, quoteinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(Quoteinfo quoteinfo) {
		super.save(quoteinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Quoteinfo quoteinfo) {
		super.delete(quoteinfo);
	}
	
}