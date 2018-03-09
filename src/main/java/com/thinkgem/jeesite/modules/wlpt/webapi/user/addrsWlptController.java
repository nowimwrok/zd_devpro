package com.thinkgem.jeesite.modules.wlpt.webapi.user;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.service.user.AddressService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by ForHeart on 16/8/10.
 * 用户地址管理
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/address")
public class addrsWlptController extends BaseController {


    @Autowired
    private AddressService addressService;

    @Autowired
    private UserBiz userBiz;

    @RequiresPermissions("user")
    @RequestMapping(value = {"address_list", ""})
    public String address_list(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/wlpt_front/address/address_list";
    }

    /**
     * 去编辑页面
     * @param address
     * @param isSave
     * @param model
     * @return
     */
    @RequiresPermissions("wlpt:user:address:view")
    @RequestMapping(value = {"from", ""})
    public String address_from(Address address, Boolean isSave, Model model) {
        if (!isSave) {
            ///获取地址对象
            address = addressService.get(address);
        }
        model.addAttribute("address", address);
        return "modules/wlpt_front/address/address_from";
    }


    @RequiresPermissions("user")
    @RequestMapping(value = "address_delet")
    public Object delete(Address address, RedirectAttributes redirectAttributes) {
        addressService.delete(address);
        addMessage(redirectAttributes, "删除地址成功");
        return "redirect:"+ Global.getFrontPath()+"/wlpt/address/address_list?repage";
    }

    /***
     * 保存地址
     *
     * @param address
     * @param model
     * @param redirectAttributes
     * @return
     */

    @RequiresPermissions("wlpt:user:address:edit")
    @RequestMapping(value = "save")
    public String  save(Address address, Model model, RedirectAttributes redirectAttributes) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        ///判断用户是否登录
        if (UserUtils.getUser() == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
        }
        if (!beanValidator(model, address)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            userBiz.saveAddressBiz(address, UserUtils.getUser());
            model.addAttribute("message","保存地址成功 ");
            addMessage(redirectAttributes, "保存地址成功");
            return "redirect:"+ Global.getFrontPath()+"/wlpt/address/address_list?repage";
        }
       return address_from(address,true,model);
    }

    /***
     * 获取货源列表
     *
     * @param address  地址对象
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getAddresList")
    public Object getAddresList(Address address, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        if (UserUtils.getUser() == null) {
            return new JSONPObject("callback", pg);
        }
        ///获取用户列表信息
        Page<Address> page = userBiz.getAddressBiz(pg, address, UserUtils.getUser());
        for (Address var : page.getList()) {
            var.setType(DictUtils.getDictLabel(var.getType(), "addressType", ""));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }


}
