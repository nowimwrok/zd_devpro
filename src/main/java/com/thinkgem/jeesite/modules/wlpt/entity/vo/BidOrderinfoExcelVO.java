package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

/**
 * 合同导出
 */
public class BidOrderinfoExcelVO extends DataEntity<BidOrderinfoExcelVO> {
    private static final long serialVersionUID = 1L;
    private String contractno;
    private String loginName;
    private String phone;
    private String freightvolume;
    private String contracttotal;
    private String contractstatus;
    private String createtime;


    //kz
    private User biduser;        // 招标用户id
    private User biddinguser;        // 竞标用户id
    private String settlestatus;
    private String contractStr;
    private Date beginCreateDate; // 开始 创建时间-交易时间
    private Date endCreateDate; // 结束 创建时间-交易时间

    @ExcelField(title = "合同号",align = 2,sort = 0)
    public String getContractno() {
        return contractno;
    }

    public void setContractno(String contractno) {
        this.contractno = contractno;
    }

    @ExcelField(title = "收款方",align = 2,sort = 1)
    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    @ExcelField(title = "收款方联系电话",align = 2,sort = 2)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @ExcelField(title = "合同运量(吨)",align = 2,sort = 3)
    public String getFreightvolume() {
        return freightvolume;
    }

    public void setFreightvolume(String freightvolume) {
        this.freightvolume = freightvolume;
    }

    @ExcelField(title = "合同金额(元)",align = 2,sort = 4)
    public String getContracttotal() {
        return contracttotal;
    }

    public void setContracttotal(String contracttotal) {
        this.contracttotal = contracttotal;
    }

    @ExcelField(title = "合同状态",align = 2,sort = 5,dictType="bidOrder_status")
    public String getContractstatus() {
        return contractstatus;
    }

    public void setContractstatus(String contractstatus) {
        this.contractstatus = contractstatus;
    }

    @ExcelField(title = "操作时间",align = 2,sort = 6)
    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public User getBiduser() {
        return biduser;
    }

    public void setBiduser(User biduser) {
        this.biduser = biduser;
    }

    public User getBiddinguser() {
        return biddinguser;
    }

    public void setBiddinguser(User biddinguser) {
        this.biddinguser = biddinguser;
    }

    public String getSettlestatus() {
        return settlestatus;
    }

    public void setSettlestatus(String settlestatus) {
        this.settlestatus = settlestatus;
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

    public String getContractStr() {
        return contractStr;
    }

    public void setContractStr(String contractStr) {
        this.contractStr = contractStr;
    }
}
