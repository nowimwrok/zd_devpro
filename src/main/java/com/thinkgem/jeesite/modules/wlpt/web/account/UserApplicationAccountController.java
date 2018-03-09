package com.thinkgem.jeesite.modules.wlpt.web.account;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserAccount;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserApplicationAccount;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserAccountService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserApplicationAccountService;

/**
 * 会员账户申请Controller
 * @author wz
 * @version 2017-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userApplicationAccount")
public class UserApplicationAccountController extends BaseController {

	@Autowired
	private UserApplicationAccountService userApplicationAccountService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private UserAccountService userAccountService;
	
	@ModelAttribute
	public UserApplicationAccount get(@RequestParam(required=false) String id) {
		UserApplicationAccount entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userApplicationAccountService.get(id);
		}
		if (entity == null){
			entity = new UserApplicationAccount();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userApplicationAccount:view")
	@RequestMapping(value = "list")
	public String list(UserApplicationAccount userApplicationAccount, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserApplicationAccount> page = userApplicationAccountService.findPage(new Page<UserApplicationAccount>(request, response), userApplicationAccount); 
		model.addAttribute("page", page);
		return "modules/wlpt/sysAccount/userApplicationAccountList";
	}

	@RequiresPermissions("wlpt:user:userApplicationAccount:view")
	@RequestMapping(value = "form")
	public String form(UserApplicationAccount userApplicationAccount, Model model) {
		model.addAttribute("userApplicationAccount", userApplicationAccount);
		return "modules/wlpt/sysAccount/userApplicationAccountForm";
	}

	@RequiresPermissions("wlpt:user:userApplicationAccount:edit")
	@RequestMapping(value = "save")
	public String save(UserApplicationAccount userApplicationAccount,@RequestParam(required=true)String target, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userApplicationAccount)){
			return form(userApplicationAccount, model);
		}
		User nUser=new User();
		nUser.setPhone(target);
		User nCondition = UserUtils.getByCondition(nUser);
		if(nCondition==null){
			model.addAttribute("message", "绑定用户不存在");
		}else if(StringUtils.isNotBlank(nCondition.getMemberId())){
			model.addAttribute("message", "绑定用户已经绑定memberID");
		}else{
			AccountUtils utils = new AccountUtils();
			try{
			  JSONObject json = (JSONObject) utils.memberApplication(userApplicationAccount.getType(), userApplicationAccount.getName(), userApplicationAccount.getIdcard(), "", userApplicationAccount.getBizlicenceno(), "", userApplicationAccount.getLegalname(), userApplicationAccount.getLinkman(), userApplicationAccount.getLinkmobile(), userApplicationAccount.getLinkaddress());
			  if(json==null){
				  model.addAttribute("message", "链接异常");
			  }else{
				  if("200".equals(json.getString("status"))){
			    		JSONObject body=(JSONObject) json.get("body");
			    		String applyId=body.getString("applyId");
			    		String accountStatus=body.getString("accountStatus");
			    		userApplicationAccount.setApplyid(applyId);
			    		userApplicationAccount.setAccountStatus(accountStatus);
			    		userApplicationAccount.setIsBind("0");
			    		userApplicationAccount.setUser(nCondition);
			    		userApplicationAccountService.save(userApplicationAccount);
			    		addMessage(redirectAttributes, "申请开户成功");
			    		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userApplicationAccount/list?repage";
					}else{
						model.addAttribute("message", "申请开户失败，失败原因："+json.getString("message"));
					}
			  }
			}catch(Exception e){
				model.addAttribute("message", "链接异常");
			}
		}
		return form(userApplicationAccount, model);
	}
	
	/**
     * 开户状态查询
     */
	@RequestMapping(value = "memberApplicationInfo")
    public String memberApplicationInfo(@RequestParam(required=true)String applyId,Model model) {
		AccountUtils utils = new AccountUtils();
		try{
			JSONObject json = (JSONObject) utils.memberApplicationInfo(applyId);
			if(json==null){
				model.addAttribute("message", "链接异常");
			}else{
				if("200".equals(json.getString("status"))){
		    		JSONObject body=(JSONObject) json.get("body");
		        	model.addAttribute("result", body);
			    	UserApplicationAccount userApplicationAccount=new UserApplicationAccount();
			    	userApplicationAccount.setApplyid(applyId);
			    	userApplicationAccount=userApplicationAccountService.findByCondition(userApplicationAccount);
			    	if(userApplicationAccount!=null){
			    		//userApplicationAccount.setAccountStatus(body.getString("accountStatus"));
				    	//userApplicationAccountService.save(userApplicationAccount);//更新申请记录审核状态
				    	model.addAttribute("userApplicationAccount", userApplicationAccount);
				    	return "modules/wlpt/sysAccount/userApplicationAccountInfo";
			    	}else{
			    		model.addAttribute("message", "查询失败，失败原因："+"申请记录不存在");
			    	}
				}else{
					model.addAttribute("message", "查询失败，失败原因："+json.getString("message"));
				}
			}
		}catch(Exception e){
			model.addAttribute("message", "链接异常");
		}
		return null;
    }
	
	/**
     * 绑定memberID到平台用户
     */
	@RequestMapping(value = "bindUserAccount")
	public String bindUserAccount(@RequestParam(required=true)String memberId, @RequestParam(required=true)String target,Model model, RedirectAttributes redirectAttributes) {
		AccountUtils utils = new AccountUtils();
		try{
			JSONObject json = (JSONObject) utils.memberList(memberId, "0");
			if(json==null){
				model.addAttribute("message", "链接异常");
			}else{
				if(!"200".equals(json.getString("status"))){
		    		model.addAttribute("message", json.getString("message"));
				}else{
					User mUser=new User();
					mUser.setMemberId(memberId);
					User byCondition = UserUtils.getByCondition(mUser);
					if(byCondition!=null){
						model.addAttribute("message", "memberID已经绑定:"+byCondition.getPhone());
					}else{
						User nCondition = UserUtils.getByPhone(target);
						if(nCondition==null){
							model.addAttribute("message", "用户"+target+"不存在");
						}else if(StringUtils.isNotBlank(nCondition.getMemberId())){
							model.addAttribute("message", "用户"+nCondition.getPhone()+"已绑定有memberID");
						}else{
							nCondition.setMemberId(memberId);
							systemService.saveUser(nCondition);//用户管理memberId
							JSONObject body=(JSONObject) json.get("body");
					    	JSONArray array = body.getJSONArray("records");
					    	List list = array.subList(0, array.size());
					    	JSONObject json1=(JSONObject) list.get(0);
					    	JSONArray array1 = json1.getJSONArray("slaveAccounts");
					    	UserAccount userAccount=new UserAccount();
					    	userAccount.setMemberId(memberId);// 会员id
					    	for(Object obj : array1){
					    		JSONObject objJSON = (JSONObject)obj;
					    		if("1".equals(objJSON.getString("accountType"))){
					    			userAccount.setRepaymentId(objJSON.getString("accountId"));// 还款户id
					    		}else if("2".equals(objJSON.getString("accountType"))){
					    			userAccount.setBorrowerId(objJSON.getString("accountId"));	// 借款户id	
					    		}else if("3".equals(objJSON.getString("accountType"))){
					    			userAccount.setDirectpaymentId(objJSON.getString("accountId"));		// 定向支付户id
					    		}else if("4".equals(objJSON.getString("accountType"))){
					    			userAccount.setWalletId(objJSON.getString("accountId"));		// 电子钱包账户id
					    		}else if("5".equals(objJSON.getString("accountType"))){
					    			userAccount.setSupervisorId(objJSON.getString("accountId"));		// 监管户
					    		}else if("6".equals(objJSON.getString("accountType"))){
					    			userAccount.setInternalId(objJSON.getString("accountId"));		// 内部户
					    		}
					    	}
					    	userAccountService.save(userAccount);//保存各种账户id
					    	addMessage(redirectAttributes, "绑定memberID到平台用户成功");
					    	return "redirect:"+Global.getAdminPath()+"/wlpt/account/memberlist?repage";
						}
					}
				}
			}
		}catch(Exception e){
			model.addAttribute("message", "链接异常");
		}
    	return goBindAccount(model);
	}
	
	/**
     * go绑定页面
     */
	@RequestMapping(value = "goBindAccount")
    public String goBindAccount(Model model) {
    	return "modules/wlpt/sysAccount/userAccountSet";
    }
}