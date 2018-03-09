/**
 * 
 */
package com.thinkgem.jeesite.modules.sms.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsSendStateEnum;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sms.entity.SendLog;
import com.thinkgem.jeesite.modules.sms.service.SendLogService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 消息发送日志Controller
 * @author 饶江龙
 * @version 2016-07-20
 */
@Controller
@RequestMapping(value = "${adminPath}/sms/sendlog")
public class SendLogController extends BaseController {

	@Autowired
	private SendLogService sendLogService;
	
	@ModelAttribute
	public SendLog get(@RequestParam(required=false) String id) {
		SendLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sendLogService.get(id);
		}
		if (entity == null){
			entity = new SendLog();
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "testSendSms")
	public SmsSendStateEnum testSendSms(SendLog smssendlog) {
		User user= UserUtils.getUser();
		smssendlog.setMobiles("13560021837");
		smssendlog.setFunction("注册");
		smssendlog.setSmsContent("您的验证码:9032932");
		SmsSendStateEnum sendState=SmsUtil.SendSms(smssendlog,"0");

		if (SmsSendStateEnum.Succeed.equals(sendState)){

			smssendlog.setCost("0.5");
			smssendlog.setSendTime(DateUtil.getTime());
			smssendlog.setUpdateDate(smssendlog.getCreateDate());
			sendLogService.save(smssendlog);
			//smssendlog.setUser();
		}

		return sendState;
	}


	@RequestMapping(value = {"toTestSendSms", ""})
	public String toTestSendSms(){
		return "modules/sms/testSendSms";
	}

	
	@RequiresPermissions("sms:smssendlog:view")
	@RequestMapping(value = {"list", ""})
	public String list(SendLog smssendlog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SendLog> page = sendLogService.findPage(new Page<SendLog>(request, response), smssendlog); 
		model.addAttribute("page", page);
		return "modules/sms/sendLogList";
	}

	@RequiresPermissions("sms:smssendlog:view")
	@RequestMapping(value = "form")
	public String form(SendLog smssendlog, Model model) {
		model.addAttribute("smssendlog", smssendlog);
		return "modules/sms/sendLogForm";
	}

	@RequiresPermissions("sms:smssendlog:edit")
	@RequestMapping(value = "save")
	public String save(SendLog smssendlog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, smssendlog)){
			return form(smssendlog, model);
		}
		sendLogService.save(smssendlog);
		addMessage(redirectAttributes, "保存消息日志成功");
		return "redirect:"+Global.getAdminPath()+"/sms/sendlog/?repage";
	}
	
	@RequiresPermissions("backstage:sms:smssendlog:edit")
	@RequestMapping(value = "delete")
	public String delete(SendLog smssendlog, RedirectAttributes redirectAttributes) {
		sendLogService.delete(smssendlog);
		addMessage(redirectAttributes, "删除消息日志成功");
		return "redirect:"+Global.getAdminPath()+"/sms/sendlog/?repage";
	}

}