/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 会员账户申请Entity
 * @author wz
 * @version 2017-05-19
 */
public class UserApplicationAccount extends DataEntity<UserApplicationAccount> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// 会员类型 1：企业会员；2：个人会员
	private String name;		// 名称 （当type=1时：企业名称，与营业执照中一致；当type=2时：个人姓名；）
	private String idcard;		// 身份证号（当type=1时：法人身份证号；当type=2时：个人身份证号）
	private String idcardimg;		// 身份证图片
	private String bizlicenceno;		// 营业执照号(当type=1时为必填)
	private String bizlicenceimg;		// 营业执照图片
	private String legalname;		// 法人姓名(当type=1时为必填)
	private String linkman;		// 联系人(当type=2时，值可以与name相等)
	private String linkmobile;		// 联系手机
	private String linkaddress;		// 联系地址
	private String applyid;		// 业务结算单ID
	private String accountStatus;//开户状态（-3：审核拒绝；1：审核中；3：已审核；6：已开户）
	private User user;//绑定的平台用户
	private String isBind;//是否已经绑定0否1是
	
	public UserApplicationAccount() {
		super();
	}

	public UserApplicationAccount(String id){
		super(id);
	}
	
	@Length(min=1, max=2, message="会员类型 1：企业会员；2：个人会员长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=64, message="名称 （当type=1时：企业名称，与营业执照中一致；当type=2时：个人姓名；）长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=64, message="身份证号（当type=1时：法人身份证号；当type=2时：个人身份证号）长度必须介于 1 和 64 之间")
	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	
	@Length(min=0, max=100, message="身份证图片长度必须介于 0 和 100 之间")
	public String getIdcardimg() {
		return idcardimg;
	}

	public void setIdcardimg(String idcardimg) {
		this.idcardimg = idcardimg;
	}
	
	@Length(min=0, max=64, message="营业执照号(当type=1时为必填)长度必须介于 0 和 64 之间")
	public String getBizlicenceno() {
		return bizlicenceno;
	}

	public void setBizlicenceno(String bizlicenceno) {
		this.bizlicenceno = bizlicenceno;
	}
	
	@Length(min=0, max=100, message="营业执照图片长度必须介于 0 和 100 之间")
	public String getBizlicenceimg() {
		return bizlicenceimg;
	}

	public void setBizlicenceimg(String bizlicenceimg) {
		this.bizlicenceimg = bizlicenceimg;
	}
	
	@Length(min=0, max=30, message="法人姓名(当type=1时为必填)长度必须介于 0 和 30 之间")
	public String getLegalname() {
		return legalname;
	}

	public void setLegalname(String legalname) {
		this.legalname = legalname;
	}
	
	@Length(min=1, max=30, message="联系人(当type=2时，值可以与name相等)长度必须介于 1 和 30 之间")
	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	
	@Length(min=1, max=30, message="联系手机长度必须介于 1 和 30 之间")
	public String getLinkmobile() {
		return linkmobile;
	}

	public void setLinkmobile(String linkmobile) {
		this.linkmobile = linkmobile;
	}
	
	@Length(min=1, max=200, message="联系地址长度必须介于 1 和 200 之间")
	public String getLinkaddress() {
		return linkaddress;
	}

	public void setLinkaddress(String linkaddress) {
		this.linkaddress = linkaddress;
	}
	
	@Length(min=1, max=30, message="业务结算单ID长度必须介于 1 和 30 之间")
	public String getApplyid() {
		return applyid;
	}

	public void setApplyid(String applyid) {
		this.applyid = applyid;
	}

	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getIsBind() {
		return isBind;
	}

	public void setIsBind(String isBind) {
		this.isBind = isBind;
	}
	
}