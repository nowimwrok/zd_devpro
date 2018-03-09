package com.thinkgem.jeesite.modules.wlpt.api.base;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.base.BscMessageBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserMessage;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by fjc on 2017-11-16.
 */
@Controller
@RequestMapping("${appPath}/api/message")
public class MessageAppController extends BaseController {

    @Autowired
    private BscMessageBiz bscMessageBiz;

    /**
     * 获取消息列表
     *
     * @param userMessage
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "messageList", method = RequestMethod.GET)
    public Object messageList(UserMessage userMessage, Integer pageNo, Integer pageSize) {

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
            userMessage.setUser(UserUtils.getUser());
            Page<BscMessage> page = bscMessageBiz.findMessagePage(pg, userMessage);
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
     * 获取消息详情
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "messageDetails", method = RequestMethod.GET)
    public Object messageDetails(String id) {

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
            map.put("state", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "消息id缺失");
            return map;
        }
        try {
            UserMessage userMessage = new UserMessage();
            userMessage = bscMessageBiz.messageDetail(id);

            result.put("message", userMessage);
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
     * 消息已读
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "messageRead", method = RequestMethod.POST)
    public Object messageRead(String id) {

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
            map.put("state", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "消息id缺失");
            return map;
        }
        try {
            bscMessageBiz.messageRead(id);
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
     * 获取消息未读数
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getSumUnRead")
    public Object getSumUnRead() {

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
            UserMessage userMessage = new UserMessage();
            userMessage.setUser(UserUtils.getUser());
            return bscMessageBiz.getSumUnRead(userMessage);
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
