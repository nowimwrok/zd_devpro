package com.thinkgem.jeesite.modules.wlpt.api.Integrity;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandardlog;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.IntegrityRecordVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "${appPath}/api/integrity")
public class IntegrityAppController extends BaseController {

    @Autowired
    private IntegrityBiz integrityBiz;


    //========================================================积分信息=================================================

    /**
     * 获取积分列表
     *
     * @param integrityStandardlog
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "integrityRecordList", method = RequestMethod.GET)
    public Object integrityRecordList(IntegrityStandardlog integrityStandardlog, Integer pageNo, Integer pageSize) {

        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
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
            integrityStandardlog.setUser(UserUtils.getUser());
            Page<IntegrityStandardlog> page = integrityBiz.findPage(pg, integrityStandardlog);
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
     * 获取总积分信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "sumPointvalueData", method = RequestMethod.GET)
    public Object sumPointvalueData() {

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
            IntegrityRecordVO iRecordVO = new IntegrityRecordVO();
            iRecordVO.setUser(UserUtils.getUser());
            iRecordVO = integrityBiz.getSumPointvalueData(iRecordVO);

            result.put("iRecord", iRecordVO);
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
