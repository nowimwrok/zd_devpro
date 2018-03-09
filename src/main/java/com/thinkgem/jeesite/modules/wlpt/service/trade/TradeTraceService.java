/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.trade;

import java.util.List;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.dao.trade.OrderinfoDao;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradePayinfo;
import com.thinkgem.jeesite.modules.wlpt.service.goods.QuoteinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeTrace;
import com.thinkgem.jeesite.modules.wlpt.dao.trade.TradeTraceDao;

/**
 * 运单操作日志记录Service
 *
 * @author 饶江龙
 * @version 2016-07-28
 */
@Service
@Transactional(readOnly = true)
public class TradeTraceService extends CrudService<TradeTraceDao, TradeTrace> {

    @Autowired
    private TradeTraceDao tradeTraceDao;

    @Autowired
    private OrderinfoDao orderinfoDao;

    @Autowired
    private QuoteinfoService quoteinfoService;

    @Autowired
    private SystemService systemService;

    @Autowired
    private TradePayinfoService payinfoService;

    public TradeTrace get(String id) {
        return super.get(id);
    }


    /**
     * 保存操作记录信息
     *
     * @param type
     * @param status
     * @param orderinfo
     */
    @Transactional(readOnly = false)
    public void saveTrace(String type, String status, Orderinfo orderinfo) {
        TradeTrace tradeTrace = new TradeTrace();
        tradeTrace.preInsert();
        String content = "";
        ///获取交易运单信息
        Orderinfo traceorder = orderinfoDao.get(orderinfo.getId());
        switch (type) {
            case "0":
                /////修改状态操作日志
                saveOrderStatusTrace(traceorder, type, status);
                break;
            case "1":
                ////支付操作日志
                saveOrderPayTrace(traceorder, type, status);
                break;
            case "2":
                ///运输轨迹日志
                break;
            case "3":
                ///争议日志
            	saveOrderUpdateTrace(traceorder,type,status);
                break;

        }

    }

    /***
     * 保存运单状态操作记录
     *
     * @param traceorder 运单对象
     * @param type       记录类型
     * @param status     状态
     */
    @Transactional(readOnly = false)
    public void saveOrderStatusTrace(Orderinfo traceorder, String type, String status) {
        TradeTrace tradeTrace = new TradeTrace();
        tradeTrace.preInsert();
        String content = "";
        //获取报价信息
        Quoteinfo quoteinfo = quoteinfoService.get(traceorder.getQuoteinfo().getId());
        String carnumber = "";
        if(quoteinfo.getCar()!=null && !Tools.IsNullOrWhiteSpace(quoteinfo.getCar().getCarnumber())){
        	carnumber = quoteinfo.getCar().getCarnumber();
        }
        User driver = new User();
        if(quoteinfo.getDriver()!=null){
        	driver = systemService.getUser(quoteinfo.getDriver().getId());
        }
        User upuser = UserUtils.getUser();
        ///保存运单状态
        if (DataDic.ORDER_TRACE_TYPE_STATUS.equals(type)) {
            tradeTrace.setType(DataDic.ORDER_TRACE_TYPE_STATUS);
            tradeTrace.setStatus(status);
            ///保存一个title
            tradeTrace.setTitle(DataDic.ORDER_TRACE_TITLE1);
            switch (status) {
                case "0":
                    content = "供货方:" + upuser.getLoginName() + "同意报价成功,生成运单";
                    break;
                case "1":
                    content = "运输方:" + upuser.getLoginName() + "同意运输";
                    break;
                case "2":
                    content = upuser.getLoginName() + "取消运单";
                    break;
                case "3":
                    content = "运输方:司机-" + driver.getLoginName() + "已提货";
                    break;
                case "4":
                    content = "运输方:车辆-" + carnumber + "已卸货," + upuser.getLoginName() + "已回单";
                    break;
                case "5":
                    content = "供货方:" + upuser.getLoginName() + "确认交易完成";
                    break;
                case "6":
                    content = "争议:" + upuser.getLoginName() + "发起争议";
                    break;
                case "7":
                    content = "争议:" + upuser.getLoginName() + "处理争议完毕";
            }
            tradeTrace.setContent(content);
            tradeTrace.setOrderinfo(traceorder);
            tradeTraceDao.insert(tradeTrace);
        }
    }

    /***
     * 保存运单状态操作记录
     *
     * @param traceorder 运单对象
     * @param type       记录类型
     * @param status     状态
     */
    @Transactional(readOnly = false)
    public void saveOrderPayTrace(Orderinfo traceorder, String type, String status) {
        TradeTrace tradeTrace = new TradeTrace();
        tradeTrace.preInsert();
        String content = "";
        //获取报价信息
        Quoteinfo quoteinfo = quoteinfoService.get(traceorder.getQuoteinfo().getId());
        ///获取司机信息
        TradePayinfo payinfo = payinfoService.get(traceorder.getPayinfo().getId());
        User upuser = UserUtils.getUser();
        ///保存运单状态
        if (DataDic.ORDER_TRACE_TYPE_PAY.equals(type)) {
            //赋值状态
            tradeTrace.setStatus(status);
            ///支付类型
            tradeTrace.setType(DataDic.ORDER_TRACE_TYPE_PAY);
            ///保存一个title
            tradeTrace.setTitle(DataDic.ORDER_TRACE_TITLE2);
            switch (status) {
                case DataDic.ORDER_PAY_PREFORZEN:
                    content = "供货方:" + upuser.getLoginName() + "预冻结线上支付运费<br>" +
                            "运单号:" + traceorder.getOrderno() + "线上支付金额:" + payinfo.getOnlineamount();
                    break;
                case DataDic.ORDER_PAY_FORZEN:
                    content = "供货方:" + upuser.getLoginName() + "冻结线上支付" + payinfo.getOnlineamount();
                    break;
                case DataDic.ORDER_PAY_PAYPREMONEY:
                    content = "供货方:" + upuser.getLoginName() + "支付预支付金额" + payinfo.getPreamount();
                    break;
                case DataDic.ORDER_PAY_CANCELFORZEN:
                    content = "供货方:" + upuser.getLoginName() + "返还冻结金额" + payinfo.getOnlineamount();
                    break;
                case DataDic.ORDER_PAY_BANANCE:
                    content = "运输方:" + upuser.getLoginName() + "收到余款" + payinfo.getActualamount();
                    //if (traceorder.getIsdispute())
                    break;

            }
            tradeTrace.setContent(content);
            tradeTrace.setOrderinfo(traceorder);
            tradeTraceDao.insert(tradeTrace);
        }
    }

    /***
     * 保存运单信息变更操作记录
     *
     * @param traceorder 运单对象
     * @param type       记录类型
     * @param status     状态
     */
    @Transactional(readOnly = false)
    public void saveOrderUpdateTrace(Orderinfo traceorder, String type, String status) {
        TradeTrace tradeTrace = new TradeTrace();
        tradeTrace.preInsert();
        String content = "";
        TradePayinfo payinfo = payinfoService.get(traceorder.getPayinfo().getId());
        ///保存运单状态
        if (DataDic.ORDER_TRACE_TYPE_DISPUTE.equals(type)) {
            tradeTrace.setType(DataDic.ORDER_TRACE_TYPE_DISPUTE);
            tradeTrace.setStatus(status);
            ///保存一个title
            tradeTrace.setTitle(DataDic.ORDER_TRACE_TITLE4);
            switch (status) {
                case "0":
                    content = "";
                    break;
                case "1":
                    content = "";
                    break;
                case "2":
                    content = "";
                    break;
                case "3":
                    content = "";
                    break;
                case "4":
                    content = "";
                    break;
                case "5":
                    content = "";
                    break;
                case "6":
                    content = "运单信息变更:争议金额变更为"+payinfo.getDisputeamount()+",实际支付金额变更为"+payinfo.getActualamount();
            }
            tradeTrace.setContent(content);
            tradeTrace.setOrderinfo(traceorder);
            tradeTraceDao.insert(tradeTrace);
        }
    }

    public List<TradeTrace> findList(TradeTrace tradeTrace) {
        return super.findList(tradeTrace);
    }

    public Page<TradeTrace> findPage(Page<TradeTrace> page, TradeTrace tradeTrace) {
        return super.findPage(page, tradeTrace);
    }

    @Transactional(readOnly = false)
    public void save(TradeTrace tradeTrace) {
        super.save(tradeTrace);
    }

    @Transactional(readOnly = false)
    public void delete(TradeTrace tradeTrace) {
        super.delete(tradeTrace);
    }

}