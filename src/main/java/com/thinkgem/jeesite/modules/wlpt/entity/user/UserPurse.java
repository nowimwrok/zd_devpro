/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.alibaba.druid.sql.visitor.functions.Isnull;
import com.thinkgem.jeesite.modules.sys.entity.User;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 账户钱包Entity
 *
 * @author 饶江龙
 * @version 2016-07-18
 */
public class UserPurse extends DataEntity<UserPurse> {

    private static final long serialVersionUID = 1L;
    private User user;        // 外键，用户ID 父类
    private Double webbalance;        // 平台余额，账户余额
    private Double availablebalance;        // 可用账户余额
    private Double freezemoney;        // 冻结资金(运费冻结)
    private Double biddingmoney;        // 竞标押金（用户竞标交纳的保证金存在这个字段）
    private Double guaranteemone;        // 保证金
    private Double petrolbalance;        // 油气金额
    private Double redpacket;        // 红包金额（活动获取）
    private Double settlemoney;        // 用户结算获得资金（预支付存到卓大账户）
    private Integer settlestatus;        // 结算状态：0可用1.冻结
    private Double insurance;        // 保险
    private Double creditmoney;        // 授信可用金额

    private Double webcoin;  //卓币金额
    private Double availablecoin; ///卓币可用余额
    private Double freezecoin;///卓币冻结余额


    public UserPurse() {
        super();
    }

    public UserPurse(String id) {
        super(id);
    }

    public UserPurse(User user) {
        this.user = user;
    }

    @NotNull(message = "外键，用户ID不能为空")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Double getWebbalance() {
        return webbalance;
    }

    public void setWebbalance(Double webbalance) {
        this.webbalance = webbalance;
    }

    public Double getAvailablebalance() {
        return availablebalance;
    }

    public void setAvailablebalance(Double availablebalance) {
        this.availablebalance = availablebalance;
    }

    public Double getFreezemoney() {
        return freezemoney;
    }

    public void setFreezemoney(Double freezemoney) {
        this.freezemoney = freezemoney;
    }

    public Double getBiddingmoney() {
        return biddingmoney;
    }

    public void setBiddingmoney(Double biddingmoney) {
        this.biddingmoney = biddingmoney;
    }

    public Double getGuaranteemone() {

        return guaranteemone;
    }

    public void setGuaranteemone(Double guaranteemone) {
        this.guaranteemone = guaranteemone;
    }

    public Double getPetrolbalance() {

        return petrolbalance;
    }

    public void setPetrolbalance(Double petrolbalance) {
        this.petrolbalance = petrolbalance;
    }

    public Double getRedpacket() {

        return redpacket;
    }

    public void setRedpacket(Double redpacket) {
        this.redpacket = redpacket;
    }

    public Double getSettlemoney() {
        return settlemoney;
    }

    public void setSettlemoney(Double settlemoney) {
        this.settlemoney = settlemoney;
    }

    public Integer getSettlestatus() {
        return settlestatus;
    }

    public void setSettlestatus(Integer settlestatus) {
        this.settlestatus = settlestatus;
    }

    public Double getInsurance() {

        return insurance;
    }

    public void setInsurance(Double insurance) {
        this.insurance = insurance;
    }

    public Double getCreditmoney() {

        return creditmoney;
    }

    public void setCreditmoney(Double creditmoney) {
        this.creditmoney = creditmoney;
    }

    public Double getWebcoin() {
        return webcoin;
    }

    public void setWebcoin(Double webcoin) {
        this.webcoin = webcoin;
    }

    public Double getAvailablecoin() {
        return availablecoin;
    }

    public void setAvailablecoin(Double availablecoin) {
        this.availablecoin = availablecoin;
    }

    public Double getFreezecoin() {
        return freezecoin;
    }

    public void setFreezecoin(Double freezecoin) {
        this.freezecoin = freezecoin;
    }
}