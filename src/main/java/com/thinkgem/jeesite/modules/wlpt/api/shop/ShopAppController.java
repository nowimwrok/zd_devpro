package com.thinkgem.jeesite.modules.wlpt.api.shop;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.activity.ActivityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.shop.ShopBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurancelist;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ShopVO;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsurancelistService;

@Controller
@RequestMapping(value = "${appPath}/api/shop")
public class ShopAppController extends BaseController {
    @Autowired
    private ShopBiz shopBiz;

    @Autowired
    private ActivityBiz activityBiz;

    @Autowired
    private UserInsuranceService userInsuranceService;

    @Autowired
    private UserInsurancelistService userInsurancelistService;

    /***
     * 获取购买商品规则和活动信息
     *
     * @param shopName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "toBuy", method = RequestMethod.GET)
    public Object toBuy(String shopName, HttpServletRequest request, HttpServletResponse respons) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        String gifttype = "";//礼品类型
        String actitytype = "";//活动类型
        String actitystatus = DataDic.ACTIVITY_STATUS_OPEN;//活动状态--开启的活动
        ShopVO shopVO = new ShopVO();
        if (StringUtils.isBlank(shopName)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "shopName商品名称为空";
        } else {
            try {

                if (StringUtils.isBlank(UserUtils.getUser().getId())) {
                    map.put("state", "1006");
                    map.put("message", "登录过期");
                    return map;
                }
                if (shopName.equals("you_qi")) {
                    shopVO.setShotName(shopName);
                    shopVO.setName("油气");
                    shopVO.setPrice("1");
                    gifttype = DataDic.ACTIVITYGIFT_TYPE_PETRO;
                    actitytype = DataDic.ACTIVITY_TYPE_PETRO;
                }
                if (shopName.equals("zd_coin")) {
                    shopVO.setShotName(shopName);
                    shopVO.setName("卓币");
                    shopVO.setPrice("1");
                    gifttype = DataDic.ACTIVITYGIFT_TYPE_COIN;
                    actitytype = DataDic.ACTIVITY_TYPE_COIN;
                }
                User user = UserUtils.getUser(true);
                //活动
                ActivityWxgift wxgift = new ActivityWxgift();
                ActivityWxinfo wxinfo = new ActivityWxinfo();
                wxgift.setGifttype(gifttype);//礼物类型
                wxgift.setCurrenttime(new Date());//当前时间
                wxinfo.setIseffective(actitystatus);//活动状态
                wxinfo.setType(actitytype);//活动类型
                wxgift.setWxinfo(wxinfo);
                //获取活动
                List<ActivityWxgift> giftlst = activityBiz.findWxgiftList(wxgift);
                if (giftlst.size() > 0) {
                    wxgift = giftlst.get(0);
                    result.put("wxgift", wxgift);
                }

                List<ActivityAwardrecord> awlist = new ArrayList<>();
                if (shopName.equals("you_qi")) {
                    //活动
                    ActivityWxgift gift = new ActivityWxgift();
                    gift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_PETRO);//礼物类型
                    ActivityAwardrecord aw = new ActivityAwardrecord();
                    aw.setWxgift(gift);
                    aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
                    aw.setPhone(user.getPhone());
                    awlist = activityBiz.awardrecordFindList(aw);
                }
                result.put("awlist", awlist);
                result.put("shop", shopVO);
                result.put("user", user);
            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 支付   判断支付类型
     *
     * @param shop
     * @param giftid
     * @param paytype
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "consumeType", method = RequestMethod.POST)
    public Object consumeType(ShopVO shop, String giftid, String paytype, String awardno, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (shop == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "购买项目为空";
        } else if (StringUtils.isBlank(paytype)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "paytype支付类型为空";
        } else if (StringUtils.isBlank(shop.getTotal())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "total总价格为空";
        } else if (StringUtils.isBlank(shop.getShotName())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "shopName商品名称为空";
        } else if (StringUtils.isBlank(shop.getNum())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "num购买数量为空";
        } else if (!StringUtils.isBlank(shop.getShotName()) && shop.getShotName().equals("zd_insur")) {
            if (StringUtils.isBlank(shop.getInsurid())) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "insurid保险id为空";
            }
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            try {
                shopBiz.consumeType(shop, giftid, paytype, awardno);
            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 卓大商场保险支付
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getInsurpay", method = RequestMethod.GET)
    public Object toinsurpay(String id, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        String gifttype = "";//礼品类型
        String actitytype = "";//活动类型
        String actitystatus = DataDic.ACTIVITY_STATUS_OPEN;//活动状态--开启的活动
        ShopVO shopVO = new ShopVO();
        if (StringUtils.isBlank(id)) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "id保险id为空";
        } else {
            try {

                if (StringUtils.isBlank(UserUtils.getUser().getId())) {
                    map.put("state", "1006");
                    map.put("message", "登录过期");
                    return map;
                }
                UserInsurance insurance = userInsuranceService.get(id);
                if (insurance != null) {
                    ShopVO shop = new ShopVO();
                    shop.setName(insurance.getInsurancetype());
                    shop.setTotal(insurance.getInsurancefeel());
                    shop.setShotName("zd_insur");
                    User user = UserUtils.getUser();
                    List<ActivityAwardrecord> awlist = new ArrayList<>();
                    //活动
                    ActivityWxgift gift = new ActivityWxgift();
                    gift.setGifttype(DataDic.ACTIVITYGIFT_TYPE_INSUR);//礼物类型
                    ActivityAwardrecord aw = new ActivityAwardrecord();
                    aw.setWxgift(gift);
                    aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);
                    aw.setPhone(user.getPhone());
                    awlist = activityBiz.awardrecordFindList(aw);
                    result.put("awlist", awlist);
                    result.put("user", user);
                    result.put("shop", shop);
                    result.put("userInsurance", insurance);
                } else {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "查无该保险记录";
                }

            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 获取卓大商场保险详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getInsurInfo", method = RequestMethod.GET)
    public Object insur_detail(String id) {
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
            message = "id保险id为空";
        } else {
            try {
                User user = UserUtils.getUser();
                result.put("user", user);
                UserInsurancelist insurlist = userInsurancelistService.get(id);
                result.put("insurlist", insurlist);
            } catch (Exception e) {
                e.printStackTrace();
                state = DataDic.RETURN_STATUS_SYSBUG;
                message = "服务器异常";
            }
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;

    }

    /**
     * 确认保险--新建单
     *
     * @param userInsurance
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveInsur", method = RequestMethod.POST)
    public Object saveInsur(UserInsurance userInsurance) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            result = (Map<String, Object>) shopBiz.saveInsur(userInsurance);
            state = (int) result.get("state");
            message = (String) result.get("message");
            map.put("data", result.get("data"));
        } catch (Exception e) {
            e.printStackTrace();
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /***
     * 获取保险品种列表
     * @param insurancelist 实体
     * @param pageNo 当前页
     * @param pageSize 页大小
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getInsuranceList", method = RequestMethod.GET)
    public Object getInsuranceList(UserInsurancelist insurancelist, int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";

        Page pg = new Page();
        pg.setLength(2);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {

            if (StringUtils.isBlank(UserUtils.getUser().getId())) {
                map.put("state", "1006");
                map.put("message", "登录过期");
                return map;
            }
            insurancelist.setIsenable(DataDic.YES);
            Page<UserInsurancelist> page = userInsurancelistService.findPage(pg, insurancelist);

            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            e.printStackTrace();
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

}
