/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.integrity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 诚信会员等级Entity
 * @author 刘欣
 * @version 2016-09-13
 */
public class IntegrityMemberlevel extends DataEntity<IntegrityMemberlevel> {
	
	private static final long serialVersionUID = 1L;
	private String membertype;		// 会员类型
	private String memberlevel;		// 会员等级
	private String integritycode;		// 标准编码
	private String standardvalue;		// 标准值
	private String standarddescribe;		// 描述
	
	public IntegrityMemberlevel() {
		super();
	}

	public IntegrityMemberlevel(String id){
		super(id);
	}

	public String getMembertype() {
		return membertype;
	}

	public void setMembertype(String membertype) {
		this.membertype = membertype;
	}
	
	@Length(min=0, max=4, message="会员等级长度必须介于 0 和 4 之间")
	public String getMemberlevel() {
		return memberlevel;
	}

	public void setMemberlevel(String memberlevel) {
		this.memberlevel = memberlevel;
	}
	
	@Length(min=0, max=32, message="标准编码长度必须介于 0 和 32 之间")
	public String getIntegritycode() {
		return integritycode;
	}

	public void setIntegritycode(String integritycode) {
		this.integritycode = integritycode;
	}
	
	@Length(min=0, max=16, message="标准值长度必须介于 0 和 16 之间")
	public String getStandardvalue() {
		return standardvalue;
	}

	public void setStandardvalue(String standardvalue) {
		this.standardvalue = standardvalue;
	}
	
	@Length(min=0, max=255, message="描述长度必须介于 0 和 255 之间")
	public String getStandarddescribe() {
		return standarddescribe;
	}

	public void setStandarddescribe(String standarddescribe) {
		this.standarddescribe = standarddescribe;
	}
	
}