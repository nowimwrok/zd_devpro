package com.thinkgem.jeesite.modules.wlpt.webapi.shop;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.activity.ActivityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.shop.ShopBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurancelist;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ShopVO;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsurancelistService;

/**
 * 商城
 * @author 王铸
 * @version 2016-09-19
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/shop")
public class ShopController extends BaseController{
	@Autowired
    private ShopBiz shopBiz;
	@Autowired
	private UserInsuranceService userInsuranceService;
	
	@Autowired
	private UserInsurancelistService userInsurancelistService;
	
	@Autowired
    private ActivityBiz activityBiz;

	/**
	 * 到购买页面
	 * @param shop
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
    @RequestMapping(value = "toBuy")
    public String toBuy(ShopVO shop, HttpServletRequest request, HttpServletResponse response, Model model){
    	User user=UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
    	if(user.getId()==null){
    		request.setAttribute("login", "login");
    	    return "modules/wlpt_front/admin/login";
    	}
    	if(shop.getShotName()==null||shop.getShotName().equals("")){
    		return "modules/wlpt_front/shop/list";
    	}
    	String gifttype ="";//礼品类型
    	String actitytype ="";//活动类型
    	String actitystatus = DataDic.ACTIVITY_STATUS_OPEN;//活动状态--开启的活动
        ShopVO shopVO=new ShopVO();
        if(shop.getShotName().equals("you_qi")){
        	shopVO.setShotName(shop.getShotName());
        	shopVO.setName("油气");
        	shopVO.setPrice("1");
        	gifttype = DataDic.ACTIVITYGIFT_TYPE_PETRO;
        	actitytype = DataDic.ACTIVITY_TYPE_PETRO;
        }
        if(shop.getShotName().equals("zd_coin")){
        	shopVO.setShotName(shop.getShotName());
        	shopVO.setName("卓币");
        	shopVO.setPrice("1");
        	gifttype = DataDic.ACTIVITYGIFT_TYPE_COIN;
        	actitytype = DataDic.ACTIVITY_TYPE_COIN;
        }
        //活动
        ActivityWxgift wxgift = new ActivityWxgift();
        ActivityWxinfo wxinfo = new ActivityWxinfo();
        wxgift.setGifttype(gifttype);//礼物类型
        wxgift.setCurrenttime(new Date());//当前时间
        wxinfo.setIseffective(actitystatus);//活动状态
        wxinfo.setType(actitytype);//活动类型
        wxgift.setWxinfo(wxinfo);
        //获取活动
        List<ActivityWxgift> giftlst = activityBiz.findWxgiftList(wxgift);
        if(giftlst.size()>0){
        	wxgift = giftlst.get(0);
        	model.addAttribute("wxgift",wxgift);
        }
        
        model.addAttribute("shopVO",shopVO);
    	return "modules/wlpt_front/shop/submitOrder";
    }
    
   /**
    * 到支付页面
    * @param shop
    * @param giftid
    * @param request
    * @param response
    * @param model
    * @return
    */
    @RequestMapping(value = "toPay")
    public String pay(ShopVO shop,String giftid,HttpServletRequest request, HttpServletResponse response,Model model){
    	User user=UserUtils.getUser();
		User newuser = UserUtils.findUser(user);
    	if(user.getId()==null){
    		request.setAttribute("login", "login");
    	    return "modules/wlpt_front/admin/login";
    	}
		List<ActivityAwardrecord> awlist = new ArrayList<>();
		if(shop.getShotName().equals("you_qi")){
			//活动
			ActivityWxgift wxgift = new ActivityWxgift();
			wxgift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_PETRO);//礼物类型
			ActivityAwardrecord aw = new ActivityAwardrecord();
			aw.setWxgift(wxgift);
			aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
			aw.setPhone(user.getPhone());
			awlist = activityBiz.awardrecordFindList(aw);
		}
		model.addAttribute("awlist",awlist);
    	model.addAttribute("giftid",giftid);
    	model.addAttribute("shop",shop);
    	model.addAttribute("user",newuser);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);

    	return "modules/wlpt_front/shop/pay";
    }
    
    /**
     * 支付   判断支付类型
     * @param shop
     * @param giftid
     * @param paytype
     * @param request
     * @param response
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "consumeType")
    public Object consumeType(ShopVO shop,String giftid,String paytype,String awardno,HttpServletRequest request, HttpServletResponse response,Model model){
    	return shopBiz.consumeType(shop, giftid,paytype,awardno);
    }
    
    @RequestMapping(value = "detail")
	public String detail(Model model){
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/shop/detail";
	}

	/**
	 * 卓币消费
	 * @return
     */
	@RequestMapping(value = "coin_detail")
	public String coin_detail(Model model){
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/shop/coin_detail";
	}

	@RequestMapping(value = "petrol_detail")
	public String petrol_detail(Model model){
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/shop/petrol_detail";
	}
	
	
	//=====================================保险==============================
	/**
	 * 保险列表
	 * @return
	 */
	@RequestMapping(value = "insur_list")
	public String toInsurance( Model model){
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		Page<UserInsurance> page = new Page<>();
        ////获取当前用户
        User curUser = UserUtils.getUser();
        if (curUser != null && !Tools.IsNullOrWhiteSpace(curUser.getId())){
        	UserInsurance insurance = new UserInsurance();
        	Page pg = new Page();
            pg.setLength(4);
            pg.setPageNo(1);
            pg.setPageSize(4);
        	
        	insurance.setUser(curUser);
	        page = userInsuranceService.findPage(pg, insurance);
	        for (UserInsurance insur : page.getList()) {
	        	insur.setStatusInt(Integer.parseInt(insur.getStatus()));
	        	insur.setStatus(DictUtils.getDictLabel(insur.getStatus(), "insurance_status", ""));
	            
	        }
        }
	        
        model.addAttribute("insurancelist", page.getList());
		return "modules/wlpt_front/shop/insurance";
	}

	/**
	 * 获取保险品种列表
	 * @param insurancelist
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "getInsuranceList")
    public Object getInsuranceList(UserInsurancelist insurancelist, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(2);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        insurancelist.setIsenable(DataDic.YES);
        Page<UserInsurancelist> page = userInsurancelistService.findPage(pg, insurancelist);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
	
	/**
	 * 卓大商场保险详情
	 * 
	 * @return
	 */
	@RequestMapping(value = "insur_detail")
	public String insur_detail(String id, Model model) {
		User user=UserUtils.getUser();
		model.addAttribute("user", user);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		UserInsurancelist insurlist = userInsurancelistService.get(id);
		model.addAttribute("insurlist", insurlist);
        return "modules/wlpt_front/shop/insur_detail";
	}
	
	/**
	 * 卓大商场保险填写
	 * 
	 * @return
	 */
	@RequestMapping(value = "toinsur")
	public String toinsur(String id,HttpServletRequest request, HttpServletResponse response,Model model) {
		User user=UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
    	if(user.getId()==null){
    		request.setAttribute("login", "login");
    	    return "modules/wlpt_front/admin/login";
    	}
    	UserInsurancelist insurlist = userInsurancelistService.get(id);
		model.addAttribute("insurlist", insurlist);
		model.addAttribute("user", user);
        return "modules/wlpt_front/shop/insur_add";
	}

	/**
	 * 卓大商场保险填写
	 * 内部
	 * @return
	 */
	@RequestMapping(value = "toinsurance")
	public String toinsurance(String id,HttpServletRequest request, HttpServletResponse response,Model model) {
		User user=UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		if(user.getId()==null){
			request.setAttribute("login", "login");
			return "modules/wlpt_front/admin/login";
		}
		UserInsurancelist insurlist = userInsurancelistService.get(id);
		model.addAttribute("insurlist", insurlist);
		model.addAttribute("user", user);
		return "modules/wlpt_front/shop/insurance_add";
	}
	
	/**
	 * 卓大商场保险支付
	 * 
	 * @return
	 */
	@RequestMapping(value = "toinsurpay")
	public String toinsurpay(UserInsurance userInsurance,Model model) {
		UserInsurance insurance=userInsuranceService.get(userInsurance.getId());
		ShopVO shop=new ShopVO();
		shop.setName(insurance.getInsurancetype());
		shop.setTotal(insurance.getInsurancefeel());;
		shop.setShotName("zd_insur");
		User user=UserUtils.getUser();
		List<ActivityAwardrecord> awlist = new ArrayList<>();
		//活动
		ActivityWxgift wxgift = new ActivityWxgift();
		wxgift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_INSUR);//礼物类型
		ActivityAwardrecord aw = new ActivityAwardrecord();
		aw.setWxgift(wxgift);
		aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
		aw.setPhone(user.getPhone());
		awlist = activityBiz.awardrecordFindList(aw);

		model.addAttribute("awlist",awlist);
		model.addAttribute("user", user);
		model.addAttribute("shop", shop);
		model.addAttribute("userInsurance", insurance);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
        return "modules/wlpt_front/shop/insur_pay";
	}
	
	/**
	 * 卓大商场保险支付
	 * 
	 * @return
	 */
	@RequestMapping(value = "toInsurPay")
	public String toInsurPay(UserInsurance userInsurance,Model model) {
		UserInsurance insurance=userInsuranceService.get(userInsurance.getId());
		ShopVO shop=new ShopVO();
		shop.setName(insurance.getInsurancetype());
		shop.setTotal(insurance.getInsurancefeel());;
		shop.setShotName("zd_insur");
		User user=UserUtils.getUser();
		List<ActivityAwardrecord> awlist = new ArrayList<>();
		//活动
		ActivityWxgift wxgift = new ActivityWxgift();
		wxgift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_INSUR);//礼物类型
		ActivityAwardrecord aw = new ActivityAwardrecord();
		aw.setWxgift(wxgift);
		aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
		aw.setPhone(user.getPhone());
		awlist = activityBiz.awardrecordFindList(aw);

		model.addAttribute("awlist",awlist);
		model.addAttribute("user", user);
		model.addAttribute("shop", shop);
		model.addAttribute("userInsurance", insurance);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
        return "modules/wlpt_front/insur/insur_pay";

	}

	/**
	 * 卓大商场保险支付
	 *内部
	 * @return
	 */
	@RequestMapping(value = "toinsurancepay")
	public String toinsurancepay(UserInsurance userInsurance,Model model) {
		UserInsurance insurance=userInsuranceService.get(userInsurance.getId());
		ShopVO shop=new ShopVO();
		shop.setName(insurance.getInsurancetype());
		shop.setTotal(insurance.getInsurancefeel());;
		shop.setShotName("zd_insur");
		User user=UserUtils.getUser();
		List<ActivityAwardrecord> awlist = new ArrayList<>();
		//活动
		ActivityWxgift wxgift = new ActivityWxgift();
		wxgift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_INSUR);//礼物类型
		ActivityAwardrecord aw = new ActivityAwardrecord();
		aw.setWxgift(wxgift);
		aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
		aw.setPhone(user.getPhone());
		awlist = activityBiz.awardrecordFindList(aw);

		model.addAttribute("awlist",awlist);
		model.addAttribute("user", user);
		model.addAttribute("shop", shop);
		model.addAttribute("userInsurance", insurance);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/wlpt_front/shop/insurance_pay";
	}

	
	/**
	 * 卓大商场支付成功
	 * 
	 * @return
	 */
	@RequestMapping(value = "topaysuccess")
	public String topaysuccess(Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
          return "modules/wlpt_front/shop/pay_success";
	}

	/**
	 * 确认保险--新建单
	 * @param userInsurance
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "saveInsur")
	public Object saveInsur(UserInsurance userInsurance){
		return shopBiz.saveInsur(userInsurance);
	}

	/**
	 * 确认保险--新建单
	 * @param userInsurance
	 * @param model
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "saveTradeInsur")
	public Object saveTradeInsur(UserInsurance userInsurance,Model model){
		return shopBiz.saveTradeInsur(userInsurance,model);
	}

	/**
	 *  取消保单
	 * @param userInsurance
	 * @param model
	 * @return
	 */
    @RequestMapping(value = "cancelInsur")
	public String cancelInsur(UserInsurance userInsurance,Model model){
    	userInsuranceService.delete(userInsurance);
    	User curUser = UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		model.addAttribute("user", curUser);
        return "modules/wlpt_front/insur/insur_list";
	}
    /**
     * 油气购买链接
     */
    @RequestMapping(value = "buyOil")
    public String byOil(ShopVO shop,String giftid,HttpServletRequest request, HttpServletResponse response,Model model){

    	User user=UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
    	if(user.getId()==null){
    		request.setAttribute("login", "login");
    	    return "modules/wlpt_front/admin/login";
    	}
    	if(shop.getShotName()==null||shop.getShotName().equals("")){
    		return "modules/wlpt_front/shop/list";
    	}
    	String gifttype ="";//礼品类型
    	String actitytype ="";//活动类型
    	String actitystatus = DataDic.ACTIVITY_STATUS_OPEN;//活动状态--开启的活动
        ShopVO shopVO=new ShopVO();
        if(shop.getShotName().equals("you_qi")){
        	shopVO.setShotName(shop.getShotName());
        	shopVO.setName("油气");
        	shopVO.setPrice("1");
        	gifttype = DataDic.ACTIVITYGIFT_TYPE_PETRO;
        	actitytype = DataDic.ACTIVITY_TYPE_PETRO;
        }
        if(shop.getShotName().equals("zd_coin")){
        	shopVO.setShotName(shop.getShotName());
        	shopVO.setName("卓币");
        	shopVO.setPrice("1");
        	gifttype = DataDic.ACTIVITYGIFT_TYPE_COIN;
        	actitytype = DataDic.ACTIVITY_TYPE_COIN;
        }
        //活动
        ActivityWxgift wxgift = new ActivityWxgift();
        ActivityWxinfo wxinfo = new ActivityWxinfo();
        wxgift.setGifttype(gifttype);//礼物类型
        wxgift.setCurrenttime(new Date());//当前时间
        wxinfo.setIseffective(actitystatus);//活动状态
        wxinfo.setType(actitytype);//活动类型
        wxgift.setWxinfo(wxinfo);
        //获取活动
        List<ActivityWxgift> giftlst = activityBiz.findWxgiftList(wxgift);
        if(giftlst.size()>0){
        	wxgift = giftlst.get(0);
        	model.addAttribute("wxgift",wxgift);
        }
        
        model.addAttribute("shopVO",shopVO);
    	return "modules/wlpt_front/shop/gas_buy";
    
    }

	/**
	 * 保险购买链接
	 * 内部
	 */
	@RequestMapping(value = "buyInsur")
	public String buyInsur(ShopVO shop,HttpServletRequest request, HttpServletResponse response,Model model){

		User user=UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		if(user.getId()==null){
			request.setAttribute("login", "login");
			return "modules/wlpt_front/admin/login";
		}
		if(shop.getShotName()==null||shop.getShotName().equals("")){
			return "modules/wlpt_front/shop/list";
		}

		return "modules/wlpt_front/shop/insurance_buy";

	}

	/**
	 * 保险购买详情
	 * 内部
	 */
	@RequestMapping(value = "buyInsurDetail")
	public String buyInsurDetail(String id,HttpServletRequest request, HttpServletResponse response,Model model){

		User user=UserUtils.getUser();
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		if(user.getId()==null){
			request.setAttribute("login", "login");
			return "modules/wlpt_front/admin/login";
		}
		if(StringUtils.isBlank(id)){
			return "modules/wlpt_front/shop/insurance_buy";
		}
		UserInsurancelist insurlist = userInsurancelistService.get(id);
		model.addAttribute("insurlist", insurlist);
		model.addAttribute("user", user);
		return "modules/wlpt_front/shop/insuranceBuy_detail";

	}

}
