package com.thinkgem.jeesite.modules.wlpt.webapi.chinaarea;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.ChinaArea;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseChinaAreasService;

@Controller
@RequestMapping(value = "${frontPath}/wlpt/chinaarea")
public class ChinaAreaController   extends BaseController{
	@Autowired
	private BaseChinaAreasService baseChinaAreaService;
	/***
	 * 获取城市信息
	 * @param isSearchHotCity
	 * @param parentCode
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "getArea")
	public List<ChinaArea> getArea(String isSearchHotCity, String parentCode,String code) {
		ChinaArea chinaarea=new ChinaArea();
		chinaarea.setParentcode(parentCode);
		chinaarea.setCode(code);
		if ("true".equals(isSearchHotCity)){
			chinaarea.setIshotcity("1");
		}
			List<ChinaArea> result= baseChinaAreaService.getAreaByCondition(chinaarea);

		return result;
	}
}
