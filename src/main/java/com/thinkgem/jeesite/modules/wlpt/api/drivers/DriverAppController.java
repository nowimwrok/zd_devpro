package com.thinkgem.jeesite.modules.wlpt.api.drivers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.driverBiz.DriverBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

@Controller
@RequestMapping("${appPath}/api/drivers")
public class DriverAppController extends BaseController {
    @Autowired
    private DriverBiz driverBiz;
    @Autowired
    private UserBiz userBiz;
    @Autowired
    private WlptUserService wlptUserService;
    @Autowired
    private DriverService driverService;

    /**
     * 获取司机列表
     *
     * @param attach
     * @param pageNo
     * @param pageSize
     * @param model
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "driverList", method = RequestMethod.GET)
    public Object getDriverList(Attach attach, int pageNo, int pageSize, Model model, HttpServletRequest request,
                                HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        Page<Attach> page = new Page<Attach>();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            attach.setUser(UserUtils.getUser());
            attach.setReuser(UserUtils.getUser());
            page = driverBiz.findPage(page, attach);
            for (Attach a : page.getList()) {
                // a.setIsagree(DictUtils.getDictLabel(a.getIsagree(),
                // "isagree", ""));
                if (a.getReuser().getId().equals(UserUtils.getUser().getId())) {
                    a.setFlag("1");
                    a.setUser(wlptUserService.get(a.getUser().getId()));
                } else {
                    a.setFlag("0");
                    a.setReuser(wlptUserService.get(a.getReuser().getId()));
                }
            }
            int totlaCount = (int) page.getCount();
            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);
            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;

        // Page pg = new Page();
        // pg.setLength(4);
        // pg.setPageNo(pageNo);
        // pg.setPageSize(pageSize);
        // ////获取当前登录用户的管理司机信息
        // attach.setUser(UserUtils.getUser());
        // attach.setReuser(UserUtils.getUser());
        // Page<Attach> page = driverBiz.findPage(pg, attach);
        // for(Attach a :page.getList()){
        // //a.setIsagree(DictUtils.getDictLabel(a.getIsagree(), "isagree",
        // ""));
        // if(a.getReuser().getId().equals(UserUtils.getUser().getId())){
        // a.setFlag("1");
        // a.setUser(wlptUserService.get(a.getUser().getId()));
        // }else{
        // a.setFlag("0");
        // a.setReuser(wlptUserService.get(a.getReuser().getId()));
        // }
        // }
        // model.addAttribute("page", page);
        // model.addAttribute("userid", UserUtils.getUser().getId());
        // return new JSONPObject("callback", page);
    }

    /**
     * 根据司机ID详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "driverInfo", method = RequestMethod.GET)
    public Object driverInfo(String id, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(id)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id为空";
        } else {
            try {

                Driver driver = new Driver();
                User user = new User();
                //user.setId(id);
                driver.setId(id);
                driver.setUser(user);
                driver = driverService.get(driver);
                if (driver == null) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "司机不存在";
                } else {
                    result.put("driver", driver);
                }

            } catch (Exception e) {
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";

            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

}
