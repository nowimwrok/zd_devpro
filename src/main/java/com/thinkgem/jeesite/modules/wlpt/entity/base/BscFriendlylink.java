/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 友情链接Entity
 * @author 王铸
 * @version 2016-08-09
 */
public class BscFriendlylink extends DataEntity<BscFriendlylink> {
	
	private static final long serialVersionUID = 1L;
	private String friendlylinkId;		// 友情链接表Id
	private String webname;		// 网站名字
	private String weburl;		// 网站路径
	private String webtype;		// 网站类型:1政府行业协会2商贸网站3物流企业4互联网企业5其他
	private String webinfo;		// 网站信息
	private String linkname;		// 联系人
	private String linkmobile;		// 联系电话
	private String linkemail;		// 联系邮箱
	private String auditstatus;		// 状态:0.待审批1.审批通过2审批不通过
	private Date createtime;		// 创建时间
	private Date updatetime;		// 更新时间
	private String isvisible;		// 是否显示;0否1是
	private String module;		// 所属模块:0common1wlpt
	private String sortcode;		// 排序码，默认升序排列
	
	public BscFriendlylink() {
		super();
	}

	public BscFriendlylink(String id){
		super(id);
	}

	@Length(min=1, max=32, message="友情链接表Id长度必须介于 1 和 32 之间")
	public String getFriendlylinkId() {
		return friendlylinkId;
	}

	public void setFriendlylinkId(String friendlylinkId) {
		this.friendlylinkId = friendlylinkId;
	}
	
	@Length(min=0, max=50, message="网站名字长度必须介于 0 和 50 之间")
	public String getWebname() {
		return webname;
	}

	public void setWebname(String webname) {
		this.webname = webname;
	}
	
	@Length(min=0, max=4000, message="网站路径长度必须介于 0 和 4000 之间")
	public String getWeburl() {
		return weburl;
	}

	public void setWeburl(String weburl) {
		this.weburl = weburl;
	}
	
	@Length(min=0, max=30, message="网站类型:1政府行业协会2商贸网站3物流企业4互联网企业5其他长度必须介于 0 和 30 之间")
	public String getWebtype() {
		return webtype;
	}

	public void setWebtype(String webtype) {
		this.webtype = webtype;
	}
	
	@Length(min=0, max=300, message="网站信息长度必须介于 0 和 300 之间")
	public String getWebinfo() {
		return webinfo;
	}

	public void setWebinfo(String webinfo) {
		this.webinfo = webinfo;
	}
	
	@Length(min=0, max=30, message="联系人长度必须介于 0 和 30 之间")
	public String getLinkname() {
		return linkname;
	}

	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}
	
	@Length(min=0, max=32, message="联系电话长度必须介于 0 和 32 之间")
	public String getLinkmobile() {
		return linkmobile;
	}

	public void setLinkmobile(String linkmobile) {
		this.linkmobile = linkmobile;
	}
	
	@Length(min=0, max=30, message="联系邮箱长度必须介于 0 和 30 之间")
	public String getLinkemail() {
		return linkemail;
	}

	public void setLinkemail(String linkemail) {
		this.linkemail = linkemail;
	}
	
	public String getAuditstatus() {
		return auditstatus;
	}

	public void setAuditstatus(String auditstatus) {
		this.auditstatus = auditstatus;
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
	
	@Length(min=0, max=11, message="是否显示;0否1是长度必须介于 0 和 11 之间")
	public String getIsvisible() {
		return isvisible;
	}

	public void setIsvisible(String isvisible) {
		this.isvisible = isvisible;
	}
	
	@Length(min=0, max=11, message="所属模块:0common1wlpt长度必须介于 0 和 11 之间")
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}
	
	@Length(min=0, max=11, message="排序码，默认升序排列长度必须介于 0 和 11 之间")
	public String getSortcode() {
		return sortcode;
	}

	public void setSortcode(String sortcode) {
		this.sortcode = sortcode;
	}
	
}