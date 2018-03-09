/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户积分表，相关等级、积分诚信积分Entity
 * @author 饶江龙
 * @version 2016-07-22
 */
public class UserScore extends DataEntity<UserScore> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID
	private String point;		// 诚信积分
	private String pointlevel;		// 当前诚信等级
	private String ordinarypoint;		// 普通积分等级
	private String ordinarypointlevel;		// 所获普通积分获得的等级
	private String memberlevle;		// 会员等级
	
	public UserScore() {
		super();
	}

	public UserScore(String id){
		super(id);
	}

	@NotNull(message="用户ID不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=11, message="诚信积分长度必须介于 0 和 11 之间")
	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}
	
	@Length(min=0, max=11, message="当前诚信等级长度必须介于 0 和 11 之间")
	public String getPointlevel() {
		return pointlevel;
	}

	public void setPointlevel(String pointlevel) {
		this.pointlevel = pointlevel;
	}
	
	@Length(min=0, max=11, message="普通积分等级长度必须介于 0 和 11 之间")
	public String getOrdinarypoint() {
		return ordinarypoint;
	}

	public void setOrdinarypoint(String ordinarypoint) {
		this.ordinarypoint = ordinarypoint;
	}
	
	@Length(min=0, max=11, message="所获普通积分获得的等级长度必须介于 0 和 11 之间")
	public String getOrdinarypointlevel() {
		return ordinarypointlevel;
	}

	public void setOrdinarypointlevel(String ordinarypointlevel) {
		this.ordinarypointlevel = ordinarypointlevel;
	}
	
	@Length(min=0, max=11, message="会员等级长度必须介于 0 和 11 之间")
	public String getMemberlevle() {
		return memberlevle;
	}

	public void setMemberlevle(String memberlevle) {
		this.memberlevle = memberlevle;
	}
	
}