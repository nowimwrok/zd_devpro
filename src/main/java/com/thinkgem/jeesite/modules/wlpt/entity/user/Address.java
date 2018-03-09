/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * 用户地址管理Entity
 * @author 饶江龙
 * @version 2016-07-24
 */
public class Address extends DataEntity<Address> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID
	private String type;		// 地址类型:0:发货地 1:收货 2: 一卡通收货地址
	private String status;		// 地址状态:0:普通地址，1: 默认地址
	private String province;		// 省
	private String city;		// 市
	private String district;		// 区
	private String address;		// 详细地址
	private String linkman;		// 联系人
	private String linkcompany;		// 联系人公司名称
	private String linkmobile;		// 联系人手机
	private String linktelphone;		// 联系电话
	private String linkemail;		//
	private String postcode;   //邮政编码
    private String info;//地址信息
	public Address() {
		super();
	}

	public Address(String id, String address){
		this.id = id;
		this.address = linkman+" "+linkmobile+" "+city+" "+district+address;
	}

	public Address(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=11, message="地址类型:0:发货地1:收货长度必须介于 0 和 11 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=11, message="地址状态:0:普通地址，1: 默认地址长度必须介于 0 和 11 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=64, message="省长度必须介于 0 和 64 之间")
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}
	
	@Length(min=0, max=64, message="市长度必须介于 0 和 64 之间")
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	@Length(min=0, max=64, message="区长度必须介于 0 和 64 之间")
	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}
	
	@Length(min=0, max=255, message="详细地址长度必须介于 0 和 255 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=64, message="联系人长度必须介于 0 和 64 之间")
	@NotEmpty(message = "联系人不能为空")
	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	
	@Length(min=0, max=64, message="联系人公司名称长度必须介于 0 和 64 之间")
	public String getLinkcompany() {
		return linkcompany;
	}

	public void setLinkcompany(String linkcompany) {
		this.linkcompany = linkcompany;
	}
	
	@Length(min=0, max=64, message="联系人手机长度必须介于 0 和 64 之间")
	@NotEmpty(message = "联系人手机不能为空")
	public String getLinkmobile() {
		return linkmobile;
	}

	public void setLinkmobile(String linkmobile) {
		this.linkmobile = linkmobile;
	}
	
	@Length(min=0, max=64, message="联系电话长度必须介于 0 和 64 之间")
	public String getLinktelphone() {
		return linktelphone;
	}

	public void setLinktelphone(String linktelphone) {
		this.linktelphone = linktelphone;
	}
	
	@Length(min=0, max=64, message="联系邮箱长度必须介于 0 和 64 之间")
	@Email(message = "请填写正确的邮箱")
	public String getLinkemail() {
		return linkemail;
	}

	public void setLinkemail(String linkemail) {
		this.linkemail = linkemail;
	}


	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getInfo() {
		return this.province+this.city+this.district;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	
}