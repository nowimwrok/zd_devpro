package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 账户系统银行卡列表
 * @author Administrator
 *
 */
public class AccountBankinfo extends DataEntity<AccountBankinfo>{
	
	private String code;//编号
	private String icon;//银行Logo
	private String isHot;//是否热门 1：是；0：否
	private String letter;//银行名称首字母
	private String spell;//银行名称中文简拼
	private String name;//银行名称
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getIsHot() {
		return isHot;
	}
	public void setIsHot(String isHot) {
		this.isHot = isHot;
	}
	public String getLetter() {
		return letter;
	}
	public void setLetter(String letter) {
		this.letter = letter;
	}
	public String getSpell() {
		return spell;
	}
	public void setSpell(String spell) {
		this.spell = spell;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
