package com.thinkgem.jeesite.modules.wlpt.web.make;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Random;

import javax.validation.ConstraintViolationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.exchange.PetrolExchangeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchangeRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.user.CarUser;
import com.thinkgem.jeesite.modules.wlpt.service.exchange.UserPetrolExchangeRecordService;


@Controller
@RequestMapping(value = "${adminPath}/wlpt/make")
public class MakeController  extends BaseController {
	@Autowired
    private PetrolExchangeBiz petrolExchangeRecordService;
	 
	 
	@RequestMapping(value = "importBox", method=RequestMethod.POST)
	public String importBox(MultipartFile file,Model model, RedirectAttributes redirectAttributes){
		try {
			int successNum = 0;
			int failureNum = 0;
	    	StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<CarUser> list = ei.getDataList(CarUser.class);
			//添加关系表
			UserPetrolExchangeRecord exchangeRecord = new UserPetrolExchangeRecord();
			exchangeRecord.setCarUserList(list);
			exchangeRecord.setStatus(DataDic.EXCHANGE_STATUS_SUCESS);
			//petrolExchangeRecordService.petrolexchangeSave1(exchangeRecord);//修改消费记录状态
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条用户，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条用户"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入用户失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/make/toimportBox"+"?repage";
	}
	
	@RequestMapping(value = "toimportBox")
	public String toimportBox(){
		int successNum = 0;
		int failureNum = 0;
		return "modules/wlpt/trade/NewFile1";
	}
}
