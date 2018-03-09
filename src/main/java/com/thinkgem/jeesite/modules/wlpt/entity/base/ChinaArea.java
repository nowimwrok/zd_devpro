/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 获取中国地址信息Entity
 * @author 饶江龙
 * @version 2016-07-24
 */
public class ChinaArea extends DataEntity<ChinaArea> {
	
	private static final long serialVersionUID = 1L;
	private String areaid;		// areaid
	private String code;		// code
	private String parentcode;		// parentcode
	private String name;		// name
	private String shortname;		// shortname
	private String mininame;		// mininame
	private String level;		// level
	private String spell;		// spell
	private String bigdistrict;		// bigdistrict
	private String ishotcity;		// ishotcity
	private String ordernumber;		// ordernumber
	
	public ChinaArea() {
		super();
	}

	public ChinaArea(String id){
		super(id);
	}

	@Length(min=1, max=11, message="areaid长度必须介于 1 和 11 之间")
	public String getAreaid() {
		return areaid;
	}

	public void setAreaid(String areaid) {
		this.areaid = areaid;
	}
	
	@Length(min=0, max=20, message="code长度必须介于 0 和 20 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=0, max=20, message="parentcode长度必须介于 0 和 20 之间")
	public String getParentcode() {
		return parentcode;
	}

	public void setParentcode(String parentcode) {
		this.parentcode = parentcode;
	}
	
	@Length(min=0, max=20, message="name长度必须介于 0 和 20 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=40, message="shortname长度必须介于 0 和 40 之间")
	public String getShortname() {
		return shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}
	
	@Length(min=0, max=20, message="mininame长度必须介于 0 和 20 之间")
	public String getMininame() {
		return mininame;
	}

	public void setMininame(String mininame) {
		this.mininame = mininame;
	}
	
	@Length(min=0, max=11, message="level长度必须介于 0 和 11 之间")
	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
	
	@Length(min=0, max=20, message="spell长度必须介于 0 和 20 之间")
	public String getSpell() {
		return spell;
	}

	public void setSpell(String spell) {
		this.spell = spell;
	}
	
	@Length(min=0, max=20, message="bigdistrict长度必须介于 0 和 20 之间")
	public String getBigdistrict() {
		return bigdistrict;
	}

	public void setBigdistrict(String bigdistrict) {
		this.bigdistrict = bigdistrict;
	}
	
	@Length(min=0, max=11, message="ishotcity长度必须介于 0 和 11 之间")
	public String getIshotcity() {
		return ishotcity;
	}

	public void setIshotcity(String ishotcity) {
		this.ishotcity = ishotcity;
	}
	
	@Length(min=0, max=11, message="ordernumber长度必须介于 0 和 11 之间")
	public String getOrdernumber() {
		return ordernumber;
	}

	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}
	
}