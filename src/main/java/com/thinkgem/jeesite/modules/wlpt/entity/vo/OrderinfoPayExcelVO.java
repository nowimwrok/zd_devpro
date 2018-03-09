package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

public class OrderinfoPayExcelVO extends DataEntity<OrderinfoPayExcelVO> {
    private static final long serialVersionUID = 1L;
    private String orderno;
    private String loginName;
    private String phone;
    private String actload;
    private String totalcost;
    private String actualamount;
    private String orderstatus;
    private String createtime;

    //kz
    private User buyer;		// 车队
    private User seller;		// 货主
    private Date endUpdateDate;		// 结束 Update_date
    private Date beginUpdateDate;		// 开始 Update_date

    @ExcelField(title = "运单号",align = 2,sort = 0)
    public String getOrderno() {
        return orderno;
    }

    public void setOrderno(String orderno) {
        this.orderno = orderno;
    }

    @ExcelField(title = "付款方",align = 2,sort = 1)
    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    @ExcelField(title = "付款方联系电话",align = 2,sort = 2)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @ExcelField(title = "运单运量(吨)",align = 2,sort = 3)
    public String getActload() {
        return actload;
    }

    public void setActload(String actload) {
        this.actload = actload;
    }

    @ExcelField(title = "运单金额(元)",align = 2,sort = 4)
    public String getTotalcost() {
        return totalcost;
    }

    public void setTotalcost(String totalcost) {
        this.totalcost = totalcost;
    }

    @ExcelField(title = "线上结算运费(元)",align = 2,sort = 4)
    public String getActualamount() {
        return actualamount;
    }

    public void setActualamount(String actualamount) {
        this.actualamount = actualamount;
    }
/*
    @ExcelField(title = "合同状态",align = 2,sort = 6,dictType="bidOrder_status")*/
    public String getOrderstatus() {
        return orderstatus;
    }

    public void setOrderstatus(String orderstatus) {
        this.orderstatus = orderstatus;
    }

    @ExcelField(title = "操作时间",align = 2,sort = 7)
    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }


    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }

    public User getSeller() {
        return seller;
    }

    public void setSeller(User seller) {
        this.seller = seller;
    }

    public Date getEndUpdateDate() {
        return endUpdateDate;
    }

    public void setEndUpdateDate(Date endUpdateDate) {
        this.endUpdateDate = endUpdateDate;
    }

    public Date getBeginUpdateDate() {
        return beginUpdateDate;
    }

    public void setBeginUpdateDate(Date beginUpdateDate) {
        this.beginUpdateDate = beginUpdateDate;
    }
}
