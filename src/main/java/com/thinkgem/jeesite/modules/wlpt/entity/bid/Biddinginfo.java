/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.bid;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import org.hibernate.validator.constraints.Length;

/**
 * 竞标信息Entity
 *
 * @author 刘欣
 * @version 2016-08-03
 */
public class Biddinginfo extends DataEntity<Biddinginfo> {

    private static final long serialVersionUID = 1L;
    private String biddingcode;        // 竞标编号
    private Bidinfo bidinfo;  //招标信息
    private User biddinguser;        // 标竞用户
    private UserStatistics userStatistics ; //用户统计

    private String biddingprice;        // 竞标价格
    private String linkman;        // 联系人
    private String linkphone;        // 联系电话
    private String biddingstatus;        // 竞标状态
    private String guarantee;        // 保证金
    private String biddingmargin;        // 缴纳的保证金金额
    private String isderate;  //是否减免保证金
    private String formatCreateDate; //格式化时间
    
    private String isGuaAccount;//交纳保证金方式 0平台余额  2账户系统
    private String isLockWay;     //是否锁定余额--账户系统

    public String getBiddingmargin() {
		return biddingmargin;
	}

	public void setBiddingmargin(String biddingmargin) {
		this.biddingmargin = biddingmargin;
	}

	public String getIsderate() {
		return isderate;
	}

	public void setIsderate(String isderate) {
		this.isderate = isderate;
	}

	public Biddinginfo() {
        super();
    }

    public Biddinginfo(String id) {
        super(id);
    }

    public String getBiddingcode() {
        return biddingcode;
    }

    public void setBiddingcode(String biddingcode) {
        this.biddingcode = biddingcode;
    }

    public Bidinfo getBidinfo() {
        return bidinfo;
    }

    public void setBidinfo(Bidinfo bidinfo) {
        this.bidinfo = bidinfo;
    }

    public User getBiddinguser() {
        return biddinguser;
    }

    public void setBiddinguser(User biddinguser) {
        this.biddinguser = biddinguser;
    }

    public String getBiddingprice() {
        return biddingprice;
    }

    public void setBiddingprice(String biddingprice) {
        this.biddingprice = biddingprice;
    }

    @Length(min = 0, max = 16, message = "联系人长度必须介于 0 和 16 之间")
    public String getLinkman() {
        return linkman;
    }

    public void setLinkman(String linkman) {
        this.linkman = linkman;
    }

    @Length(min = 0, max = 32, message = "联系电话长度必须介于 0 和 32 之间")
    public String getLinkphone() {
        return linkphone;
    }

    public void setLinkphone(String linkphone) {
        this.linkphone = linkphone;
    }

    @Length(min = 0, max = 2, message = "竞标状态长度必须介于 0 和 2 之间")
    public String getBiddingstatus() {
        return biddingstatus;
    }

    public void setBiddingstatus(String biddingstatus) {
        this.biddingstatus = biddingstatus;
    }

    @Length(min = 0, max = 2, message = "保证金长度必须介于 0 和 2 之间")
    public String getGuarantee() {
        return guarantee;
    }

    public void setGuarantee(String guarantee) {
        this.guarantee = guarantee;
    }

	public String getFormatCreateDate() {
		return formatCreateDate;
	}

	public void setFormatCreateDate(String formatCreateDate) {
		this.formatCreateDate = formatCreateDate;
	}

    public UserStatistics getUserStatistics() {
        return userStatistics;
    }

    public void setUserStatistics(UserStatistics userStatistics) {
        this.userStatistics = userStatistics;
    }

	public String getIsGuaAccount() {
		return isGuaAccount;
	}

	public void setIsGuaAccount(String isGuaAccount) {
		this.isGuaAccount = isGuaAccount;
	}

	public String getIsLockWay() {
		return isLockWay;
	}

	public void setIsLockWay(String isLockWay) {
		this.isLockWay = isLockWay;
	}
	
	
}