package com.thinkgem.jeesite.common.utils;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;

public class GoodsPushUtils {
	
	private static String recEncoding = "UTF-8";
	private static String fyez="http://www.zhuoda56.com/fyez/wlpt/goods/getPush";
	
	@SuppressWarnings("unchecked")
	public static void goodsPush(Goods goods){
		Map parameters=new HashMap();
		if(!StringUtils.isEmpty(goods.getCarlength())){
			parameters.put("carlength", goods.getCarlength());
		}
        if(!StringUtils.isEmpty(goods.getCartype())){
        	parameters.put("cartype", goods.getCartype());
		}
        if(!StringUtils.isEmpty(goods.getEffectdays())){
        	parameters.put("effectdays", goods.getEffectdays());
		}
        if(!StringUtils.isEmpty(goods.getExpectedprice())){
        	parameters.put("expectedprice", goods.getExpectedprice());
		}
        if(!StringUtils.isEmpty(goods.getFreightunit())){
        	parameters.put("freightunit", goods.getFreightunit());
		}
        if(!StringUtils.isEmpty(goods.getFreightvolume())){
        	parameters.put("freightvolume", goods.getFreightvolume());
		}
        if(!StringUtils.isEmpty(goods.getGoodsname())){
        	parameters.put("goodsname", goods.getGoodsname());
		}
        if(!StringUtils.isEmpty(goods.getGoodstype())){
        	parameters.put("goodstype", goods.getGoodstype());
		}
        if(!StringUtils.isEmpty(goods.getGsoddtype())){
        	parameters.put("gsoddtype", goods.getGsoddtype());
		}
        if(!StringUtils.isEmpty(goods.getRemarks())){
        	parameters.put("remarks", goods.getRemarks());
		}
        if(!StringUtils.isEmpty(goods.getFreightvolume())){
        	parameters.put("residualvolume", goods.getFreightvolume());
		}
        if(!StringUtils.isEmpty(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(goods.getSendtime()))){
        	parameters.put("ymdDate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(goods.getSendtime()));
		}
        if(!StringUtils.isEmpty(goods.getTransportway())){
        	parameters.put("transportway", goods.getTransportway());
		}
        if(!StringUtils.isEmpty(goods.getWorth())){
        	parameters.put("worth", goods.getWorth());
		}
        
        if(!StringUtils.isEmpty(goods.getUser().getRole().getId())){
        	parameters.put("role", goods.getUser().getRole().getId());
		}
        if(!StringUtils.isEmpty(goods.getUser().getLoginName())){
        	parameters.put("loginName", goods.getUser().getLoginName());
		}
        if(!StringUtils.isEmpty(goods.getUser().getPhone())){
        	parameters.put("phone", goods.getUser().getPhone());
		}
        if(!StringUtils.isEmpty(goods.getUser().getName())){
        	parameters.put("name", goods.getUser().getName());
		}
        if(!StringUtils.isEmpty(goods.getUser().getCompany().getId())){
        	parameters.put("company", goods.getUser().getCompany().getId());
		}
        if(!StringUtils.isEmpty(goods.getUser().getOffice().getId())){
        	parameters.put("office", goods.getUser().getOffice().getId());
		}
        if(!StringUtils.isEmpty(goods.getUser().getPassword())){
        	parameters.put("password", goods.getUser().getPassword());
		}
        
        if(!StringUtils.isEmpty(goods.getConsignAddress().getDistrict())){
        	parameters.put("district", goods.getConsignAddress().getDistrict());
		}
        if(!StringUtils.isEmpty(goods.getConsignAddress().getCity())){
        	parameters.put("city", goods.getConsignAddress().getCity());
		}
        if(!StringUtils.isEmpty(goods.getConsignAddress().getProvince())){
        	parameters.put("province", goods.getConsignAddress().getProvince());
		}
        if(!StringUtils.isEmpty(goods.getConsignAddress().getLinkman())){
        	parameters.put("linkman", goods.getConsignAddress().getLinkman());
		}
        if(!StringUtils.isEmpty(goods.getConsignAddress().getLinkmobile())){
        	parameters.put("linkmobile", goods.getConsignAddress().getLinkmobile());
		}
        
        if(!StringUtils.isEmpty(goods.getShipAddress().getDistrict())){
        	parameters.put("district1", goods.getShipAddress().getDistrict());
		}
        if(!StringUtils.isEmpty(goods.getShipAddress().getCity())){
        	parameters.put("city1", goods.getShipAddress().getCity());
		}
        if(!StringUtils.isEmpty(goods.getShipAddress().getProvince())){
        	parameters.put("province1", goods.getShipAddress().getProvince());
		}
        if(!StringUtils.isEmpty(goods.getShipAddress().getLinkman())){
        	parameters.put("linkman1", goods.getShipAddress().getLinkman());
		}
        if(!StringUtils.isEmpty(goods.getShipAddress().getLinkmobile())){
        	parameters.put("linkmobile1", goods.getShipAddress().getLinkmobile());
		}
        
        
		String result=HttpRequestProxy.doPost(fyez, parameters, recEncoding);
		Object json=JSON.parse(result);
	}
}
