/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 物流企业资料Entity
 * @author 饶江龙
 * @version 2016-07-18
 */
public class UserCompany extends DataEntity<UserCompany> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 会员id（关联会员表） 父类
	private UserCompanypicture usercompanypicture;		//公司图片表
	private String logoname;		// 公司Logo名称
	private String companyname;		// 公司名称
	private String legalperson;		// 企业法人
	private String legalidcardnum;		// 企业法人身份证号码
	private String legaladdress;		// 法人身份证地址
	private String headerperson;		// 负责人
	private String headeridcarno;		// 负责人的身份证号码
	private String headeraddress;		// 负责人身份证地址
	private String headertel;		// 负责人的固定电话
	private String headermobile;		// 负责人的手机
	private String headerexperience;		// 工作年限
	private String qrencoder;		// 二维码
	private String companyaddress;		// 详细地址
	private String homepageurl;		// 公司主页
	private String businesslicencenum;		// 营业执照
	private String mainbusiness;		// 主营业务
	private String advantagesresources;		// 优势资源
	private String mainline;		// 主营路线,最多三条，中间通过逗号分隔
	private Date setuptime;		// 公司成立时间
	private Date companyvalidtime;		// 公司有效期
	private String companysummary;		// 公司简介
	private String companyintroduction;		// 公司介绍
	private String qualifications;		// 相关资质
	private String isrecommend;		// 推荐企业
	private String status;		// 认证状态：0未提交认证1等待认证2认证通过3.认证不通过
	private String companyfax;		// 公司传真
	private String companyqq;		// 公司QQ
	private String productserver;		// 产品服务
	private String companyhonor;		// companyhonor
	private String companytel;		// companytel
	private String provinceCityDistrict;		// 公司地址:只包括省市区
	
	public UserCompany() {
		super();
	}

	public UserCompany(String id){
		super(id);
	}

	public UserCompanypicture getUsercompanypicture() {
		return usercompanypicture;
	}

	public void setUsercompanypicture(UserCompanypicture usercompanypicture) {
		this.usercompanypicture = usercompanypicture;
	}

	public UserCompany(User user){
		this.user = user;
	}

	@Length(min=1, max=50, message="会员id（关联会员表）长度必须介于 1 和 50 之间")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=200, message="公司Logo名称长度必须介于 0 和 200 之间")
	public String getLogoname() {
		return logoname;
	}

	public void setLogoname(String logoname) {
		this.logoname = logoname;
	}
	
	@Length(min=0, max=100, message="公司名称长度必须介于 0 和 100 之间")
	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	
	@Length(min=0, max=20, message="企业法人长度必须介于 0 和 20 之间")
	public String getLegalperson() {
		return legalperson;
	}

	public void setLegalperson(String legalperson) {
		this.legalperson = legalperson;
	}
	
	@Length(min=0, max=50, message="企业法人身份证号码长度必须介于 0 和 50 之间")
	public String getLegalidcardnum() {
		return legalidcardnum;
	}

	public void setLegalidcardnum(String legalidcardnum) {
		this.legalidcardnum = legalidcardnum;
	}
	
	@Length(min=0, max=100, message="法人身份证地址长度必须介于 0 和 100 之间")
	public String getLegaladdress() {
		return legaladdress;
	}

	public void setLegaladdress(String legaladdress) {
		this.legaladdress = legaladdress;
	}
	
	@Length(min=0, max=20, message="负责人长度必须介于 0 和 20 之间")
	public String getHeaderperson() {
		return headerperson;
	}

	public void setHeaderperson(String headerperson) {
		this.headerperson = headerperson;
	}
	
	@Length(min=0, max=50, message="负责人的身份证号码长度必须介于 0 和 50 之间")
	public String getHeaderidcarno() {
		return headeridcarno;
	}

	public void setHeaderidcarno(String headeridcarno) {
		this.headeridcarno = headeridcarno;
	}
	
	@Length(min=0, max=100, message="负责人身份证地址长度必须介于 0 和 100 之间")
	public String getHeaderaddress() {
		return headeraddress;
	}

	public void setHeaderaddress(String headeraddress) {
		this.headeraddress = headeraddress;
	}
	
	@Length(min=0, max=50, message="负责人的固定电话长度必须介于 0 和 50 之间")
	public String getHeadertel() {
		return headertel;
	}

	public void setHeadertel(String headertel) {
		this.headertel = headertel;
	}
	
	@Length(min=0, max=100, message="负责人的手机长度必须介于 0 和 100 之间")
	public String getHeadermobile() {
		return headermobile;
	}

	public void setHeadermobile(String headermobile) {
		this.headermobile = headermobile;
	}
	
	@Length(min=0, max=11, message="工作年限长度必须介于 0 和 11 之间")
	public String getHeaderexperience() {
		return headerexperience;
	}

	public void setHeaderexperience(String headerexperience) {
		this.headerexperience = headerexperience;
	}
	
	@Length(min=0, max=200, message="二维码长度必须介于 0 和 200 之间")
	public String getQrencoder() {
		return qrencoder;
	}

	public void setQrencoder(String qrencoder) {
		this.qrencoder = qrencoder;
	}
	
	@Length(min=0, max=200, message="详细地址长度必须介于 0 和 200 之间")
	public String getCompanyaddress() {
		return companyaddress;
	}

	public void setCompanyaddress(String companyaddress) {
		this.companyaddress = companyaddress;
	}
	
	@Length(min=0, max=200, message="公司主页长度必须介于 0 和 200 之间")
	public String getHomepageurl() {
		return homepageurl;
	}

	public void setHomepageurl(String homepageurl) {
		this.homepageurl = homepageurl;
	}
	
	@Length(min=0, max=100, message="营业执照长度必须介于 0 和 100 之间")
	public String getBusinesslicencenum() {
		return businesslicencenum;
	}

	public void setBusinesslicencenum(String businesslicencenum) {
		this.businesslicencenum = businesslicencenum;
	}
	
	@Length(min=0, max=100, message="主营业务长度必须介于 0 和 100 之间")
	public String getMainbusiness() {
		return mainbusiness;
	}

	public void setMainbusiness(String mainbusiness) {
		this.mainbusiness = mainbusiness;
	}
	
	@Length(min=0, max=100, message="优势资源长度必须介于 0 和 100 之间")
	public String getAdvantagesresources() {
		return advantagesresources;
	}

	public void setAdvantagesresources(String advantagesresources) {
		this.advantagesresources = advantagesresources;
	}
	
	@Length(min=0, max=300, message="主营路线,最多三条，中间通过逗号分隔长度必须介于 0 和 300 之间")
	public String getMainline() {
		return mainline;
	}

	public void setMainline(String mainline) {
		this.mainline = mainline;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSetuptime() {
		return setuptime;
	}

	public void setSetuptime(Date setuptime) {
		this.setuptime = setuptime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCompanyvalidtime() {
		return companyvalidtime;
	}

	public void setCompanyvalidtime(Date companyvalidtime) {
		this.companyvalidtime = companyvalidtime;
	}
	
	@Length(min=0, max=500, message="公司简介长度必须介于 0 和 500 之间")
	public String getCompanysummary() {
		return companysummary;
	}

	public void setCompanysummary(String companysummary) {
		this.companysummary = companysummary;
	}
	
	@Length(min=0, max=4000, message="公司介绍长度必须介于 0 和 4000 之间")
	public String getCompanyintroduction() {
		return companyintroduction;
	}

	public void setCompanyintroduction(String companyintroduction) {
		this.companyintroduction = companyintroduction;
	}
	
	@Length(min=0, max=4000, message="相关资质长度必须介于 0 和 4000 之间")
	public String getQualifications() {
		return qualifications;
	}

	public void setQualifications(String qualifications) {
		this.qualifications = qualifications;
	}
	
	@Length(min=0, max=11, message="推荐企业长度必须介于 0 和 11 之间")
	public String getIsrecommend() {
		return isrecommend;
	}

	public void setIsrecommend(String isrecommend) {
		this.isrecommend = isrecommend;
	}
	
	//@认证不通过长度必须介于 0 和 11 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=20, message="公司传真长度必须介于 0 和 20 之间")
	public String getCompanyfax() {
		return companyfax;
	}

	public void setCompanyfax(String companyfax) {
		this.companyfax = companyfax;
	}
	
	@Length(min=0, max=20, message="公司QQ长度必须介于 0 和 20 之间")
	public String getCompanyqq() {
		return companyqq;
	}

	public void setCompanyqq(String companyqq) {
		this.companyqq = companyqq;
	}
	
	@Length(min=0, max=4000, message="产品服务长度必须介于 0 和 4000 之间")
	public String getProductserver() {
		return productserver;
	}

	public void setProductserver(String productserver) {
		this.productserver = productserver;
	}
	
	@Length(min=0, max=4000, message="companyhonor长度必须介于 0 和 4000 之间")
	public String getCompanyhonor() {
		return companyhonor;
	}

	public void setCompanyhonor(String companyhonor) {
		this.companyhonor = companyhonor;
	}
	
	@Length(min=0, max=50, message="companytel长度必须介于 0 和 50 之间")
	public String getCompanytel() {
		return companytel;
	}

	public void setCompanytel(String companytel) {
		this.companytel = companytel;
	}
	
	@Length(min=0, max=100, message="公司地址:只包括省市区长度必须介于 0 和 100 之间")
	public String getProvinceCityDistrict() {
		return provinceCityDistrict;
	}

	public void setProvinceCityDistrict(String provinceCityDistrict) {
		this.provinceCityDistrict = provinceCityDistrict;
	}
	
}