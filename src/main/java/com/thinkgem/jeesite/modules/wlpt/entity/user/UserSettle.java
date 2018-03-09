/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户结算资金－－招标结算资金Entity
 * @author 饶江龙
 * @version 2016-07-24
 */
public class UserSettle extends DataEntity<UserSettle> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID
	private String bidorderId;		// 关联的招标合同
	private String settlemoney;		// 当前结算金额
	private String settlestatus;		// 0为未提现，1提前提现金额已提现2.完全提现
	private String settletype;		// 结算类型：0:正常结算；1:提前结算
	private Date settletime;		// 帐期结算时间
	private String avalbecash;		// 可提现金额
	private String cashmoney;		// 提现金额
	private Date cashtime;		// 提现时间
	
	public UserSettle() {
		super();
	}

	public UserSettle(String id){
		super(id);
	}

	@NotNull(message="用户ID不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=32, message="关联的招标合同长度必须介于 0 和 32 之间")
	public String getBidorderId() {
		return bidorderId;
	}

	public void setBidorderId(String bidorderId) {
		this.bidorderId = bidorderId;
	}
	
	public String getSettlemoney() {
		return settlemoney;
	}

	public void setSettlemoney(String settlemoney) {
		this.settlemoney = settlemoney;
	}
	
	//@完全提现长度必须介于 0 和 11 之间")
	public String getSettlestatus() {
		return settlestatus;
	}

	public void setSettlestatus(String settlestatus) {
		this.settlestatus = settlestatus;
	}
	
	@Length(min=0, max=11, message="结算类型：0:正常结算；1:提前结算长度必须介于 0 和 11 之间")
	public String getSettletype() {
		return settletype;
	}

	public void setSettletype(String settletype) {
		this.settletype = settletype;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSettletime() {
		return settletime;
	}

	public void setSettletime(Date settletime) {
		this.settletime = settletime;
	}
	
	public String getAvalbecash() {
		return avalbecash;
	}

	public void setAvalbecash(String avalbecash) {
		this.avalbecash = avalbecash;
	}
	
	public String getCashmoney() {
		return cashmoney;
	}

	public void setCashmoney(String cashmoney) {
		this.cashmoney = cashmoney;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCashtime() {
		return cashtime;
	}

	public void setCashtime(Date cashtime) {
		this.cashtime = cashtime;
	}
	
}