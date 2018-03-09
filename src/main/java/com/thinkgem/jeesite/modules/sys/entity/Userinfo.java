/**
 *
 */
package com.thinkgem.jeesite.modules.sys.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserIdcard;

/**
 * 用户管理Entity
 *
 * @author 饶江龙
 * @version 2016-07-13
 */
public class Userinfo extends DataEntity<Userinfo> {

    private static final long serialVersionUID = 1L;
    private String qq;        // QQ唯一性
    private String contactaddress;        // 联系地址
    private String sex;        // 0:女；1：男（默认改为1）
    private String identitycard;        // 身份证
    private String telphone;            //座机号码TELPHONE
    //private String companyId;        // 公司名称
    private String companyname;        // 公司名称
    private String openid;        // 微信OPENID
    private String associatedId;        // 关联账户父账户ID
    private String status;        // 认证状态：0未提交认证1等待认证2认证通过3.认证不通过
    private String iscompleteinfo;        // 是否完善资料：0未完善，1已完善
    private String registerway;        // 注册方式：1：Web网站门户注册2：手机APP注册3：微信公众号注册4.后台系统添加
    private int point;//诚信积分
    private int pointlevle;//诚信等级
    private int memberlevle;//会员等级
    private String cashpassword;        // 提现密码
    private Date countdate; //诚信等级统计时间

    private String roadcertificate;    //（0未校验，1匹配，2不配位，3未知，-1未查询到接口） 
    
    //private String userid;      ///关联用户ID
    
    private String accountId;

    private User user;    ///用户主表

    private UserCompany userCompany;    ///用户公司信息
    
    private UserIdcard userIdcard;

    
    public Userinfo() {
        super();
    }

    public Userinfo(String id) {
        super(id);
    }
    
    
    

    /*public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }*/

    public String getRoadcertificate() {
		return roadcertificate;
	}

	public void setRoadcertificate(String roadcertificate) {
		this.roadcertificate = roadcertificate;
	}

	@Length(min=1, max=50, message="公司ID（关联企业资料表）长度必须介于 1 和 50 之间")
    public UserCompany getUserCompany() {
        return userCompany;
    }

    public void setUserCompany(UserCompany userCompany) {
        this.userCompany = userCompany;
    }

    @Length(min=1, max=50, message="会员id（关联会员表）长度必须介于 1 和 50 之间")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }


    @Length(min = 0, max = 32, message = "QQ唯一性长度必须介于 0 和 32 之间")
    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    @Length(min = 0, max = 200, message = "联系地址长度必须介于 0 和 200 之间")
    public String getContactaddress() {
        return contactaddress;
    }

    public void setContactaddress(String contactaddress) {
        this.contactaddress = contactaddress;
    }

    @Length(min = 0, max = 11, message = "0:女；1：男（默认改为1）长度必须介于 0 和 11 之间")
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Length(min = 0, max = 18, message = "身份证长度必须介于 0 和 32 之间")
    public String getIdentitycard() {
        return identitycard;
    }

    public void setIdentitycard(String identitycard) {
        this.identitycard = identitycard;
    }
    @NotNull
    @Length(min = 0, max = 32, message = "电话号码长度必须介于 0 和 32 之间")
    public String getTelphone() {
        return telphone;
    }
    @NotNull
    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }
    @NotNull
    @Length(min = 0, max = 32, message = "公司名称长度必须介于 0 和 32 之间")
    public String getCompanyname() {
        return companyname;
    }

    public void setCompanyname(String companyname) {
        this.companyname = companyname;
    }

    @Length(min = 0, max = 50, message = "微信OPENID长度必须介于 0 和 50 之间")
    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    @Length(min = 0, max = 32, message = "关联账户父账户ID长度必须介于 0 和 32 之间")
    public String getAssociatedId() {
        return associatedId;
    }

    public void setAssociatedId(String associatedId) {
        this.associatedId = associatedId;
    }

    //@认证不通过长度必须介于 0 和 11 之间")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Length(min = 0, max = 11, message = "是否完善资料：0未完善，1已完善长度必须介于 0 和 11 之间")
    public String getIscompleteinfo() {
        return iscompleteinfo;
    }

    public void setIscompleteinfo(String iscompleteinfo) {
        this.iscompleteinfo = iscompleteinfo;
    }

    //@后台系统添加长度必须介于 0 和 11 之间")
    public String getRegisterway() {
        return registerway;
    }

    public void setRegisterway(String registerway) {
        this.registerway = registerway;
    }


    @Length(min = 0, max = 100, message = "提现密码长度必须介于 0 和 100 之间")
    @NotNull(message = "提现密码不允许为空")
    public String getCashpassword() {
        //System.out.print("提现密码" + cashpassword);
        return cashpassword;
    }

    public void setCashpassword(String cashpassword) {
        this.cashpassword = cashpassword;
    }

	public UserIdcard getUserIdcard() {
		return userIdcard;
	}

	public void setUserIdcard(UserIdcard userIdcard) {
		this.userIdcard = userIdcard;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getPointlevle() {
		return pointlevle;
	}

	public void setPointlevle(int pointlevle) {
		this.pointlevle = pointlevle;
	}

	public int getMemberlevle() {
		return memberlevle;
	}

	public void setMemberlevle(int memberlevle) {
		this.memberlevle = memberlevle;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public Date getCountdate() {
		return countdate;
	}

	public void setCountdate(Date countdate) {
		this.countdate = countdate;
	}


}