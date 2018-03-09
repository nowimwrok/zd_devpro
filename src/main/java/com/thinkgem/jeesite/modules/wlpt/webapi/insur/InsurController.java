package com.thinkgem.jeesite.modules.wlpt.webapi.insur;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsuranceInfo;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceInfoService;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.insur.InsurBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;

/**
 *保单
 * @author 曾煜佳
 * @version 2016-12-19
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/insur")
public class InsurController  extends BaseController{

	@Autowired
	private InsurBiz insurBiz;

	@Autowired
	private UserInsuranceInfoService userInsuranceInfoService;
	/**
	 * 我的保单列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "insur_list")
	public String insur_list(UserInsurance insurance,Model model) {
		User curUser = UserUtils.getUser();
		model.addAttribute("user", curUser);
        //return "modules/wlpt_front/insur/insur_list";
		return "modules/user_front/insur/insur_list";
	}
	
    /***
     * 获取保单列表
     * @param insurance 实体
     * @param pageNo 当前页
     * @param pageSize 页大小
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getInsurList")
    public Object getInsurList(UserInsurance insurance, int pageNo, int pageSize, Model model) {
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
        insurance.setUser(curUser);
        Page<UserInsurance> page = insurBiz.findPage(pg, insurance);
        for (UserInsurance insur : page.getList()) {
        	insur.setStatusInt(Integer.parseInt(insur.getStatus()));
			Date nowTime=new Date();
        	if (insur.getStartTime()!=null && insur.getEndTime()!=null) {

				long day=(insur.getEndTime().getTime()-nowTime.getTime())/(24*60*60*1000);
				//insur.setDueTime(DateUtil.getDaySub(insur.getStartTime().toString(), insur.getEndTime().toString()));
				insur.setDueTime(day);
			}
        	insur.setStatus(DictUtils.getDictLabel(insur.getStatus(), "insurance_status", ""));
            
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
	
	/**
	 * 我的保单详情
	 * 
	 * @return
	 */
	@RequestMapping(value = "todetail")
	public String todetail(UserInsurance insurance,Model model) {
		User curUser = UserUtils.getUser();
		model.addAttribute("user", curUser);
		if(insurance==null || Tools.IsNullOrWhiteSpace(insurance.getId())){
	        //return "modules/wlpt_front/insur/insur_list";
			return "modules/user_front/insur/insur_list";
		}
		insurance = insurBiz.get(insurance.getId());
		if(insurance==null){
			//return "modules/wlpt_front/insur/insur_list";
			return "modules/user_front/insur/insur_list";
		}
		model.addAttribute("insurance", insurance);
        //return "modules/wlpt_front/insur/insur_detail";
        return "modules/user_front/insur/insur_detail";
	}
	/**
	 * 我的保单详情
	 * 
	 * @return
	 */
	@RequestMapping(value = "todetailByOrderNo")
	public String todetailByOrderNo(UserInsurance insurance,Model model) {
		User curUser = UserUtils.getUser();
		model.addAttribute("user", curUser);
		if(insurance==null || Tools.IsNullOrWhiteSpace(insurance.getOrderno())){
	        //return "modules/wlpt_front/insur/insur_list";
	        return "modules/user_front/insur/insur_list";
		}
		UserInsurance uis = insurBiz.getInsurInfo(insurance);
		if(uis==null){
			//return "modules/wlpt_front/insur/insur_list";
	        return "modules/user_front/insur/insur_list";
		}
		model.addAttribute("insurance", uis);
        //return "modules/wlpt_front/insur/insur_detail";
        return "modules/user_front/insur/insur_detail";
	}
	
	/***
     *我的保单详情
     * @param id
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDetail")
    public Object getDetail(String id) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        Map<String, Object> map = new HashMap<String, Object>();

        if (id != null && !StringUtils.isEmpty(id)) {
        	UserInsurance insurance = insurBiz.get(id);
    		if(insurance==null){
    			state=DataDic.RETURN_STATUS_INFOBUG;
                message="未查询到数据";
    		}else{
				UserInsuranceInfo info = new UserInsuranceInfo();
				info.setInsurance(insurance);
				List<UserInsuranceInfo> infoList = userInsuranceInfoService.findList(info);
				if(infoList.size()>0){
					insurance.setInfoList(infoList);
				}
    			map.put("insurance",insurance);
    		}
        }else{
            state=DataDic.RETURN_STATUS_INFOBUG;
            message="未查询到数据";
        }
        return this.getMapResult(state,message,map);
    }
}
