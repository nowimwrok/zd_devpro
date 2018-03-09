/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.integralexchange;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 积分规则Entity
 * @author qiao
 * @version 2017-12-22
 */
public class Integralexchange extends DataEntity<Integralexchange> {
	
	private static final long serialVersionUID = 1L;
	private String exchangetype;		// 兑换类型：0卓币1油气2余额
	private String exchangerate;		// 积分兑换比例
	
	public Integralexchange() {
		super();
	}

	public Integralexchange(String id){
		super(id);
	}

	@Length(min=0, max=1, message="兑换类型：0卓币1油气2余额长度必须介于 0 和 1 之间")
	public String getExchangetype() {
		return exchangetype;
	}

	public void setExchangetype(String exchangetype) {
		this.exchangetype = exchangetype;
	}
	
	@Length(min=0, max=11, message="积分兑换比例长度必须介于 0 和 11 之间")
	public String getExchangerate() {
		return exchangerate;
	}

	public void setExchangerate(String exchangerate) {
		this.exchangerate = exchangerate;
	}
	
}