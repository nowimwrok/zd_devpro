//package com.thinkgem.jeesite.modules.weixin.wxpay.util;
//
//import java.io.IOException;
//import java.text.DecimalFormat;
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.Comparator;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//import java.util.Map.Entry;
//
//import org.apache.commons.lang.StringUtils;
//import org.apache.log4j.Logger;
//import org.jdom.JDOMException;
//
//public class WxPayV3Helper {
//	private HashMap<String, String> parameters = new HashMap<String, String>();
//	private  final Logger logger = Logger.getLogger(WxPayV3Helper.class);
//	public void setParameters(HashMap<String, String> parameters) {
//		this.parameters = parameters;
//	}
//
//	private String appid = "";// 必填 String(32)微信分配的公众账号ID
//	private String mch_id = "";// 必填 String(32)微信支付分配的商户号
//	private String device_info = "";// 可选 String(32)微信支付分配的终端设备号
//	private String nonce_str = "";// 必填 String(32) 随机字符串，不长于32位
//	private String sign = "";// 必填 String(32) 签名
//	private String body = "";// 必填 String(127) 商品描述
//	private String attach = "";// 可选 String(127) 附加数据，原样返回
//	private String out_trade_no = "";// 必填 String(32) 商户系统内部的订单号
//	private int total_fee = 0; // 必填 Int 订单总金额，单位为分，不能带小数点
//	private String spbill_create_ip = "";// 必填 String(16) 订单生成的机器IP
//	private String time_start = "";// 可选 String(14) 订单生成时间，格式为yyyyMMddHHmmss，
//	private String time_expire = "";// 可选 String(14) 订单失效时间，格式为yyyyMMddHHmmss，
//	private String goods_tag = "";// 可选 String(32) 商品标记，该字段不能随便填，不使用请填空
//	private String notify_url = "";// 必填 String(256) 接收微信支付成功通知
//	private String trade_type = "";// 必填 String(16) JSAPI、NATIVE、APP
//	private String openid = "";// 可选 String(128)
//								// 用户在商户appid下的唯一标识，trade_type为JSAPI时，此参数必传，获取方式见表头说明。
//	private String product_id = "";// 可选 String(32)
//									// 只在trade_type为NATIVE时需要填写。此id为二维码中包含的商品ID，商户自行维护。
//	private String key = "";// 支付密钥
//
//	public void setKey(String key) {
//		this.key = key;
//	}
//
//	public void SetParameter(String key, String value) {
//		parameters.put(key, value);
//	}
//
//	public String GetParameter(String key) {
//		return parameters.get(key);
//	}
//
//	private Boolean CheckPrePayParameters() {
//		if (parameters.get("appid") == "" || parameters.get("mch_id") == "" || parameters.get("openid") == "" || parameters.get("nonce_str") == "" || parameters.get("body") == ""
//				|| parameters.get("out_trade_no") == "" || parameters.get("total_fee") == null || parameters.get("spbill_create_ip") == "" || parameters.get("notify_url") == ""
//				|| parameters.get("trade_type") == "") {
//			return false;
//		}
//		return true;
//	}
//
//	private Boolean CheckPayParameters() {
//		if (parameters.get("appId") == "" || parameters.get("timeStamp") == "" || parameters.get("nonceStr") == "" || parameters.get("package") == "" || parameters.get("signType") == "") {
//			return false;
//		}
//		return true;
//	}
//
//	// 生成签名
//	public String CreateSign(HashMap<String, String> mapParames, String characterEncoding) throws SDKRuntimeException {
//
//		HashMap<String, String> bizParameters = new HashMap<String, String>();
//		List<Map.Entry<String, String>> infoIds = new ArrayList<Map.Entry<String, String>>(mapParames.entrySet());
//
//		Collections.sort(infoIds, new Comparator<Map.Entry<String, String>>() {
//			public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
//				return (o1.getKey()).toString().compareTo(o2.getKey());
//			}
//		});
//
//		for (int i = 0; i < infoIds.size(); i++) {
//			Map.Entry<String, String> item = infoIds.get(i);
//			if (item.getKey() != "") {
//				bizParameters.put(item.getKey(), item.getValue());
//			}
//		}
//		String bizString = CommonUtil.FormatQueryParaMap(bizParameters, false);
//		if (key == "") {
//			throw new SDKRuntimeException("key为空！");
//		}
//		bizString+="&key="+key;
//		
//		logger.info("MD5加密前字符串:" + bizString);
//		return MD5Util.MD5Encode(bizString, characterEncoding).toUpperCase();
//	}
//
//	/**
//	 * 生成js api统一支付接口的请求xml （预支付）
//	 */
//	public String CreatePrePayPackage() throws SDKRuntimeException {
//		HashMap<String, String> nativeObj = new HashMap<String, String>();
//		if (CheckPrePayParameters() == false) {
//			throw new SDKRuntimeException("生成package参数缺失！");
//		}
//		parameters.put("sign", CreateSign(parameters, "UTF-8"));
//		return MapToXml(parameters);// getRequestXml(parameters);
//	}
//
//	/**
//	 * 生成js api支付请求数据包（支付）
//	 */
//	public String CreatePayPackage() throws SDKRuntimeException {
//		if (CheckPayParameters() == false) {
//			throw new SDKRuntimeException("生成package参数缺失！");
//		}
//
//		parameters.put("paySign", CreateSign(parameters, "UTF-8"));
//		return MapToJson(parameters);
//	}
//
//	public String MapToJson(HashMap<String, String> arr)
//	{
//		List<Map.Entry<String, String>> infoIds = new ArrayList<Map.Entry<String, String>>(arr.entrySet());
//		Collections.sort(infoIds, new Comparator<Map.Entry<String, String>>() {
//			public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
//				return (o1.getKey()).toString().compareTo(o2.getKey());
//			}
//		});
//
//		String jsonStr = "";
//		String paySign="";
//		Iterator<Entry<String, String>> iter = infoIds.iterator();
//		while (iter.hasNext()) {
//			Entry<String, String> entry = iter.next();
//			String key = entry.getKey();
//			String val = entry.getValue();
//			
//			if (key.toLowerCase().equals("paysign")) {
//				paySign = ",\""+key+"\":\""+val+"\"";
//			}else
//				jsonStr +=",\""+key+"\":\""+val+"\"";
//		}
//		
//		jsonStr ="{" +jsonStr.substring(1) + paySign + "}";
//		return jsonStr;
//	}
//	public String MapToXml(HashMap<String, String> arr) {
//
//		List<Map.Entry<String, String>> infoIds = new ArrayList<Map.Entry<String, String>>(arr.entrySet());
//		Collections.sort(infoIds, new Comparator<Map.Entry<String, String>>() {
//			public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
//				return (o1.getKey()).toString().compareTo(o2.getKey());
//			}
//		});
//
//		String xml = "<xml>";
//		String nodeSign = "";
//		Iterator<Entry<String, String>> iter = infoIds.iterator();
//		while (iter.hasNext()) {
//			Entry<String, String> entry = iter.next();
//			String key = entry.getKey();
//			String val = entry.getValue();
//			if (key.toLowerCase().equals("sign")) {
//				nodeSign = "<" + key + "><![CDATA[" + val + "]]></" + key + ">";
//			} else {
//				if(key.toLowerCase().equals("attach") || key.toLowerCase().equals("body")){
//					xml += "<" + key + "><![CDATA[" + val + "]]></" + key + ">";
//				} else
//					xml += "<" + key + ">" + val + "</" + key + ">";
//			}
//		}
//		xml += nodeSign + "</xml>";
//		return xml;
//	}
//
//	public static void main(String[] args) throws SDKRuntimeException, JDOMException, IOException {
//
//		WxPayV3Helper wxPrePayHelper = new WxPayV3Helper();
//		wxPrePayHelper.setKey("1302486788813110716655shab301068");
//		wxPrePayHelper.SetParameter("appid", "wxa3cac9b4a3720ad4");
//		wxPrePayHelper.SetParameter("mch_id", "10018910");
//		wxPrePayHelper.SetParameter("openid", "oJxmrjrKXo2bBdk840_F4KwbDdYQ");
//
//		wxPrePayHelper.SetParameter("nonce_str", CommonUtil.getNonceStr());
//		wxPrePayHelper.SetParameter("body", "会杀"); // 订单描述
//		wxPrePayHelper.SetParameter("out_trade_no", "abc12345678--101");// 订单编号
//		wxPrePayHelper.SetParameter("total_fee", new DecimalFormat("0").format(1000));// 订单总金额:单位为分
//		String ip = "106.120.108.228";
//		wxPrePayHelper.SetParameter("spbill_create_ip", StringUtils.isBlank(ip) ? "127.0.0.1" : ip.split(",")[0]);
//		wxPrePayHelper.SetParameter("notify_url", "http://v.veshow.cn/weixinpay/weixin_notify_v3!payNotify.action?showwxpaytitle=1");
//		wxPrePayHelper.SetParameter("trade_type", "JSAPI");// JSAPI、NATIVE、APP
//
//		// wxPayHelper.getBizSign(bizObj);
//		// wxPayHelper.SetParameter("sign",wxPayHelper.CreateBizPackage()));
//
//		String reqXmlData = wxPrePayHelper.CreatePrePayPackage();
//
//		WxPayV3Helper wxPayHelper = new WxPayV3Helper();
//		wxPayHelper.setKey("1302486788813110716655shab301068");
//		wxPayHelper.SetParameter("appId", "wxa3cac9b4a3720ad4");
//		wxPayHelper.SetParameter("timeStamp", CommonUtil.getTimeStamp());
//		wxPayHelper.SetParameter("nonceStr", CommonUtil.getNonceStr());
//		wxPayHelper.SetParameter("package", "prepay_id=" + "wx2014121821422869ebe6ca090210656761");
//		wxPayHelper.SetParameter("signType", "MD5");
//		//System.err.println(reqXmlData);
//		
//		String weixinReqData = wxPayHelper.CreatePayPackage();
//		String has1 = SHA1Util.Sha1("appid=wxa3cac9b4a3720ad4&deliver_msg=ok&deliver_status=1&deliver_timestamp=1418981248&openid=oJxmrjrKXo2bBdk840_F4KwbDdYQ&out_trade_no=20141219121859416236&transid=1008490094201412190007659394&key=1302486788813110716655shab301068");
//		
//		System.err.println("has1:"+has1);
////		Map test = XMLUtil.doXMLParse(reqXmlData);
////		System.err.println(test + "----");
////		Map resultMap = XMLUtil.doXMLParse(rpsXmlData);
////		System.err.println(resultMap + "----");
//
//	}
//
//}
