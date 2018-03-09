package com.thinkgem.jeesite.modules.weixin.controller.car;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.wlpt.biz.driverBiz.DriverBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * 司机管理
 * @author 曾煜佳
 *
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/driver")
public class DriverWeiXinController extends BaseController{
	@Autowired
    private DriverBiz driverBiz;
    @Autowired 
    private UserBiz userBiz;
    @Autowired
    private WlptUserService wlptUserService;
    /**
     * 司机管理页面
     * @param request、response
     * @return
     */
    @RequestMapping(value = "driver_list")
    public String list(Attach attach, HttpServletRequest request, HttpServletResponse response, Model model) {

    	model.addAttribute("userid", UserUtils.getUser().getId());
    	model.addAttribute("user", userBiz.getUser());
        return "modules/wx_front/car/driver_list";
    }
    
    /***
     * 获取绑定司机列表
     * @param attach实体
     * @param 当前页
     * @param 页大小
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDriverList")
    public Object getDriverList(Attach attach, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        ////获取当前登录用户的管理司机信息
        attach.setUser(UserUtils.getUser());
        attach.setReuser(UserUtils.getUser());
        Page<Attach> page = driverBiz.findPage(pg, attach);
        for(Attach a :page.getList()){
        	//a.setIsagree(DictUtils.getDictLabel(a.getIsagree(), "isagree", ""));
        	if(a.getReuser().getId().equals(UserUtils.getUser().getId())){
        		a.setFlag("1");
        		a.setUser(wlptUserService.get(a.getUser().getId()));
        	}else{
        		a.setFlag("0");
        		a.setReuser(wlptUserService.get(a.getReuser().getId()));
        	}
        }
        model.addAttribute("page", page);
        model.addAttribute("userid", UserUtils.getUser().getId());
        return new JSONPObject("callback", page);
    }
    
    /*
    * 到司机绑定页面
    * @param attach实体
    * @param model
    * @return
    */
   @RequestMapping(value = "toSave")
   public String toSave(Attach attach, Model model) {
	   User user = UserUtils.getUser();
	   
	   Attach a = attach;
       if (a.getId() != null) {
           a = driverBiz.get(a.getId());
       }
       model.addAttribute("attach", a);
       model.addAttribute("user",user);
       return "modules/wx_front/car/driver_add";
   }
   /***
    * 绑定司机
    * @param attach实体
    * @param model
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "saveAttach")
   public Object save(Attach attach, Model model) {

	   Object result=driverBiz.saveAttach(attach, UserUtils.getUser());
	   //UserUtils.clearCache( UserUtils.getUser());
	   model.addAttribute("user", userBiz.getUser());
	   return new JSONPObject("callback", result);
   }
   
   /***
    * 解除绑定
    *
    * @param attach id
    * @param model
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "deleteAttach")
   public Object deleteAttach(@RequestParam(required = false) String id, Model model) {
	   Attach attach = driverBiz.get(id);
	   driverBiz.delete(attach);
	   return new JSONPObject("callback", "成功取消绑定");
   }
   /***
    * 是否同意绑定
    *
    * @param attach实体
    * @param model
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "isAgree")
   public Object isAgree(Attach attach, Model model) {

	   Attach at = driverBiz.get(attach.getId());
       at.setIsagree(attach.getIsagree());
       return driverBiz.save(at, UserUtils.getUser());
   }

}
