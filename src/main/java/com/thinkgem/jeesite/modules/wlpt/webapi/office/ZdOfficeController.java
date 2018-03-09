package com.thinkgem.jeesite.modules.wlpt.webapi.office;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.web.BaseController;

@Controller
@RequestMapping(value = "${frontPath}/office")
public class ZdOfficeController extends BaseController{
	
	/**
	 * 跳转到商城
	 * @return
	 */
	@RequestMapping(value = "shop")
	public String shop(){
		return "modules/wlpt_front/admin/shop";
	}
	
	/**
	 * 跳转到解决方案
	 * @return
	 */
	@RequestMapping(value = "answer")
	public String answer(String index){
		return "modules/wlpt_front/admin/solveEnd";
	}
	
	/**
	 * 跳转到关于我们
	 * @return
	 */
	@RequestMapping(value = "about")
	public String about(String index){
		return "modules/wlpt_front/admin/about";
	}
	
	/**
	 * 跳转到主页
	 * @return
	 */
	@RequestMapping(value = "index")
	public String index(){
		return "modules/wlpt_front/admin/index";
	}
}
