package com.thinkgem.jeesite.modules.wlpt.webapi.bid;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BidOrderBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BiddingBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.QuoteBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.QuoteinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.AddressService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserStatisticsService;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 招标
 * Created by xin_ on 2016/8/16. 
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/bid")
public class bidController extends BaseController {

    @Autowired
    private BidinfoService bidinfoService;

    @Autowired
    private BiddingBiz biddingBiz;

    @Autowired
    private BiddinginfoService biddinginfoService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private BidBlinfoService blinfoService;

    @Autowired
    private BidOrderBiz bidOrderBiz;

    @Autowired
    private BidOrderinfoService bidOrderinfoService;

    @Autowired
    private ConsumeRecodBiz consumeRecodBiz;

    @Autowired
    private UserStatisticsService userStatisticsService;

    @Autowired
    private QuoteinfoService quoteinfoService;
    
    @Autowired
    private UserBiz userBiz;
    
    @Autowired
    private BidBlinfoService bidBlinfoService;

    /**
     * 车辆监控
     * @param bidOrderinfo
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"bidtrack", ""})
    public String bidTrack(BidOrderinfo bidOrderinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (bidOrderinfo == null || Tools.IsNullOrWhiteSpace(bidOrderinfo.getId())) {
        	//return "modules/wlpt_front/bid/bargain_list";
            return "modules/user_front/bid/bargain_list";
        }
        bidOrderinfo = bidOrderinfoService.get(bidOrderinfo.getId());
        model.addAttribute("bidOrderinfo", bidOrderinfo);
        return "modules/user_front/bid/bid_gpstrack";
    }


    /***
     * 支付招标合同运费
     *
     * @param bidOrderinfo
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "payBidOrder")
    public Object payBidOrderMoney(BidOrderinfo bidOrderinfo, Model model, RedirectAttributes redirectAttributes) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "操作成功";
        if (bidOrderinfo == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "操作失败,信息缺失";
            return this.getMapResult(state, message, null);
        }
        String id = bidOrderinfo.getId();
        String ispayCoin = bidOrderinfo.getIspaycoin(); //是否支付卓币
        String isonliePay = bidOrderinfo.getIsOnlinePay();///是否线上支付
        Double coinAmount = Double.valueOf(bidOrderinfo.getCoinamount() != null ? bidOrderinfo.getCoinamount() : 0.00);
        ///平台支付金额
        Double webAmount = Double.valueOf(bidOrderinfo.getWebamount() != null ? bidOrderinfo.getWebamount() : 0.00);

        ///查询当前用户
        User curUser = UserUtils.getUser();
        if (Tools.IsNullOrWhiteSpace(id) || curUser == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "对不起,您无权限操作";
        } else if (DataDic.YES.equals(ispayCoin)) {
            if (coinAmount < 0) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "请输入卓币支付信息";
            }
        } else if (DataDic.YES.equals(isonliePay)) {
            if (webAmount < 0) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "请输入线上支付信息";
            }
        }

        if (state == DataDic.RETURN_STATUS_NORMAL) {
            ///修改合同交易状态
            return bidOrderBiz.payBidOrderMoneyBiz(id, curUser.getId(), ispayCoin, coinAmount, isonliePay, webAmount,bidOrderinfo.getIsAccount());
        }
        return this.getMapResult(state, message, null);
    }

    /***
     * 去支付页面
     *
     * @param bidOrderinfo
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"toPay", ""})
    public String toPay(BidOrderinfo bidOrderinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (bidOrderinfo == null || Tools.IsNullOrWhiteSpace(bidOrderinfo.getId())) {
        	//return "modules/wlpt_front/bid/bargain_list";
            return "modules/user_front/bid/bargain_list";
        }
        bidOrderinfo = bidOrderinfoService.get(bidOrderinfo.getId());
        model.addAttribute("bidOrderinfo", bidOrderinfo);
        model.addAttribute("curUser", UserUtils.findUser(UserUtils.getUser()));
        return "modules/user_front/bid/bidorder_pay";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "import", method = RequestMethod.POST)
    @ResponseBody
    public Object importFile(MultipartFile file,String type, RedirectAttributes redirectAttributes) {
        if (Global.isDemoMode()) {
            addMessage(redirectAttributes, "演示模式，不允许操作！");
            return "redirect:" + adminPath + "/sys/user/list?repage";
        }
        try {
            ImportExcel ei = new ImportExcel(file, 0, 0);
            List<BidBlinfo> blList = new ArrayList<>();
            for (int i = ei.getDataRowNum(); i < ei.getLastDataRowNum(); i++) {
                Row row = ei.getRow(i);
                BidBlinfo blinfo = new BidBlinfo();
                if (StringUtils.isNotEmpty(ei.getCellValue(row, 1).toString())){
                    blinfo.setWarehousename(ei.getCellValue(row, 0).toString());  //仓库名称
                    blinfo.setContractno(ei.getCellValue(row, 1).toString());  //提货单号
                    blinfo.setBatch(ei.getCellValue(row, 2).toString());  //批号
                    blinfo.setNamematerials(ei.getCellValue(row, 3).toString());  //品名
                    blinfo.setStandard(ei.getCellValue(row, 4).toString());  //规格
                    blinfo.setWidth(ei.getCellValue(row, 5).toString());  //定尺\板宽
                    blinfo.setQuantity(ei.getCellValue(row, 6).toString());  //数量
                    blinfo.setAddress(ei.getCellValue(row, 7).toString());  //卸货地址
                    blinfo.setRemarks(ei.getCellValue(row, 8).toString());  //备注
                    blinfo.setYmdDate(DateUtils.getDate());//创建时间
                    blList.add(blinfo);
                }
            }
            if("1".equals(type)){
                return new JSONPObject("callback", blList);
            }
            BidBlinfo blinfo = new BidBlinfo();
            blinfo.setBiduser(UserUtils.getUser());
            blinfo.setBiddinguser(UserUtils.getUser());
            blinfo.setBltype(DataDic.Bl_TYPE_BL);   //招标提货单类型
            blinfo.setBlstatus(DataDic.Bl_STATUS_NOPUBLISH);  //发布状态
            blinfo.setTradestatus(DataDic.BL_TRADE_STATUS_WSC);  //未生成
            List<BidBlinfo> blinfos = bidBlinfoService.findList(blinfo);
            if(blinfos.size()>0){
                blList.addAll(blinfos);
            }
//            List<BidBlinfo> list = ei.getDataList(BidBlinfo.class);
//            for (BidBlinfo bl : list) {
//                if (StringUtils.isNotEmpty(bl.getContractno())) {
//                    blList.add(bl);
//                }
//            }
            return new JSONPObject("callback", blList);
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "导入用户失败！失败信息：" + e.getMessage());
        }
        return new JSONPObject("callback", null);
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "importSave", method = RequestMethod.POST)
    @ResponseBody
    public Object importSave(MultipartFile file, RedirectAttributes redirectAttributes) {
        if (Global.isDemoMode()) {
            addMessage(redirectAttributes, "演示模式，不允许操作！");
            return "redirect:" + adminPath + "/sys/user/list?repage";
        }
        try {
            ImportExcel ei = new ImportExcel(file, 0, 0);
            List<BidBlinfo> blList = new ArrayList<>();
            for (int i = ei.getDataRowNum(); i < ei.getLastDataRowNum(); i++) {
                Row row = ei.getRow(i);
                BidBlinfo blinfo = new BidBlinfo();
                if (StringUtils.isNotEmpty(ei.getCellValue(row, 1).toString())){
                    blinfo.setWarehousename(ei.getCellValue(row, 0).toString());  //仓库名称
                    blinfo.setContractno(ei.getCellValue(row, 1).toString());  //提货单号
                    blinfo.setBatch(ei.getCellValue(row, 2).toString());  //批号
                    blinfo.setNamematerials(ei.getCellValue(row, 3).toString());  //品名
                    blinfo.setStandard(ei.getCellValue(row, 4).toString());  //规格
                    blinfo.setWidth(ei.getCellValue(row, 5).toString());  //定尺\板宽
                    blinfo.setQuantity(ei.getCellValue(row, 6).toString());  //数量
                    blinfo.setAddress(ei.getCellValue(row, 7).toString());  //卸货地址
                    blinfo.setRemarks(ei.getCellValue(row, 8).toString());  //备注

                    blinfo.setBiduser(UserUtils.getUser());
                    blinfo.setBiddinguser(UserUtils.getUser());
                    blinfo.setBltype(DataDic.Bl_TYPE_BL);   //招标提货单类型
                    blinfo.setBlstatus(DataDic.Bl_STATUS_NOPUBLISH);  //发布状态
                    blinfo.setTradestatus(DataDic.BL_TRADE_STATUS_WSC);  //未生成
                    blinfo.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_YRK);
                    blinfo.setBidInboundDate(new Date());
                    blinfo.setBlcode(OrderNumberUtil.getBidCode(Const.System_Module_Enum.All, 3));
                    blinfo.setId(IdGen.uuid());
                    blinfo.setIsNewRecord(true);
                    blinfoService.save(blinfo);
                    blinfo.setYmdDate(DateUtils.getDate());//创建时间
                    blinfo.setBlstatus(DictUtils.getDictLabel(blinfo.getBlstatus(), "bl_status", ""));
                    blList.add(blinfo);
                }
            }

            return new JSONPObject("callback", blList);
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "导入用户失败！失败信息：" + e.getMessage());
        }
        return new JSONPObject("callback", null);
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "bidBlinfoSave", method = RequestMethod.POST)
    @ResponseBody
    public Object importSave(BidBlinfo blinfo, RedirectAttributes redirectAttributes) {

        Object result = biddingBiz.saveBinBlinfo(blinfo);

        return new JSONPObject("callback", result);
    }

    /***
     * 合同发布货源
     * @param mv
     * @param bidOrderinfo
     * @return
     */
    @RequestMapping(value = "orderPubilshGoods")
    public ModelAndView orderPublishGoods(ModelAndView mv, BidOrderinfo bidOrderinfo) {
        bidOrderinfo = bidOrderinfoService.get(bidOrderinfo);
        Bidinfo bidinfo = bidinfoService.get(bidOrderinfo.getBidinfo());
        Biddinginfo biddinginfo = biddinginfoService.get(bidOrderinfo.getBiddinginfo());
        mv.addObject("bidOrder", bidOrderinfo);
        mv.addObject("bidinfo", bidinfo);
        mv.addObject("biddinginfo", biddinginfo);
        mv.addObject("blTradeStatus", DataDic.BL_TRADE_STATUS_WSC);
        //mv.setViewName("modules/wlpt_front/bid/order_publish_goods");
        mv.setViewName("modules/user_front/bid/bidorder_blinfo");
        return mv;
    }


    /***
     * 修改合同结算状态
     *
     * @param bidOrderinfo
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "editBidOrderSettle")
    public Object editBidOrderSettle(BidOrderinfo bidOrderinfo, Model model, RedirectAttributes redirectAttributes) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "操作成功";
        if (bidOrderinfo == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "操作失败,信息缺失";
            return this.getMapResult(state, message, null);
        }
        String id = bidOrderinfo.getId();
        ///结算状态
        String status = bidOrderinfo.getSettlestatus();
        User curUser = UserUtils.getUser();
        if (Tools.IsNullOrWhiteSpace(id) || Tools.IsNullOrWhiteSpace(status) || curUser == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "对不起,您无权限操作";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            ///修改合同交易状态
            return bidOrderBiz.editBidSettleStatus(id, curUser, status);
        }
        return this.getMapResult(state, message, null);
    }

    /**
     * 废标
     *
     * @param bidinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "repealBid")
    public Object repealBid(Bidinfo bidinfo) {
        return biddingBiz.repealBid(bidinfo);
    }


    /***
     * 修改合同状态
     *
     * @param bidOrderinfo
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "editBidOrderStatus")
    public Object editBidOrderStatus(BidOrderinfo bidOrderinfo, Model model, RedirectAttributes redirectAttributes) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "操作成功";
        if (bidOrderinfo == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "操作失败,信息缺失";
            return this.getMapResult(state, message, null);
        }
        String id = bidOrderinfo.getId();
        String status = bidOrderinfo.getContractstatus();
        User curUser = UserUtils.getUser();
        if (Tools.IsNullOrWhiteSpace(id) || Tools.IsNullOrWhiteSpace(status) || curUser == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "对不起,您无权限操作";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            ///修改合同交易状态
            return bidOrderBiz.editBidTradeStatus(id, curUser, status);
        }
        return this.getMapResult(state, message, null);
    }


    /***
     * 招标合同页面
     *
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"bidOrder", ""})
    public String bidOrder() {
    	User user = UserUtils.getUser();
        if (user.getId() == null) {
        	return "modules/wlpt_front/admin/login";
        }
    	//return "modules/wlpt_front/bid/bargain_list";
        return "modules/user_front/bid/bargain_list";
    }


    /***
     * 提货单管理页面
     *
     * @param
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"bidbl", ""})
    public ModelAndView bidbl(ModelAndView mv) {
        User user = UserUtils.getUser();
        if (user.getId() != null) {
            mv.addObject("loginUser", user);
            mv.setViewName("modules/user_front/bid/bidbl");
        } else {
            mv.setViewName("modules/wlpt_front/admin/login");
        }
        return mv;
    }

    /***
     * 获取招标合同列标
     *
     * @param bidOrderinfo
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getBidOrderList")
    public Object getbidOrderList(BidOrderinfo bidOrderinfo, int pageNo, int pageSize, Model model) {
        Page<BidOrderinfo> pg = new Page<>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            return null;
        }
        bidOrderinfo.setCurUser(UserUtils.getUser());
        Page<BidOrderinfo> page = bidOrderBiz.getBidOrderList(pg, bidOrderinfo, curUser);
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }


    /***
     * 保存竞标
     *
     * @param biddinginfo
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveBidding")
    public Object saveBidding(Biddinginfo biddinginfo, Model model, RedirectAttributes redirectAttributes) {
        return biddingBiz.bidding(biddinginfo);
    }


    /**
     * 去选标页面
     *
     * @param bidinfoId
     * @param mv
     * @return
     */
    @RequestMapping(value = "goSelectBid")
    public ModelAndView goSelectBid(String bidinfoId, ModelAndView mv) {
        if (StringUtils.isNotEmpty(bidinfoId)) {
            Bidinfo bidinfo = bidinfoService.get(bidinfoId);
            mv.addObject("bidinfo", bidinfo);
            mv.setViewName("modules/user_front/bid/select_bid");
        } else {
        	User user = UserUtils.getUser(true);
            mv.addObject("loginUser", user);
            mv.addObject("isRedrect", true);
            mv.setViewName("modules/wlpt_front/bid/my_bid");
        }
        return mv;
    }

    /**
     * 选择中标
     *
     * @param biddingId
     * @param mv
     * @return
     */
    @RequestMapping(value = "bidNotifys")
    public ModelAndView bidNotifys(String biddingId, ModelAndView mv) {
        if (StringUtils.isNotEmpty(biddingId)) {
            Biddinginfo biddinginfo = biddinginfoService.get(biddingId);
            Bidinfo bidinfo = bidinfoService.get(biddinginfo.getBidinfo());
            Map map = biddingBiz.selectBid(biddinginfo);
            mv.addAllObjects(map);
            mv.addObject("bidOrderinfo", map.get("data"));
            mv.addObject("biddinginfo", biddinginfo);
            mv.addObject("bidinfo", bidinfo);
            mv.setViewName("modules/user_front/bid/bid_notifys");
        } else {
        	User user = UserUtils.getUser(true);
            mv.addObject("loginUser", user);
            mv.addObject("isRedrect", true);
            mv.setViewName("modules/wlpt_front/bid/my_bid");
        }
        return mv;
    }


    /**
     * 查看中标
     *
     * @param biddingId
     * @param mv
     * @return
     */
    @RequestMapping(value = "notifys")
    public ModelAndView notifys(String biddingId, ModelAndView mv) {
        if (StringUtils.isNotEmpty(biddingId)) {
            Biddinginfo biddinginfo = biddinginfoService.get(biddingId);
            BidOrderinfo orderinfo = new BidOrderinfo();
            orderinfo.setBiddinginfo(biddinginfo);
            BidOrderinfo bidOrderinfo = bidOrderinfoService.findList(orderinfo).get(0);
            Bidinfo bidinfo = bidinfoService.get(biddinginfo.getBidinfo());
            mv.addObject("bidOrderinfo", bidOrderinfo);
            mv.addObject("biddinginfo", biddinginfo);
            mv.addObject("bidinfo", bidinfo);
            mv.setViewName("modules/user_front/bid/bid_notifys");
        } else {
        	User user = UserUtils.getUser(true);
            mv.addObject("loginUser", user);
            mv.addObject("isRedrect", true);
            mv.setViewName("modules/wlpt_front/bid/my_bid");
        }
        return mv;
    }

    /**
     * 保存中标通知
     *
     * @param mv
     * @return
     */
    @RequestMapping(value = "saveNotifys")
    public ModelAndView saveNotifys(BidOrderinfo bidOrderinfo, ModelAndView mv) {
        bidOrderinfoService.save(bidOrderinfo);
        User user = UserUtils.getUser(true);
        mv.addObject("isRedrect", true);
        mv.addObject("loginUser", user);
        mv.setViewName("modules/user_front/bid/my_bid");
        return mv;
    }


    /**
     * 招标详情--去竞价
     */
    @RequestMapping(value = "toBidding")
    public Object toBidding(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
        String bidinfoId = request.getParameter("bidinfoId");
        User user = UserUtils.getUser();
        if (user.getId() != null) {
            if (bidinfoId != null && !StringUtils.isEmpty(bidinfoId)) {
                Bidinfo bidinfo = bidinfoService.get(bidinfoId);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                bidinfo.setEndtimeFM(sdf.format(bidinfo.getEndtime()));
                mv.addObject("bidinfo", bidinfo);
                //mv.setViewName("modules/wlpt_front/bid/bid_bidding");
                mv.setViewName("modules/wlpt_front/hall/bid_bidding");
            } else {
                //mv.setViewName("modules/wlpt_front/bid/bid_bidding");
                mv.setViewName("modules/wlpt_front/hall/bid_bidding");
            }
        } else {
            mv.addObject("login", "login");
            mv.setViewName("modules/wlpt_front/admin/login");
        }
        return mv;
    }


    /**
     * 招标详情
     */
    @RequestMapping(value = "bidDetails")
    public ModelAndView bidDetails(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
        String bidinfoId = request.getParameter("bidinfoId");
        User user = UserUtils.getUser();
        if (user != null) {
            if (bidinfoId != null && !StringUtils.isEmpty(bidinfoId)) {
                Bidinfo bidinfo = bidinfoService.get(bidinfoId);
                BidBlinfo blinfo=new BidBlinfo();
                blinfo.setBidgoods(bidinfo.getGoods());
                List<BidBlinfo> blinfos = blinfoService.findList(blinfo);
                mv.addObject("blinfoList", blinfos);
                mv.addObject("bidstatus", DictUtils.getDictLabel(bidinfo.getBidstatus(), "bid_status", ""));
                mv.addObject("bidinfo", bidinfo);
                mv.setViewName("modules/wlpt_front/bid/bid_details");
            } else {
                mv.setViewName("modules/wlpt_front/bid/bid_details");
            }
        } else {
            mv.setViewName("modules/wlpt_front/admin/login");
        }
        return mv;
    }

    /***
     * 获取招标详情
     * @param id
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDetail")
    public Object getDetail(String id) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        Map<String, Object> map = new HashMap<String, Object>();

        if (id != null && !StringUtils.isEmpty(id)) {
           Bidinfo bidinfo = bidinfoService.get(id);
            BidBlinfo blinfo = new BidBlinfo();
            blinfo.setBidgoods(bidinfo.getGoods());
            List<BidBlinfo> blinfos = blinfoService.findList(blinfo);
            bidinfo.getGoods().setGsoddtype(DictUtils.getDictLabel(bidinfo.getGoods().getGsoddtype(), "gsoddtype", ""));
            map.put("bidinfo",bidinfo);
            map.put("blinfoList",blinfos);
            map.put("bidstatus",DictUtils.getDictLabel(bidinfo.getBidstatus(), "bid_status", ""));
        }else{
            state=DataDic.RETURN_STATUS_INFOBUG;
            message="未查询到数据";
        }
        return this.getMapResult(state,message,map);
    }
    /**
     * 我的招标
     */
    @RequestMapping(value = "myBid")
    public ModelAndView mybid(ModelAndView mv,HttpServletRequest request,HttpServletResponse response, String isRedrect) {
        User user = UserUtils.getUser(true);
        if (user.getId() != null) {
            mv.addObject("loginUser", user);
            mv.addObject("isRedrect", isRedrect);
            if(isRedrect == null || isRedrect ==""){        	
            	Cookie[] cookies = request.getCookies();
            	for(Cookie c :cookies){
            		if(c.getName().equals("bid_fromprovince") ||c.getName().equals("bid_fromcity")
            				||c.getName().equals("bid_addressStart")||c.getName().equals("bid_toprovince")
            				||c.getName().equals("bid_tocity")||c.getName().equals("bid_addressEnd")
            				||c.getName().equals("bid_bidcode")||c.getName().equals("bid_goodsName")
            				||c.getName().equals("bid_pageno")){
            			c.setValue(null);
            			response.addCookie(c);
            		}
            	}
            }
            /*mv.setViewName("modules/wlpt_front/bid/my_bid");*/
            mv.setViewName("modules/user_front/bid/my_bid");
        } else {
            mv.setViewName("modules/wlpt_front/admin/login");
        }
        return mv;
    }


    /**
     * 我的竞标
     */
    @RequestMapping(value = "myBidding")
    public ModelAndView myBidding(ModelAndView mv) {
        User user = UserUtils.getUser();
        if (user.getId() != null) {
            mv.addObject("loginUser", user);
            /*mv.setViewName("modules/wlpt_front/bid/my_bidding");*/
            mv.setViewName("modules/user_front/bid/my_bidding");
        } else {
            mv.setViewName("modules/wlpt_front/admin/login");
        }
        return mv;
    }


    /**
     * 竞标 保存动作
     *
     * @param biddinginfo
     * @param mv
     * @return
     */
    @RequestMapping(value = "bidding")
    public ModelAndView bidding(Biddinginfo biddinginfo, ModelAndView mv) {
        User user = UserUtils.getUser();
        if (user != null) {
            Map bidding = biddingBiz.bidding(biddinginfo);
            mv.addAllObjects(bidding);
            mv.setViewName("modules/wlpt_front/bid/bid_bidding");
        } else {
            mv.setViewName("modules/wlpt_front/admin/login");
        }
        return mv;
    }

    /**
     * 招标列表
     *
     * @param bidinfo
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getbidsList")
    public Object getbidsList(Bidinfo bidinfo, int pageNo, int pageSize, Model model) {
        Page<Bidinfo> pg = new Page<>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        User user = UserUtils.getUser();
        bidinfo.setBiduser(user);
        Page<Bidinfo> page = bidinfoService.findPage(pg, bidinfo);
        for (Bidinfo b : page.getList()) {
            b = biddingBiz.checkEndTime(b);
            b.setBidstatus(DictUtils.getDictLabel(b.getBidstatus(), "bid_status", ""));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }


    /**
     * 提货单列表
     *
     * @param
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getblList")
    public Object getblList(BidBlinfo bidBlinfo, Model model) {
        User user = UserUtils.getUser();
        //获取提货单列表
        List<BidBlinfo> list = blinfoService.findList(bidBlinfo);
        for (BidBlinfo b : list) {
            b.setBlstatus(DictUtils.getDictLabel(b.getBlstatus(), "bl_status", ""));
            if(b.getBiddingInboundDate()!=null && b.getBiddinguser()!=null && user.getId().equals(b.getBiddinguser().getId())){
                b.setYmdDate(b.getYmdbiddingInboundDate());
            }
        }
        model.addAttribute("list", list);
        return new JSONPObject("callback", list);
    }

    /**
     * 通过报价ID获取提货单列表信息
     * @param quoteBlinfo
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getblListByQuote")
    public Object getBlQuoteList(QuoteBlinfo quoteBlinfo, Model model) {

        //获取提货单列表
        List<BidBlinfo> bllist=new ArrayList<BidBlinfo>();
        List<QuoteBlinfo> list = quoteinfoService.findBLinfoList(quoteBlinfo);
        for (QuoteBlinfo b : list) {
            b.getBlinfo().setBlstatus(DictUtils.getDictLabel(b.getBlinfo().getBlstatus(), "bl_status", ""));
            bllist.add(b.getBlinfo());
        }
        model.addAttribute("list", bllist);
        return new JSONPObject("callback", bllist);
    }

    /**
     * 竞标列表
     *
     * @param
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getbiddingListbyBid")
    public Object getbiddingListbyBid(Biddinginfo biddinginfo, int pageNo, int pageSize, Model model) {
        Page<Biddinginfo> pg = new Page<>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        if (UserUtils.getUser() == null) {
            return null;
        }
        Page<Biddinginfo> page = biddinginfoService.findPage(pg, biddinginfo);
        for (Biddinginfo b : page.getList()) {
            b.setBiddingstatus(DictUtils.getDictLabel(b.getBiddingstatus(), "bidding_status", ""));
            UserStatistics userStatistics = new UserStatistics();
            userStatistics.setUser(b.getBiddinguser());
            b.setUserStatistics(userStatisticsService.getConditon(userStatistics));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }


    /**
     * 竞标列表
     *
     * @param
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getbiddingList")
    public Object getbiddingList(Biddinginfo biddinginfo, int pageNo, int pageSize, Model model) {
        Page<Biddinginfo> pg = new Page<>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        if (UserUtils.getUser() == null) {
            return null;
        }
        biddinginfo.setBiddinguser(UserUtils.getUser());

        Page<Biddinginfo> page = biddinginfoService.findPage(pg, biddinginfo);
        for (Biddinginfo b : page.getList()) {
            b.setBiddingstatus(DictUtils.getDictLabel(b.getBiddingstatus(), "bidding_status", ""));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }


    /**
     * 发布招标
     */
    @RequestMapping(value = "publshBid")
    public ModelAndView publshBid(ModelAndView mv) {

        User user = UserUtils.getUser();
        if (user.getId() != null) {
            mv.addObject("bidinfo", new Bidinfo());
            Address address = new Address();
            address.setUser(user);
            List<Address> list = addressService.findList(address);
            Map<String, String> addressMap = new HashMap<>();
            for (Address ad : list) {
                addressMap.put(ad.getId(), ad.getProvince() + " " + ad.getCity() + " " + ad.getDistrict() + " " + ad.getAddress());
            }
            mv.addObject("loginUser",user);
            mv.addObject("address", addressMap);
            mv.setViewName("modules/user_front/bid/publish_bid");
        } else {
            mv.setViewName("modules/wlpt_front/admin/login");
        }
        return mv;
    }

//    /**
//     * 保存招标信息
//     *
//     * @param mv
//     * @param bidinfo
//     * @param request
//     * @param response
//     * @return
//     * @throws IOException
//     */
//    @RequestMapping(value = "bidSave", produces = "application/json", method = RequestMethod.POST)
//    public ModelAndView bidSave(ModelAndView mv, Bidinfo bidinfo, HttpServletRequest request, HttpServletResponse response) throws IOException {
//        User user = UserUtils.getUser();
//        if (user != null && user.getId() != null) {
//            ObjectMapper mapper = new ObjectMapper();
//            mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
//            mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
//            mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
//            String blinfoStr = request.getParameter("blinfoList");
//            if (blinfoStr != null && StringUtils.isNotEmpty(blinfoStr)) {
//                List<BidBlinfo> blinfoList = Arrays.asList(mapper.readValue(blinfoStr, BidBlinfo[].class));
//                bidinfo.setBlinfoList(blinfoList);
//                Map map = biddingBiz.publishBid(bidinfo, user);
//                mv.addAllObjects(map);
//            }
//            mv.setViewName("modules/wlpt_front/bid/my_bid");
//        } else {
//            mv.setViewName("modules/sys/sysLogin");
//        }
//        return mv;
//    }


    /**
     * 招标保存
     *
     * @param bidinfo
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping(value = "bidSave", produces = "application/json", method = RequestMethod.POST)
    public Object bidSave(Bidinfo bidinfo, HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = UserUtils.getUser(true);
        String result;
        if (user != null && user.getId() != null&&DataDic.AUTHENSUCCES.equals(user.getUserinfo().getStatus())) {
            ObjectMapper mapper = new ObjectMapper();
            mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
            mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
            mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
            String blinfoStr = request.getParameter("blinfoList");
            if (blinfoStr != null && StringUtils.isNotEmpty(blinfoStr)) {
                List<BidBlinfo> blinfoList = Arrays.asList(mapper.readValue(blinfoStr, BidBlinfo[].class));
                bidinfo.setBlinfoList(blinfoList);
                biddingBiz.publishBid(bidinfo);
            }
            result = "1";
        } else {
            result = "0";
        }
        return new JSONPObject("callback", result);
    }

    /**
     * 是否有资格减免投标保证金
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "isDerate")
    public Boolean isDerateBidGuarantee() {
        Boolean isDerate = false;
        User user = UserUtils.getUser();
        if (user.getId() != null) {
            isDerate = consumeRecodBiz.isDerateBidGuarantee(user.getId());
        }
        return isDerate;
    }
    
    /***
     * 删除明细
     *
     * @param goods 货源实体
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "deleteBl", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteBl(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
    	ObjectMapper mapper = new ObjectMapper();
        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
        mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
    	String blinfoStr = request.getParameter("blinfoList");
        int delnum=0;
        int allnum=0;
    	if (blinfoStr != null && StringUtils.isNotEmpty(blinfoStr)) {
    		List<BidBlinfo> blinfoList = Arrays.asList(mapper.readValue(blinfoStr, BidBlinfo[].class));
    		allnum=blinfoList.size();
            for(BidBlinfo bl:blinfoList){
                if("0".equals(bl.getBltype())){
                    delnum+=1;
                    continue;
                }
    			bidBlinfoService.delete(bl);
    		}
    	}
        String result="您本次选中删除"+allnum+"条数据,成功删除"+(allnum-delnum)+"条提货单,其中"+delnum+"条合同提货单删除失败！";
    	return new JSONPObject("callback", result);
    }
}