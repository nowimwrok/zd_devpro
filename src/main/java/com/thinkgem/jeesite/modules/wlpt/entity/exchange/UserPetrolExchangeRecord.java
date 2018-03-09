/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.exchange;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.user.CarUser;

/**
 * 油气兑换余额关系表Entity
 * @author zyj
 * @version 2017-02-15
 */
public class UserPetrolExchangeRecord extends DataEntity<UserPetrolExchangeRecord> {
	
	private static final long serialVersionUID = 1L;
	private String exchangeNo;		// 兑换号
	private UserMetroCardRecord recorditem;		// 明细号
	private String status;		// 记录状态
	
	private List<UserMetroCardRecord> cardRecordList =new ArrayList<>();
	private List<CarUser> carUserList =new ArrayList<>();
	
	public UserPetrolExchangeRecord() {
		super();
	}

	public UserPetrolExchangeRecord(String id){
		super(id);
	}

	@Length(min=1, max=32, message="兑换号长度必须介于 1 和 32 之间")
	public String getExchangeNo() {
		return exchangeNo;
	}

	public void setExchangeNo(String exchangeNo) {
		this.exchangeNo = exchangeNo;
	}
	
	public UserMetroCardRecord getRecorditem() {
		return recorditem;
	}

	public void setRecorditem(UserMetroCardRecord recorditem) {
		this.recorditem = recorditem;
	}

	@Length(min=0, max=1, message="记录状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<UserMetroCardRecord> getCardRecordList() {
		return cardRecordList;
	}

	public void setCardRecordList(List<UserMetroCardRecord> cardRecordList) {
		this.cardRecordList = cardRecordList;
	}

	public List<CarUser> getCarUserList() {
		return carUserList;
	}

	public void setCarUserList(List<CarUser> carUserList) {
		this.carUserList = carUserList;
	}
	
}