/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.integrity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 诚信标准Entity
 * @author 刘欣
 * @version 2016-09-13
 */
public class IntegrityStandard extends DataEntity<IntegrityStandard> {
	
	private static final long serialVersionUID = 1L;
	private String membertype;		// 会员类型
	private String typename;		// 类型名称
	private String priority;		// 优先级
	private String exclude;		// 是否排斥
	private int standardvalue;		// 标准值
	
	public IntegrityStandard() {
		super();
	}

	public IntegrityStandard(String id){
		super(id);
	}

	public String getMembertype() {
		return membertype;
	}

	public void setMembertype(String membertype) {
		this.membertype = membertype;
	}
	
	@Length(min=0, max=255, message="类型名称长度必须介于 0 和 255 之间")
	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}
	
	@Length(min=0, max=2, message="优先级长度必须介于 0 和 2 之间")
	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}
	
	@Length(min=0, max=2, message="是否排斥长度必须介于 0 和 2 之间")
	public String getExclude() {
		return exclude;
	}

	public void setExclude(String exclude) {
		this.exclude = exclude;
	}

	public int getStandardvalue() {
		return standardvalue;
	}

	public void setStandardvalue(int standardvalue) {
		this.standardvalue = standardvalue;
	}
}