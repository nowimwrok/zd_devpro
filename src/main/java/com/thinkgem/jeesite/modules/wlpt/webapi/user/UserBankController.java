package com.thinkgem.jeesite.modules.wlpt.webapi.user;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.bankBiz.UserBankBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.user.AccountBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.AccountBranchBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 用户银行卡
 * Created by 刘欣
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/user/userBank")
public class UserBankController extends BaseController {

	@Autowired
	private UserBankBiz userBankBiz;


    /**
     * 银行卡绑定页
     * @param model
     * @return
     */
	@RequestMapping(value = "toBankbind")
	public String toBankbind( Model model){
		User user = UserUtils.getUser();
        if (user.getId() == null) {
        	return "modules/wlpt_front/admin/login";
        }
        model.addAttribute("loginUser",user);
        model.addAttribute("userBankinfo",new UserBankinfo());
        //return "modules/wlpt_front/user/bankbind";
        return "modules/user_front/finance/bank_bind";
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
     * 根据卡号获取银行名称
     * @param cardNo
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "getNameByCard")
	public Object getNameByCard(String cardNo, Model model){
        
        return userBankBiz.getNameByCard(cardNo);
		
	}

    /**
     * 银行卡管理页
     * @param model
     * @return
     */
    @RequestMapping(value = "userBank")
    public String index( Model model){
        User user = UserUtils.getUser();
        if (user.getId() == null) {
            return "modules/wlpt_front/admin/login";
        }
        return "modules/user_front/finance/userBank";
    }

    @ResponseBody
    @RequestMapping(value = "bankList")
    public Object bankList(UserBankinfo userBankinfo){
        User user = UserUtils.getUser();
        ///判断用户是否登录获取数据
        if (user == null) {
            return new JSONPObject("callback", null);
        }
        userBankinfo.setUser(user);
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
        return new ModelAndView("modules/user_front/finance/userBank");
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
        return new ModelAndView("modules/user_front/finance/userBank");
    }
    
    @RequestMapping(value = "toDelBankcard")
    public String toDelBankCard(UserBankinfo userBankinfo,Model model){
    	List<UserBankinfo> list = userBankBiz.findBankList(userBankinfo);
    	
    	model.addAttribute("model", list.get(0));
    	//return "modules/wlpt_front/user/delbankcard";
        return "modules/user_front/finance/bank_del";
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
        page.setLength(2);
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
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
         page.setLength(2);
         model.addAttribute("page", page);
         return new JSONPObject("callback", page);
     }
}
