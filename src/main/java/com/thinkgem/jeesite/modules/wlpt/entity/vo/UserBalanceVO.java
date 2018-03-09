package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class UserBalanceVO  extends DataEntity<UserBalanceVO> {

	private static final long serialVersionUID = 1L;
	private String code;// 类型编号
	private String name;// 类型名称
	private Double mony;// 余额
	private int count;// 数量
	private Double weight;// 重量
	private String createtime;//时间
	
	//扩展字段-用于重新
	private Date beginCreateDate;    // 创建日期
	private Date endCreateDate;    // 结束日期
	private String searchType; //状态：1收入 2支出
	private String type;
    private String userid; //用户id
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getMony() {
		if(mony==null){
			return 0.0;
		}
		return mony;
	}
	public void setMony(Double mony) {
		this.mony = mony;
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
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Double getWeight() {
		if(weight==null){
			return 0.0;
		}
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
