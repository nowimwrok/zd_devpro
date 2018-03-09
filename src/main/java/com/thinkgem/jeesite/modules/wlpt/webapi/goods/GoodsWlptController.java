package com.thinkgem.jeesite.modules.wlpt.webapi.goods;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.gps.GpsInfoBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarInfo;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.car.AttachService;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightrateLineService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.QuoteinfoService;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by ForHeart on 16/8/10.
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/goods")
public class GoodsWlptController extends BaseController {


    @Autowired
    private GoodsBiz goodsBiz;
    @Autowired
    private AttachService attachService;
    @Autowired
    private QuoteinfoService quoteinfoService;
    @Autowired
    private CarService carService;
    @Autowired
    private UserBiz userBiz;
    @Autowired
    private BidBlinfoService bidBlinfoService;
    @Autowired
    private BidinfoService bidinfoService;
    @Autowired
    private FreightrateLineService freightrateLineService;
    @Autowired
    private GpsCarInfoService carInfoService;
    @Autowired
    private GpsInfoBiz gpsInfoBiz;

    @RequiresPermissions("user")
    @RequestMapping(value = {"goods_list", ""})
    public String goods_list(HttpServletRequest request, HttpServletResponse response, Model model, String isRedrect) {
        /*UserUtils.clearCache( UserUtils.getUser());*/
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        model.addAttribute("user", userBiz.getUser());
        model.addAttribute("isRedrect", isRedrect);
        if (isRedrect == null || isRedrect == "") {
            Cookie[] cookies = request.getCookies();
            for (Cookie c : cookies) {
                if (c.getName().equals("goods_tradestatus") || c.getName().equals("goods_fromprovince")
                        || c.getName().equals("goods_fromcity") || c.getName().equals("goods_fromdistrict")
                        || c.getName().equals("goods_toprovince") || c.getName().equals("goods_tocity") || c.getName().equals("goods_todistrict")) {
                    c.setValue(null);
                    response.addCookie(c);
                }
            }
        }
        return "modules/user_front/goods/goods_list";
        //return "modules/wlpt_front/goods/goods_list";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = {"toPublishGoods", ""})
    public String toPublishGoods(HttpServletRequest request, HttpServletResponse response, Model model) {
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        //return "modules/wlpt_front/goods/goods_add";
        return "modules/user_front/goods/goods_add";
    }

    /***
     * 获取货源列表
     *
     * @param goods 货源实体
     * @param pageNo 当前页码
     * @param pageSize 页面大小
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getGoodsList")
    public Object getGoodsList(Goods goods, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            return null;
        }
        goods.setUser(curUser);
        // goods.setDatasource("0");
        Page<Goods> page = goodsBiz.findPage(pg, goods);
        for (Goods gds : page.getList()) {
            gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }


    /***
     * 到货源编辑页面
     *
     * @param goods 货源实体
     * @param model
     * @return
     */
    @RequestMapping(value = "toSave")
    public String toSave(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        ObjectMapper mapper = new ObjectMapper();
        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
        mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
        Goods gs = goods;
        gs.setBlinfoList(goods.getBlinfoList());
        String orderId = request.getParameter("orderId");  //合同ID
        String blinfoStr = request.getParameter("blinfoList");
        if (goods.getId() != null) {//编辑货源还是发布货源
            gs = goodsBiz.get(goods.getId());//获取需要编辑的货源
            if (Objects.equals(gs.getDatasource(), DataDic.GDS_DATASORCE_BIDGDS) && orderId != null && StringUtils.isNotEmpty(orderId)) {  //如果是招标货源
                gs.setId(null);
                //if (blinfoStr != null && StringUtils.isNotEmpty(blinfoStr)) {
                if (!Tools.IsNullOrWhiteSpace(blinfoStr) && blinfoStr != null && !"[]".equals(blinfoStr)) {
                    List<BidBlinfo> blinfoList = Arrays.asList(mapper.readValue(blinfoStr, BidBlinfo[].class));
                    model.addAttribute("blinfoList", blinfoList);
                    gs.setDatasource(DataDic.GDS_DATASORCE_BIDORDERBL);
                    gs.setGsoddtype(DataDic.GDS_ODDTYPE_CP);//发布货源时只要上传货物明细，判定该货源为成品货源
                } else {
                    gs.setDatasource(DataDic.GDS_DATASORCE_BIDORDER);
                }
                String freightvolume = request.getParameter("freightvolume");
                gs.setFreightvolume(freightvolume);
            }
            //  model.addAttribute("sendtime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(gs.getSendtime()));
//        } else if (blinfoStr != null && StringUtils.isNotEmpty(blinfoStr)) {
        } else if (!Tools.IsNullOrWhiteSpace(blinfoStr) && blinfoStr != null && !"[]".equals(blinfoStr)) {
            List<BidBlinfo> blinfoList = Arrays.asList(mapper.readValue(blinfoStr, BidBlinfo[].class));
            model.addAttribute("blinfoList", blinfoList);
            gs.setDatasource(DataDic.GDS_DATASORCE_BLNOMAL);   //明细发布
            gs.setGsoddtype(DataDic.GDS_ODDTYPE_CP);//发布货源时只要上传货物明细，判定该货源为成品货源
        }
        model.addAttribute("orderId", orderId);
        model.addAttribute("user", UserUtils.getUser());
        model.addAttribute("goods", gs);
//        model.addAttribute("shipAddress", UserUtils.getUserSendAddress());
//        model.addAttribute("consignAddress", UserUtils.getUserRevAddress());
        //return "modules/wlpt_front/goods/goods_add";
        return "modules/user_front/goods/goods_add";
    }

    /***
     * 发布货源
     *
     * @param goods 货源实体
     * @param model
     * @return
     */
    @RequestMapping(value = "saveGoods")
    public String save(Goods goods, String orderId, Model model) {
        if (DataDic.GDS_DATASORCE_BIDORDERBL.equals(goods.getDatasource())) {
            goodsBiz.bidBLPubGodosBiz(UserUtils.getUser(), goods.getBlinfoList(), goods);
        } else if (DataDic.GDS_DATASORCE_BIDORDER.equals(goods.getDatasource())) {
            goodsBiz.bidPubGodosBiz(UserUtils.getUser(), orderId, goods);
        } else if (DataDic.GDS_DATASORCE_BLNOMAL.equals(goods.getDatasource())) {
            goodsBiz.saveBlGoodsBiz(goods, UserUtils.getUser());
        } else {
            goodsBiz.saveGoodsBiz(goods, UserUtils.getUser());
        }

        model.addAttribute("user", userBiz.getUser());
        //return "modules/wlpt_front/goods/goods_list";
        return "modules/user_front/goods/goods_list";
    }

    /***
     * Ajax发布货源
     *
     * @param goods 货源实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "save")
    public Object saveGoods(Goods goods, String orderId, Model model) {
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        Object result = null;
        if (DataDic.GDS_DATASORCE_BIDORDERBL.equals(goods.getDatasource())) {
            result = goodsBiz.bidBLPubGodosBiz(UserUtils.getUser(), goods.getBlinfoList(), goods);
        } else if (DataDic.GDS_DATASORCE_BIDORDER.equals(goods.getDatasource())) {
            result = goodsBiz.bidPubGodosBiz(UserUtils.getUser(), orderId, goods);
        } else if (DataDic.GDS_DATASORCE_BLNOMAL.equals(goods.getDatasource())) {
            result = goodsBiz.saveBlGoodsBiz(goods, UserUtils.getUser());
        } else {
            result = goodsBiz.saveGoodsBiz(goods, UserUtils.getUser());
        }
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("user", userBiz.getUser());
        return new JSONPObject("callback", result);
    }


    /***
     * 查看货源
     *
     * @param id 货源id
     * @param model
     * @return
     */
    @RequestMapping(value = "goodsInfo")
    public String goodsInfo(@RequestParam(required = false) String id, Model model) {
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        Goods gs = goodsBiz.get(id);
        BidBlinfo blinfo = new BidBlinfo();
        blinfo.setGoods(gs);
        List<BidBlinfo> blinfos = bidBlinfoService.findList(blinfo);
        model.addAttribute("blinfoList", blinfos);
        model.addAttribute("sendtime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(gs.getSendtime()));
        model.addAttribute("goods", gs);
        return "modules/wlpt_front/goods/goodsInfo";
    }

    /**
     * 货源详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDetail")
    public Object getDetail(String id) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        Map<String, Object> map = new HashMap<String, Object>();

        if (id != null && !StringUtils.isEmpty(id)) {
            Goods gs = goodsBiz.get(id);
            BidBlinfo blinfo = new BidBlinfo();
            blinfo.setGoods(gs);
            List<BidBlinfo> blinfos = bidBlinfoService.findList(blinfo);
            gs.setGsoddtype(DictUtils.getDictLabel(gs.getGsoddtype(), "gsoddtype", ""));
            gs.setGoodstype(DictUtils.getDictLabel(gs.getGoodstype(), "goodstype", ""));
            gs.setTradestatus(DictUtils.getDictLabel(gs.getTradestatus(), "gds_tradeStatus", ""));
            gs.setTransportway(DictUtils.getDictLabel(gs.getTransportway(), "transportway", ""));
            map.put("sendtime", (new SimpleDateFormat("yyyy-MM-dd HH:mm").format(gs.getSendtime())));
            map.put("goods", gs);
            map.put("blinfoList", blinfos);
        } else {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "未查询到数据";
        }
        return this.getMapResult(state, message, map);
    }

    /***
     * 删除货源
     *
     * @param id 货源ID
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteGoods")
    public Object deleteGoods(@RequestParam(required = false) String id, Model model) {
        Goods gs = goodsBiz.get(id);
        if (!DataDic.GDS_DATASORCE_NORMAL.equals(gs.getDatasource())) {
            ///修改货源的联动效果
            goodsBiz.cancelGoods(gs);
        }
        //删除货源
        goodsBiz.delete(gs);

        return new JSONPObject("callback", "删除成功");
    }

    /***
     * 获取司机报价
     *
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getQuoteInfo")
    public Object getQuoteInfo(Goods goods, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(3);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        Quoteinfo quote = new Quoteinfo();
        quote.setGoods(goods);
        Page<Quoteinfo> page = goodsBiz.getQuoteList(pg, quote);
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /***
     * 货主查看货源报价
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "toQuoteInfo")
    public String toQuoteInfo(@RequestParam(required = false) String id, Model model) {
//    	User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        Goods gs = goodsBiz.get(id);
        BidBlinfo blinfo = new BidBlinfo();
        blinfo.setGoods(gs);
        List<BidBlinfo> blinfos = bidBlinfoService.findList(blinfo);
        model.addAttribute("blinfoList", blinfos);
        model.addAttribute("sendtime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(gs.getSendtime()));
        model.addAttribute("goods", gs);
        return "modules/user_front/goods/quoteInfo";
        //return "modules/wlpt_front/goods/quoteInfo";
    }

    /**
     * 货源详情页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "goodsHallInfo")
    public String goodsHallInfo(@RequestParam(required = false) String id, Model model) {
        Goods goods = goodsBiz.get(id);
        goodsBiz.updatePageViews(goods);
        model.addAttribute("sendtime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(goods.getSendtime()));
        model.addAttribute("goods", goods);
        return "modules/wlpt_front/hall/goodsInfo";
    }

    /***
     * 车主去报价页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "goodsQuote")
    public String goodsQuote(@RequestParam(required = false) String id, Model model) {
        User user = UserUtils.getUser();
        if (user.getId() == null) {
            return "modules/wlpt_front/admin/login";
        }
        Goods goods = goodsBiz.get(id);
        //获取报价信息
        FreightrateLine line = new FreightrateLine();
        line.setStartaddress(goods.getShipAddress().getCity());
        line.setEndaddress(goods.getConsignAddress().getCity());
        line = freightrateLineService.getLineInfo(line);
        model.addAttribute("line", line);
        Quoteinfo quoteinfo = new Quoteinfo();
        if (UserUtils.getUser() != null && UserUtils.getUser().getId() != null) {
            Attach attach = new Attach();
            attach.setUser(UserUtils.getUser());
            attach.setIsagree(DataDic.ATTACH_AGGREE);
            List<Attach> attachs = attachService.findList(attach);
            ///司机
            model.addAttribute("driver", attachs);
            //获取用户车辆
            List<Car> cars = new ArrayList<>();
            for (Car car : carService.getMyCar()) {
                if (car.getStatus().equals(DataDic.AUTHENSUCCES)) {
                    cars.add(car);
                }
            }
            model.addAttribute("car", cars);
        }
        goodsBiz.updatePageViews(goods);
        model.addAttribute("quoteinfo", quoteinfo);
        model.addAttribute("goods", goods);
        if (goods.getSendtime() != null && !goods.getSendtime().equals("")) {
            model.addAttribute("sendtime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(goods.getSendtime()));
        }
        //return "modules/wlpt_front/hall/quote";
        return "modules/wlpt_front/hall/goods_quote";
    }

    /***
     * 保存报价
     *
     * @param quoteinfo 报价实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveQuote")
    public Object saveQuote(Quoteinfo quoteinfo, Model model) {
        String result = goodsBiz.saveDriverQuote(quoteinfo);
        return new JSONPObject("callback", result);
    }

    /**
     * 验证当前用户是否已报价
     *
     * @param goodsid 货源ID
     * @return status:-1货源信息有误,0:用户请先登录1:正常可以报价2:内部信息3:已报价4:已运输完
     */
    @ResponseBody
    @RequestMapping(value = "validQuote")
    public Integer validQuote(String goodsid) {

        return goodsBiz.validQuote(goodsid);
    }

    /***
     * 货主去报价生成运单信息
     *
     * @param quoteinfo 报价实体
     * @param model
     * @return
     */
    /*@RequestMapping(value = "quoteOrder")
    public String quoteOrder(Quoteinfo quoteinfo, Model model) {
    	User user = UserUtils.findUser(UserUtils.getUser());
    	if(user.getUserPurse()==null){
    		user.setUserPurse(new UserPurse());
    	}
        quoteinfo = quoteinfoService.get(quoteinfo.getId());
        if (quoteinfo != null) {
            Goods goods = goodsBiz.get(quoteinfo.getGoods().getId());
            //获取报价信息
            quoteinfo.setGoods(goods);
            Orderinfo orderinfo = new Orderinfo();
            orderinfo.setQuoteinfo(quoteinfo);
            
            model.addAttribute("quoteinfo", quoteinfo);
            model.addAttribute("orderinfo", orderinfo);
            
        }
        model.addAttribute("quoteinfo", quoteinfo);
        model.addAttribute("user", user);
        return "modules/wlpt_front/goods/orderPayinfo";
    }*/

    /***
     * 货主去报价生成运单信息
     *
     * @param quoteinfo 报价实体
     * @param model
     * @return
     */
    @RequestMapping(value = "quoteOrder")
    public String quoteOrder(Quoteinfo quoteinfo, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getUserPurse() == null) {
            user.setUserPurse(new UserPurse());
        }
        quoteinfo = quoteinfoService.get(quoteinfo.getId());
        if (quoteinfo != null) {
            Goods goods = goodsBiz.get(quoteinfo.getGoods().getId());
            Bidinfo bidinfo = new Bidinfo();
            bidinfo.setGoods(goods);
            bidinfo = bidinfoService.get(bidinfo);
            //获取报价信息
            quoteinfo.setGoods(goods);
            Orderinfo orderinfo = new Orderinfo();
            orderinfo.setQuoteinfo(quoteinfo);

            model.addAttribute("quoteinfo", quoteinfo);
            model.addAttribute("orderinfo", orderinfo);
            model.addAttribute("bidinfo", bidinfo);

        }
        model.addAttribute("quoteinfo", quoteinfo);
        model.addAttribute("user", user);
        return "modules/user_front/goods/order_payinfo";
    }


    /***
     * 是否同意报价
     *
     * @param quoteinfo 报价实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "isAgree")
    public Object isAgree(Quoteinfo quoteinfo, Model model) {
        String result = "success";
        quoteinfo = quoteinfoService.get(quoteinfo.getId());
        quoteinfo.setQuotestatus(DataDic.QUOTE_QUOTFILED);
        goodsBiz.saveQuote(quoteinfo);
        return new JSONPObject("callback", result);
    }

    /**
     * 结束货源报价
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "finishQuote")
    public Object finishQuote(Goods goods, Model module) {
        String result = "success";
        Goods gs = goodsBiz.get(goods.getId());
        if (gs.getTradestatus().equals("2")) {
            gs.setTradestatus("2");
            goodsBiz.save(gs);
        }
        return new JSONPObject("callback", result);
    }

    /***
     * 更新点击数
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updatePraiseNumber")
    public Object updatePraiseNumber(Goods goods, Model module) {
        String result = "success";
        goodsBiz.updatePraiseNumber(goods);
        return new JSONPObject("callback", result);
    }
    //====================================================报价========================================

    /***
     * 我的报价
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "quoteInfo_list")
    public String quoteInfo_list(Quoteinfo quoteinfo, Model model) {
//		User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        model.addAttribute("quoteinfo", quoteinfo);
        return "modules/user_front/goods/quoteinfo_list";
        //return "modules/wlpt_front/goods/quoteinfo_list";
    }

    /**
     * 获取我的报价列表
     *
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getQuoteInfoList")
    public Object getQuoteInfoList(Quoteinfo quoteinfo, Page pg, Model model) {
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            return null;
        }
        quoteinfo.setUser(curUser);// 获取当前登录用户
        pg.setLength(4);
        Page<Quoteinfo> page = goodsBiz.getQuoteList(pg, quoteinfo);
        for (Quoteinfo var : page.getList()) {
            var.setStatusStr((DictUtils.getDictLabel(var.getQuotestatus(), "quotestatus", "")));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /***
     * 我的报价详情
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "quoteInfo_detail")
    public String quoteInfo_detail(@RequestParam(required = false) String id, Model model) {
//		User user = UserUtils.getUser();
//        if (user.getId() == null) {
//        	return "modules/wlpt_front/admin/login";
//        }
        Quoteinfo quoteinfo = new Quoteinfo();
        quoteinfo.setId(id);
        quoteinfo = goodsBiz.getQuote(quoteinfo);
        Goods goods = goodsBiz.get(quoteinfo.getGoods().getId());
        model.addAttribute("goods", goods);
        model.addAttribute("quoteinfo", quoteinfo);
        return "modules/wlpt_front/goods/quoteinfo_detail";
    }


    /**
     * 货源详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getQuoteDetail")
    public Object getQuoteDetail(String id) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        Map<String, Object> map = new HashMap<String, Object>();

        if (id != null && !StringUtils.isEmpty(id)) {
            Quoteinfo quoteinfo = new Quoteinfo();
            quoteinfo.setId(id);
            quoteinfo = goodsBiz.getQuote(quoteinfo);
            quoteinfo.setStatusStr(DictUtils.getDictLabel(quoteinfo.getQuotestatus(), "quotestatus", ""));
            Goods goods = goodsBiz.get(quoteinfo.getGoods().getId());

            map.put("sendtime", (new SimpleDateFormat("yyyy-MM-dd HH:mm").format(goods.getSendtime())));
            map.put("goods", goods);
            map.put("quoteinfo", quoteinfo);
        } else {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "未查询到数据";
        }
        return this.getMapResult(state, message, map);
    }


    /***
     * 货主指派报价页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "toAddQuote")
    public String toAddQuote(@RequestParam(required = false) String id, Model model) {
        User user = UserUtils.getUser();

        Goods goods = goodsBiz.get(id);
        Quoteinfo quoteinfo = new Quoteinfo();
        goodsBiz.updatePageViews(goods);
        BidBlinfo blinfo = new BidBlinfo();
        blinfo.setGoods(goods);
        List<BidBlinfo> blinfos = bidBlinfoService.findList(blinfo);
        model.addAttribute("blinfoList", blinfos);
        model.addAttribute("quoteinfo", quoteinfo);
        model.addAttribute("goods", goods);
        model.addAttribute("user", user);
        if (goods.getSendtime() != null && !goods.getSendtime().equals("")) {
            model.addAttribute("sendtime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(goods.getSendtime()));
        }
        //return "modules/wlpt_front/goods/addquote";
        return "modules/user_front/goods/addquote";
    }

    /***
     * 货主保存报价
     *
     * @param quoteinfo 报价实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveAddQuote")
    public Object saveAddQuote(Quoteinfo quoteinfo, String userid, Model model) {
        Object result = goodsBiz.addquoteBiz(quoteinfo, userid);
        return new JSONPObject("callback", result);
    }

    /**
     * 获取车辆和司机信息
     *
     * @param id
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarAndDriverInfo")
    public Object getCarAndDriverInfo(String id, Model model) {
        if (!Tools.IsNullOrWhiteSpace(id)) {
            User user = new User();
            user.setId(id);
            Attach attach = new Attach();
            attach.setUser(user);
            attach.setIsagree(DataDic.ATTACH_AGGREE);//获取已经申请通过的手机
            List<Attach> attachs = attachService.findList(attach);
            ///司机
            model.addAttribute("driver", attachs);
            //获取用户车辆
            Car car = new Car();
            car.setUser(user);
            car.setStatus(DataDic.AUTHENSUCCES);//获取已经认证通过的司机
            List<Car> cars = carService.findList(car);

            model.addAttribute("car", cars);
        }
        return new JSONPObject("callback", model);
    }

    /***
     * 查询用户信息 searchinfo
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "searchInfo")
    public Object searchInfo(User user, Model model) {
        User newuser = UserUtils.findUser(user);
        User curuser = UserUtils.getUser();
        Map map = new HashMap();
        if (newuser != null) {
            if (newuser.getId().equals(curuser.getId())) {
                return new JSONPObject("callback", "不能指派给自己");
            }
            Userinfo info = newuser.getUserinfo();
            Role role = newuser.getRole();
            if (role != null && (role.getEnname().equals(DataDic.ROLE_ENTERPRISE) || role.getEnname().equals(DataDic.ROLE_CAROWNER))) {
                User u = new User();
                u.setId(newuser.getId());
                Attach attach = new Attach();
                attach.setUser(u);
                attach.setIsagree(DataDic.ATTACH_AGGREE);//获取已经申请通过的手机
                List<Attach> attachs = attachService.findList(attach);
                if (attachs.size() < 1) {
                    return new JSONPObject("callback", "该用户无司机信息");
                }
                //获取用户车辆
                Car car = new Car();
                car.setUser(u);
                car.setStatus(DataDic.AUTHENSUCCES);//获取已经认证通过的司机
                List<Car> cars = carService.findList(car);
                if (cars.size() < 1) {
                    return new JSONPObject("callback", "该用户无车辆信息");
                }
            }

            map.put("role", role);
            map.put("info", info);
            map.put("user", newuser);
            return new JSONPObject("callback", map);
        } else {
            return new JSONPObject("callback", "未查到指定用户");
        }

    }


    /***
     * 去抢单轨迹页面
     *
     * @param carNumber
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"quoteinfo_track", ""})
    public String quoteinfo_track(String id, String carNumber, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (Tools.IsNullOrWhiteSpace(carNumber)) {
            return "redirect:" + Global.getFrontPath() + "/wlpt/goods/goods_list";
        }
        model.addAttribute("id", id);
        model.addAttribute("carNumber", carNumber);
        return "modules/user_front/goods/quoteinfo_gpstrack";
    }

    /**
     * 获取货物信息
     *
     * @param goods
     * @param carNumber
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "carAndQuoteInfo")
    public Object getCarAndTradeInfo(Goods goods, String carNumber, Model model) {
        List<Map<String, Object>> mapListJson = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        List<GpsCarInfo> gpsCars = new ArrayList<>();
        Goods goodsInfo = new Goods();
        ///判断用户是否登录获取数据
        if (UserUtils.getUser() == null) {
            return new JSONPObject("callback", null);
        }

        if (!Tools.IsNullOrWhiteSpace(carNumber)) {
            mapListJson = (List<Map<String, Object>>) gpsInfoBiz.getNewTrackInof(carNumber);
            if (mapListJson == null || mapListJson.size() <= 0) {
                List<String> gpslist = new ArrayList<>();
                GpsCarInfo gpsinfo = new GpsCarInfo();
                gpslist.add(carNumber);
                gpsCars = carInfoService.findByGroup(gpslist.toArray(new String[gpslist.size()]));

            }
        }
        if (goods != null && !Tools.IsNullOrWhiteSpace(goods.getId())) {
            goodsInfo = goodsBiz.get(goods.getId());

        }
        list.add(mapListJson);
        list.add(goodsInfo);
        list.add(gpsCars);
        return new JSONPObject("callback", list);
    }


}
