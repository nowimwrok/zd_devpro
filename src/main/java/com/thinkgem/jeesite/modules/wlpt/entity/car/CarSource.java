/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 车源管理Entity
 * @author zyj
 * @version 2016-12-26
 */
public class CarSource extends DataEntity<CarSource> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 车源发布人
	private Car car;		// 关联的车辆id
	private String carnumber;		// 车牌号码
	private String mainroad;		// 本次车源行驶路线
	private String contactname;		// 联系人
	private String contactmobile;		// 联系人号码
	private Date departuretime;		// 截止时间
	private String effectday;		// 有效期
	private String status;		// 车源状态：1:已发布，2:已过期，3:已取消
	
	//扩展字段
	private String fromaddress;    //开始地址
    private String toaddress;      //终点地址
	
	public CarSource() {
		super();
	}

	public CarSource(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}

	@Length(min=0, max=20, message="车牌号码长度必须介于 0 和 20 之间")
	public String getCarnumber() {
		return carnumber;
	}

	public void setCarnumber(String carnumber) {
		this.carnumber = carnumber;
	}
	
	@Length(min=0, max=500, message="本次车源行驶路线长度必须介于 0 和 500 之间")
	public String getMainroad() {
		return mainroad;
	}

	public void setMainroad(String mainroad) {
		this.mainroad = mainroad;
	}
	
	@Length(min=0, max=20, message="联系人长度必须介于 0 和 20 之间")
	public String getContactname() {
		return contactname;
	}

	public void setContactname(String contactname) {
		this.contactname = contactname;
	}
	
	@Length(min=0, max=20, message="联系人号码长度必须介于 0 和 20 之间")
	public String getContactmobile() {
		return contactmobile;
	}

	public void setContactmobile(String contactmobile) {
		this.contactmobile = contactmobile;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getDeparturetime() {
		return departuretime;
	}

	public void setDeparturetime(Date departuretime) {
		this.departuretime = departuretime;
	}
	
	@Length(min=0, max=20, message="有效期长度必须介于 0 和 20 之间")
	public String getEffectday() {
		return effectday;
	}

	public void setEffectday(String effectday) {
		this.effectday = effectday;
	}
	
	@Length(min=0, max=11, message="车源状态：1:已发布，2:已过期，3:已取消长度必须介于 0 和 11 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFromaddress() {
		return fromaddress;
	}

	public void setFromaddress(String fromaddress) {
		this.fromaddress = fromaddress;
	}

	public String getToaddress() {
		return toaddress;
	}

	public void setToaddress(String toaddress) {
		this.toaddress = toaddress;
	}
	
}