/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 司机信息Entity
 * @author 饶江龙
 * @version 2016-07-26
 */
public class Driver extends DataEntity<Driver> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 
	private String drivername;		// 司机名
	private String drivermobile;		// 手机号码
	private String idcardnum;		// 身份证号
	private String status;		// 认证状态
	private String isdefault;		// 是否默认
	private String driverheadimg;		// 司机头像
	private String driverlicimg;		// 驾驶证
	private String idcardimg;		// 身份证图片
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	private Date beginUpdateDate;		// 开始 更新时间
	private Date endUpdateDate;		// 结束 更新时间
	
	public Driver() {
		super();
	}

	public Driver(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=20, message="司机名长度必须介于 0 和 20 之间")
	public String getDrivername() {
		return drivername;
	}

	public void setDrivername(String drivername) {
		this.drivername = drivername;
	}
	
	@Length(min=0, max=20, message="手机号码长度必须介于 0 和 20 之间")
	public String getDrivermobile() {
		return drivermobile;
	}

	public void setDrivermobile(String drivermobile) {
		this.drivermobile = drivermobile;
	}
	
	@Length(min=0, max=30, message="身份证号长度必须介于 0 和 30 之间")
	public String getIdcardnum() {
		return idcardnum;
	}

	public void setIdcardnum(String idcardnum) {
		this.idcardnum = idcardnum;
	}
	
	@Length(min=0, max=11, message="认证状态长度必须介于 0 和 11 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=11, message="是否默认长度必须介于 0 和 11 之间")
	public String getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(String isdefault) {
		this.isdefault = isdefault;
	}
	
	@Length(min=0, max=256, message="司机头像长度必须介于 0 和 256 之间")
	public String getDriverheadimg() {
		return driverheadimg;
	}

	public void setDriverheadimg(String driverheadimg) {
		this.driverheadimg = driverheadimg;
	}
	
	@Length(min=0, max=512, message="驾驶证长度必须介于 0 和 512 之间")
	public String getDriverlicimg() {
		return driverlicimg;
	}

	public void setDriverlicimg(String driverlicimg) {
		this.driverlicimg = driverlicimg;
	}
	
	@Length(min=0, max=512, message="身份证图片长度必须介于 0 和 512 之间")
	public String getIdcardimg() {
		return idcardimg;
	}

	public void setIdcardimg(String idcardimg) {
		this.idcardimg = idcardimg;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
		
	public Date getBeginUpdateDate() {
		return beginUpdateDate;
	}

	public void setBeginUpdateDate(Date beginUpdateDate) {
		this.beginUpdateDate = beginUpdateDate;
	}
	
	public Date getEndUpdateDate() {
		return endUpdateDate;
	}

	public void setEndUpdateDate(Date endUpdateDate) {
		this.endUpdateDate = endUpdateDate;
	}
		
}