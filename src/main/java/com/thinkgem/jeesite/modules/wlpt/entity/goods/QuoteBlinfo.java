/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.goods;

import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 生成运单配载物料清单Entity
 * @author 饶江龙
 * @version 2016-09-24
 */
public class QuoteBlinfo extends DataEntity<QuoteBlinfo> {
	
	private static final long serialVersionUID = 1L;
	private Quoteinfo quote;		// 报价ID；一对多物料清单
	private BidBlinfo blinfo;		// 提货单ID，多对一个报价
	
	public QuoteBlinfo() {
		super();
	}

	public QuoteBlinfo(String id){
		super(id);
	}

	@Length(min=0, max=64, message="报价ID；一对多物料清单长度必须介于 0 和 64 之间")
	public Quoteinfo getQuote() {
		return quote;
	}

	public void setQuote(Quoteinfo quote) {
		this.quote = quote;
	}
	
	@Length(min=0, max=64, message="提货单ID，多对一个报价长度必须介于 0 和 64 之间")
	public BidBlinfo getBlinfo() {
		return blinfo;
	}

	public void setBlinfo(BidBlinfo blinfo) {
		this.blinfo = blinfo;
	}
	
}