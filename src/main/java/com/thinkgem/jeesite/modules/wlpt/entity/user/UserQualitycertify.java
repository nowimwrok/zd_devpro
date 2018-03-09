/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;

/**
 * 资质认证Entity
 * @author fjc
 * @version 2016-08-02
 */
public class UserQualitycertify extends DataEntity<UserQualitycertify> {
	
	private static final long serialVersionUID = 1L;
	private String certifytype;		// 认证类型:0:个人信息1:企业信息2:车辆信息3:司机信息
	private String targetid;		// 认证目标的Id
	private User certifyuser;		// 认证操作者Id
	private String certifystatus;		// 认证状态1:认证通过0:等待认证2认证不通过
	private String certifycomment;		// 认证内容
	private String certifyfile;		// 认证附件
	private Date certifytime;		// 认证时间
	private User requestuser;		// 申请操作者Id
	private Date requesttime;		// 申请认证时间
	private Date beginRequesttime;		// 开始 申请认证时间
	private Date endRequesttime;		// 结束 申请认证时间
	
	private String searchInfo;
	private String targetInfo;
	private String carInfo;
	private String companyInfo;
	private String driverInfo;
//	private Car car;//认证车辆
//	private Driver driver;
//	private UserCompanypicture userCompanypicture;
//	private Userinfo userinfo;
	
	public UserQualitycertify() {
		super();
	}

	public UserQualitycertify(String id){
		super(id);
	}


	
	@Length(min=0, max=11, message="认证类型:0:个人信息1:企业信息2:车辆信息3:司机信息长度必须介于 0 和 11 之间")
	public String getCertifytype() {
		return certifytype;
	}

	public void setCertifytype(String certifytype) {
		this.certifytype = certifytype;
	}
	
	@Length(min=0, max=50, message="认证目标的Id长度必须介于 0 和 50 之间")
	public String getTargetid() {
		return targetid;
	}

	public void setTargetid(String targetid) {
		this.targetid = targetid;
	}
	

	
	@Length(min=0, max=11, message="认证状态1:认证通过0:等待认证2认证不通过长度必须介于 0 和 11 之间")
	public String getCertifystatus() {
		return certifystatus;
	}

	public void setCertifystatus(String certifystatus) {
		this.certifystatus = certifystatus;
	}
	
	@Length(min=0, max=500, message="认证内容长度必须介于 0 和 500 之间")
	public String getCertifycomment() {
		return certifycomment;
	}

	public void setCertifycomment(String certifycomment) {
		this.certifycomment = certifycomment;
	}
	
	@Length(min=0, max=100, message="认证附件长度必须介于 0 和 100 之间")
	public String getCertifyfile() {
		return certifyfile;
	}

	public void setCertifyfile(String certifyfile) {
		this.certifyfile = certifyfile;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCertifytime() {
		return certifytime;
	}

	public void setCertifytime(Date certifytime) {
		this.certifytime = certifytime;
	}
	
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRequesttime() {
		return requesttime;
	}

	public void setRequesttime(Date requesttime) {
		this.requesttime = requesttime;
	}
	
	public Date getBeginRequesttime() {
		return beginRequesttime;
	}

	public void setBeginRequesttime(Date beginRequesttime) {
		this.beginRequesttime = beginRequesttime;
	}
	
	public Date getEndRequesttime() {
		return endRequesttime;
	}

	public void setEndRequesttime(Date endRequesttime) {
		this.endRequesttime = endRequesttime;
	}

	public User getCertifyuser() {
		return certifyuser;
	}

	public void setCertifyuser(User certifyuser) {
		this.certifyuser = certifyuser;
	}

	public User getRequestuser() {
		return requestuser;
	}

	public void setRequestuser(User requestuser) {
		this.requestuser = requestuser;
	}

//	public Car getCar() {
//		return car;
//	}
//
//	public void setCar(Car car) {
//		this.car = car;
//	}
//
//	public Driver getDriver() {
//		return driver;
//	}
//
//	public void setDriver(Driver driver) {
//		this.driver = driver;
//	}
//
//	public UserCompanypicture getUserCompanypicture() {
//		return userCompanypicture;
//	}
//
//	public void setUserCompanypicture(UserCompanypicture userCompanypicture) {
//		this.userCompanypicture = userCompanypicture;
//	}
//
//	public Userinfo getUserinfo() {
//		return userinfo;
//	}
//
//	public void setUserinfo(Userinfo userinfo) {
//		this.userinfo = userinfo;
//	}

	public String getCarInfo() {
		return carInfo;
	}

	public void setCarInfo(String carInfo) {
		this.carInfo = carInfo;
	}

	public String getCompanyInfo() {
		return companyInfo;
	}

	public void setCompanyInfo(String companyInfo) {
		this.companyInfo = companyInfo;
	}

	public String getDriverInfo() {
		return driverInfo;
	}

	public void setDriverInfo(String driverInfo) {
		this.driverInfo = driverInfo;
	}

	public String getSearchInfo() {
		return searchInfo;
	}

	public void setSearchInfo(String searchInfo) {
		this.searchInfo = searchInfo;
	}

	public String getTargetInfo() {
		return targetInfo;
	}

	public void setTargetInfo(String targetInfo) {
		this.targetInfo = targetInfo;
	}
		
}