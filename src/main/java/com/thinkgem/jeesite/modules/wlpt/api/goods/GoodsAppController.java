package com.thinkgem.jeesite.modules.wlpt.api.goods;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "${appPath}/api/goods")
public class GoodsAppController extends BaseController {

    @Autowired
    private GoodsBiz goodsBiz;


    //========================================================报价信息=================================================

    /**
     * 获取我的报价列表
     *
     * @param quoteinfo
     * @param pageNo
     * @param pageSize
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "quoteList", method = RequestMethod.GET)
    public Object getQuoteInfoList(Quoteinfo quoteinfo, int pageNo, int pageSize, HttpServletRequest request,
                                   HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        Page<Quoteinfo> pg = new Page<Quoteinfo>();
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        try {
            quoteinfo.setUser(UserUtils.getUser());// 获取当前登录用户
            Page<Quoteinfo> page = goodsBiz.getQuoteList(pg, quoteinfo);
            for (Quoteinfo var : page.getList()) {
                var.setStatusStr((DictUtils.getDictLabel(var.getQuotestatus(), "quotestatus", "")));
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
    }

    /**
     * 我的报价详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "quoteInfo", method = RequestMethod.GET)
    public Object quoteInfo(String id) {
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
                Quoteinfo quoteinfo = new Quoteinfo();
                quoteinfo.setId(id);
                quoteinfo = goodsBiz.getQuote(quoteinfo);
                if (quoteinfo == null) {
                    state = DataDic.RETURN_STATUS_INFOBUG;
                    message = "报价不存在";
                } else {
                    result.put("quoteinfo", quoteinfo);
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
