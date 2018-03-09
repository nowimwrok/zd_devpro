package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

public class CarGroup extends DataEntity<CarGroup>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7779724154706368476L;
    private Car car;
    private int groupsize;
    public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	@ExcelField(title="车辆数量",type=1,align=2,sort=7)
	public int getGroupsize() {
		return groupsize;
	}
	public void setGroupsize(int groupsize) {
		this.groupsize = groupsize;
	}
	@ExcelField(title="登录名",type=1,align=2,sort=1)
	public String loginName(){
		return getCar().getUser().getLoginName();
	}
	@ExcelField(title="用户名",type=1,align=2,sort=2)
	public String Name(){
		return getCar().getUser().getName();
	}
	@ExcelField(title="车主",type=1,align=2,sort=3)
	public String carOwner(){
		return getCar().getOwnername();
	}
	@ExcelField(title="手机号码",type=1,align=2,sort=6)
	public String Phone(){
		return getCar().getUser().getPhone();
	}
	@ExcelField(title="用户角色",type=1,align=2,sort=4)
	public String role(){
		return getCar().getUser().getRole().getName();
	}
	@ExcelField(title="公司名称",type=1,align=2,sort=5)
	public String companyName(){
		return getCar().getUser().getCompany().getName();
	}
	
}
