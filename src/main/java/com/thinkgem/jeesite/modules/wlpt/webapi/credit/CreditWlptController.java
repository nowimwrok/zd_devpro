package com.thinkgem.jeesite.modules.wlpt.webapi.credit;

import java.util.HashMap;
import java.util.Map;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.creditBiz.CreditBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.integrity.IntegrityCarownerBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.integrity.IntegrityEnterpriseBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserCompanyBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserStatisticsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityEnterprise;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;

/**
 * 诚信档案
 *
 * @author 王铸
 * @version 2016-09-01
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/credit")
public class CreditWlptController extends BaseController{

	@Autowired
	private CreditBiz creditBiz;
	@Autowired
	private IntegrityEnterpriseBiz integrityEnterpriseBiz;
	@Autowired
	private IntegrityCarownerBiz integrityCarownerBiz;
	@Autowired
	private UserStatisticsBiz userStatisticsBiz;
	@Autowired
	private TradeBiz tradeBiz;
	@Autowired
	 private UserCompanyBiz userCompanyBiz;
	
	/**
     * 根据user获取诚信档案
     */
    @RequestMapping(value = "/getCreditInfo")
    public String getCreditInfo(Model model){
    	User user=UserUtils.getUser();
    	if(user==null || user.getId()==null){
    		return "modules/wlpt_front/admin/login";
    	}
    	if(user.getRole().getEnname().equals("enterprise")){
    		return companyCredit(user,model);
    	}else if(user.getRole().getEnname().equals("carowner")||user.getRole().getEnname().equals("goodsowner")){
    		return carCredit(user,model);
    	}else{
    		return null;
    	}
    }
	
	
	/**
	 * 车主诚信档案
	 * @param 诚信user
	 * @return
	 */
	@RequestMapping(value = "/carCredit")
	public String carCredit(User user , Model model){
		User caruser=UserUtils.get(user.getId());
		IntegrityCarowner integrityCarowner=new IntegrityCarowner();
		integrityCarowner.setUser(caruser);
		UserStatistics userStatistics=new UserStatistics();
		userStatistics.setUser(caruser);
		Orderinfo orderinfo=new Orderinfo();
		orderinfo.setBuyer(caruser);
		orderinfo.setOrderstatus("6");
	//	model.addAttribute("statisticsOwner", creditBiz.ownerBiz(caruser));
		model.addAttribute("complainttimes", tradeBiz.findList(orderinfo).size());
		model.addAttribute("userStatistics", userStatisticsBiz.getConditon(userStatistics));
		model.addAttribute("carowner", integrityCarownerBiz.findCarowner(integrityCarowner));
		model.addAttribute("ratingscale", creditBiz.ratingscaleBiz(caruser));
		model.addAttribute("user", caruser);
		return "modules/wlpt_front/user/car_home";
	}
	
	/**
	 * 获取用户评价
	 * @param 诚信user
	 * @return
	 */
	@RequestMapping(value = "/getComment")
	@ResponseBody
	public Object getShopEvaluation(User user,Model model) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("commentlist", creditBiz.findTradeComment(user));
			return new JSONPObject("callback", map);
	}
	/**
	 * 企业诚信
	 * @param 诚信user
	 * @return
	 */
	@RequestMapping(value = "/CompanyCredit")
	public String companyCredit(User user , Model model){
		User caruser=UserUtils.get(user.getId());
		IntegrityEnterprise integrityEnterprise=new IntegrityEnterprise();
		integrityEnterprise.setUser(caruser);
		UserStatistics userStatistics=new UserStatistics();
		userStatistics.setUser(caruser);
		Orderinfo orderinfo=new Orderinfo();
		orderinfo.setBuyer(caruser);
		orderinfo.setOrderstatus("6");
	//	model.addAttribute("statisticsOwner", creditBiz.ownerBiz(caruser));
		model.addAttribute("complainttimes", tradeBiz.findList(orderinfo).size());
		model.addAttribute("userStatistics", userStatisticsBiz.getConditon(userStatistics));
		model.addAttribute("ratingscale", creditBiz.ratingscaleBiz(caruser));
		model.addAttribute("enterprise", integrityEnterpriseBiz.findEnterprise(integrityEnterprise));
		model.addAttribute("enterprise", integrityEnterpriseBiz.findEnterprise(integrityEnterprise));
		model.addAttribute("userCompany",  userCompanyBiz.getompanyInfo(caruser.getUserinfo().getUserCompany().getId()));
		model.addAttribute("user", caruser);
		return "modules/wlpt_front/user/company_home";
	}
    /**
     * 获取图片
     *  @param UserCompanypicture
     */
    @ResponseBody
    @RequestMapping(value = "/getHonor", produces = "application/json;charset=UTF-8")
    public Object getHonor(UserCompanypicture picture,Model model) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("honors", creditBiz.honorsBiz(picture));
    	return new JSONPObject("callback", map);
    }
    /**
     * 获取图片
     * @param IntegrityEnterprise
     */
    @ResponseBody
    @RequestMapping(value = "/getEnterprise", produces = "application/json;charset=UTF-8")
    public Object getEnterprise(IntegrityEnterprise integrityEnterprise,Model model) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("honors", creditBiz.enterprise(integrityEnterprise));
    	return new JSONPObject("callback", map);
    }
    
    /**
     * 获取图片
     * @param IntegrityCarowner
     */
    @ResponseBody
    @RequestMapping(value = "/getCarOwner", produces = "application/json;charset=UTF-8")
    public Object getCarOwner(IntegrityCarowner integrityCarowner,Model model) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("honors", creditBiz.carowner(integrityCarowner));
    	return new JSONPObject("callback", map);
    }
    
    /**
     * 获取诚信档案
     * @param 
     */
    @RequestMapping(value = "/infoCredit")
    public String infoCredit(Model model){
    	User user = UserUtils.getUser();
    	if(user.getId()==null){
    		return "modules/wlpt_front/admin/login";
    	}
    	if(user.getRole().getEnname().equals("enterprise")){
    		return companyCredit(user,model);
    	}else if(user.getRole().getEnname().equals("carowner")){
    		return carCredit(user,model);
    	}else{
    		return "modules/wlpt_front/admin/index";
    	}
    }
    
    /**
     * 根据user获取诚信档案
     * @param 诚信user
     */
    @ResponseBody
    @RequestMapping(value = "/getCredit")
    public String getCredit(User user,Model model){
    	user=UserUtils.getUserById(user.getId());
    	if(user==null){
    		return "0";
    	}
    	if(user.getRole().getEnname().equals("enterprise")){
    		return "1";
    	}else if(user.getRole().getEnname().equals("carowner")){
    		return "2";
    	}else{
    		return "3";
    	}
    }
    
    /**
     * 根据user获取诚信档案
     * @param 诚信user
     */
    @RequestMapping(value = "/getCreditByUser")
    public String getCreditByUser(User user,Model model){
    	user=UserUtils.getUserById(user.getId());
    	if(user==null){
    		return null;
    	}
    	if(user.getRole().getEnname().equals("enterprise")){
    		return companyCredit(user,model);
    	}else if(user.getRole().getEnname().equals("carowner")||user.getRole().getEnname().equals("goodsowner")){
    		return carCredit(user,model);
    	}else{
    		return null;
    	}
    }
}
