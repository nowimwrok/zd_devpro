/**
 * 
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Log;
import com.thinkgem.jeesite.modules.sys.service.LogService;

/**
 * 日志Controller
 * @author 
 * @version 2013-6-2
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/log")
public class LogController extends BaseController {

	@Autowired
	private LogService logService;
	
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = {"list", ""})
	public String list(Log log, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Log> page = logService.findPage(new Page<Log>(request, response), log); 
        model.addAttribute("page", page);
		return "modules/sys/logList";
	}
	
	@RequestMapping(value="export")
	public String export(Log log,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes){
		try{
			String title = "日志统计信息数据";
			String fileName = title  + DateUtils.getDate("yyyyMMddHHmmss") +".xlsx";
			//不导出异常
			log.setType(Log.TYPE_ACCESS);
			List<Log> list = logService.findList(log);
			//Page<Log> page = logService.findPage(new Page<Log>(request,response), log);
			new ExportExcel(title, Log.class).setDataList(list).write(response, fileName).dispose();
			return null;
		}catch (Exception e) {
			// TODO: handle exception
			addMessage(redirectAttributes, "导出货源数据统计信息数据失败！失败信息：" + e.getMessage());
		}
		
		return "redirect:" +Global.getAdminPath()+"/modules/sys/logList";
	}
}
