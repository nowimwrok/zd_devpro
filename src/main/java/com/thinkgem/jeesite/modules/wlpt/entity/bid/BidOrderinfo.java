/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.bid;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 招标合同Entity
 *
 * @author fjc
 * @version 2016-08-04
 */
public class BidOrderinfo extends DataEntity<BidOrderinfo> {

    private static final long serialVersionUID = 1L;
    private String contractno;        // 合同号
    private Bidinfo bidinfo;        // 招标id
    private Biddinginfo biddinginfo;        // 竞标id
    private User biduser;        // 招标用户id
    private User biddinguser;        // 竞标用户id
    private Double contracttotal;        // 合同总价
    private String settlestatus;        // 0:未申请，1申请结算，2，申请通过3.支付完成，4确认
    private String ispayment;        // 0默认无需还款：1待还款：2已返款：3 确认返款
    private String contractstatus;        // 1合同中标状态，2正在交易，3.交易完成
    private String setttleStr;    ///结算状态字符
    private String contractStr;   ///合同状态字符
    private Boolean isBidUser;   //是否是招标用户
    private String noticeinfo;  //中标通知书
    private User curUser;        ///当前用户数据
    private String isAccount;//是否账户系统支付
    private String setttleSearch;//是否已结算 1已结算 2未结算
    private String sumcontracttotal;//统计的金钱
    private String ispaycoin; ///是否使用卓币
    private Double webamount;//现金金额
    private Double coinamount; ///卓币金额
    private String isOnlinePay;  ///是否线上支付,1:是,0否
    private Double lineAmount;   //线下支付金额
    private Date beginCreateDate; // 开始 创建时间-交易时间
	private Date endCreateDate; // 结束 创建时间-交易时间
    private String bidcode;


    private List<BidBlinfo> blinfoList = new ArrayList<>();
    private int total;
    private Double quantity;
    private String searchInfo;


    @ExcelField(title="是否支付卓币", align=2, sort=13,dictType = "yesorno")
    public String getIspaycoin() {
		return ispaycoin;
	}

	public void setIspaycoin(String ispaycoin) {
		this.ispaycoin = ispaycoin;
	}

    @ExcelField(title="线上支付", align=2, sort=11)
	public Double getWebamount() {
		return webamount;
	}

	public void setWebamount(Double webamount) {
		this.webamount = webamount;
	}

    @ExcelField(title="卓币支付", align=2, sort=14)
	public Double getCoinamount() {
		return coinamount;
	}

	public void setCoinamount(Double coinamount) {
		this.coinamount = coinamount;
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

	public String getSetttleSearch() {
		return setttleSearch;
	}

	public void setSetttleSearch(String setttleSearch) {
		this.setttleSearch = setttleSearch;
	}

	public String getSumcontracttotal() {
		return sumcontracttotal;
	}

	public void setSumcontracttotal(String sumcontracttotal) {
		this.sumcontracttotal = sumcontracttotal;
	}

	public BidOrderinfo() {
        super();
    }

    public BidOrderinfo(String id) {
        super(id);
    }

    public String getNoticeinfo() {
        return noticeinfo;
    }

    public void setNoticeinfo(String noticeinfo) {
        this.noticeinfo = noticeinfo;
    }

    public Boolean getIsBidUser() {
        return isBidUser;
    }

    public void setIsBidUser(Boolean isBidUser) {
        this.isBidUser = isBidUser;
    }

    public String getSetttleStr() {
        return setttleStr;
    }

    public void setSetttleStr(String setttleStr) {
        this.setttleStr = setttleStr;
    }

    public String getContractStr() {
        return contractStr;
    }

    public void setContractStr(String contractStr) {
        this.contractStr = contractStr;
    }

    public List<BidBlinfo> getBlinfoList() {
        return blinfoList;
    }

    public void setBlinfoList(List<BidBlinfo> blinfoList) {
        this.blinfoList = blinfoList;
    }

    @Length(min = 0, max = 32, message = "合同号长度必须介于 0 和 32 之间")
    public String getContractno() {
        return contractno;
    }

    public void setContractno(String contractno) {
        this.contractno = contractno;
    }

    public Bidinfo getBidinfo() {
        return bidinfo;
    }

    public void setBidinfo(Bidinfo bidinfo) {
        this.bidinfo = bidinfo;
    }

    public Biddinginfo getBiddinginfo() {
        return biddinginfo;
    }

    public void setBiddinginfo(Biddinginfo biddinginfo) {
        this.biddinginfo = biddinginfo;
    }

    public User getBiduser() {
        return biduser;
    }

    public void setBiduser(User biduser) {
        this.biduser = biduser;
    }
    
    @ExcelField(title="标招方", align=2, sort=0,value="biduser.loginName")
    public String getBidName(){
    	if(getBiduser()==null){
    		return "";
    	}
    	return getBiduser().getLoginName();
    }
    
    @ExcelField(title="联系方式", align=2, sort=1,value="biduser.phone")
    public String getBidPhone(){
    	if(getBiduser()==null){
    		return "";
    	}
    	return getBiduser().getPhone();
    }

    public User getBiddinguser() {
        return biddinguser;
    }

    public void setBiddinguser(User biddinguser) {
        this.biddinguser = biddinguser;
    }
    
    @ExcelField(title="竞标方", align=2, sort=2,value="biddinguser.loginName")
    public String getBiddingName(){
    	if(getBiddinguser()==null){
    		return "";
    	}
    	return getBiddinguser().getLoginName();
    }
    
    @ExcelField(title="联系方式", align=2, sort=3,value="biddinguser.phone")
    public String getBiddingPhone(){
    	if(getBiddinguser()==null){
    		return "";
    	}
    	return getBiddinguser().getPhone();
    }
    @ExcelField(title="合同总额", align=2, sort=9)
    public Double getContracttotal() {
        return contracttotal;
    }

    public void setContracttotal(Double contracttotal) {
        this.contracttotal = contracttotal;
    }

    @ExcelField(title="结算状态", align=2, sort=5,dictType = "bidOrder_settleStatus")
    public String getSettlestatus() {
        return settlestatus;
    }

    public void setSettlestatus(String settlestatus) {
        this.settlestatus = settlestatus;
    }

    @ExcelField(title="保证金状态", align=2, sort=6,dictType = "guarantee")
    public String getGuarantee() {
    	if(getBiddinginfo()==null){
    		return "";
    	}
    	
        return getBiddinginfo().getGuarantee();
    }

    
    @Length(min = 0, max = 2, message = "0默认无需还款：1待还款：2已返款：3 确认返款长度必须介于 0 和 2 之间")
    public String getIspayment() {
        return ispayment;
    }

    public void setIspayment(String ispayment) {
        this.ispayment = ispayment;
    }

    @ExcelField(title="合同状态", align=2, sort=4,dictType = "bidOrder_status")
    public String getContractstatus() {
        return contractstatus;
    }

    public void setContractstatus(String contractstatus) {
        this.contractstatus = contractstatus;
    }

    public User getCurUser() {
        return curUser;
    }

    public void setCurUser(User curUser) {
        this.curUser = curUser;
    }

    @ExcelField(title="货单量", align=2, sort=7)
	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	@ExcelField(title="货运量", align=2, sort=8)
	public Double getQuantity() {
		return quantity;
	}

	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}

    @ExcelField(title="竞标价", align=2, sort=9)
    public String getBidingPrice(){
        if (getBiddinginfo()==null || Tools.IsNullOrWhiteSpace(getBiddinginfo().getBiddingprice())){
            return "0.00";
        }
        return getBiddinginfo().getBiddingprice();
    }
	/*public Double getNum(){
		return total*quantity;
	}*/

	public String getSearchInfo() {
		return searchInfo;
	}

	public void setSearchInfo(String searchInfo) {
		this.searchInfo = searchInfo;
	}

    @ExcelField(title="是否线上支付", align=2, sort=10,dictType = "yesorno")
    public String getIsOnlinePay() {
        return isOnlinePay;
    }

    public void setIsOnlinePay(String isOnlinePay) {
        this.isOnlinePay = isOnlinePay;
    }

    @ExcelField(title="线下支付", align=2, sort=12)
    public Double getLineAmount() {
        return lineAmount;
    }
    
    @ExcelField(title="是否免保证金", align=2, sort=15,dictType = "yesorno")
    public String getIsderate() {
    	if(getBiddinginfo()==null){
    		return "";
    	}
    	
		return getBiddinginfo().getIsderate();
	}
    
    @ExcelField(title="缴纳的保证金", align=2, sort=16)
    public String getBiddingmargin() {
    	if(getBiddinginfo()==null){
    		return "0.00";
    	}
    	
		return getBiddinginfo().getBiddingmargin();
	}
    
    @ExcelField(title="创建时间", align=2, sort=17)
    public Date getcreate() {
        return getCreateDate();
    }
    
    @ExcelField(title="更新时间", align=2, sort=18)
    public Date getupdate() {
        return getUpdateDate();
    }

    public void setLineAmount(Double lineAmount) {
        this.lineAmount = lineAmount;
    }

    public String getBidcode() {
        return bidcode;
    }

    public void setBidcode(String bidcode) {
        this.bidcode = bidcode;
    }

	public String getIsAccount() {
		return isAccount;
	}

	public void setIsAccount(String isAccount) {
		this.isAccount = isAccount;
	}
}