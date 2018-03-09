package com.thinkgem.jeesite.modules.wlpt.webapi.car;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.driverBiz.DriverBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.service.car.AttachService;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeDriverService;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 王铸
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/driver")
public class DriverWlptController extends BaseController {

    @Autowired
    private DriverBiz driverBiz;
    @Autowired
    private UserBiz userBiz;
    @Autowired
    private WlptUserService wlptUserService;
    @Autowired
    private MotorcadeDriverService motorcadeDriverService;
    @Autowired
    private MotorcadeService motorcadeService;
    @Autowired
    private AttachService attachService;


    /**
     * 司机管理页面
     *
     * @param request、response
     * @return
     */
    @RequestMapping(value = "attach_list")
    public String list(Attach attach, HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = userBiz.getUser();
        if (user.getId() == null) {
            return "modules/wlpt_front/admin/login";
        }
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("userid", user.getId());
        model.addAttribute("user", userBiz.getUser());
        return "modules/user_front/car/attach_list";
        //return "modules/wlpt_front/car/attach_list";
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
        ////获取当前用户
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            return null;
        }
        ////获取当前登录用户的管理司机信息
        attach.setUser(curUser);
        attach.setReuser(curUser);
        Page<Attach> page = driverBiz.findPage(pg, attach);

        for (Attach a : page.getList()) {
            //a.setIsagree(DictUtils.getDictLabel(a.getIsagree(), "isagree", ""));
            if (a.getReuser().getId().equals(curUser.getId())) {
                a.setFlag("1");
                a.setUser(wlptUserService.get(a.getUser().getId()));
            } else {
                a.setFlag("0");
                a.setReuser(wlptUserService.get(a.getReuser().getId()));

            }
        }
        model.addAttribute("page", page);
        model.addAttribute("userid", curUser.getId());
        return new JSONPObject("callback", page);
    }


    /***
     * 获取绑定司机列表
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDriverDataList")
    public Object getDriverDataList(Attach attach, Model model) {
        ////获取当前用户
        User user = UserUtils.getUser();
        if (user == null) {
            return null;
        }
        attach.setUser(user);
        attach.setIsagree(DataDic.ATTACH_AGGREE);//获取已经申请通过的手机
        List<Attach> attachs = attachService.findList(attach);
        return new JSONPObject("callback", attachs);
    }

    /*
    * 到司机绑定页面
    * @param attach实体
    * @param model
    * @return
    */
    @RequestMapping(value = "toSave")
    public String toSave(Attach attach, Model model) {
//	   User user = UserUtils.getUser();
//       if (user.getId() == null) {
//       	return "modules/wlpt_front/admin/login";
//       }
        Attach a = attach;
        if (a.getId() != null) {
            a = driverBiz.get(a.getId());
        }
        model.addAttribute("attach", a);
        //return "modules/wlpt_front/car/attach_add";
        return "modules/user_front/car/attach_add";
    }

    /***
     * 绑定司机
     * @param attach
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveAttach")
    public Object save(Attach attach, Model model) {
//	   User user = UserUtils.getUser();
//       if (user.getId() == null) {
//       	return "modules/wlpt_front/admin/login";
//       }
        Object result = driverBiz.saveAttach(attach, UserUtils.getUser());
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("user", userBiz.getUser());
        return new JSONPObject("callback", result);
    }

    /***
     * 删除司机
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
     * @param attach
     * @param model
     * @return
     */
    @RequestMapping(value = "isAgree")
    public String isAgree(Attach attach, Model model) {
//	   User user = UserUtils.getUser();
//       if (user.getId() == null) {
//       	return "modules/wlpt_front/admin/login";
//       }
        Attach at = driverBiz.get(attach.getId());
        at.setIsagree(attach.getIsagree());
        driverBiz.save(at, UserUtils.getUser());
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("user", userBiz.getUser());
        return "modules/user_front/car/attach_list";
    }

    /**
     * 获取该用户的司机总数
     *
     * @param attach
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getUserDriverNum")
    public Object getUserDriverNum(Attach attach) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        Map<String, Object> result = new HashMap<>();
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "获取用户失败";
        } else {
            attach.setUser(curUser);
            attach.setReuser(curUser);
            int i = attachService.getUserDriverNum(attach);
            result.put("totalDriverNum", i);
        }
        return this.getMapResult(state, message, result);
    }
}
