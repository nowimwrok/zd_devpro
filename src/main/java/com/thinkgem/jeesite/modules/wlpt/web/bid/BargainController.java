package com.thinkgem.jeesite.modules.wlpt.web.bid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.thinkgem.jeesite.common.web.BaseController;
@Controller
@RequestMapping(value = "${frontPath}/wlpt/bargain")
public class BargainController extends BaseController{
	
	@RequestMapping(value = {"list", ""})
    public String bargainlist(Model model) {
    	 
         return "modules/wlpt_front/bid/bargain_list";
    }
	@RequestMapping(value = {"orderlist", ""})
    public String orderlist(Model model) {
    	 
         return "modules/wlpt_front/bid/orderlist";
    }
	@RequestMapping(value = {"goodslist", ""})
    public String goodslist(Model model) {
    	 
         return "modules/wlpt_front/bid/goods_list";
    }
	@RequestMapping(value = {"bidsSeachlist", ""})
    public String bids_search(Model model) {
    	 
         return "modules/wlpt_front/bid/bids_search";
    }
	@RequestMapping(value = {"goBidding", ""})
    public String goBidding(Model model) {
    	 
         return "modules/wlpt_front/bid/bargain_procee";
    }
}
