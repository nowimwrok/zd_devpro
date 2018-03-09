package com.thinkgem.jeesite.modules.wlpt.webapi.info;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.ModelAndView;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightratePriceinfo;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightrateLineService;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightratePriceinfoService;

@Controller
@RequestMapping(value = "${frontPath}/wlpt/info/price")
public class PricesController extends BaseController {
	
	@Autowired
	private FreightrateLineService freightratelineService;
	@Autowired 
	private FreightratePriceinfoService freightratePriceinfoService;
    /**
     * 价格指数
     */
    @RequestMapping(value = "/toPrices")
    public String toPrices(HttpServletRequest request, HttpServletResponse response, Model model) {
    	
        return "modules/wlpt_front/info/prices";
    }
	/**
     * 价格指数
     */
    @ResponseBody
    @RequestMapping(value = "/getPrices" , produces = "application/json;charset=UTF-8")
    public Object getPrices(FreightrateLine freightrateLine) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<FreightrateLine> datas = freightratelineService.findList(freightrateLine);
            FreightratePriceinfo freightratePriceinfo=new FreightratePriceinfo();
            freightratePriceinfo.setGoodstype(freightrateLine.getPriceinfo().getGoodstype());
            freightratePriceinfo.setStartAddress(freightrateLine.getStartaddress());
            freightratePriceinfo.setEndAddress(freightrateLine.getEndaddress());
            List<FreightratePriceinfo> prices=freightratePriceinfoService.findPrices(freightratePriceinfo);
            List<BigDecimal> avgList=new ArrayList<>();
            List<String> dateList=new ArrayList<>();
            for (FreightratePriceinfo p :prices){
                avgList.add(new BigDecimal(p.getAvgprice()).setScale(2,BigDecimal.ROUND_DOWN));
                dateList.add(p.getCreatetimeFormat());
            }
     
            map.put("datas", datas);
            map.put("avgPrices", avgList);
            map.put("date",dateList);
        } catch (Exception e) {
            e.printStackTrace();
            
        }
        return new JSONPObject("callback", map);
    }
   
}
