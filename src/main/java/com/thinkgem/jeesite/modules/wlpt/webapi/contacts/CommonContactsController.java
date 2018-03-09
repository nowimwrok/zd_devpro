package com.thinkgem.jeesite.modules.wlpt.webapi.contacts;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.contacts.CommonContactsBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.contacts.UserCommonContacts;

/**
 * 常用联系人管理
 * @author zyj
 *2017-04-11
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/contacts")
public class CommonContactsController extends BaseController {

	@Autowired 
    private UserBiz userBiz;
	
	@Autowired
	private CommonContactsBiz commonContactsBiz;
	
	/**
	 * 去常用联系人列表页面
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
    @RequestMapping(value = {"contacts_list", ""})
    public String contacts_list(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("user", userBiz.getUser());
		return "modules/user_front/contacts/contacts_list";
        //return "modules/wlpt_front/contacts/contacts_list";
    }

	
    /***
     * 获取常用联系人列表
     *
     * @param contacts 常用联系人实体
     * @param pageNo 当前页码
     * @param pageSize 页面大小
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getContactsList")
    public Object getContactsList(UserCommonContacts contacts, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            return null;
        }
        contacts.setUser(curUser);
        Page<UserCommonContacts> page = commonContactsBiz.findPage(pg, contacts);
        
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
    
    
    /***
     * 到联系人添加页面
     * @param contacts实体
     * @param model
     * @return
     */
    @RequestMapping(value = "toContacts")
    public String toContacts(UserCommonContacts contacts, Model model) {
        //return "modules/wlpt_front/contacts/contacts_add";
        return "modules/user_front/contacts/contacts_add";
    }
    /***
     * 添加联系人
     * @param contacts实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveContacts")
    public Object saveContacts(UserCommonContacts contacts, Model model) {
 	   Object result=commonContactsBiz.saveContacts(contacts, UserUtils.getUser());
 	   model.addAttribute("user", userBiz.getUser());
 	   return new JSONPObject("callback", result);
    }
    
    /***
     * 删除联系人
     *
     * @param contacts id
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteContacts")
    public Object deleteContacts(@RequestParam(required = false) String id, Model model) {
    	UserCommonContacts contacts = commonContactsBiz.get(id);
    	commonContactsBiz.delete(contacts);
 	   return new JSONPObject("callback", "删除联系人成功");
    }
	
}
