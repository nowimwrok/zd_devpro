package com.thinkgem.jeesite.modules.weixin.controller.freightrate;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightratePriceinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightrateLineService;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightratePriceinfoService;

/**
 * 线路运价Controller
 *
 * @author
 * @version 2016-08-28
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/freightrate")
public class FreightrateWeiXinControlle extends BaseController {
	@Autowired
	private FreightrateLineService freightratelineService;
	@Autowired
	private FreightratePriceinfoService freightratePriceinfoService;

	/**
	 * 价格指数
	 */
	@RequestMapping(value = "/tofrightrate")
	public String toPrices(HttpServletRequest request, HttpServletResponse response, Model model) {

		return "modules/wx_front/freightrate/freightrate";
	}

	/**
	 * 价格指数
	 */
	@ResponseBody
	@RequestMapping(value = "/getPrices", produces = "application/json;charset=UTF-8")
	public Object getPrices(FreightrateLine freightrateLine, int pageNo, int pageSize) {
		Page pg = new Page();
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		// 获取数据
		Page<FreightrateLine> page = freightratelineService.findPage(pg, freightrateLine);
		return new JSONPObject("callback", page);
	}

}
