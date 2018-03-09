package com.thinkgem.jeesite.modules.weixin.controller.bid;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BiddingBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserStatisticsService;

/**
 * 招标Controller
 *
 * @author fjc
 * @version 2016-08-24
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/bid")
public class BidWeiXinController {

	@Autowired
	private BiddingBiz biddingBiz;
	
	@Autowired
    private BidinfoService bidinfoService;
	
	@Autowired
    private BiddinginfoService biddinginfoService;
	
	@Autowired
	private UserStatisticsService userStatisticsService;
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
		Page<Bidinfo> page = biddingBiz.findPage(pg, bidinfo);
		for (Bidinfo b : page.getList()) {
			b.setBidstatus(DictUtils.getDictLabel(b.getBidstatus(), "bid_status", ""));
			b.getBiduser().setPointlevle(b.getBiduser().getUserinfo().getPointlevle());
		}

		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/**
     * 废标
     *
     * @param bidinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"repealBid", ""})
    public Object repealBid(Bidinfo bidinfo,Model model, RedirectAttributes redirectAttributes) {
        return biddingBiz.repealBid(bidinfo);
    }
	
	/***
	 * 去招标详情 --竞标
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toBidding")
	public String toBidding(@RequestParam(required = false) String id, Model model) {
		
		Bidinfo bid = biddingBiz.get(id);
		model.addAttribute("bidinfo", bid);
		return "modules/wx_front/bid/bid_details";
	}

	/**
	 * 竞标
	 * 
	 * @param bidinfo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "bidding")
	public Object Bidding(Biddinginfo biddinginfo, Model model) {
		return biddingBiz.bidding(biddinginfo);
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

		Page<Biddinginfo> page = biddingBiz.biddingFindPage(pg, biddinginfo);
		for (Biddinginfo b : page.getList()) {
			b.setBiddingstatus(DictUtils.getDictLabel(b.getBiddingstatus(), "bidding_status", ""));
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/**
	 * 去我的竞标列表
	 */
	@RequestMapping(value = "toMyBidding")
	public String myBidding(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/wx_front/bid/bidding_list";
	}

	/***
	 * 去我的竞标详情 --
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toBiddingDetails")
	public String toBiddingDetails(@RequestParam(required = false) String id, Model model) {
		Biddinginfo biddinginfo = biddingBiz.getBiddingDetail(id);
		model.addAttribute("bidding", biddinginfo);
		return "modules/wx_front/bid/bidding_details";
	}
	
	/**
     * 我的招标
     */
    @RequestMapping(value = "myBid")
    public ModelAndView mybid(ModelAndView mv) {
        User user = UserUtils.getUser(true);
        mv.addObject("loginUser", user);
        mv.setViewName("modules/wx_front/bid/bid_list");
        
        return mv;
    }
    /**
     * 去选标页面
     *
     * @param bidinfoId
     * @param mv
     * @return
     */
    @RequestMapping(value = "goSelect")
    public ModelAndView goSelect(String bidinfoId, ModelAndView mv) {
        if (StringUtils.isNotEmpty(bidinfoId)) {
            Bidinfo bidinfo = bidinfoService.get(bidinfoId);
            mv.addObject("bidinfo", bidinfo);
            mv.setViewName("modules/wx_front/bid/select_bid");
        } else {
        	User user = UserUtils.getUser(true);
            mv.addObject("loginUser", user);
            mv.setViewName("modules/wx_front/bid/bid_list");
        }
        return mv;
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
            Biddinginfo bidding = biddingBiz.getBiddingDetail(biddingId);
            mv.addObject("bidding", bidding);
            mv.addObject("bidinfo", bidinfo);
            mv.setViewName("modules/wx_front/bid/bid_notifys");
        } else {
        	User user = UserUtils.getUser(true);
            mv.addObject("loginUser", user);
            mv.setViewName("modules/wx_front/bid/bid_list");
        }
        return mv;
    }
    /***
	 * 去中标通知书
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "notifys")
	public String notifys(@RequestParam(required = false) String id, Model model) {
		Biddinginfo biddinginfo = biddingBiz.getBiddingDetail(id);
		model.addAttribute("bidding", biddinginfo);
		return "modules/wx_front/bid/bid_notifys";
	}
	
	/***
	 * 去招标详情
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toBiddinginfo")
	public String toBiddinginfo(@RequestParam(required = false) String id, Model model) {
		
		Bidinfo bid = bidinfoService.get(id);
		model.addAttribute("bidinfo", bid);
		model.addAttribute("bidstatus", DictUtils.getDictLabel(bid.getBidstatus(), "bid_status", ""));
		return "modules/wx_front/bid/bid_info";
	}

}
