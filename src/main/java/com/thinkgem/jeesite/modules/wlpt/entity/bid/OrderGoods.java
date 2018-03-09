/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.bid;

import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * &nbsp;招标合同与货源关联信息Entity
 * @author 饶江龙
 * @version 2016-08-19
 */
public class OrderGoods extends DataEntity<OrderGoods> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;		// 货源ID
	private BidOrderinfo bidorder;		// 招标合同ID
	private String freightvolume;		// 运输量
	private String freightunit;		// 运输吨位
	
	public OrderGoods() {
		super();
	}

	public OrderGoods(String id){
		super(id);
	}

	@Length(min=0, max=64, message="货源ID长度必须介于 0 和 64 之间")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	@Length(min=0, max=64, message="招标合同ID长度必须介于 0 和 64 之间")
	public BidOrderinfo getBidorder() {
		return bidorder;
	}

	public void setBidorder(BidOrderinfo bidorder) {
		this.bidorder = bidorder;
	}
	
	public String getFreightvolume() {
		return freightvolume;
	}

	public void setFreightvolume(String freightvolume) {
		this.freightvolume = freightvolume;
	}
	
	@Length(min=0, max=10, message="运输吨位长度必须介于 0 和 10 之间")
	public String getFreightunit() {
		return freightunit;
	}

	public void setFreightunit(String freightunit) {
		this.freightunit = freightunit;
	}
	
}