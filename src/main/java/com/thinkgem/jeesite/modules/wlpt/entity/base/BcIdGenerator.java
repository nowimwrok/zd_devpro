/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 业务结算单号Entity
 * @author zyj
 * @version 2017-05-18
 */
public class BcIdGenerator extends DataEntity<BcIdGenerator> {
	
	private static final long serialVersionUID = 1L;
	private String tableName;		// 表名
	private String prefix;		// 前缀
	private String maxDate;		// 日期（yyyyMMdd）
	private String maxNum;		// 递增戳
	private String numLength;		// 递增戳的长度
	private String calcId;		// 计算后的Id
	
	
	private String policy;  //扩展字段：重置策略:'none','daily'
	
	public BcIdGenerator() {
		super();
	}

	public BcIdGenerator(String id){
		super(id);
	}

	@Length(min=1, max=50, message="表名长度必须介于 1 和 50 之间")
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	@Length(min=0, max=20, message="前缀长度必须介于 0 和 20 之间")
	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	
	@Length(min=0, max=20, message="日期（yyyyMMdd）长度必须介于 0 和 20 之间")
	public String getMaxDate() {
		return maxDate;
	}

	public void setMaxDate(String maxDate) {
		this.maxDate = maxDate;
	}
	
	@Length(min=0, max=4, message="递增戳长度必须介于 0 和 4 之间")
	public String getMaxNum() {
		return maxNum;
	}

	public void setMaxNum(String maxNum) {
		this.maxNum = maxNum;
	}
	
	@Length(min=0, max=4, message="递增戳的长度长度必须介于 0 和 4 之间")
	public String getNumLength() {
		return numLength;
	}

	public void setNumLength(String numLength) {
		this.numLength = numLength;
	}
	
	@Length(min=0, max=50, message="计算后的Id长度必须介于 0 和 50 之间")
	public String getCalcId() {
		return calcId;
	}

	public void setCalcId(String calcId) {
		this.calcId = calcId;
	}

	public String getPolicy() {
		return policy;
	}

	public void setPolicy(String policy) {
		this.policy = policy;
	}
	
}