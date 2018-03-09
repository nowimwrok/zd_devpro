package com.thinkgem.jeesite.modules.wlpt.webapi.integrity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityExchaneBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandardlog;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.IntegrityRecordVO;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.integrity.IntegrityCarownerBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.integrity.IntegrityEnterpriseBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserCompanyBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityEnterprise;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;

/**
 * Created by ForHeart on 16/8/20
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/integrity")
public class IntegrityController  extends BaseController{

	@Autowired
	private IntegrityCarownerBiz integrityCarownerBiz;
	
	@Autowired
	private IntegrityEnterpriseBiz integrityEnterpriseBiz;
	
	@Autowired
	private UserCompanyBiz userCompanyBiz;

	@Autowired
	private IntegrityBiz integrityBiz;

	@Autowired
	private IntegrityExchaneBiz integrityExchaneBiz;
	
	/**
	 * 去诚信页面
	 */
	@RequestMapping(value = {"goIntegrity_Info", ""})
	public String goIntegrityInfo(IntegrityEnterprise  integrityEnterprise,IntegrityCarowner integrityCarowner,HttpServletRequest request, HttpServletResponse response, Model model) {
		
		User user = UserUtils.getUser();
		try {
		
			if (user.getRole() != null
					&& user.getRole().getEnname().equals("carowner")) {
				return goCarWnerInfo(integrityCarowner,request,response, model);
				// 企业
			} else {
				//获取企业诚信信息
				return goEnterpriseInfo(integrityEnterprise,request,response, model);
			}

		} catch (Exception e) {
			logger.error(e.toString(), e);
		}	
		return "";
	}
	
	/**
	 * 获取企业诚信信息
	 * @param integrityEnterprise
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
    @RequestMapping(value = {"goEnterprise_Info", ""})
    public String goEnterpriseInfo(IntegrityEnterprise  integrityEnterprise,HttpServletRequest request, HttpServletResponse response, Model model) {
    	//获取企业诚信信息
    	integrityEnterprise =integrityEnterpriseBiz.getEnterpriseInfo(integrityEnterprise);
    	UserCompany  userCompany=new UserCompany();
    	userCompany.setUser(integrityEnterprise.getUser());
    	userCompany = userCompanyBiz.getuserCompanyInfo(userCompany);
    	model.addAttribute("userCompany", userCompany);
        model.addAttribute("integrityEnterprise", integrityEnterprise);
        //return "modules/wlpt_front/integrity/integrity_enterprise_info";
        return "modules/user_front/integrity/integrity_enterprise_info";
    }
    /**
     * 获取车主诚信
     * @param integrityCarowner
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"goCarWner_Info", ""})
    public String goCarWnerInfo(IntegrityCarowner integrityCarowner,HttpServletRequest request, HttpServletResponse response, Model model) {
    	//获取车主诚信信息
    	integrityCarowner = integrityCarownerBiz.getCarownerInfo(integrityCarowner);
        model.addAttribute("integrityCarowner", integrityCarowner);
        //return "modules/wlpt_front/integrity/integrity_carowner_info";	
        return "modules/user_front/integrity/integrity_carowner_info";
    }
	
    /**
	 * 获取企业诚信资质信息
	 * @param integrityEnterprise
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
    @RequestMapping(value = {"goEnterprise_Picture", ""})
    public String goEnterprisePicture(IntegrityEnterprise  integrityEnterprise,HttpServletRequest request, HttpServletResponse response, Model model) {
    	//获取企业诚信信息
    	integrityEnterprise = integrityEnterpriseBiz.getEnterpriseInfo(integrityEnterprise);
    	model.addAttribute("integrityEnterprise", integrityEnterprise);
        //return "modules/wlpt_front/integrity/integrity_enterprise_picture";
        return "modules/user_front/integrity/integrity_enterprise_picture";
    }
    /**
     * 获取车主诚信图片信息
     * @param integrityCarowner
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"goCarWner_Picture", ""})
    public String goCarWnerPicture(IntegrityCarowner integrityCarowner,HttpServletRequest request, HttpServletResponse response, Model model) {
    	//获取车主诚信信息
    	integrityCarowner = integrityCarownerBiz.getCarownerInfo(integrityCarowner);
        model.addAttribute("integrityCarowner", integrityCarowner);
        //return "modules/wlpt_front/integrity/integrity_carowner_picture";	
        return "modules/user_front/integrity/integrity_carowner_picture";
    }
	
    
    /**
     * 保存企业诚信信息
     * @param integrityEnterprise
     * @param model
     * @param redirectAttributes 
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "entrprseInfoSave")
    public Object entrprseInfoSave(IntegrityEnterprise  integrityEnterprise, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
    	int result = integrityEnterpriseBiz.saveEnterpriseInfo(integrityEnterprise);//保存企业诚信信息
    	String message = "保存成功";
    	if(result!=DataDic.RETURN_STATUS_NORMAL){
    		message ="保存失败";
    	}
    	return this.getMapResult(result,message,integrityEnterprise);
		//return goEnterpriseInfo(integrityEnterprise,request,response, model);
    }
    /**
     * 保存企业诚信图片
     * @param integrityEnterprise
     * @param model
     * @param redirectAttributes
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "entrprsePictureSave")
    public String entrprsePictureSave(IntegrityEnterprise  integrityEnterprise, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
    	int result = integrityEnterpriseBiz.saveEnterpriseInfo(integrityEnterprise);//保存企业诚信信息
    	model.addAttribute("msg","保存成功");
    	if(result!=DataDic.RETURN_STATUS_NORMAL){
    		model.addAttribute("msg","保存失败");
    	}
    	
		return goEnterprisePicture(integrityEnterprise,request,response, model);
    }
 
    /**
     * 保存车主诚信信息
     * @param integrityCarowner
     * @param model
     * @param redirectAttributes
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "carownerInfoSave")
    public Object carownerInfoSave(IntegrityCarowner integrityCarowner, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
    	int result = integrityCarownerBiz.saveCarownerInfo(integrityCarowner);//保存车主诚信信息
    	String message = "保存成功";
    	if(result!=DataDic.RETURN_STATUS_NORMAL){
    		message ="保存失败";
    	}
    	return this.getMapResult(result,message,integrityCarowner);
    }
    
    /**
     * 保存车主诚信信息
     * @param integrityCarowner
     * @param model
     * @param redirectAttributes
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "carownerPictureSave")
    public String carownerPictureSave(IntegrityCarowner integrityCarowner, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
    	int result =integrityCarownerBiz.saveCarownerInfo(integrityCarowner);//保存车主诚信信息
    	model.addAttribute("msg","保存成功");
    	if(result!=DataDic.RETURN_STATUS_NORMAL){
    		model.addAttribute("msg","保存失败");
    	}
    	
		return goCarWnerPicture(integrityCarowner,request,response, model);
    }


    //------------------------------------------------------------诚信积分----------------------------------------------

	/**
	 * 诚信积分
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"toIntegrityRecordInfo", ""})
	public String toIntegrityRecordInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		User curUser = UserUtils.getUser();
		if (curUser == null) {
			return "modules/wlpt_front/admin/login";
		}
		IntegrityRecordVO iRecordVO = new IntegrityRecordVO();
		iRecordVO.setUser(curUser);
		iRecordVO = integrityBiz.getSumPointvalueData(iRecordVO);
		model.addAttribute("iRecord",iRecordVO);
		return "modules/user_front/integrity/integrity_recordinfo";
	}

	/**
	 * 获取积分
	 * @param integrityStandardlog
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getIntegrityRecordList")
	public Object getIntegrityRecordList(IntegrityStandardlog integrityStandardlog, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		//
		////获取当前用户
		User curUser = UserUtils.getUser();
		if (curUser == null) {
			return null;
		}
		integrityStandardlog.setUser(curUser);
		// goods.setDatasource("0");
		Page<IntegrityStandardlog> page = integrityBiz.findPage(pg, integrityStandardlog);
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}
	
	
	@RequestMapping(value="exchangeIntegral")
	@ResponseBody
	public String exchangeIntegral(int integral) {
		return integrityExchaneBiz.exchangeIntegral(integral);
	}
	
}
