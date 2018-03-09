/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.validation.constraints.NotNull;

/**
 * 用户绑定银行卡Entity
 * @author 饶江龙
 * @version 2016-07-21
 */
public class UserBankinfo extends DataEntity<UserBankinfo> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID
	private String bankname;		// 银行类型下面的什么支行
	private String banktype;		// 银行卡类型
	private String bankcard;		// 银行卡卡号
	private String bindname;		// 绑卡姓名
	private String bindphone;		// 绑卡手机
	private int isdefault;   		//是否默认卡
	private String unionpayNo;    //银联号
	private String accountName; //银行卡账户名
	private String card;//隐藏部分卡号
	private String password;//提现密码
	
	public UserBankinfo() {
		super();
	}

	public UserBankinfo(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=32, message="银行类型下面的什么支行长度必须介于 0 和 32 之间")
	@NotNull
	public String getBankname() {
		return bankname;
	}

	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	
	@Length(min=0, max=32, message="银行卡类型长度必须介于 0 和 32 之间")
	@NotNull
	public String getBanktype() {
		return banktype;
	}

	public void setBanktype(String banktype) {
		this.banktype = banktype;
	}
	
	@Length(min=0, max=32, message="银行卡卡号长度必须介于 0 和 32 之间")
	@NotNull
	public String getBankcard() {
		return bankcard;
	}

	public void setBankcard(String bankcard) {
		this.bankcard = bankcard;
	}
	
	@Length(min=0, max=32, message="绑卡姓名长度必须介于 0 和 32 之间")
	@NotNull
	public String getBindname() {
		return bindname;
	}

	public void setBindname(String bindname) {
		this.bindname = bindname;
	}
	
	@Length(min=0, max=32, message="绑卡手机长度必须介于 0 和 32 之间")

	public String getBindphone() {
		return bindphone;
	}

	public void setBindphone(String bindphone) {
		this.bindphone = bindphone;
	}

	public int getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(int isdefault) {
		this.isdefault = isdefault;
	}

	public String getUnionpayNo() {
		return unionpayNo;
	}

	public void setUnionpayNo(String unionpayNo) {
		this.unionpayNo = unionpayNo;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCard() {
		return card;
	}

	public void setCard(String card) {
		this.card = card;
	}
}