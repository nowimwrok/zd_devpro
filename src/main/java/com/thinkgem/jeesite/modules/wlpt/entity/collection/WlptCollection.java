/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.collection;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 我关注的路线信息Entity
 * @author zyj
 * @version 2017-04-19
 */
public class WlptCollection extends DataEntity<WlptCollection> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户Id
	private String targettype;		// 关注目标类型:1：车源，2：货源，3：招标
	private String fromprovince;		// 始发省
	private String fromcity;		// 始发市
	private String toprovince;		// 目的省
	private String tocity;		// 目的市
	private String typename;		// 关注目标类型:1：车源，2：货源，3：招标
	private String openid;		// 微信openid
	
	public WlptCollection() {
		super();
	}

	public WlptCollection(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=11, message="关注目标类型:0：车源，1：货源，2：招标长度必须介于 0 和 11 之间")
	public String getTargettype() {
		return targettype;
	}

	public void setTargettype(String targettype) {
		this.targettype = targettype;
	}
	
	@Length(min=0, max=20, message="始发省长度必须介于 0 和 20 之间")
	public String getFromprovince() {
		return fromprovince;
	}

	public void setFromprovince(String fromprovince) {
		this.fromprovince = fromprovince;
	}
	
	@Length(min=0, max=20, message="始发市长度必须介于 0 和 20 之间")
	public String getFromcity() {
		return fromcity;
	}

	public void setFromcity(String fromcity) {
		this.fromcity = fromcity;
	}
	
	@Length(min=0, max=20, message="目的省长度必须介于 0 和 20 之间")
	public String getToprovince() {
		return toprovince;
	}

	public void setToprovince(String toprovince) {
		this.toprovince = toprovince;
	}
	
	@Length(min=0, max=20, message="目的市长度必须介于 0 和 20 之间")
	public String getTocity() {
		return tocity;
	}

	public void setTocity(String tocity) {
		this.tocity = tocity;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
}