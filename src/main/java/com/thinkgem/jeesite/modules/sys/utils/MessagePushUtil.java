package com.thinkgem.jeesite.modules.sys.utils;

import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Message;
import cn.jpush.api.push.model.Options;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.Notification;
import com.thinkgem.jeesite.common.config.Global;
import org.apache.log4j.Logger;

import java.util.Map;


public final class MessagePushUtil {

    private static final Logger LOG = Logger.getLogger(MessagePushUtil.class);

    private final static String MASTER_SECRET;

    private final static String APP_KEY;

    static {
        MASTER_SECRET = Global.getConfig("messagePush.masterSecret");
        APP_KEY = Global.getConfig("messagePush.appKey");
    }

    private static PushPayload buildPushObject(String title, String summary, String uerId, Map<String, String> paramMap) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.android())
                .setAudience(Audience.alias(uerId))
                .setNotification(Notification.android(summary, title, paramMap))
                .setMessage(Message.newBuilder()
                        .setMsgContent(summary).setTitle(title).addExtras(paramMap)
                        .build()).setOptions(Options.newBuilder()
                        .setApnsProduction(true)
                        .build())
                .build();

    }

    public static boolean sendPush(String title, String summary, String userId,
                                   Map<String, String> paramMap) {

        boolean isSend = false;
        try {
            JPushClient jpushClient = new JPushClient(MASTER_SECRET, APP_KEY, 3);
            PushPayload pushPayload = buildPushObject(title, summary, userId, paramMap);
            PushResult result = jpushClient.sendPush(pushPayload);
            LOG.info("title:" + title + "summary:" + summary + "userId" + userId + "result:" + result);
            isSend = true;
        } catch (APIConnectionException e) {
            LOG.error("Connection error. Should retry later. " + e);
        } catch (APIRequestException e) {
            LOG.error("Error response from JPush server. Should review and fix it. " + e);
            LOG.error("HTTP Status: " + e.getStatus());
            LOG.error("Error Code: " + e.getErrorCode());
            LOG.error("Error Message: " + e.getErrorMessage());
            LOG.error("Msg ID: " + e.getMsgId());
        }catch (Exception e){
            LOG.error("e" + e);
        }
        return isSend;
    }

}
