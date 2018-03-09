package com.thinkgem.jeesite.modules.wlpt.web.interfacelog;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/wlpt/baidustatistics/baidustatistics")
public class BaiduStatistics extends BaseController{
	@RequestMapping(value="list")
	public String list() {
		return "modules/wlpt/baidustatistics/baidustatistics";
	}
}
