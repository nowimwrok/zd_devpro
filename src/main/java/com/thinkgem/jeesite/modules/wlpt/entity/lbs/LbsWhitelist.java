/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.lbs;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * LBS白名单Entity
 * @author zyj
 * @version 2016-10-10
 */
public class LbsWhitelist extends DataEntity<LbsWhitelist> {
	
	private static final long serialVersionUID = 1L;
	private String id;		// 白名单ID
	private String companyid;		// 公司账户
	private String companypwd;		// 公司密码
	private String mobile;		// 手机号码
	private Date registertime;		// 注册时间
	private String isreply;		// 是否已经答复:Y,是;N,否
	private Date replytime;		// 回复时间
	private String isdelete;		// 是否删除标识:0:未删除;1,删除;
	private Date createtime;		// 创建时间
	private String username;		// 操作者
	private String userip;		// 操作者IP
	
	public LbsWhitelist() {
		super();
	}

	public LbsWhitelist(String id){
		super(id);
	}

	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Length(min=0, max=32, message="公司账户长度必须介于 0 和 32 之间")
	public String getCompanyid() {
		return companyid;
	}

	public void setCompanyid(String companyid) {
		this.companyid = companyid;
	}
	
	@Length(min=0, max=50, message="公司密码长度必须介于 0 和 50 之间")
	public String getCompanypwd() {
		return companypwd;
	}

	public void setCompanypwd(String companypwd) {
		this.companypwd = companypwd;
	}
	
	@Length(min=0, max=20, message="手机号码长度必须介于 0 和 20 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRegistertime() {
		return registertime;
	}

	public void setRegistertime(Date registertime) {
		this.registertime = registertime;
	}
	
	@Length(min=0, max=4, message="是否已经答复:Y,是;N,否长度必须介于 0 和 4 之间")
	public String getIsreply() {
		return isreply;
	}

	public void setIsreply(String isreply) {
		this.isreply = isreply;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReplytime() {
		return replytime;
	}

	public void setReplytime(Date replytime) {
		this.replytime = replytime;
	}
	
	@Length(min=0, max=11, message="是否删除标识:0:未删除;1,删除;长度必须介于 0 和 11 之间")
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
	
	@Length(min=0, max=50, message="操作者长度必须介于 0 和 50 之间")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@Length(min=0, max=50, message="操作者IP长度必须介于 0 和 50 之间")
	public String getUserip() {
		return userip;
	}

	public void setUserip(String userip) {
		this.userip = userip;
	}
	
}