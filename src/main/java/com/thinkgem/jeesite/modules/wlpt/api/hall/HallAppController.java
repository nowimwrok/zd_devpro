package com.thinkgem.jeesite.modules.wlpt.api.hall;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.driverBiz.DriverBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;

@Controller
@RequestMapping(value = "${appPath}/api/hall")
public class HallAppController extends BaseController {

    @Autowired
    private GoodsBiz goodsBiz;

    @Autowired
    private CarBiz carBiz;

    @Autowired
    private DriverBiz driverBiz;
    private static final String REX = "^[0-9]+(.[0-9]{0,2})?$";
    private static final String REX1 = "^[0-9]+(.[0-9]{0,3})?$";

    /**
     * 货源大厅
     *
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "goodsList", method = RequestMethod.GET)
    public Object goodsList(Goods goods, int pageNo, int pageSize, HttpServletRequest request,
                            HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        Page<Goods> pg = new Page<Goods>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {
            Page<Goods> page = goodsBiz.findPage(pg, goods);
            for (Goods gds : page.getList()) {
                gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
                gds.getUser().setPointlevle(gds.getUser().getUserinfo().getPointlevle());
            }

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
     * 车主报价
     *
     * @param quoteinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveQuote", method = RequestMethod.POST)
    public Object saveQuote(Quoteinfo quoteinfo, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "报价成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (quoteinfo == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "报价参数为空";
        } else if (quoteinfo.getGoods() == null || StringUtils.isBlank(quoteinfo.getGoods().getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "goods.id为空";
        } else if (quoteinfo.getDriver() == null || StringUtils.isBlank(quoteinfo.getDriver().getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "driver.id为空";
        } else if (quoteinfo.getCar() == null || StringUtils.isBlank(quoteinfo.getCar().getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "car.id为空";
        } else if (StringUtils.isBlank(quoteinfo.getOoferprice())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "ooferprice为空";
        } else if (!quoteinfo.getOoferprice().matches(REX)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "ooferprice格式错误";
        } else if (StringUtils.isBlank(quoteinfo.getOddloadweight())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "oddloadweight为空";
        } else if (!quoteinfo.getOddloadweight().matches(REX1)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "oddloadweight格式错误";
        } else {
            try {
                message = goodsBiz.saveDriverQuote(quoteinfo);
                if (!"报价成功".equals(message)) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
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
     * 获取货源详情 --抢单
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "toGoodsQuote", method = RequestMethod.GET)
    public Object toGoodsQuote(String id) {
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
        } else {
            try {
                Goods gs = goodsBiz.get(id);// 货源详情
                Attach attach = new Attach();
                attach.setUser(UserUtils.getUser());
                attach.setIsagree(DataDic.ATTACH_AGGREE);
                List<Attach> list = driverBiz.findList(attach);// 司机列表
                goodsBiz.updatePageViews(gs);/// 更新浏览次数
                map.put("driver", list);
                List<Car> cars = new ArrayList<>();
                for (Car car : carBiz.getMyCar()) {
                    if (car.getStatus().equals(DataDic.AUTHENSUCCES))
                        cars.add(car);
                }
                map.put("car", cars);// 获取用户车辆
                map.put("goods", gs);
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
     * 货源详情
     *
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "goodsInfo", method = RequestMethod.GET)
    public Object goodsInfo(String id, HttpServletRequest request, HttpServletResponse response) {
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
        } else {
            try {
                Goods gs = goodsBiz.get(id);// 货源详情
                if (gs == null) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "id错误，货源不存在";
                } else {
                    goodsBiz.updatePageViews(gs);/// 更新浏览次数
                    map.put("data", gs);
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
     * 验证当前用户是否已报价
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "validQuote", method = RequestMethod.GET)
    public Object validQuote(String id) {
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
        } else {
            try {
                Goods goods = goodsBiz.get(id);
                if (goods == null) {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "id错误，货源不存在";
                } else if (UserUtils.getUser() == null) {
                    state = 3;
                    message = "请先登录";
                } else if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())) {
                    state = 4;
                    message = "该货源结束报价";
                } else if (goods.getSendtime().before(new Date())) {
                    state = 5;
                    message = "该货源已过期";
                } else if (goods.getUser().getId().equals(UserUtils.getUser().getId())) {
                    state = 6;
                    message = "内部货源";
                } else {
                    Quoteinfo quoteinfo = new Quoteinfo();
                    quoteinfo.setGoods(goods);
                    quoteinfo.setUser(UserUtils.getUser());
                    quoteinfo.setQuotestatus(DataDic.QUOTE_QUOTING);
                    List<Quoteinfo> result = goodsBiz.findQuoteList(quoteinfo);
                    if (result != null && result.size() > 0) {/// 报价状态为0;如果报价中的状态,则不能报价
                        state = 7;
                        message = "已报价";
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
}
