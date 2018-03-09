package com.thinkgem.jeesite.modules.wlpt.api.base;

import java.util.HashMap;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.Page;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.railregistBiz.RailRegistBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.railregist.RailRegist;


@Controller
@RequestMapping("${appPath}/api/railregist")
public class RailRegistAppController extends BaseController {
    @Autowired
    private RailRegistBiz RailRegistBiz;

    /**
     * 查询自定义电子围栏信息列表
     *
     * @param railRegist
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "showRailMsg", method = RequestMethod.GET)
    public Map<String, Object> findList(RailRegist railRegist, Integer pageNo, Integer pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            state = 1006;
            message = "登录过期";
            return Tools.getMapResult(state, message, null);
        }
        if (pageNo == null || pageSize == null) {
            map.put("state", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "页码参数缺失");
            return map;
        }
        try {
            Page pg = new Page();
            pg.setPageNo(pageNo);
            pg.setPageSize(pageSize);
            Page<RailRegist> page = RailRegistBiz.findPage(pg, railRegist);
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
}
