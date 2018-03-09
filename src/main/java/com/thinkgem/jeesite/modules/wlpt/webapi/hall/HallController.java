package com.thinkgem.jeesite.modules.wlpt.webapi.hall;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BiddingBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarLocsService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserQualitycertifyService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserStatisticsService;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by ForHeart on 16/8/10.
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/hall")
public class HallController extends BaseController {
	
	@Autowired
	private UserQualitycertifyService userQualitycertifyService;
	
	@Autowired
	private DriverService driverService;
	
    @Autowired
    private CarService carService;
    
    @Autowired
    private GoodsService goodsService;

    @Autowired
    private GoodsBiz goodsBiz;

    @Autowired
    private CarBiz carBiz;

    @Autowired
    private BiddingBiz biddingBiz;
    
    @Autowired
    private BiddinginfoService biddingService;

    @Autowired
    private GpsCarLocsService gpsCarLocsService;

    @Autowired
    private BidinfoService bidinfoService;

    @Autowired
    private UserStatisticsService statisticsService;

    @RequestMapping(value = {"integrity", ""})
    public String integrity_hall(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/wlpt_front/hall/integrity";
    }

    @RequestMapping(value = {"car", ""})
    public String car_hall(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/wlpt_front/hall/car";
    }

    @RequestMapping(value = {"goods", ""})
    public String goods_hall(HttpServletRequest request, HttpServletResponse response, Model model,@RequestParam(required = false)String message) {
    	model.addAttribute("message", message);
    	return "modules/wlpt_front/hall/goods";
    }

    @RequestMapping(value = {"bids", ""})
    public String bids_hall(HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = UserUtils.getUser();
        if (user.getId() != null)
            user = UserUtils.findUser(UserUtils.getUser());
        request.setAttribute("user", user);
        return "modules/wlpt_front/hall/bids";
    }

    @ResponseBody
    @RequestMapping(value = "getIntegrityList")
    public Object getIntegrityList(UserStatistics finduser, String orderBy, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        pg.setOrderBy(orderBy);
        //
        //  goods.setDatasource("0");
        Page<UserStatistics> page = statisticsService.findUinfoPage(pg, finduser);
        User user = UserUtils.getUser();
        /*List<User> list = new ArrayList<User>();
        for (User var : page.getList()) {

        }
        page.setList(list);*/
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
    /***
     * 获取车辆信息
     *
     * @param car      车辆搜索对象
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getCarList")
    public Object getCarList(Car car, String orderBy, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        pg.setOrderBy(orderBy);
        //
        Page<Car> page = carService.findHallList(pg, car);
        List<String> gpslist = new ArrayList<>();
        for (Car var : page.getList()) {
        	if(var.getUser()!=null&&var.getUser().getUserinfo()!=null){
        		var.getUser().setPointlevle(var.getUser().getUserinfo().getPointlevle());
        	}
            if (UserUtils.getUser().getId() == null) {
                if (var.getUser().getPhone() != null && !var.getUser().getPhone().equals("")) {
                    var.getUser().setPhone(var.getUser().getPhone().substring(0, 4) + "****" + var.getUser().getPhone().substring(7));
                }
            }
            if(!Tools.IsNullOrWhiteSpace(var.getCarsourceid())){
    			if(!Tools.IsNullOrWhiteSpace(var.getCarsourcemainroad())){
    				var.setMainroad(var.getCarsourcemainroad());
    			}
    			if(!Tools.IsNullOrWhiteSpace(var.getContactname())){
    				var.setOwnername(var.getContactname());
    			}
    			if(!Tools.IsNullOrWhiteSpace(var.getContactmobile())){
    				var.setOwnermobile(var.getContactmobile());
    			}
    			var.setCarsourcestatus(DictUtils.getDictLabel(var.getCarsourcestatus(), "carsources_tatus", ""));
    		}
            gpslist.add(var.getCarnumber());
            /*GpsCarLocs gpsCarLocs = new GpsCarLocs();
            gpsCarLocs.setName(var.getCarnumber());
            gpsCarLocs = gpsCarLocsService.get(gpsCarLocs);
            var.setGpsloc(gpsCarLocs);*/
        }
        if (gpslist.size() > 0) {
            List<GpsCarLocs> gpsCars = gpsCarLocsService.findByGroup(gpslist.toArray(new String[gpslist.size()]));
            for (Car var : page.getList()) {
                for (GpsCarLocs gpsCar : gpsCars) {
                    if (gpsCar.getName().equals(var.getCarnumber())) {
                        var.setGpsloc(gpsCar);
                    }
                }
            }
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
    
    /***
     * 获取车辆信息
     *
     * @param car      车辆搜索对象
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getLEDCarList")
    public Object getLEDCarList(Car car, String orderBy, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        pg.setOrderBy(orderBy);
        Page<Car> page = carService.findPage(pg, car);
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /***
     * 获取货源列表
     *
     * @param goods
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getGoodsList")
    public Object getGoodsList(Goods goods, String orderBy, int pageNo, int pageSize,String type, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        pg.setOrderBy(orderBy);
        //
        //  goods.setDatasource("0");
        goods.setSearchType(1);
        if(!Tools.IsNullOrWhiteSpace(type)){
        	goods.setBeginSendtime(new Date());
        	goods.setNottradestatus(DataDic.GDS_FULLQUOTE);
        }
        
        Page<Goods> page = goodsService.findPage(pg, goods);
        User user = UserUtils.getUser();
        List<Goods> list = new ArrayList<Goods>();
        for (Goods gds : page.getList()) {
        	if(gds.getUser()!=null&&gds.getUser().getUserinfo()!=null){
        		gds.getUser().setPointlevle(gds.getUser().getUserinfo().getPointlevle());
        	}
            if (user.getId() == null) {
                if (gds.getUser().getPhone() != null && !gds.getUser().getPhone().equals("")) {
                    gds.getUser().setPhone(gds.getUser().getPhone().substring(0, 4) + "****" + gds.getUser().getPhone().substring(7));
                }
            }
            gds.setTradestatus(DictUtils.getDictLabel(gds.getTradestatus(), "gds_tradeStatus", ""));
            gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
            if(!Tools.IsNullOrWhiteSpace(gds.getPaypeople())){
            	gds.setPaypeople(DictUtils.getDictLabel(gds.getPaypeople(), "insur_paypeople", ""));
            }
            
            int status = goodsBiz.validQuote(gds.getId());//-1货源不存在、0用户未登陆、1可抢单、2内部货源、3已报价、4报价完成
            gds.setStatus(status);
            list.add(gds);
        }
        page.setList(list);
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
    
    /***
     * 获取货源列表
     *
     * @param goods
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getGoodsAndBidNum")
    public Object getGoodsAndBidNum() {
    	Map<String, Object> resultMap = new HashMap<>();
        Page pg = new Page();
        pg.setPageNo(0);
        pg.setPageSize(1);
        pg.setOrderBy("");
        //
        //  goods.setDatasource("0");
        Goods goods = new Goods();
        goods.setSearchType(1);
    	goods.setBeginSendtime(new Date());
    	goods.setNottradestatus(DataDic.GDS_FULLQUOTE);
        
        
        Page<Goods> pagegoods = goodsService.findPage(pg, goods);
        resultMap.put("goodsnum", pagegoods.getCount());
        
        Bidinfo bidinfo = new Bidinfo();
        bidinfo.setBidstatus(DataDic.BID_STATUS_FAB);
        Page<Bidinfo> pagebid = bidinfoService.findPage(pg, bidinfo);
        
        resultMap.put("bidnum", pagebid.getCount());
        return new JSONPObject("callback", resultMap);
    }
    
    
    
    

    /***
     * 获取LED货源列表
     *
     * @param goods
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getLEDGoodsList")
    public Object getLEDGoodsList(Goods goods, String orderBy, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        pg.setOrderBy(orderBy);
        Page<Goods> page = goodsService.findPage(pg, goods);
        List<Goods> list = new ArrayList<Goods>();
        /*for (Goods gds : page.getList()) {
            if (!gds.getTradestatus().equals(DataDic.GDS_FULLQUOTE)) {
                list.add(gds);
            }
        }*/
        page.setList(page.getList());
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /**
     * 获取招标列表
     *
     * @param bidinfo
     * @param orderBy
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getbidsList")
    public Object getbidsList(Bidinfo bidinfo, String orderBy, int pageNo, int pageSize,String type, Model model) {
        Page<Bidinfo> pg = new Page<>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        pg.setOrderBy(orderBy);
        //
        User user = UserUtils.getUser();
        if(!Tools.IsNullOrWhiteSpace(type)){
        	bidinfo.setBidstatus(DataDic.BID_STATUS_FAB);
        }
        Page<Bidinfo> page = bidinfoService.findPage(pg, bidinfo);
        for (Bidinfo bid : page.getList()) {
            bid = biddingBiz.checkEndTime(bid);
            if(bid.getBiduser()!=null&&bid.getBiduser().getUserinfo()!=null){
            	bid.getBiduser().setPointlevle(bid.getBiduser().getUserinfo().getPointlevle());
            }
            if (DataDic.BID_STATUS_ZZJY.equals(bid.getBidstatus())) {
                bid.setBidstatus("已截标");
            } else {
                bid.setBidstatus(DictUtils.getDictLabel(bid.getBidstatus(), "bid_status", ""));
            }
            List<Biddinginfo> blist = null;
            if(user != null && !Tools.IsNullOrWhiteSpace(user.getId())){
            	Biddinginfo bidding = biddingService.findByBidIdAndUserId(bid.getId(), user.getId());
                if(bidding!=null){
                	blist = new ArrayList<Biddinginfo>();
                	blist.add(bidding);
                }
            }
            bid.setBiddingList(blist);
        }

        /* gds.setTradestatus(DictUtils.getDictLabel(gds.getTradestatus(), "gds_tradeStatus", ""));
         gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
         */
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /***
     * 获取货源详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "getGoodsInfo")
    public String getGoodsInfo(@RequestParam(required = false) String id, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
    	
    	if (user.getId() == null) {
            request.setAttribute("login", "login");
            return "modules/wlpt_front/admin/login";
        }
    	
    	
    	/*Userinfo ui=user.getUserinfo();
    	if(ui == null || "2".equals(ui.getStatus())){
    		redirectAttributes.addAttribute("message", "您尚未认证");
    		return "redirect:" + Global.getFrontPath() + "/wlpt/hall/goods";
    	}*/
    		
        Goods gs = goodsBiz.get(id);
        model.addAttribute("sendtime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(gs.getSendtime()));
        gs.setGoodstype(DictUtils.getDictLabel(gs.getGoodstype(), "goodstype", ""));
        gs.setGsoddtype(DictUtils.getDictLabel(gs.getGsoddtype(), "gsoddtype", ""));
        model.addAttribute("goods", gs);
        return "modules/wlpt_front/hall/goodsInfo";
    }

    /***
     * 获取车辆详情
     *
     * @param id    当前car
     * @param model
     * @return
     */
    @RequestMapping(value = "getCarInfo")
    public String getCarInfo(@RequestParam(required = false) String id,@RequestParam(required = false) String carsourceid, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (UserUtils.getUser().getId() == null) {
            request.setAttribute("login", "login");
            return "modules/wlpt_front/admin/login";
        }
        Car car = carBiz.gethallinfo(id,carsourceid);
        String picture = car.getCarsurfaceimg();
        List<String> list = new ArrayList<String>();
        if (picture != null && !picture.equals("")) {
            String[] pictures = picture.split("\\|");
            for (int i = 0; i < pictures.length; i++) {
                if (!"".equals(pictures[i])) {
                    list.add(pictures[i]);
                }
            }
        }
        car.setIssocialcar(DictUtils.getDictLabel(car.getIssocialcar(), "issocialcar", ""));
        if(!Tools.IsNullOrWhiteSpace(car.getCarsourceid())){
        	car.setCarsourcestatus(DictUtils.getDictLabel(car.getCarsourcestatus(), "carsources_tatus", ""));
        }
        model.addAttribute("list", list);
        model.addAttribute("car", car);
        return "modules/wlpt_front/hall/carInfo";
    }

    /**
     * 平台车辆
     *
     * @return
     */
    @RequestMapping(value = "/towlptCar")
    public String towlptCar(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

        return "modules/wlpt_front/hall/lps_car";
    }

    /**
     * 去信息大屏页
     *
     * @return
     */
    @RequestMapping(value = "/toScreenInfomation")
    public String toScreenInfomation() {
        return "modules/wlpt_front/hall/screenInformation";
    }
}
