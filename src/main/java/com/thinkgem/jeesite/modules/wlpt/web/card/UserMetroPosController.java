/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.card;

import java.util.Map;

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

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.UserMetroPosBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPos;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroPosService;

/**
 * 一卡通POS机列表Controller
 * @author 曾煜佳
 * @version 2016-11-30
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/card/userMetroPos")
public class UserMetroPosController extends BaseController {

	
	@Autowired
	private UserMetroPosBiz userMetroPosBiz;
	
	@ModelAttribute
	public UserMetroPos get(@RequestParam(required=false) String id) {
		UserMetroPos entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userMetroPosBiz.get(id);
		}
		if (entity == null){
			entity = new UserMetroPos();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:card:userMetroPos:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserMetroPos userMetroPos, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserMetroPos> page = userMetroPosBiz.findPage(new Page<UserMetroPos>(request, response), userMetroPos); 
		model.addAttribute("page", page);
		return "modules/wlpt/card/userMetroPosList";
	}

	@RequiresPermissions("wlpt:card:userMetroPos:view")
	@RequestMapping(value = "form")
	public String form(UserMetroPos userMetroPos, Model model) {
		model.addAttribute("userMetroPos", userMetroPos);
		return "modules/wlpt/card/userMetroPosForm";
	}

	@RequiresPermissions("wlpt:card:userMetroPos:edit")
	@RequestMapping(value = "save")
	public String save(UserMetroPos userMetroPos, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userMetroPos)){
			return form(userMetroPos, model);
		}
		
		Map<String, Object> map = userMetroPosBiz.bindMetroPos(userMetroPos);
		addMessage(redirectAttributes, map.get("message").toString());
		/*userMetroPosService.save(userMetroPos);*/
		//addMessage(redirectAttributes, "保存一卡通POS机列表成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroPos/?repage";
	}
	
	@RequiresPermissions("wlpt:card:userMetroPos:edit")
	@RequestMapping(value = "delete")
	public String delete(UserMetroPos userMetroPos, RedirectAttributes redirectAttributes) {
		userMetroPosBiz.delete(userMetroPos);
		addMessage(redirectAttributes, "删除一卡通POS机列表成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroPos/?repage";
	}
	/**
	 * 验证POS机号是否唯一
	 * @param useraccount
	 * @param id
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "checkUserAccount")
    public String checkUserAccount(String useraccount,String id) {
    	
    	if(Tools.IsNullOrWhiteSpace(useraccount)){
    		return "false";
    	}
    	UserMetroPos ump = new UserMetroPos();
    	ump.setUseraccount(useraccount);
    	ump = userMetroPosBiz.getMetroPosInfo(ump);
    	
        if (ump != null) {
        	int delflag = Integer.parseInt(ump.getDelFlag())*1;
        	if(DataDic.DEL_FLAG_DELETE.equals(ump.getDelFlag())){
        		return "false";
        	}
        	if(!Tools.IsNullOrWhiteSpace(id)&&ump.getId().equals(id)){
        		return "true";
        	}
            return "false";
        }
        return "true";
    }
}