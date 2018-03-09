package com.thinkgem.jeesite.modules.wlpt.web.interfacelog;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.TotalValidationBiz;
 
@Controller
@RequestMapping("${frontPath}/wlpt/totalvalida")
public class TotalValidationController extends BaseController{
	@Autowired
	private TotalValidationBiz totalbiz;
	
	@RequestMapping(value = "totalVali" )
	@ResponseBody
	public Map<String,Object> totalVali(String name,String phone,String vclN,String area,String vco,String regist,String carid,String authentication) {
		int state=DataDic.RETURN_STATUS_NORMAL;
			Map<String,Object> map=new HashMap<>();
	    try {
	    	 User curUser = UserUtils.getUser();
	         if (curUser == null) {
	             return null;
	         }
			map= totalbiz.totalvalidation( name, phone ,vclN , area,vco,regist ,carid,authentication);
			if(map!=null) {
				return Tools.getMapResult(state, "查询成功", map);
				
			}else {
				state=DataDic.RETURN_STATUS_SYSBUG;
				return Tools.getMapResult(state,"查询失败",map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			state=DataDic.RETURN_STATUS_SYSBUG;
			return Tools.getMapResult(state,"查询失败",map);
		}
		
	}
	
	@RequestMapping(value = "showMsg")
	@ResponseBody
	public Map<String,Object> showMsg(String name,String phone,String vclN,String area,String vco,String regist,String carid,String authentication){
		Map<String,Object> map = totalbiz.showMsg(name, phone, vclN, area, vco, regist, carid, authentication);
		return map;
	}
	
	@RequestMapping(value = "totalValis" )
	@ResponseBody
	public Map<String,Object> totalValis(String name,String phone,String vclN,String area,String vco,String regist,String carid,String authentication) {
		int state=DataDic.RETURN_STATUS_NORMAL;
		Map<String,Object> map=new HashMap<>();
		try {
			User curUser = UserUtils.getUser();
			if (curUser == null) {
				return null;
			}
			map= totalbiz.totalvalidations( name, phone ,vclN , area,vco,regist ,authentication);
			if(map!=null) {
				return Tools.getMapResult(state, "查询成功", map);
				
			}else {
				state=DataDic.RETURN_STATUS_SYSBUG;
				return Tools.getMapResult(state,"查询失败",map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			state=DataDic.RETURN_STATUS_SYSBUG;
			return Tools.getMapResult(state,"查询失败",map);
		}
		
	}
	
	
	
}
