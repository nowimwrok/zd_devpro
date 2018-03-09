/**
 *
 */
package com.thinkgem.jeesite.modules.weixin.controller.informationhall;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 微信信息大厅Controller
 *
 * @author
 * @version 2016-08-22
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/informationHall")
public class InformationHallController extends BaseController {

	@RequestMapping(value = { "infoHall_list", "" })
	public String infoHall_list(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user=UserUtils.getUser();
		if(user!=null){
			model.addAttribute("user", user);
		}
		return "modules/wx_front/infoHall/infoHall_list";
	}

}