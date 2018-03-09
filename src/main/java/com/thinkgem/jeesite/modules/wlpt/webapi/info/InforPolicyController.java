package com.thinkgem.jeesite.modules.wlpt.webapi.info;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BasePolicy;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseAdvertisementService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseCategoriesService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BasePolicyService;

/**
 * 政策公告Controller
 *
 * @author 曾煜佳
 * @version 2016-08-10
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/info/policy")
public class InforPolicyController extends BaseController{
	@Autowired
	private BasePolicyService basePolicyService;
	@Autowired
	private BaseCategoriesService basecategoriesService;
	
	//广告
	@Autowired
	private BaseAdvertisementService baseAdvertisementService;
		
	@ModelAttribute("basePolicy")
	public BasePolicy get(@RequestParam(required=false) String id) {
		BasePolicy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = basePolicyService.get(id);
		}
		if (entity == null){
			entity = new BasePolicy();
		}
		return entity;
	}
	
	
	/**
	 * 政策公告
	 * @param baseNews
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"index", ""})
	public String index(BasePolicy Policy, HttpServletRequest request, HttpServletResponse response, Model model) {
		//政策公告分类
		model.addAttribute("baseCategories", basecategoriesService.getCategories(DataDic.POLICY_TYPE));
		//获取广告信息
		model.addAttribute("adverlist", baseAdvertisementService.getAdvertisementList("infor_index"));
		return "modules/wlpt_front/info/policy/policy_list";
	}
	
	
	/**
	 * 获取政策公告
	 * @param baseNews
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "getpolicylist")
    public Object getpolicylist(BasePolicy Policy,int pageNo,int pageSize, Model model){
        Page pg = new Page();
        pg.setLength(3);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
    	//
		Page<BasePolicy> page = basePolicyService.getPolicyList(pg, Policy); 
		
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
    }
    
    /**
   	 * 获取详情
   	 * @param Policy
   	 * @param request
   	 * @param response
   	 * @param model
   	 * @return
   	 */
   	@RequestMapping(value = {"getpolicyddetail", ""})
   	public String getpolicyddetail(BasePolicy Policy, HttpServletRequest request, HttpServletResponse response, Model model) {
   		model.addAttribute("baseNews", Policy);
   		return "modules/wlpt_front/info/infor_detail";
   	}
}
