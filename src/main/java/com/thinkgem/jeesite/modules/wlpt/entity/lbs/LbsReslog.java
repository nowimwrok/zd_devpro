/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.lbs;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * LBS日志记录Entity
 * @author zyj
 * @version 2016-10-10
 */
public class LbsReslog extends DataEntity<LbsReslog> {
	
	private static final long serialVersionUID = 1L;
	private String id;		// LBS日志Id
	private String companyid;		// 公司账户Id
	private String companypwd;		// 公司账户密码
	private String mobile;		// 手机号码
	private String actiontype;		// 功能类型:1,白名单操作;2,定位操作
	private String opertype;		// 操作类型:[白名单操作]0,删除;1,添加,2,查询;[定位操作]0,查询最后一次位置;1,立即定位
	private String result;		// 请求结果：1,成功;0,失败;
	private String resmsg;		// 返回的描述信息
	private String resreason;		// 结果原因
	private String resfrom;		// 第三方API来源
	private String restimedelay;		// 所耗时长
	private Date operatetime;		// 操作时间
	private String username;		// 操作者
	private String userip;		// 操作者Ip
	
	public LbsReslog() {
		super();
	}

	public LbsReslog(String id){
		super(id);
	}

	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Length(min=0, max=32, message="公司账户Id长度必须介于 0 和 32 之间")
	public String getCompanyid() {
		return companyid;
	}

	public void setCompanyid(String companyid) {
		this.companyid = companyid;
	}
	
	@Length(min=0, max=50, message="公司账户密码长度必须介于 0 和 50 之间")
	public String getCompanypwd() {
		return companypwd;
	}

	public void setCompanypwd(String companypwd) {
		this.companypwd = companypwd;
	}
	
	@Length(min=0, max=15, message="手机号码长度必须介于 0 和 15 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Length(min=0, max=11, message="功能类型:1,白名单操作;2,定位操作长度必须介于 0 和 11 之间")
	public String getActiontype() {
		return actiontype;
	}

	public void setActiontype(String actiontype) {
		this.actiontype = actiontype;
	}
	
	@Length(min=0, max=11, message="操作类型:[白名单操作]0,删除;1,添加,2,查询;[定位操作]0,查询最后一次位置;1,立即定位长度必须介于 0 和 11 之间")
	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}
	
	@Length(min=0, max=11, message="请求结果：1,成功;0,失败;长度必须介于 0 和 11 之间")
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	@Length(min=0, max=200, message="返回的描述信息长度必须介于 0 和 200 之间")
	public String getResmsg() {
		return resmsg;
	}

	public void setResmsg(String resmsg) {
		this.resmsg = resmsg;
	}
	
	@Length(min=0, max=200, message="结果原因长度必须介于 0 和 200 之间")
	public String getResreason() {
		return resreason;
	}

	public void setResreason(String resreason) {
		this.resreason = resreason;
	}
	
	@Length(min=0, max=20, message="第三方API来源长度必须介于 0 和 20 之间")
	public String getResfrom() {
		return resfrom;
	}

	public void setResfrom(String resfrom) {
		this.resfrom = resfrom;
	}
	
	public String getRestimedelay() {
		return restimedelay;
	}

	public void setRestimedelay(String restimedelay) {
		this.restimedelay = restimedelay;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOperatetime() {
		return operatetime;
	}

	public void setOperatetime(Date operatetime) {
		this.operatetime = operatetime;
	}
	
	@Length(min=0, max=50, message="操作者长度必须介于 0 和 50 之间")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@Length(min=0, max=128, message="操作者Ip长度必须介于 0 和 128 之间")
	public String getUserip() {
		return userip;
	}

	public void setUserip(String userip) {
		this.userip = userip;
	}
	
}