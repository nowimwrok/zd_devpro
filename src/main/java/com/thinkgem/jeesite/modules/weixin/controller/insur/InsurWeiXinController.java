package com.thinkgem.jeesite.modules.weixin.controller.insur;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.insur.InsurBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ShopVO;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;

/**
 * 我的保单Controller
 *
 * @author
 * @version 2017-01-06
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/insur")
public class InsurWeiXinController  extends BaseController {

	@Autowired
	private InsurBiz insurBiz;
	
	@Autowired
	private UserInsuranceService userInsuranceService;
	
	@ResponseBody
	@RequestMapping(value="list")
	public Object list(UserInsurance userInsurance, Page page,Model model){
		User user = UserUtils.getUser();
		if(StringUtils.isBlank(user.getId())){
			return null;
		}
		userInsurance.setUser(user);
		Page<UserInsurance> dest = insurBiz.findPage(page, userInsurance);
	    for (UserInsurance insur : dest.getList()) {
	        	insur.setStatusInt(Integer.parseInt(insur.getStatus()));
	        	insur.setStatus(DictUtils.getDictLabel(insur.getStatus(), "insurance_status", ""));
	            
	    }
		return page;
	}
	
	@RequestMapping(value="input")
	public String input(@RequestParam(value="id",required= false)String id,Model model){
		if( id != null){
			UserInsurance userInsurance = insurBiz.get(id);
			model.addAttribute("model", userInsurance);
		}
		return "modules/wx_front/insur/policy_info";
	}
	
	@RequestMapping(value="save")
	public String save(UserInsurance userInsurance,HttpServletRequest request,RedirectAttributes model){
		UserInsurance dest = null;
		
		String id = userInsurance.getId();
		if(StringUtils.isBlank(id)){
			
		}else{
			
		}
		addMessage(model, "保存成功");
		return "redirect:"+Global.getWeixinPath() +"/weixin/insur/toInsur";
	}
	
	@RequestMapping(value="remove")
	public String remove(UserInsurance userInsurance,RedirectAttributes model){
		
		addMessage(model, "删除成功");
		return "redirect:"+Global.getWeixinPath() +"/weixin/insur/toInsur";
	}
	
	@RequestMapping("toInsur")
	public String toInsur(){	
		
		return "modules/wx_front/insur/insurance_order_list";
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
		model.addAttribute("user", user);
		model.addAttribute("shop", shop);
		model.addAttribute("userInsurance", insurance);
        return "modules/wx_front/insur/insurance_payonline";
	}
}
