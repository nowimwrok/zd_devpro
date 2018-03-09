/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.integrity;

import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * 诚信积分日志Entity
 * @author 刘欣
 * @version 2016-09-13
 */
public class IntegrityStandardlog extends DataEntity<IntegrityStandardlog> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户名
	private IntegrityStandarditems standarditems;		// 评分项
	private int pointvalue;		// 本次变化的积分
	private int pointbefore;		// 变化前的积分
	private int pointafter;		// 变化后的积分

	//扩展字段
	private String ymdDate;
	private Date beginCreateDate; // 开始 创建时间-交易时间
	private Date endCreateDate; // 结束 创建时间-交易时间


	public IntegrityStandardlog() {
		super();
	}

	public IntegrityStandardlog(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ExcelField(title = "登陆名",align = 2,sort = 0,value = "user.loginName")
	public String loginname() {
		return getUser().getLoginName();
	}


	public IntegrityStandarditems getStandarditems() {
		return standarditems;
	}

	public void setStandarditems(IntegrityStandarditems standarditems) {
		this.standarditems = standarditems;
	}

	@ExcelField(title = "评分项",align = 2,sort = 1,value = "standarditems.scoreitem")
	public String scoreitem() {
		return getStandarditems().getScoreitem();
	}

	@ExcelField(title = "本次变化的积分",align = 2,sort = 2)
	public int getPointvalue() {
		return pointvalue;
	}

	public void setPointvalue(int pointvalue) {
		this.pointvalue = pointvalue;
	}

	@ExcelField(title = "变化前的积分",align = 2,sort = 4)
	public int getPointbefore() {
		return pointbefore;
	}

	public void setPointbefore(int pointbefore) {
		this.pointbefore = pointbefore;
	}

	@ExcelField(title = "变化后的积分",align = 2,sort = 5)
	public int getPointafter() {
		return pointafter;
	}

	public void setPointafter(int pointafter) {
		this.pointafter = pointafter;
	}

	@ExcelField(title = "创建时间",align = 2,sort = 6)
	public Date getCreateDate() {
		return createDate;
	}

	public String getYmdDate() {
		return ymdDate;
	}

	public void setYmdDate(String ymdDate) {
		this.ymdDate = ymdDate;
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