package com.thinkgem.jeesite.modules.wlpt.biz.userBiz;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanyService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanypictureService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * 企业信息
 *
 * @author 曾煜佳
 * @version 2016-08-15
 */
@Service(value = "usercompanyBiz")
@Transactional(readOnly = true)
public class UserCompanyBiz {
	@Autowired
	 private WlptUserService wlptUserService;
	 
	 @Autowired
	 private UserCompanypictureService userCompanypictureService;
	 
	 @Autowired
	 private UserCompanyService userCompanyService;
	 
	 @Autowired
	 private UserinfoService userinfoService;
	 /**
	  * 添加或修改企业信息
	  * @param userCompany
	  * @return
	  */
	 @Transactional(readOnly = false)
	 public int saveUserCompanyInfo(UserCompany userCompany){
		 
		 int result = DataDic.RETURN_STATUS_NORMAL;
		 
		 try {
			 //判断企业id是否有值
			 if(Tools.IsNullOrWhiteSpace(userCompany.getId())){
		    		userCompany.setId(IdGen.uuid());
		    		userCompany.setIsNewRecord(true);
		    	}
			 	//添加或修改图片
		    	if(userCompany.getUsercompanypicture()!=null){
		    		//获取提交的图片信息
		    		UserCompanypicture ucp = userCompany.getUsercompanypicture();
		    		ucp.setUserCompany(userCompany);
		    		if(Tools.IsNullOrWhiteSpace(ucp.getId())){
		    			ucp.setId(IdGen.uuid());
		    			ucp.setIsNewRecord(true);
		    		}
		    		userCompanypictureService.save(ucp);//保存图片信息
		    	}
		    	
		    	if(!Tools.IsNullOrWhiteSpace(userCompany.getCompanysummary())){
		    		userCompany.setCompanysummary(Jsoup.parse(userCompany.getCompanysummary()).text());
		    	}
		    	if(!Tools.IsNullOrWhiteSpace(userCompany.getProductserver())){
		    		userCompany.setProductserver(Jsoup.parse(userCompany.getProductserver()).text());
		    	}
		    	userCompanyService.save(userCompany);//保存企业信息
		    	//保存公司数据到用户信息表
		    	if(StringUtils.isNoneBlank(UserUtils.getUser().getUserinfo().getId())){
		    		Userinfo userinfo = new Userinfo();
		    		userinfo.setId(UserUtils.getUser().getUserinfo().getId());
		    		userinfo.setUserCompany(userCompany);
		    		userinfo.setCompanyname(userCompany.getCompanyname());
		    		userinfoService.save(userinfo);
		    	}
		    	
		} catch (Exception e) {
			result = DataDic.RETURN_STATUS_SYSBUG;
			e.printStackTrace();
		}
		 return result;
	 }
	 
	 /**
	  * 获取企业信息
	  * @param userCompany
	  * @return
	  */
	 public UserCompany getuserCompanyInfo(UserCompany  userCompany){
		User user= UserUtils.getUser();
        if(user.getUserCompany()!=null){
        	userCompany = userCompanyService.get(user.getUserCompany().getId());
        }
        //判断图片信息是否为空	
        if(userCompany==null){
        	userCompany = new UserCompany();
        	userCompany.setUsercompanypicture(new UserCompanypicture());
        }else{
        	//实例化一个图片信息
        	UserCompanypicture ucp = new UserCompanypicture();
        	ucp.setUserCompany(userCompany);
        	ucp = userCompanypictureService.findPicture(ucp);//获取图片信息
        	userCompany.setUsercompanypicture(ucp!=null?ucp:new UserCompanypicture());
        }
        return userCompany;
	}
	 
	 /**
	  * 获取企业信息
	  * @param userCompany
	  * @return
	  */
	 public UserCompany getompanyInfo(String companyid){
		UserCompany userCompany = new UserCompany();
        if(!Tools.IsNullOrWhiteSpace(companyid)){
        	userCompany = userCompanyService.get(companyid);
        }
        //判断图片信息是否为空	
        if(userCompany==null){
        	userCompany = new UserCompany();
        	userCompany.setUsercompanypicture(new UserCompanypicture());
        }else{
        	//实例化一个图片信息
        	UserCompanypicture ucp = new UserCompanypicture();
        	ucp.setUserCompany(userCompany);
        	ucp = userCompanypictureService.findPicture(ucp);//获取图片信息
        	userCompany.setUsercompanypicture(ucp!=null?ucp:new UserCompanypicture());
        }
        return userCompany;
	}
}
