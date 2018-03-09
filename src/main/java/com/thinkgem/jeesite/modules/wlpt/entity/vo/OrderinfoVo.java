/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;
import org.hibernate.validator.constraints.Length;

import javax.tools.Tool;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 运单统计信息Entity
 *
 * @author 饶江龙
 * @version 2016-07-28
 */
public class OrderinfoVo extends DataEntity<OrderinfoVo> {

    private Integer evercount;   ///每笔单数统计
    private String timeflag;    ///格式化日期
    private String showtime;    //展示格式化时间
    private Double allload;     ////所有吨位
    private Double newodload;   //新运单吨位
    private Double newodfreight;  //新运单运费
    private Double tradingodload;  //运输中  吨位
    private Double tradingodfreight;  //运输中运费
    private Double waitpayodload;  //待支付吨位
    private Double waitpayodfreight;  //待支付运费
    private Double endodload;  //已支付  吨位
    private Double endodfreight;  //已支付运费


    public OrderinfoVo() {
        super();
    }

    public OrderinfoVo(String id) {
        super(id);
    }

    public Integer getEvercount() {
        return evercount;
    }

    public void setEvercount(Integer evercount) {
        this.evercount = evercount;
    }

    public String getTimeflag() {
        return timeflag;
    }

    public void setTimeflag(String timeflag) {
        this.timeflag = timeflag;
    }

    public String getShowtime() {
        return showtime;
    }

    public void setShowtime(String showtime) {
        this.showtime = showtime;
    }

    public Double getAllload() {
        return allload;
    }

    public void setAllload(Double allload) {
        this.allload = allload;
    }

    public Double getNewodload() {
        return newodload;
    }

    public void setNewodload(Double newodload) {
        this.newodload = newodload;
    }

    public Double getNewodfreight() {
        return newodfreight;
    }

    public void setNewodfreight(Double newodfreight) {
        this.newodfreight = newodfreight;
    }

    public Double getTradingodload() {
        return tradingodload;
    }

    public void setTradingodload(Double tradingodload) {
        this.tradingodload = tradingodload;
    }

    public Double getTradingodfreight() {
        return tradingodfreight;
    }

    public void setTradingodfreight(Double tradingodfreight) {
        this.tradingodfreight = tradingodfreight;
    }

    public Double getWaitpayodload() {
        return waitpayodload;
    }

    public void setWaitpayodload(Double waitpayodload) {
        this.waitpayodload = waitpayodload;
    }

    public Double getWaitpayodfreight() {
        return waitpayodfreight;
    }

    public void setWaitpayodfreight(Double waitpayodfreight) {
        this.waitpayodfreight = waitpayodfreight;
    }

    public Double getEndodload() {
        return endodload;
    }

    public void setEndodload(Double endodload) {
        this.endodload = endodload;
    }

    public Double getEndodfreight() {
        return endodfreight;
    }

    public void setEndodfreight(Double endodfreight) {
        this.endodfreight = endodfreight;
    }
}