/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.interfacelog;

import org.hibernate.validator.constraints.Length;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 接口调用日志信息Entity
 * 
 * @author W
 * @version 2017-10-16
 */
public class InterfaceLog extends DataEntity<InterfaceLog> {

	private static final long serialVersionUID = 1L;
	private String userid; // 用户id
	private String phone; // 手机号
	private String username; // 用户名
	private String reallyName; // 真实姓名
	private String interfaceType; // 接口类型
	private String interfaceName; // 接口名称
	private String interfaceSource; // 接口来源
	private String msgFlag; // 数据开关
	private String price; // 价格
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间

	private double total; // 总价格
	private int count; // 计数

	public InterfaceLog() {
		super();
	}

	public InterfaceLog(String id) {
		super(id);
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Length(min = 0, max = 255, message = "用户id长度必须介于 0 和 255 之间")
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Length(min = 0, max = 255, message = "手机号长度必须介于 0 和 255 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Length(min = 0, max = 255, message = "用户名长度必须介于 0 和 255 之间")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Length(min = 0, max = 255, message = "真实姓名长度必须介于 0 和 255 之间")
	public String getReallyName() {
		return reallyName;
	}

	public void setReallyName(String reallyName) {
		this.reallyName = reallyName;
	}

	@Length(min = 1, max = 1, message = "接口类型长度必须介于 1 和 1 之间")
	public String getInterfaceType() {
		return interfaceType;
	}

	public void setInterfaceType(String interfaceType) {
		this.interfaceType = interfaceType;
	}

	@Length(min = 0, max = 255, message = "接口名称长度必须介于 0 和 255 之间")
	public String getInterfaceName() {
		return interfaceName;
	}

	public void setInterfaceName(String interfaceName) {
		this.interfaceName = interfaceName;
	}

	@Length(min = 0, max = 1, message = "接口来源长度必须介于 0 和 1 之间")
	public String getInterfaceSource() {
		return interfaceSource;
	}

	public void setInterfaceSource(String interfaceSource) {
		this.interfaceSource = interfaceSource;
	}

	@Length(min = 0, max = 1, message = "数据开关长度必须介于 0 和 1 之间")
	public String getMsgFlag() {
		return msgFlag;
	}

	public void setMsgFlag(String msgFlag) {
		this.msgFlag = msgFlag;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
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

}