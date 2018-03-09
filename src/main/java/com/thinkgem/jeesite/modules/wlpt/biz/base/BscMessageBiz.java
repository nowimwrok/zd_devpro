package com.thinkgem.jeesite.modules.wlpt.biz.base;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserMessage;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscMessageService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserMessageService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by fjc on 2017-11-15.
 */
@Service
@Transactional(readOnly = true)
public class BscMessageBiz extends BaseController {

    @Autowired
    private BscMessageService bscMessageService;

    @Autowired
    private UserMessageService userMessageService;

    public BscMessage get(String id) {
        return bscMessageService.get(id);
    }

    /**
     * 获取消息详情
     * @param id
     * @return
     */
    public UserMessage messageDetail(String id) {
        return userMessageService.get(id);
    }

    public List<BscMessage> findList(BscMessage bscMessage) {
        return bscMessageService.findList(bscMessage);
    }

    public List<BscMessage> findAllList(BscMessage bscMessage) {
        return bscMessageService.findAllList(bscMessage);
    }

    public Page<BscMessage> findPage(Page<BscMessage> page, BscMessage bscMessage) {
        return bscMessageService.findPage(page, bscMessage);
    }

    /**
     * 用户消息列表
     * @param page
     * @param userMessage
     * @return
     */
    public Page<UserMessage> findMessagePage(Page<UserMessage> page, UserMessage userMessage) {
        return userMessageService.findPage(page, userMessage);
    }

    /**
     * 统计未读消息数
     * @param userMessage
     * @return
     */
    public Map getSumUnRead(UserMessage userMessage) {
        if (StringUtils.isBlank(userMessage.getUser().getId())) {
            return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "用户id信息缺失", null);
        }
        userMessage=userMessageService.sumUnRead(userMessage);
        if(null==userMessage){
            userMessage=new UserMessage();
            userMessage.setSumUnRead("0");
        }
        return Tools.getMapResult(DataDic.RETURN_STATUS_NORMAL, "获取成功", userMessage);
    }

    @Transactional(readOnly = false)
    public void save(BscMessage bscMessage) {
        bscMessageService.save(bscMessage);
    }

    /**
     * 保存消息
     * @param bscMessage
     */
    @Transactional(readOnly = false)
    public void saveMessage(BscMessage bscMessage,UserMessage userMessage) {
        bscMessage.setIsNewRecord(true);
        bscMessageService.save(bscMessage);
        userMessageService.save(userMessage);
    }

    @Transactional(readOnly = false)
    public void delete(BscMessage bscMessage) {
        bscMessageService.delete(bscMessage);
    }

    @Transactional(readOnly = false)
    public Map messageRead(String id) {
        if (StringUtils.isBlank(id)) {
            return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "消息id信息缺失", null);
        }
        UserMessage userMessage=new UserMessage();
        userMessage.setId(id);
        userMessage.setStatus(DataDic.MESSAGE_IS_READ_YES);
        userMessageService.save(userMessage);//先更新UserMessage

        UserMessage userMessageInfo= userMessageService.get(id);

        BscMessage bscMessage = new BscMessage();
        bscMessage.setId(userMessageInfo.getMessage().getId());
        bscMessage.setIsRead(DataDic.MESSAGE_IS_READ_YES);//已读
        bscMessageService.save(bscMessage);//再更新BscMessage
        return Tools.getMapResult(DataDic.RETURN_STATUS_NORMAL, "操作成功", null);
    }
}
