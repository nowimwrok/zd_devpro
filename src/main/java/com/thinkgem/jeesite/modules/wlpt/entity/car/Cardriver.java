/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 司机管理Entity
 * @author 饶江龙
 * @version 2016-07-26
 */
public class Cardriver extends DataEntity<Cardriver> {
	
	private static final long serialVersionUID = 1L;
	private String carid;		// carid
	private User driver;		// driverid
	
	public Cardriver() {
		super();
	}

	public Cardriver(String id){
		super(id);
	}

	@Length(min=1, max=32, message="carid长度必须介于 1 和 32 之间")
	public String getCarid() {
		return carid;
	}

	public void setCarid(String carid) {
		this.carid = carid;
	}
	
	@NotNull(message="driverid不能为空")
	public User getDriver() {
		return driver;
	}

	public void setDriver(User driver) {
		this.driver = driver;
	}
	
}