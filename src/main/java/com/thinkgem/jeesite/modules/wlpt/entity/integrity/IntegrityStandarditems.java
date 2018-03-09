/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.integrity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 诚信标准评分项Entity
 * @author 刘欣
 * @version 2016-09-13
 */
public class IntegrityStandarditems extends DataEntity<IntegrityStandarditems> {
	
	private static final long serialVersionUID = 1L;
	private IntegrityStandard standard;		// 标准类型
	private String scoreitem;		// 评分项
	private String integritycode;		// 评分CODE
	private String scoreway;		// 评分方式
	private Integer scorevalue;		// 评分值
	private Integer integral;		// 所得积分
	private Integer isrequired;		// 是否必填
	
	public IntegrityStandarditems() {
		super();
	}

	public IntegrityStandarditems(String id){
		super(id);
	}

	public IntegrityStandard getStandard() {
		return standard;
	}

	public void setStandard(IntegrityStandard standard) {
		this.standard = standard;
	}

	@Length(min=0, max=32, message="评分项长度必须介于 0 和 32 之间")
	public String getScoreitem() {
		return scoreitem;
	}

	public void setScoreitem(String scoreitem) {
		this.scoreitem = scoreitem;
	}
	
	@Length(min=0, max=32, message="评分CODE长度必须介于 0 和 32 之间")
	public String getIntegritycode() {
		return integritycode;
	}

	public void setIntegritycode(String integritycode) {
		this.integritycode = integritycode;
	}
	
	@Length(min=0, max=2, message="评分方式长度必须介于 0 和 2 之间")
	public String getScoreway() {
		return scoreway;
	}

	public void setScoreway(String scoreway) {
		this.scoreway = scoreway;
	}

	public Integer getScorevalue() {
		return scorevalue;
	}

	public void setScorevalue(Integer scorevalue) {
		this.scorevalue = scorevalue;
	}

	public Integer getIntegral() {
		return integral;
	}

	public void setIntegral(Integer integral) {
		this.integral = integral;
	}

	public Integer getIsrequired() {
		return isrequired;
	}

	public void setIsrequired(Integer isrequired) {
		this.isrequired = isrequired;
	}
}