package com.thinkgem.jeesite.modules.weixin.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.bankBiz.UserBankBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.user.AccountBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.AccountBranchBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;

/**
 * 微信用户银行卡Controller
 *
 * @author zengyujia
 * @version 2016-08-25
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/userbankinfo")
public class UserBankinfoWeiXinController extends BaseController {
	@Autowired
	private UserBiz userBiz;
	@Autowired
	private UserBankBiz userBankBiz;

	@RequestMapping(value = { "toBankList", "" })
	public String toBankList(){
		return "modules/wx_front/pay/bankList";
	}
	
	/**
	 * 绑定银行卡
	 * 
	 * @return
	 */
	@RequestMapping(value = { "toBindBankCard", "" })
	public String toBindBankCard(UserBankinfo userbankinfo, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		model.addAttribute("loginUser",UserUtils.getUser());
        model.addAttribute("userBankinfo",new UserBankinfo());
		return "modules/wx_front/pay/bind_bankCard";
	}
	
	/**
	 * 银行卡list
	 * 
	 * @return
	 */
	@ResponseBody
    @RequestMapping(value = "bankList")
    public Object bankList(UserBankinfo userBankinfo){
        userBankinfo.setUser(UserUtils.getUser());
        List<UserBankinfo> bankList = userBankBiz.findBankList(userBankinfo);
        return new JSONPObject("callback", bankList);
    }
	
	/**
     * 设置默认方法
     * @param userBankinfo
     * @return
     */
    @RequestMapping(value = "isDefault")
    public ModelAndView isDefault(UserBankinfo userBankinfo){
    	List<UserBankinfo> bankList = userBankBiz.findBankList(userBankinfo);
        UserBankinfo ub = bankList.get(0);
        UserBankinfo newUserBankInfo=new UserBankinfo();
        newUserBankInfo.setUser(ub.getUser());
        List<UserBankinfo> bankList1 = userBankBiz.findBankList(newUserBankInfo);
        if (bankList1.size()>1){
            for (UserBankinfo u:bankList1){
                if (u.getIsdefault()==1){
                      u.setIsdefault(0);
                      userBankBiz.saveBank(u);
                }
            }
        }
        ub.setIsdefault(1);
        userBankBiz.saveBank(ub);
        return new ModelAndView("modules/wx_front/pay/bankList");
    }
    
    /**
     * 银行卡删除方法
     * @param userBankinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deteleBank")
    public ModelAndView deteleBank(UserBankinfo userBankinfo){
        List<UserBankinfo> bankList = userBankBiz.findBankList(userBankinfo);
        UserBankinfo ub = bankList.get(0);
        ub.setDelFlag(DataDic.DEL_FLAG_DELETE);
        userBankBiz.deteleBank(ub);
        if(ub.getIsdefault()==1){
        	UserBankinfo ubk=new UserBankinfo();
        	ubk.setUser(ub.getUser());
        	List<UserBankinfo> ubkList = userBankBiz.findBankList(ubk);
        	if(ubkList.size()>0){
        		ubk=ubkList.get(0);
        		ubk.setIsdefault(1);
        		userBankBiz.saveBank(ubk);
        	}
        }
        return new ModelAndView("modules/wx_front/pay/bankList");
    }
	
	/**
     * 银行卡绑定方法
     * @param userBankinfo
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "bankBind")
	public Object bankBind(UserBankinfo userBankinfo, Model model){
		Object result=userBankBiz.bankBind(userBankinfo);
		return new JSONPObject("callback", result);
	}

	/**
	 * 绑定银行卡信息
	 * 
	 * @param userbankinfo
	 * @param cashpassword
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveBankCard")
	public Object saveBankCard(UserBankinfo userbankinfo, String cashpassword, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		// 处理绑定银行卡信息
		return userBiz.saveBankCard(userbankinfo, cashpassword);
	}

	/**
	 * 验证提现密码
	 * 
	 * @param cashpassword
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkCashPwd")
	public Object checkCashPwd(String cashpassword) {
		return userBiz.checkCashPwd(cashpassword);
	}
	/**
     * 根据卡号获取银行名称
     * @param userBankinfo
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "getNameByCard")
	public Object getNameByCard(String cardNo, Model model){
        
        return userBankBiz.getNameByCard(cardNo);
		
	}
	
	   /**
	    * 获取账户系统银行卡信息列表
	    * @param keyword
	    * @param pageNo
	    * @param pageSize
	    * @param model
	    * @return
	    */
	    @ResponseBody
	    @RequestMapping(value = "getBankinfoList")
	    public Object getBankinfoList(String keyword, String pageNo, String pageSize, Model model) {
	        
	        //
	        Page<AccountBankinfo> page = userBankBiz.findBankinfoPage(keyword, pageNo, pageSize);
	        
	        return page;
	    }
	    
	    /**
	     * 获取账户系统银行支行信息列表
	     * @param name
	     * @param keyword
	     * @param pageNo
	     * @param pageSize
	     * @param model
	     * @return
	     */
	     @ResponseBody
	     @RequestMapping(value = "getBranchBankinfoList")
	     public Object getBranchBankinfoList(String name,String keyword, String pageNo, String pageSize, Model model) {
	         
	         //
	         Page<AccountBranchBankinfo> page = userBankBiz.findBranchBankinfoPage(name,keyword, pageNo, pageSize);
	         
	         return page;
	     }
	
}
