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
 * 诚信车主Entity
 * @author fjc
 * @version 2016-07-27
 */
public class IntegrityCarowner extends DataEntity<IntegrityCarowner> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 车主姓名
	private String linkphone;		// 联系方式
	private String idcard;		// 身份证
	private String driverlicense;		// 驾驶证
	private String owncar;		// 自有车辆证明
	private String qualifycertficate;		// 从业资格证
	private String carnumber;		// 车牌号
	private String bodywork;		// 车身照片
	private String auditrecord;		// 年审记录
	private String insurance;		// 保险资料
	private User user;		// 诚信用户id
	private Date updatetime;		// 更新时间
	private Date createtime;		// 创建时间
	private String isedit;		// 是否可以编辑 0 是 1否
	private String status;   //认证状态：0未认证1等待认证2认证通过3.认证不通过
	
	public IntegrityCarowner() {
		super();
	}

	public IntegrityCarowner(String id){
		super(id);
	}

	@Length(min=0, max=20, message="车主姓名长度必须介于 0 和 20 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=20, message="联系方式长度必须介于 0 和 20 之间")
	public String getLinkphone() {
		return linkphone;
	}

	public void setLinkphone(String linkphone) {
		this.linkphone = linkphone;
	}
	
	@Length(min=0, max=255, message="身份证长度必须介于 0 和 255 之间")
	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	
	@Length(min=0, max=255, message="驾驶证长度必须介于 0 和 255 之间")
	public String getDriverlicense() {
		return driverlicense;
	}

	public void setDriverlicense(String driverlicense) {
		this.driverlicense = driverlicense;
	}
	
	@Length(min=0, max=255, message="自有车辆证明长度必须介于 0 和 255 之间")
	public String getOwncar() {
		return owncar;
	}

	public void setOwncar(String owncar) {
		this.owncar = owncar;
	}
	
	@Length(min=0, max=255, message="从业资格证长度必须介于 0 和 255 之间")
	public String getQualifycertficate() {
		return qualifycertficate;
	}

	public void setQualifycertficate(String qualifycertficate) {
		this.qualifycertficate = qualifycertficate;
	}
	
	@Length(min=0, max=10, message="车牌号长度必须介于 0 和 10 之间")
	public String getCarnumber() {
		return carnumber;
	}

	public void setCarnumber(String carnumber) {
		this.carnumber = carnumber;
	}
	
	@Length(min=0, max=255, message="车身照片长度必须介于 0 和 255 之间")
	public String getBodywork() {
		return bodywork;
	}

	public void setBodywork(String bodywork) {
		this.bodywork = bodywork;
	}
	
	@Length(min=0, max=255, message="年审记录长度必须介于 0 和 255 之间")
	public String getAuditrecord() {
		return auditrecord;
	}

	public void setAuditrecord(String auditrecord) {
		this.auditrecord = auditrecord;
	}
	
	@Length(min=0, max=255, message="保险资料长度必须介于 0 和 255 之间")
	public String getInsurance() {
		return insurance;
	}

	public void setInsurance(String insurance) {
		this.insurance = insurance;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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