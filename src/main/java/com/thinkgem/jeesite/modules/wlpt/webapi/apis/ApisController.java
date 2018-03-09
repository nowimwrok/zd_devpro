package com.thinkgem.jeesite.modules.wlpt.webapi.apis;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;

/**
 * 中交兴路Api连调用接口
 * 
 * @author renshuai
 *
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/apis")
public class ApisController extends BaseController {
	
	@Autowired
	private TradeBiz tradeBiz;
	
	  @RequestMapping(value = {"areamsg"})
	  @ResponseBody
	  public Map<String,Object> callbackInterface(String userflag,String vno,String plateColor,String areaId,String type,String utc){
		 Map<String,Object> map = tradeBiz.callbackInterface(userflag, vno, plateColor, areaId, type, utc);
		 return map;
	  }
}
