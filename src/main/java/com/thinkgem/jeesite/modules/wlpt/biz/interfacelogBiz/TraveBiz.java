package com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.trafficUtils.findCarDelivery.Query;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.Travelinformation;
import com.thinkgem.jeesite.modules.wlpt.service.interfacelog.TravelinformationService;

@Service
public class TraveBiz {
	@Autowired
	private TravelinformationService traveservice;
	@Autowired
	private InterfaceLogBiz interfacelogbiz;
	
	
	public Travelinformation  traveQuery(String vclN ,String vco) {
		Travelinformation traveLin=new Travelinformation();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		Query query=new Query();
		Map<String,Object>map= query.vQueryLicense(token,vclN, vco);
		traveLin=(Travelinformation) map.get("data");
		if(traveLin!=null) {
			traveservice.save(traveLin);
		}
		return traveLin;
	}
}
