/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.integrity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 诚信企业Entity
 * @author fjc
 * @version 2016-07-27
 */
public class IntegrityEnterprise extends DataEntity<IntegrityEnterprise> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 企业法人的姓名
	private String linkphone;		// 公司联系方式
	private String idcard;		// 身份证图片用
	private String persionaladdress;		// 个人地址
	private String certificateproperty;		// 房产证图片
	private String companyname;		// 公司名称
	private String companyaddress;		// 公司地址
	private String operationyears;		// 经营年限
	private String companyinfo;		// 企业信息介绍
	private String stallscorporate;		// 档口和法人的照片&ldquo;,
	private String officespace;		// 办公场所
	private String storageplace;		// 存储货物的地方
	private String staffphoto;		// 员工合照
	private String businesslicense;		// 营业执照
	private String bankopening;		// 银行开户许可证
	private String roadtransport;		// 道路运输许可证
	private String owncar;		// 自有车辆证明
	private String upstreamcontract;		// 上游运输合同
	private User user;		// 诚信用户id
	private Date operationyearstime;		// 企业成立时间
	private Date updatetime;		// 更新时间
	private Date createtime;		// 创建时间
	private String isedit;		// 是否可以编辑 0 是 1否
	private String status;   //认证状态：0未认证1等待认证2认证通过3.认证不通过
	
	public IntegrityEnterprise() {
		super();
	}

	public IntegrityEnterprise(String id){
		super(id);
	}

	@Length(min=0, max=20, message="企业法人的姓名长度必须介于 0 和 20 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=20, message="公司联系方式长度必须介于 0 和 20 之间")
	public String getLinkphone() {
		return linkphone;
	}

	public void setLinkphone(String linkphone) {
		this.linkphone = linkphone;
	}
	
	@Length(min=0, max=200, message="身份证图片用长度必须介于 0 和 200 之间")
	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	
	@Length(min=0, max=255, message="个人地址长度必须介于 0 和 255 之间")
	public String getPersionaladdress() {
		return persionaladdress;
	}

	public void setPersionaladdress(String persionaladdress) {
		this.persionaladdress = persionaladdress;
	}
	
	@Length(min=0, max=255, message="房产证图片长度必须介于 0 和 255 之间")
	public String getCertificateproperty() {
		return certificateproperty;
	}

	public void setCertificateproperty(String certificateproperty) {
		this.certificateproperty = certificateproperty;
	}
	
	@Length(min=0, max=50, message="公司名称长度必须介于 0 和 50 之间")
	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	
	@Length(min=0, max=255, message="公司地址长度必须介于 0 和 255 之间")
	public String getCompanyaddress() {
		return companyaddress;
	}

	public void setCompanyaddress(String companyaddress) {
		this.companyaddress = companyaddress;
	}
	
	public String getOperationyears() {
		return operationyears;
	}

	public void setOperationyears(String operationyears) {
		this.operationyears = operationyears;
	}
	
	@Length(min=0, max=500, message="企业信息介绍长度必须介于 0 和 500 之间")
	public String getCompanyinfo() {
		return companyinfo;
	}

	public void setCompanyinfo(String companyinfo) {
		this.companyinfo = companyinfo;
	}
	
	@Length(min=0, max=255, message="档口和法人的照片&ldquo;,长度必须介于 0 和 255 之间")
	public String getStallscorporate() {
		return stallscorporate;
	}

	public void setStallscorporate(String stallscorporate) {
		this.stallscorporate = stallscorporate;
	}
	
	@Length(min=0, max=255, message="办公场所长度必须介于 0 和 255 之间")
	public String getOfficespace() {
		return officespace;
	}

	public void setOfficespace(String officespace) {
		this.officespace = officespace;
	}
	
	@Length(min=0, max=255, message="存储货物的地方长度必须介于 0 和 255 之间")
	public String getStorageplace() {
		return storageplace;
	}

	public void setStorageplace(String storageplace) {
		this.storageplace = storageplace;
	}
	
	@Length(min=0, max=255, message="员工合照长度必须介于 0 和 255 之间")
	public String getStaffphoto() {
		return staffphoto;
	}

	public void setStaffphoto(String staffphoto) {
		this.staffphoto = staffphoto;
	}
	
	@Length(min=0, max=255, message="营业执照长度必须介于 0 和 255 之间")
	public String getBusinesslicense() {
		return businesslicense;
	}

	public void setBusinesslicense(String businesslicense) {
		this.businesslicense = businesslicense;
	}
	
	@Length(min=0, max=255, message="银行开户许可证长度必须介于 0 和 255 之间")
	public String getBankopening() {
		return bankopening;
	}

	public void setBankopening(String bankopening) {
		this.bankopening = bankopening;
	}
	
	@Length(min=0, max=255, message="道路运输许可证长度必须介于 0 和 255 之间")
	public String getRoadtransport() {
		return roadtransport;
	}

	public void setRoadtransport(String roadtransport) {
		this.roadtransport = roadtransport;
	}
	
	@Length(min=0, max=255, message="自有车辆证明长度必须介于 0 和 255 之间")
	public String getOwncar() {
		return owncar;
	}

	public void setOwncar(String owncar) {
		this.owncar = owncar;
	}
	
	@Length(min=0, max=255, message="上游运输合同长度必须介于 0 和 255 之间")
	public String getUpstreamcontract() {
		return upstreamcontract;
	}

	public void setUpstreamcontract(String upstreamcontract) {
		this.upstreamcontract = upstreamcontract;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOperationyearstime() {
		return operationyearstime;
	}

	public void setOperationyearstime(Date operationyearstime) {
		this.operationyearstime = operationyearstime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@Length(min=0, max=2, message="是否可以编辑 0 是 1否长度必须介于 0 和 2 之间")
	public String getIsedit() {
		return isedit;
	}

	public void setIsedit(String isedit) {
		this.isedit = isedit;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}