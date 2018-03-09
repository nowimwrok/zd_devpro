/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 系统文案Entity
 * @author 王铸
 * @version 2016-08-03
 */
public class BscAgreement extends DataEntity<BscAgreement> {
	
	private static final long serialVersionUID = 1L;
	private String agreementId;		// 系统协议ID
	private String name;		// 名称
	private String code;		// 编码
	private String content;		// 内容
	private String parentid;		// parentid
	private String type;		// 0一般链接需要显示内容1链接父目录
	private String sortcode;		// 排序码
	private String isdelete;		// 0显示1删除
	private Date createtime;		// createtime
	private Date updatetime;		// updatetime
	
	public BscAgreement() {
		super();
	}

	public BscAgreement(String id){
		super(id);
	}

	@Length(min=1, max=32, message="系统协议ID长度必须介于 1 和 32 之间")
	public String getAgreementId() {
		return agreementId;
	}

	public void setAgreementId(String agreementId) {
		this.agreementId = agreementId;
	}
	
	@Length(min=0, max=32, message="名称长度必须介于 0 和 32 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=32, message="编码长度必须介于 0 和 32 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String getParentid() {
		return parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	
	@Length(min=0, max=11, message="0一般链接需要显示内容1链接父目录长度必须介于 0 和 11 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=11, message="排序码长度必须介于 0 和 11 之间")
	public String getSortcode() {
		return sortcode;
	}

	public void setSortcode(String sortcode) {
		this.sortcode = sortcode;
	}
	
	@Length(min=0, max=11, message="0显示1删除长度必须介于 0 和 11 之间")
	public String getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(String isdelete) {
		this.isdelete = isdelete;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
}