/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 企业图片信息Entity
 * @author fjc
 * @version 2016-07-27
 */
public class UserCompanypicture extends DataEntity<UserCompanypicture> {
	
	private static final long serialVersionUID = 1L;
	private UserCompany userCompany;		// 公司Id关联到物流企业Id
	private String headerimg;		// 法人或负责人照片
	private String businesslicencenumimg;		// 营业执照图片
	private String idcardimg;		// 身份证照片
	private String transportcardimg;		// 道路运输许可证书图片
	private String taximg;		// 税务登记许可证图片
	private String companysimg;		// 公司形象展示图片
	private String transporstyleimg;		// 运输风采图片
	private String carteamimg;		// 车队展示图片
	private String comanycultureimg;		// 企业文化照片
	private String comanyhonorimg;		// 公司荣誉
	private Date createtime;		// 创建时间
	private Date updatetime;		// 修改时间
	private String comanyhonorimgtitle;		// 公司荣誉图片标题,多张标题之间以分号隔开
	
	public UserCompanypicture() {
		super();
	}

	public UserCompanypicture(String id){
		super(id);
	}
	
	public UserCompany getUserCompany() {
		return userCompany;
	}

	public void setUserCompany(UserCompany userCompany) {
		this.userCompany = userCompany;
	}

	@Length(min=0, max=200, message="法人或负责人照片长度必须介于 0 和 200 之间")
	public String getHeaderimg() {
		return headerimg;
	}

	public void setHeaderimg(String headerimg) {
		this.headerimg = headerimg;
	}
	
	@Length(min=0, max=200, message="营业执照图片长度必须介于 0 和 200 之间")
	public String getBusinesslicencenumimg() {
		return businesslicencenumimg;
	}

	public void setBusinesslicencenumimg(String businesslicencenumimg) {
		this.businesslicencenumimg = businesslicencenumimg;
	}
	
	@Length(min=0, max=200, message="身份证照片长度必须介于 0 和 200 之间")
	public String getIdcardimg() {
		return idcardimg;
	}

	public void setIdcardimg(String idcardimg) {
		this.idcardimg = idcardimg;
	}
	
	@Length(min=0, max=200, message="道路运输许可证书图片长度必须介于 0 和 200 之间")
	public String getTransportcardimg() {
		return transportcardimg;
	}

	public void setTransportcardimg(String transportcardimg) {
		this.transportcardimg = transportcardimg;
	}
	
	@Length(min=0, max=200, message="税务登记许可证图片长度必须介于 0 和 200 之间")
	public String getTaximg() {
		return taximg;
	}

	public void setTaximg(String taximg) {
		this.taximg = taximg;
	}
	
	@Length(min=0, max=200, message="公司形象展示图片长度必须介于 0 和 200 之间")
	public String getCompanysimg() {
		return companysimg;
	}

	public void setCompanysimg(String companysimg) {
		this.companysimg = companysimg;
	}
	
	@Length(min=0, max=200, message="运输风采图片长度必须介于 0 和 200 之间")
	public String getTransporstyleimg() {
		return transporstyleimg;
	}

	public void setTransporstyleimg(String transporstyleimg) {
		this.transporstyleimg = transporstyleimg;
	}
	
	@Length(min=0, max=200, message="车队展示图片长度必须介于 0 和 200 之间")
	public String getCarteamimg() {
		return carteamimg;
	}

	public void setCarteamimg(String carteamimg) {
		this.carteamimg = carteamimg;
	}
	
	@Length(min=0, max=200, message="企业文化照片长度必须介于 0 和 200 之间")
	public String getComanycultureimg() {
		return comanycultureimg;
	}

	public void setComanycultureimg(String comanycultureimg) {
		this.comanycultureimg = comanycultureimg;
	}
	
	@Length(min=0, max=300, message="公司荣誉长度必须介于 0 和 300 之间")
	public String getComanyhonorimg() {
		return comanyhonorimg;
	}

	public void setComanyhonorimg(String comanyhonorimg) {
		this.comanyhonorimg = comanyhonorimg;
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
	
	@Length(min=0, max=300, message="公司荣誉图片标题,多张标题之间以分号隔开长度必须介于 0 和 300 之间")
	public String getComanyhonorimgtitle() {
		return comanyhonorimgtitle;
	}

	public void setComanyhonorimgtitle(String comanyhonorimgtitle) {
		this.comanyhonorimgtitle = comanyhonorimgtitle;
	}
	
}