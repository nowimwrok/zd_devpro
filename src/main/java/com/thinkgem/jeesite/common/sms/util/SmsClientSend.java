package com.thinkgem.jeesite.common.sms.util;



import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.sun.tools.javac.util.ClientCodeException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

/**
 * 阿里大鱼短信发送接口
 * 
 * @author by franky
 * @version 1.0
 * @date 2016年5月24日下午5:33:35
 */
public class SmsClientSend {

	/**
	 * 阿里大鱼短信发送接口
	 * 
	 * @param url  接口地址
	 * @param appkey 阿里大于分配给应用的AppKey
	 * @param secret 阿里大于分配给应用的AppSecret
	 * @param mobiles 短信接收号码。支持单个或多个手机号码，传入号码为11位手机号码，不能加0或+86。群发短信需传入多个号码，以英文逗号分隔，一次调用最多传入200个号码。示例：18600000000,13911111111,13322222222
	 * @param content 阿里大于短信模板变量，传参规则{"key":"value"}，key的名字须和申请模板中的变量名一致，多个变量之间以逗号隔开。示例：针对模板“验证码${code}，您正在进行${product}身份验证，打死不要告诉别人哦！”，传参时需传入{"code":"1234","product":"alidayu"} 
	 * @param sign 短信签名
	 * @param sms_template_code 阿里大于上短信模板ID
	 * @retur
	 * @throws Exception
	 */
	public static AlibabaAliqinFcSmsNumSendResponse sendSms(String url, String appkey, String secret, String mobiles, String content, String sign, String  sms_template_code) throws Exception {
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setSmsType("normal");
		req.setSmsFreeSignName(sign);
		req.setRecNum(mobiles);
		req.setSmsParamString(content);
		req.setSmsTemplateCode(sms_template_code);
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		return rsp;
	}
	/**
	 * 阿里大鱼短信发送接口
	 *
	 * @param domain  接口地址
	 * @param accessKeyId 阿里大于分配给应用的AppKey
	 * @param accessKeySecret 阿里大于分配给应用的AppSecret
	 * @param mobiles 短信接收号码。支持单个或多个手机号码，传入号码为11位手机号码，不能加0或+86。群发短信需传入多个号码，以英文逗号分隔，一次调用最多传入200个号码。示例：18600000000,13911111111,13322222222
	 * @param TemplateParam 阿里大于短信模板变量，传参规则{"key":"value"}，key的名字须和申请模板中的变量名一致，多个变量之间以逗号隔开。示例：针对模板“验证码${code}，您正在进行${product}身份验证，打死不要告诉别人哦！”，传参时需传入{"code":"1234","product":"alidayu"}
	 * @param sign 短信签名
	 * @param sms_template_code 阿里大于上短信模板ID
	 * @retur
	 * @throws Exception
	 */
	public static SendSmsRequest aLiyunSms(String domain,String accessKeyId, String accessKeySecret, String mobiles, String TemplateParam, String sign, String  sms_template_code)throws Exception{
	//设置超时时间-可自行调整
			System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
			System.setProperty("sun.net.client.defaultReadTimeout", "10000");
		//组装请求对象
		SendSmsRequest request = new SendSmsRequest();
		//使用post提交
		request.setMethod(MethodType.POST);
		//必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
		request.setPhoneNumbers(mobiles);
		//必填:短信签名-可在短信控制台中找到
		request.setSignName(sign);
		//必填:短信模板-可在短信控制台中找到
		request.setTemplateCode(sms_template_code);
		//可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
		//友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
		request.setTemplateParam(TemplateParam);
		//可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
		//request.setSmsUpExtendCode("90997");
		//可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
		//request.setOutId("yourOutId");
		return request;
	}
}
