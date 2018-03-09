package com.thinkgem.jeesite.modules.weixin.controller.shop;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.activity.ActivityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.shop.ShopBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurancelist;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ShopVO;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsurancelistService;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by ForHeart on 2016/10/20.
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/shop")
public class ShopWeiXinController extends BaseController {
	@Autowired
    private ShopBiz shopBiz;
	
	@Autowired
    private ActivityBiz activityBiz;
	
	@Autowired
	private UserInsuranceService userInsuranceService;
	
	@Autowired
	private UserInsurancelistService userInsurancelistService;
    /**
     * 商城首页
     * @param model
     * @param openID
     * @return
     */
    @RequestMapping(value = { "index", "" })
    public String shop_index(Model model, String openID) {
    	User user=UserUtils.getUser();
		if(user.getId()==null){
			model.addAttribute("user",user);
		}else{
			model.addAttribute("isShowAt",true);
			User newuser = UserUtils.findUser(user);
			model.addAttribute("user",newuser);
		}
        return "modules/wx_front/shop/shop_index";
    }

    
    /***
     * 到购买页面
     *
     * @param 商品
     * @param model
     * @return
     */
    @RequestMapping(value = "toBuy")
    public String toBuy(ShopVO shop, HttpServletRequest request, HttpServletResponse response, Model model){
    	User user=UserUtils.getUser(true);
    	String gifttype ="";//礼品类型
    	String actitytype ="";//活动类型
    	String actitystatus = DataDic.ACTIVITY_STATUS_OPEN;//活动状态--开启的活动
        ShopVO shopVO=new ShopVO();
        if(shop.getShotName().equals("you_qi")){
        	shopVO.setShotName(shop.getShotName());
        	shopVO.setName("油气");
        	shopVO.setPrice("100");
        }
        if(shop.getShotName().equals("zd_coin")){
        	shopVO.setShotName(shop.getShotName());
        	shopVO.setName("卓币");
        	shopVO.setPrice("1");
        }
        if(shop.getShotName().equals("you_qi")){
        	shopVO.setShotName(shop.getShotName());
        	shopVO.setName("油气");
        	shopVO.setPrice("100");
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

		List<ActivityAwardrecord> awlist = new ArrayList<>();
		if(shop.getShotName().equals("you_qi")){
			//活动
			ActivityWxgift gift = new ActivityWxgift();
			gift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_PETRO);//礼物类型
			ActivityAwardrecord aw = new ActivityAwardrecord();
			aw.setWxgift(gift);
			aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
			aw.setPhone(user.getPhone());
			awlist = activityBiz.awardrecordFindList(aw);
		}
		model.addAttribute("awlist",awlist);
		model.addAttribute("user",user);
        model.addAttribute("shopVO",shopVO);
        return "modules/wx_front/shop/sub_order";
    }
    
    
    
    @RequestMapping(value = { "finish", "" })
    public String sub_finish(Model model, String openID) {

        return "modules/wx_front/shop/sub_finish";
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
    
    
    //===========================================================保险=================================================
    /**
	 * 卓大商场保险详情
	 * 
	 * @return
	 */
	@RequestMapping(value = "insur_detail")
	public String insur_detail(String id,Model model) {
		User user=UserUtils.getUser();
		model.addAttribute("user", user);
		UserInsurancelist insurlist = userInsurancelistService.get(id);
		model.addAttribute("insurlist", insurlist);
        return "modules/wx_front/shop/insurance_details";
	}
	/**
	 * 卓大商场保险填写
	 * 
	 * @return
	 */
	@RequestMapping(value = "toinsur")
	public String toinsur(String id,HttpServletRequest request, HttpServletResponse response,Model model) {
		User user=UserUtils.getUser();
		UserInsurancelist insurlist = userInsurancelistService.get(id);
		model.addAttribute("insurlist", insurlist);
    	if(user.getId()==null){
    		request.setAttribute("login", "login");
    	    return "modules/wx_front/shop/insurance_details";
    	}
    	
		model.addAttribute("user", user);
        return "modules/wx_front/shop/insurance_form";
	}
	/***
     * 确认保险--新建单
     *
     * @param userInsurance
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveInsur")
	public Object saveInsur(UserInsurance userInsurance){
		return shopBiz.saveInsur(userInsurance);
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
		shop.setTotal(insurance.getInsurancefeel());
		shop.setShotName("zd_insur");
		User user=UserUtils.getUser();
		List<ActivityAwardrecord> awlist = new ArrayList<>();
		//活动
		ActivityWxgift gift = new ActivityWxgift();
		gift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_INSUR);//礼物类型
		ActivityAwardrecord aw = new ActivityAwardrecord();
		aw.setWxgift(gift);
		aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
		aw.setPhone(user.getPhone());
		awlist = activityBiz.awardrecordFindList(aw);
		model.addAttribute("awlist",awlist);
		model.addAttribute("user", user);
		model.addAttribute("shop", shop);
		model.addAttribute("userInsurance", insurance);
        return "modules/wx_front/shop/insurance_payonline";
	}
	
	/**
	 * 卓大商场支付成功
	 * 
	 * @return
	 */
	@RequestMapping(value = "topaysuccess")
	public String topaysuccess(Model model) {
          return "modules/wx_front/shop/paysuccess";
	}
	//*********************************************保险列表**************************************
	/**
	 * 保险列表
	 * @return
	 */
	@RequestMapping(value = "insur_list")
	public String toInsurance( Model model){
		User user=UserUtils.getUser();
		if(user.getId()==null){
			model.addAttribute("user",user);
		}else{
			model.addAttribute("isShowAt",true);
			User newuser = UserUtils.findUser(user);
			model.addAttribute("user",newuser);
		}
		return "modules/wx_front/shop/insurance_list";
	}
	
    /***
     * 获取保险品种列表
     * @param getInsuranceList实体
     * @param 当前页
     * @param 页大小
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
        
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
	
	
	
}
