/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.integrity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.IntegrityRecordVO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityRecord;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityRecordService;

import java.util.List;

/**
 * 诚信积分Controller
 * @author 刘欣
 * @version 2016-09-13
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integrity/integrityRecord")
public class IntegrityRecordController extends BaseController {

	@Autowired
	private IntegrityRecordService integrityRecordService;

	@Autowired
	private IntegrityBiz integrityBiz;

	
	@RequiresPermissions("wlpt:integrity:integrityRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(IntegrityRecordVO integrityRecordVO, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IntegrityRecordVO> page = integrityBiz.findSumPointvalueList(new Page<IntegrityRecordVO>(request, response), integrityRecordVO);
		model.addAttribute("page", page);
		model.addAttribute("integrityRecordVO", integrityRecordVO);
		return "modules/wlpt/integrity/integrityRecordTotalList";
	}

	@RequiresPermissions("wlpt:integrity:integrityRecord:view")
	@RequestMapping(value = "form")
	public String form(IntegrityRecord integrityRecord, Model model) {
		model.addAttribute("integrityRecord", integrityRecord);
		return "modules/wlpt/integrity/integrityRecordForm";
	}

	@RequiresPermissions("wlpt:integrity:integrityRecord:edit")
	@RequestMapping(value = "save")
	public String save(IntegrityRecord integrityRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integrityRecord)){
			return form(integrityRecord, model);
		}
		integrityRecordService.save(integrityRecord);
		addMessage(redirectAttributes, "保存诚信积分成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityRecord/?repage";
	}
	
	@RequiresPermissions("wlpt:integrity:integrityRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(IntegrityRecord integrityRecord, RedirectAttributes redirectAttributes) {
		integrityRecordService.delete(integrityRecord);
		addMessage(redirectAttributes, "删除诚信积分成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityRecord/?repage";
	}


	/**
	 * 导出积分数据
	 *
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(IntegrityRecordVO integrityRecordVO, HttpServletRequest request, HttpServletResponse response,
							 RedirectAttributes redirectAttributes) {
		try {
			String fileName = "积分信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<IntegrityRecordVO> page = integrityBiz.findSumPointvalueList(new Page<IntegrityRecordVO>(), integrityRecordVO);
			List<IntegrityRecordVO> varOList=page.getList();

			new ExportExcel("积分信息数据", IntegrityRecordVO.class).setDataList(varOList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户积分信息失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/integrity/integrityRecord/list?repage";
	}
	
	
}