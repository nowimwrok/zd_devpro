package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;

public class IntegrityRecordVO extends DataEntity<IntegrityRecordVO> {
    private static final long serialVersionUID = 1L;
    private User user;		// 会员ID
    private int totalValue = 0;//总获得
    private int tradeValue = 0;//交易获得
    private int shopValue = 0;//商城消费获得
    private int otherValue = 0;//其他获得
    private int consumeValue = 0;//消费

    //扩展字段
    private String ymdDate;
    private Date beginCreateDate; // 开始 创建时间-交易时间
    private Date endCreateDate; // 结束 创建时间-交易时间

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

    @ExcelField(title = "姓名",align = 2,sort = 1,value = "user.name")
    public String name() {
        return getUser().getName();
    }

    @ExcelField(title = "手机号",align = 2,sort = 2,value = "user.phone")
    public String phone() {
        return getUser().getPhone();
    }

    @ExcelField(title = "总分",align = 2,sort = 3)
    public int getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(int totalValue) {
        this.totalValue = totalValue;
    }

    @ExcelField(title = "交易得分",align = 2,sort = 4)
    public int getTradeValue() {
        return tradeValue;
    }

    public void setTradeValue(int tradeValue) {
        this.tradeValue = tradeValue;
    }

    @ExcelField(title = "商城消费得分",align = 2,sort = 5)
    public int getShopValue() {
        return shopValue;
    }

    public void setShopValue(int shopValue) {
        this.shopValue = shopValue;
    }

    @ExcelField(title = "其他得分",align = 2,sort = 6)
    public int getOtherValue() {
        return otherValue;
    }

    public void setOtherValue(int otherValue) {
        this.otherValue = otherValue;
    }

    @ExcelField(title = "积分消费",align = 2,sort = 7)
    public int getConsumeValue() {
        return consumeValue;
    }

    public void setConsumeValue(int consumeValue) {
        this.consumeValue = consumeValue;
    }

    @ExcelField(title = "更新时间",align = 2,sort = 8)
	public Date getUpdateDate() {
		return updateDate;
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
