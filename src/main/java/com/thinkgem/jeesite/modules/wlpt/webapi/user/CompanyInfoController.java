package com.thinkgem.jeesite.modules.wlpt.webapi.user;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserCompanyBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanyService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanypictureService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * Created by ForHeart on 16/8/13.
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/company")
public class CompanyInfoController extends BaseController {
	 @Autowired
	 private UserCompanyBiz userCompanyBiz;

	/**
     * 到修改企业信息页面
     * @param userCompany
     * @param request
     * @param response
     * @param model
     * @param url
     * @return
     */
    @RequestMapping(value = {"company_info", ""})
    public String companyinfo(UserCompany  userCompany,String url,HttpServletRequest request, HttpServletResponse response, Model model) {
    	//获取企业信息
    	userCompany = userCompanyBiz.getuserCompanyInfo(userCompany);
        model.addAttribute("userCompany", userCompany);
        if(Tools.IsNullOrWhiteSpace(url)){
        	url="enterprise_info";
        }
        //return "modules/wlpt_front/user/"+url;	
        return "modules/user_front/user/"+url;
    }
    
    @ResponseBody
    @RequestMapping(value = "saveUserCompany")
    public Object saveUserCompany(UserCompany  userCompany,String type, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
    	int state = userCompanyBiz.saveUserCompanyInfo(userCompany);
    	String message = "保存成功";
    	model.addAttribute("type", type);
    	if(state!=DataDic.RETURN_STATUS_NORMAL){
    		message ="保存失败";
    		
    	}
    	return this.getMapResult(state,message,userCompany);
    }
 
    /**
     * 企业信息添加或修改提交
     * @param userCompany
     * @param model
     * @param redirectAttributes
     * @return
     */
    /*@ResponseBody*/
    @RequestMapping(value = "save")
    public String save(UserCompany  userCompany,String url,Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
    	if(userCompany.getCompanysummary()!=null&&userCompany.getCompanysummary().length()>500){
    		model.addAttribute("msg","公司简介内容不能超过1000字");
    		return companyinfo(userCompany,url,request,response, model);
    	}
    	if(userCompany.getProductserver()!=null&&userCompany.getProductserver().length()>4000){
    		model.addAttribute("msg","产品服务内容不能超过4000字");
    		return companyinfo(userCompany,url,request,response, model);
    	}
    	int result = userCompanyBiz.saveUserCompanyInfo(userCompany);
    	
    	if(result!=DataDic.RETURN_STATUS_NORMAL){
    		model.addAttribute("msg","保存失败");
    		return companyinfo(userCompany,url,request,response, model);
    	}
    	model.addAttribute("msg","保存成功");
    	return companyinfo(userCompany,url,request,response, model);
    }
    
    /**
     * 企业信息添加或修改提交
     * @param userCompany
     * @param model
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveCompany")
    public Object saveCompany(UserCompany  userCompany,String url,Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
    	if(userCompany.getCompanysummary()!=null&&userCompany.getCompanysummary().length()>500){
    		model.addAttribute("msg","公司简介内容不能超过1000字");
    		return companyinfo(userCompany,url,request,response, model);
    	}
    	if(userCompany.getProductserver()!=null&&userCompany.getProductserver().length()>4000){
    		model.addAttribute("msg","产品服务内容不能超过4000字");
    		return companyinfo(userCompany,url,request,response, model);
    	}
    	int result = userCompanyBiz.saveUserCompanyInfo(userCompany);
    	
    	if(result!=DataDic.RETURN_STATUS_NORMAL){
    		return this.getMapResult(result,"保存失败", null);
    	}
    	return this.getMapResult(result,"保存成功", null);
    }
}
