package com.thinkgem.jeesite.common.sms.util;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.transaction.annotation.Transactional;

import com.taobao.api.domain.BizResult;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.sms.ruanwei.interfacej.SmsClientOverage;
import com.thinkgem.jeesite.common.sms.ruanwei.interfacej.SmsClientSend;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Request;
import com.thinkgem.jeesite.common.utils.RequestContent;
import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.XMLUtil;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sms.entity.SendLog;
import com.thinkgem.jeesite.modules.sms.entity.Template;
import com.thinkgem.jeesite.modules.sms.service.SendLogService;
import com.thinkgem.jeesite.modules.sms.service.TemplateService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;

/**
 * ClassName: SmsUtil
 *
 * @author 饶江龙
 * @Description:短信发送工具类,SendSms:提供发送短信
 * @date 2016年7月20日
 */
public class SmsUtil extends BaseController {


    /**
     * @Description: 判断手机验证码是否超时,是否正确
     * @param telphone
     * @param vercode
     * @param codeValidity 分钟 验证码有效期
     * @return
     * @return int 1表示验证通过，0表示验证码错误，2表示验证码超时,3表示发生错误
     * @throws
     * @author 饶江龙
     * @date 2016年7月21日
     */
    public static int judgeSmsVerCode(String telphone, String vercode, int codeValidity, String funName) {
        try {
            SendLog smssendlog=new SendLog();
            smssendlog.setMobiles(telphone);
            smssendlog.setSmsContent(vercode);
            smssendlog.setFunction(funName);
            SendLogService smssendlogService=ServiceHelper.getSmssendLogService();
            smssendlog = smssendlogService.findByPhoneVerCodeAndFun(smssendlog);
            if (smssendlog == null) {
                return 0;
            } else {
                String sendTime = smssendlog.getSendTime();
                Calendar dayc1 = new GregorianCalendar();
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date daystart = df.parse(sendTime); // start_date是类似"2013-02-02"的字符串
                dayc1.setTime(daystart);
                dayc1.add(Calendar.MINUTE, codeValidity);

                Calendar currentTime = Calendar.getInstance();
                if (dayc1.before(currentTime)) {
                    return 2;
                } else {
                    return 1;
                }
            }
        } catch (Exception ex) {
            return 3;
        }
    }

    /***
     * @param openId          发送到用户id null则不推送微信消息
     * @param phone           发送到的电话
     * @param smsTemplateCode 短信模板编码
     * @param module          来源
     * @param function        短信类型
     * @param keyword         替换内容是个数组{fisrt,keyword1,keywork2,……,remark}
     *                        模板消息ID,ConstantWeChat.NEW_ORDER
     * @param isSendSMS       是否发送短信
     * @return
     */
    public static int sendSmsMesge(String openId,String smsTemplateCode, String phone, Const.System_Module_Enum module, String function, String[] keyword, String templateID, String url, boolean isSendSMS, String aliSmsCode) {
        int state = 1;
     // 给货主发送短信并推送微信信息
        new Request(new RequestContent(){
           	 public void doSomeThing(){
           		 System.out.println("doSomething");
           	 }
           	 public void onSuccess(){
           		asynsend(openId,smsTemplateCode,phone,module,function,keyword,templateID,url,isSendSMS,aliSmsCode);
           	 }
       	}).start();
        /*try {
            Template template = getSmsTemplate(smsTemplateCode);
            String smsTemplate = template.getTemplate().toString(); // 得到短信模板字符串
            if(!StringUtils.isNoneBlank(smsTemplate)){
            	state = 0;
            	return state;
            }
            String smsContent = smsTemplate;
            StringBuffer sendSmsContent = new StringBuffer("{");//阿里大于短信
            Map<String, String> mapData = new HashMap<String, String>();
            for (int i = 0; i < keyword.length; i++) {
                // /i==0是为first
                if (i == 0) {
                    smsContent = smsTemplate.replace("{{first}}", keyword[i]);
                    sendSmsContent.append("\"first\":\""+keyword[i]+"\"");// 阿里大于短信
                    mapData.put("first", keyword[i]);
                    continue;
                } else {
                    // i==keyword.length 为最后的mark
                    if (i + 1 == keyword.length) {
                        smsContent = smsContent.replace("{{remark}}", keyword[i]);
                        sendSmsContent.append(",\"remark\":\""+keyword[i]+"\"");// 阿里大于短信
                        mapData.put("remark", keyword[i]);
                        continue;
                    } else {
                        mapData.put("keyword" + i, keyword[i]);
                        smsContent = smsContent.replace("{{keyword" + i + "}}", keyword[i]);
                        sendSmsContent.append(",\"keyword"+i+"\":\""+keyword[i]+"\"");// 阿里大于短信
                    }
                }
            }
            sendSmsContent.append("}");
            if (Tools.IsNullOrWhiteSpace(url)) {
                url = "";
            }
            if (!Tools.IsNullOrWhiteSpace(openId)) {
                System.out.println("----------------------openID=" + openId);
                TemplateService.sendWXTempMessage(openId, templateID, url, mapData);
                System.out.println("----------------------openID=" + openId + "-------success");
            }

            if (phone != null && phone.startsWith("1") && isSendSMS) {
            	String needSign = "1";
            	if(smsTemplateCode.equals(DataDic.SMSCODE_REGISTER)){
            		needSign = "0";
            	}
                SendLog smssendlog = new SendLog();
                smssendlog.setMobiles(phone);
                smssendlog.setSmsContent(smsContent);
                smssendlog.setModule(module.toString());
                smssendlog.setFunction(function);
                smssendlog.setUser(UserUtils.getUser());
                smssendlog.setSendTime(DateUtil.getTime());
                try {
    				AlibabaAliqinFcSmsNumSendResponse response = com.thinkgem.jeesite.common.sms.util.SmsClientSend.sendSms(SmsConfig.smsUrl, SmsConfig.appKey, SmsConfig.appSecret, phone, sendSmsContent.toString(), SmsConfig.smsFreeSignName, aliSmsCode);
                    System.out.println("==========="+response);
    				BizResult bizResult = response.getResult();
                    System.out.println("==========="+bizResult);
    				if(bizResult != null && "0".equals(bizResult.getErrCode()) && bizResult.getSuccess())
    					return 1;
    				else{
    					SmsSendStateEnum sssEnum = SendSms(smssendlog,needSign); // 发送短信
    	                switch (sssEnum) {
    	                    case Succeed:
    	                        state = 1;
    	                        break;
    	                    case InsufficientBalance:
    	                        state = 0;
    	                        break;
    	                    case HaveFilterKey:
    	                        state = 0;
    	                        break;
    	                    case MsgOverstep:
    	                        state = 0;
    	                        break;
    	                    default:
    	                        state = -1;
    	                }
    				}
    			} catch (Exception e) {
    				return -1;
    			 }finally{
    				 if (UserUtils.getUser() != null) {
    	                    smssendlog.setUser(UserUtils.getUser());
    	                }
    	                //smssendlog.setCost("0.5");
    	                smssendlog.setSendTime(DateUtil.getTime());
    	                SendLogService smslogsv = ServiceHelper.getSmssendLogService();
    	                smslogsv.save(smssendlog);
    			 }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            state = -1;
        }*/
        return state;
    }

    /**
     * 异步发送短信
     * @param openId
     * @param smsTemplateCode
     * @param phone
     * @param module
     * @param function
     * @param keyword
     * @param templateID
     * @param url
     * @param isSendSMS
     * @param aliSmsCode
     */
    public static int asynsend(String openId,String smsTemplateCode, String phone, Const.System_Module_Enum module, String function, String[] keyword, String templateID, String url, boolean isSendSMS, String aliSmsCode){
    	int state = 1;
        try {
            Template template = getSmsTemplate(smsTemplateCode);
            String smsTemplate = template.getTemplate().toString(); // 得到短信模板字符串
            if(!StringUtils.isNoneBlank(smsTemplate)){
            	state = 0;
            	return state;
            }
            String smsContent = smsTemplate;
            StringBuffer sendSmsContent = new StringBuffer("{");//阿里大于短信
            Map<String, String> mapData = new HashMap<String, String>();
            for (int i = 0; i < keyword.length; i++) {
                // /i==0是为first
                if (i == 0) {
                    smsContent = smsTemplate.replace("{{first}}", keyword[i]);
                    sendSmsContent.append("\"first\":\""+keyword[i]+"\"");// 阿里大于短信
                    mapData.put("first", keyword[i]);
                    continue;
                } else {
                    // i==keyword.length 为最后的mark
                   /* if (i + 1 == keyword.length) {
                        smsContent = smsContent.replace("{{remark}}", keyword[i]);
                        sendSmsContent.append(",\"remark\":\""+keyword[i]+"\"");// 阿里大于短信
                        mapData.put("remark", keyword[i]);
                        continue;
                    } else {*/
                        mapData.put("keyword" + i, keyword[i]);
                        smsContent = smsContent.replace("{{keyword" + i + "}}", keyword[i]);
                        sendSmsContent.append(",\"keyword"+i+"\":\""+keyword[i]+"\"");// 阿里大于短信
                    }
                //}
            }
            sendSmsContent.append("}");
            if (Tools.IsNullOrWhiteSpace(url)) {
                url = "";
            }
            if (!Tools.IsNullOrWhiteSpace(openId)) {
                System.out.println("----------------------openID=" + openId);
                TemplateService.sendWXTempMessage(openId, templateID, url, mapData);
                System.out.println("----------------------openID=" + openId + "-------success");
            }

            if (phone != null && phone.startsWith("1") && isSendSMS) {
            	String needSign = "1";
            	if(smsTemplateCode.equals(DataDic.SMSCODE_REGISTER)){
            		needSign = "0";
            	}
                SendLog smssendlog = new SendLog();
                smssendlog.setMobiles(phone);
                smssendlog.setSmsContent(smsContent);
                smssendlog.setModule(module.toString());
                smssendlog.setFunction(function);
                smssendlog.setUser(UserUtils.getUser());
                smssendlog.setSendTime(DateUtil.getTime());
                smssendlog.setIsNewRecord(true);
                smssendlog.setId(IdGen.uuid());
                try {
                    //初始化ascClient,暂时不支持多region（请勿修改）
                    IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", SmsConfig.appKey,
                            SmsConfig.appSecret);
                    DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", "Dysmsapi", "dysmsapi.aliyuncs.com");
                    IAcsClient acsClient = new DefaultAcsClient(profile);
                    SendSmsRequest request = com.thinkgem.jeesite.common.sms.util.SmsClientSend.aLiyunSms(SmsConfig.smsUrl, SmsConfig.appKey, SmsConfig.appSecret, phone, sendSmsContent.toString(), SmsConfig.smsFreeSignName, aliSmsCode);
                    SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
                    System.out.println("============"+sendSmsResponse.getCode());
                    if(sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
                        //请求成功
                        state = 1;
                    }
    				else{
    					SmsSendStateEnum sssEnum = SendSms(smssendlog,needSign); // 发送短信
    	                switch (sssEnum) {
    	                    case Succeed:
    	                        state = 1;
    	                        break;
    	                    case InsufficientBalance:
    	                        state = 0;
    	                        break;
    	                    case HaveFilterKey:
    	                        state = 0;
    	                        break;
    	                    case MsgOverstep:
    	                        state = 0;
    	                        break;
    	                    default:
    	                        state = -1;
    	                }
    				}
    	                if (UserUtils.getUser() != null) {
    	                    smssendlog.setUser(UserUtils.getUser());
    	                }
    	                //smssendlog.setCost("0.5");
    	                smssendlog.setSendTime(DateUtil.getTime());
    	                SendLogService smslogsv = ServiceHelper.getSmssendLogService();
    	                String sm = smssendlog.toString();
    	                System.out.println("打印："+sm);
    	                smslogsv.save(smssendlog);
    			} catch (Exception e) {
    				 e.printStackTrace();
    				return -1;
    			 }finally{
    				 
    			 }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            state = -1;
        }
        return state;
    }
    
    
    /***
     * 获取短信模版信息,通过短信编码
     *
     * @param templateCode 模版编码
     * @return
     */
    public static Template getSmsTemplate(String templateCode) {
        Template smstemplate = new Template();
        smstemplate.setCode(templateCode);
        TemplateService smstemplateService = ServiceHelper.getSmstemplateService();
        smstemplate = smstemplateService.findSmstemlate(smstemplate);
        return smstemplate;
    }

    /***
     * 发送短信
     *
     * @param smssendlog 消息日志对象  手机号码
     * @param
     * @return SendResultType
     * @author 饶江龙
     * @Description: 发送短信
     * @date 2016年7月20日
     */

    @Transactional(readOnly = true)
    public static SmsSendStateEnum SendSms(SendLog smssendlog,String needSign) {
        /*String account = "", password = "",url="",uid="";*/
        String account = "", password = "", url = "", Extends = "{}";//短信2配置--sms3
        //String strSMS = Tools.readTxtFile(Const.SMSCS);//读取测试短信配置
        String strSMS = Tools.readTxtFile(Const.SMS);//读取短信配置
        if (null != strSMS && !"".equals(strSMS)) {
            String strS1[] = strSMS.split(",wl,");
            if (strS1.length == 4) {
                account = strS1[0];
                password = strS1[1];
                /*uid=strS1[2];*/
                url = strS1[3];
            }
        }
        ////获取手机号码
        String mobiles = smssendlog.getMobiles().trim();
        ///获取短信内容
        String smsContent = smssendlog.getSmsContent();
        String result = "";

        if (mobiles.startsWith("1")) {
            result = SmsClientSend.sendSms3(url, account, password, mobiles, smsContent, needSign, Extends);//短信2配置--sms3

            HashMap resultMap = new HashMap();
            try {

                Document document = DocumentHelper.parseText(result);
                Element element = document.getRootElement();
                for (Iterator i = element.elementIterator(); i.hasNext(); ) {
                    Element element2 = (Element) i.next();

                    for (Iterator it = element2.elementIterator(); it.hasNext(); ) {
                        Element element3 = (Element) it.next();
                        Attribute names = element3.attribute("name");
                        Attribute values = element3.attribute("value");
                        String name = names.getText();
                        String value = values.getText();
                        resultMap.put(name, value);
                    }

                }

                if (resultMap.get("message").toString().equals("包含非法字符")) {
                    return SmsSendStateEnum.HaveFilterKey;
                } else if ((resultMap.get("result").toString()).indexOf("40") > 0) {
                    return SmsSendStateEnum.Error;
                }
                /**ok	提交成功
                 用户名或密码不能为空	提交的用户名或密码为空
                 发送内容包含sql注入字符	包含sql注入字符
                 用户名或密码错误	表示用户名或密码错误
                 短信号码不能为空	提交的被叫号码为空
                 短信内容不能为空	发送内容为空
                 包含非法字符：	表示检查到不允许发送的非法字符
                 对不起，您当前要发送的量大于您当前余额	当支付方式为预付费是，检查到账户余额不足
                 其他错误	其他数据库操作方面的错误**/

                return SmsSendStateEnum.Succeed;
            } catch (Exception e) {
                // TODO 自动生成的 catch 块
                e.printStackTrace();
                return SmsSendStateEnum.Error;
            }
        }
        return SmsSendStateEnum.Succeed;
    }

    /***
     * 返回余额查询字符串
     *
     * @param @return
     * @return String
     * @throws DocumentException
     * @throws
     * @Description: TODO
     * @author 
     * @date 2015年6月13日
     */
    public static String queryOveragequeryOverage() throws DocumentException {
        String account = "", password = "", url = "", uid = "";
        String strSMS1 = Tools.readTxtFile(Const.SMS1);
        if (null != strSMS1 && !"".equals(strSMS1)) {
            String strS1[] = strSMS1.split(",wl,");
            if (strS1.length == 4) {
                account = strS1[0];
                password = strS1[1];
                uid = strS1[2];
                url = strS1[3];
            }
        }
        String result = XMLUtil.getXMLProperty(getSMSString()).get("overage");
        return result;
    }

    /***
     * 获取http://客户端地址/sms.aspx返回的xml
     *
     * @param @return
     * @param @throws DocumentException
     * @return String
     * @throws
     * @Description: TODO
     * @author 
     * @date 2015年6月15日
     */
    private static String getSMSString() throws DocumentException {
        String account = "", password = "", url = "", uid = "";
        String strSMS1 = Tools.readTxtFile(Const.SMS1);
        if (null != strSMS1 && !"".equals(strSMS1)) {
            String strS1[] = strSMS1.split(",wl,");
            if (strS1.length == 4) {
                account = strS1[0];
                password = strS1[1];
                uid = strS1[2];
                url = strS1[3];
            }
        }
        return SmsClientOverage.queryOverage(url, uid, account, password);
    }
}
