package com.thinkgem.jeesite.modules.wlpt.api.trade;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.driverBiz.DriverBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.gps.GpsInfoBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.*;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.TradeComment;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.StatisticsBusinessVO;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;
import com.thinkgem.jeesite.modules.wlpt.service.comment.TradeCommentService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeReceipt;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.TradeTrace;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.TradeTraceService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "${appPath}/api/trade")
public class TradeAppController extends BaseController {

    private static final String REX = "^[0-9]+(.[0-9]{0,2})?$";
    private static final String REX1 = "^[0-9]+(.[0-9]{0,3})?$";

    @Autowired
    private OrderinfoService orderinfoService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private TradeBiz tradeBiz;
    @Autowired
    private TradeTraceService tradeTraceService;

    @Autowired
    private CarBiz carBiz;

    @Autowired
    private DriverBiz driverBiz;

    @Autowired
    private GoodsBiz goodsBiz;

    @Autowired
    private GpsCarInfoService carInfoService;

    @Autowired
    private TradeCommentService tradeCommentService;

    @Autowired
    private GpsInfoBiz gpsInfoBiz;

    /***
     * 获取运单列表
     *
     * @param orderinfo
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getTradeList", method = RequestMethod.GET)
    public Object getTradeList(Orderinfo orderinfo, int pageNo, int pageSize) {

        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Page<Orderinfo> pg = new Page<Orderinfo>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {

            if (StringUtils.isBlank(UserUtils.getUser().getId())) {
                map.put("state", "1006");
                map.put("message", "登录过期");
                return map;
            }
            User us = UserUtils.getUser();
            orderinfo.setSeller(us);
            Page<Orderinfo> pageVal = orderinfoService.findPage(pg, orderinfo);
            /// 如果是查询个人用户的运单信息则判断是否是买家
            for (Orderinfo var : pageVal.getList()) {
                if (us.getId().equals(var.getBuyer().getId())) {
                    var.setIsBuyer(true);
                } else {
                    var.setIsBuyer(false);
                }
                /// 查询货源信息
                if (var.getQuoteinfo() != null && var.getQuoteinfo().getGoods() != null) {
                    var.getQuoteinfo().setGoods(goodsService.get(var.getQuoteinfo().getGoods().getId()));
                }
                /// 字符状态--运单状态转化为中文
                var.setStatusStr(DictUtils.getDictLabel(var.getOrderstatus(), "order_status", null));

                var.getQuoteinfo().getGoods().setGsoddtype(
                        DictUtils.getDictLabel(var.getQuoteinfo().getGoods().getGsoddtype(), "gsoddtype", ""));
            }

            int totlaCount = (int) pageVal.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / pageVal.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", pageVal.getList());
        } catch (Exception e) {
            e.printStackTrace();
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /***
     * 运单详情
     *
     * @param request
     * @param response
     * @param id     运单ID
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "orderInfo", method = RequestMethod.GET)
    public Object orderInfo(String id, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(id)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "orderId为空";
        } else {
            try {
                /// 获取详细信息
                Orderinfo orderinfo = tradeBiz.getDetail(id, UserUtils.getUser());
                // 获取运单凭证信息
                TradeReceipt takeGoods = tradeBiz.getTradeReceiptBiz(orderinfo.getId(),
                        DataDic.TRADERECEIPT_TYPE_TAKEGOODS);
                TradeReceipt tradeReceipt = tradeBiz.getTradeReceiptBiz(orderinfo.getId(),
                        DataDic.TRADERECEIPT_TYPE_RECEIPT);
                result.put("orderinfo", orderinfo);
                result.put("takeGoods", takeGoods);
                result.put("tradeReceipt", tradeReceipt);
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /***
     * 获取交易历史记录
     *
     * @param orderinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "traceList", method = RequestMethod.GET)
    public Object getTraceList(Orderinfo orderinfo) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (orderinfo == null || StringUtils.isBlank(orderinfo.getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "运单id为空";
        } else {
            try {
                TradeTrace tradeTrace = new TradeTrace();
                tradeTrace.setOrderinfo(orderinfo);
                tradeTrace.setType(DataDic.ORDER_TRACE_TYPE_STATUS);
                List<TradeTrace> traceList = tradeTraceService.findList(tradeTrace);
                for (TradeTrace trace : traceList) {
                    String code = "order_status";
                    // 运单状态
                    if (trace.getType().equals(DataDic.ORDER_TRACE_TYPE_STATUS)) {
                        code = "order_status";
                    } else if (trace.getType().equals(DataDic.ORDER_TRACE_TYPE_STATUS)) {/// 支付状态
                        code = "order_paystatus";
                    }
                    trace.setStatus(DictUtils.getDictLabel(trace.getStatus(), code, null));
                }
                result.put("list", traceList);
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 确认运单信息
     *
     * @param id
     * @param ischange
     * @param carId
     * @param driverId
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "confrimOrder", method = RequestMethod.POST)
    public Object confrimOrder(String id, String ischange, String carId, String driverId, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(id)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "运单id为空";
        } else if (StringUtils.isNotBlank(ischange) && DataDic.YES.equals(ischange)) {
            if (StringUtils.isBlank(carId)) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "carId为空";
            } else if (StringUtils.isBlank(driverId)) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "driverId为空";
            }
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            try {
                /// 当前用户信息
                User curUser = UserUtils.getUser();
                /// 获取原运单信息
                Orderinfo orderinfo = orderinfoService.get(id);
                /// 运单支付信息是否完整
                if (orderinfo == null || orderinfo.getBuyer() == null || orderinfo.getSeller() == null
                        || orderinfo.getPayinfo() == null) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "运单信息缺失";
                } else if (!curUser.getId().equals(orderinfo.getBuyer().getId())) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "只有运输方才能确认运单信息";
                } else {
                    if (StringUtils.isNotBlank(id)) {
                        Quoteinfo qu = orderinfo.getQuoteinfo();
                        qu.setCar(new Car(carId));
                        qu.setDriver(new User(driverId));
                        qu.setIschange(ischange);
                        orderinfo.setQuoteinfo(qu);
                    }
                    int result = tradeBiz.confrimOrderBiz(orderinfo, model);
                    if (result != DataDic.RETURN_STATUS_NORMAL) {
                        state = DataDic.RETURN_STATUS_INFOBUG;
                        message = "操作失败";
                    }
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 运单上传提货凭据
     *
     * @param tradeReceipt
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveTradeTakeGoods", method = RequestMethod.POST)
    public Object saveTradeTakeGoods(TradeReceipt tradeReceipt) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (tradeReceipt == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "提货信息为空";
        } else if (StringUtils.isBlank(tradeReceipt.getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else if (StringUtils.isBlank(tradeReceipt.getReceiptimg())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "receiptimg为空";
        } else {
            try {
                int result = tradeBiz.saveTradeTakeGoods(tradeReceipt.getId(), tradeReceipt.getReceiptimg(),
                        tradeReceipt.getOddloadweight());
                if (result != DataDic.RETURN_STATUS_NORMAL) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "操作失败";
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 运单上传回执单
     *
     * @param tradeReceipt
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveTradeReceipt", method = RequestMethod.POST)
    public Object saveTradeReceipt(TradeReceipt tradeReceipt) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (tradeReceipt == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "回单信息为空";
        } else if (StringUtils.isBlank(tradeReceipt.getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else if (StringUtils.isBlank(tradeReceipt.getReceiptimg())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "receiptimg为空";
        } else {
            try {
                int result = tradeBiz.saveTradeReceipt(tradeReceipt.getId(), tradeReceipt.getReceiptimg(),
                        tradeReceipt.getOddloadweight());
                if (result != DataDic.RETURN_STATUS_NORMAL) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "操作失败";
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 取消运单
     *
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "cancelOrder", method = RequestMethod.POST)
    public Object cancelOrder(Orderinfo orderinfo, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (orderinfo == null || StringUtils.isBlank(orderinfo.getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else {
            try {
                int result = tradeBiz.cancelOrderBiz(orderinfo, model);
                if (result != DataDic.RETURN_STATUS_NORMAL) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "操作失败";
                }
            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 运单发起争议
     *
     * @param userDispute
     * @param orderId
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveTradeDispute", method = RequestMethod.POST)
    public Object saveTradeDispute(UserDispute userDispute, String orderId, RedirectAttributes redirectAttributes) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (userDispute == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "争议信息为空";
        } else if (StringUtils.isBlank(orderId)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "orderId为空";
        } else if (StringUtils.isBlank(userDispute.getGoodsname())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "goodsname为空";
        } else if (StringUtils.isBlank(userDispute.getTakeloadweight())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "takeloadweight为空";
        } else if (StringUtils.isBlank(userDispute.getUnloadweight())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "unloadweight为空";
        } else if (StringUtils.isBlank(userDispute.getDisputemoney())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "disputemoney为空";
        } else if (StringUtils.isBlank(userDispute.getDisputetype())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "disputetype为空";
        } else {
            try {
                Map<String, Object> result = (Map<String, Object>) tradeBiz.saveUserDispute(orderId, userDispute.getGoodsname(),
                        userDispute.getTakeloadweight(), userDispute.getUnloadweight(),
                        userDispute.getDisputeinfo(), userDispute.getDisputemoney(),
                        userDispute.getDisputetype());

                state = (int) result.get("state");
                message = result.get("message").toString();

            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }


        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 运单司机是否同意争议
     * dealDispute
     *
     * @param userDispute
     * @returns
     */

    @ResponseBody
    @RequestMapping(value = "dealDispute", method = RequestMethod.POST)
    public Object isAgreeDispute(UserDispute userDispute) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (userDispute == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "争议信息为空";
        } else if (StringUtils.isBlank(userDispute.getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "争议id为空";
        } else if (StringUtils.isBlank(userDispute.getIsreject())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "争议isreject为空";
        } else {
            try {
                Boolean result = tradeBiz.confirmUserdispute(userDispute.getId(), userDispute.getIsreject());
                if (!result) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "请求失败";
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /***
     * 运输完成
     *
     * @param id
     * @param passWord
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "endOrder", method = RequestMethod.POST)
    public Object endOrder(String id, String passWord, RedirectAttributes redirectAttributes) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(id)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else if (StringUtils.isBlank(passWord)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "passWord为空";
        } else {
            try {
                User user = UserUtils.getUser();
                if (StringUtils.isBlank(user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_SYSBUG;
                    message = "请先设置支付密码";
                } else if (!Tools.validatePassword(SystemService.decodeBase64Pwd(passWord), user.getUserinfo().getCashpassword())) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "支付密码错误";
                } else {
                    Map<String, Object> result = (Map<String, Object>) tradeBiz.saveOrderEnd(id, user);

                    if (result.get("state").equals(DataDic.RETURN_STATUS_NORMAL)) {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = result.get("message").toString();
                    }
                }

            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /***
     * 获取司机和车辆数据用于报价
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarAndDriverInfo", method = RequestMethod.GET)
    public Object toGoodsQuote() {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            Attach attach = new Attach();
            attach.setUser(UserUtils.getUser());
            attach.setIsagree(DataDic.ATTACH_AGGREE);
            List<Attach> list = driverBiz.findList(attach);// 司机列表
            map.put("driver", list);
            List<Car> cars = new ArrayList<>();
            for (Car car : carBiz.getMyCar()) {
                if (car.getStatus().equals(DataDic.AUTHENSUCCES))
                    cars.add(car);
            }
            map.put("car", cars);// 获取用户车辆
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 获取评价信息
     *
     * @param id
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getOrdercomment", method = RequestMethod.GET)
    public Object getOrdercomment(String id, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            Orderinfo order = tradeBiz.get(id);
            User user = UserUtils.getUser();
            TradeComment tradeComment = new TradeComment();
            tradeComment.setOrderno(order.getOrderno());
            List<TradeComment> comment = tradeCommentService.findList(tradeComment);
            if (user.getId().equals(order.getSeller().getId())) {
                if (comment.size() != 0) {
                    tradeComment = comment.get(0);
                    order.setFlag(false);
                } else {
                    order.setFlag(true);
                }
            } else {
                if (comment.size() != 0) {
                    tradeComment = comment.get(0);
                }
                order.setFlag(false);
            }
            result.put("tradeComment", tradeComment);
            order.getQuoteinfo().setGoods(goodsBiz.get(order.getQuoteinfo().getGoods().getId()));
            result.put("order", order);
            result.put("user", user);
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("data", result);
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 提交评价
     *
     * @param tradeComment
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "ordercomment", method = RequestMethod.POST)
    public Object ordercomment(TradeComment tradeComment, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (tradeComment == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "评价信息为空";
        } else if (StringUtils.isBlank(tradeComment.getOrderno())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "orderno为空";
        } else if (StringUtils.isBlank(tradeComment.getSelleriscomment())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "selleriscomment为空";
        } else if (StringUtils.isBlank(tradeComment.getSellercomment())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "sellercomment为空";
        } else if (StringUtils.isBlank(tradeComment.getSellercommentlv())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "sellercommentlv为空";
        } else if (StringUtils.isBlank(tradeComment.getServiceattitudepoint())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "serviceattitudepoint为空";
        } else if (StringUtils.isBlank(tradeComment.getTransportationcostpoint())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "transportationcostpoint为空";
        } else if (StringUtils.isBlank(tradeComment.getTransportlimitationpoint())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "transportlimitationpoint为空";
        } else if (StringUtils.isBlank(tradeComment.getGoodssafetypoint())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "goodssafetypoint为空";
        } else if (StringUtils.isBlank(tradeComment.getComprehensivepoint())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "comprehensivepoint为空";
        } else {
            try {
                Map<String, Object> result = (Map<String, Object>) tradeBiz.ordercommentBiz(tradeComment);
                state = (int) result.get("state");
                message = (String) result.get("message");

            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }


    /***
     * 获取运单列表
     *
     * @param orderinfo
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarAndTradeList")
    public Object getCarAndTradeList(Orderinfo orderinfo, int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            Page<Orderinfo> page = tradeBiz.getCarAndTradeList(pg, orderinfo, UserUtils.getUser());

            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 获取运单信息
     *
     * @param orderNo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getTradeInfo")
    public Object getTradeInfo(String orderNo) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(orderNo)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "orderNo为空";
        } else {
            try {
                Orderinfo oinfo = new Orderinfo();
                oinfo = tradeBiz.getOrderInfoByOrderNo(orderNo);
                if (oinfo != null) {
                    oinfo.setStatusStr(DictUtils.getDictLabel(oinfo.getOrderstatus(), "order_status", null));
                    map.put("data", oinfo);
                } else {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "运单不存在";
                }
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }


    /**
     * 车辆定位信息
     *
     * @param carnumber
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarTrackInfo")
    public Object getCarTrackInfo(String carnumber, String orderNo) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        List<Map<String, Object>> mapListJson = new ArrayList<>();
        List<GpsCarInfo> gpsCars = new ArrayList<>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(carnumber)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "carnumber为空";
        } else {
            try {
                mapListJson = (List<Map<String, Object>>) gpsInfoBiz.getNewTrackInof(carnumber);
                if (mapListJson == null || mapListJson.size() <= 0) {
                    List<String> gpslist = new ArrayList<>();
                    GpsCarInfo gpsinfo = new GpsCarInfo();
                    gpslist.add(carnumber);
                    gpsCars = carInfoService.findByGroup(gpslist.toArray(new String[gpslist.size()]));
                    if (gpsCars.size() <= 0) {
                        result.put("gpscarinfo", "无定位信息");
                    } else {
                        result.put("gpscarinfo", gpsCars);
                    }
                } else {
                    for (Map<String, Object> data : mapListJson) {
                        GpsCarInfo gps = new GpsCarInfo();
                        GpsCarLocs locs = new GpsCarLocs();
                        gps.setCname(data.get("LICENSE_PLATE").toString());
                        locs.setName(data.get("LICENSE_PLATE").toString());
                        locs.setLng(data.get("REAL_X").toString());
                        locs.setLat(data.get("REAL_Y").toString());
                        locs.setFormatgpstime(data.get("LOCATION_TIME").toString());
                        locs.setState(data.get("STATE_DESC").toString());
                        locs.setSpeed(data.get("SPEED").toString());
                        gps.setCarLocs(locs);
                        gpsCars.add(gps);
                    }
                    result.put("gpscarinfo", gpsCars);
                }
                if (StringUtils.isNotBlank(orderNo)) {
                    Orderinfo oinfo = new Orderinfo();
                    oinfo = tradeBiz.getOrderInfoByOrderNo(orderNo);
                    if (oinfo != null) {
                        oinfo.setStatusStr(DictUtils.getDictLabel(oinfo.getOrderstatus(), "order_status", null));
                        result.put("orderinfo", oinfo);
                    } else {
                        result.put("orderinfo", "无该运单信息");
                    }
                }

            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("data", result);
        map.put("state", state);
        map.put("message", message);
        return map;
    }


    /**
     * 获取gps历史轨迹数据
     *
     * @param carnumber
     * @param beginTime
     * @param endTime
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarGpsInfo")
    public Object getlCarGpsInfo(String carnumber, String beginTime, String endTime) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<GpsCarInfo> gpsCars = new ArrayList<>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(carnumber)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "carnumber为空";
        } else if (StringUtils.isBlank(beginTime)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "beginTime为空";
        } else if (StringUtils.isBlank(endTime)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "endTime为空";
        } else {
            try {
                List<Map<String, Object>> mapListJson = (List<Map<String, Object>>) gpsInfoBiz.getTrackList(carnumber, beginTime, endTime);
                map.put("data", mapListJson);
            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }

        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /***
     * 获取车辆的所有定位信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getTradeTrackList")
    public Object getTradeTrackList() {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        List<GpsCarInfo> gpsCars = new ArrayList<>();
        Page pg = new Page();
        pg.setPageNo(0);
        pg.setPageSize(Integer.MAX_VALUE);
        try {
            Page<Orderinfo> page = tradeBiz.getCarAndTradeList(pg, new Orderinfo(), UserUtils.getUser());
            List<String> gpslist = new ArrayList<>();
            for (Orderinfo order : page.getList()) {
                if (order.getQuoteinfo().getCar() != null) {
                    gpslist.add(order.getQuoteinfo().getCar().getCarnumber());
                }
            }
            if (gpslist.size() > 0) {
                gpsCars = carInfoService.findByGroup(gpslist.toArray(new String[gpslist.size()]));
                if (gpsCars.size() <= 0) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "无定位信息";
                }
            } else {
                state = DataDic.RETURN_STATUS_AUTHBUG;
                message = "无车辆信息";
            }
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("data", gpsCars);
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /***
     * 获取运力列表
     *
     * @param statisticsBusinessVO
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getOrderInfoList")
    public Object getOrderInfoList(StatisticsBusinessVO statisticsBusinessVO, int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Page pg = new Page();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {
            Page<StatisticsBusinessVO> page = orderinfoService.findOrderInfoList(pg, statisticsBusinessVO);

            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }


    /***
     * 获取运力已回单列表
     *
     * @param statisticsBusinessVO
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getReceiptOrderInfoList")
    public Object getReceiptOrderInfoList(StatisticsBusinessVO statisticsBusinessVO, int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Page pg = new Page();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {
            Page<StatisticsBusinessVO> page = orderinfoService.findReceiptOrderInfoList(pg, statisticsBusinessVO);

            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }
}
