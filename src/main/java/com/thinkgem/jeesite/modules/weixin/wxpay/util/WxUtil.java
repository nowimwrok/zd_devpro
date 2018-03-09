//package com.thinkgem.jeesite.modules.weixin.wxpay.util;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.util.Arrays;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//import java.util.SortedMap;
//import java.util.TreeMap;
//
//import org.apache.http.NameValuePair;
//import org.apache.log4j.Logger;
//import org.dom4j.Document;
//import org.dom4j.DocumentHelper;
//import org.dom4j.Element;
// 
//
//public class WxUtil {
//	public static Logger logger = Logger.getLogger(WxUtil.class);
//	/**
//	 * 数组转字符串
//	 * @author GUOERZHONG
//	 * @param arr 要转化的数组
//	 * @return 转化后的字符串
//	 */
//	public static  String arrayToString(String [] arr){  
//        StringBuffer bf = new StringBuffer();  
//        for(int i = 0; i < arr.length; i++){  
//         bf.append(arr[i]);  
//        }  
//        return bf.toString();  
//    }
//	/**
//	 * 从指定的输入流中读取数据
//	 * @author GUOERZHONG
//	 * @param in 要读取的输入流
//	 * @return 读取后的数据
//	 */  
//    public static String readDataFromStream(InputStream in){  
//    	StringBuffer buffer = new StringBuffer();  
//        BufferedReader reader=null;  
//        try{  
//            reader = new BufferedReader(new InputStreamReader(in,"utf-8"));  
//            int charCount = -1;
//            while ((charCount = reader.read()) != -1) {
//            	buffer.append((char) charCount);
//			}
//        }catch(Exception e){  
//            e.printStackTrace();
//            return null;
//        }finally{  
//            if(null!=reader){  
//                try {  
//                    reader.close();  
//                } catch (IOException e) {  
//                    e.printStackTrace();  
//                    return null;
//                }  
//            }  
//        }  
//        return buffer.toString();  
//    } 
//
//    /**
//     * 微信支付用户信息  用于微信支付V3
//     * @param xml
//     * @return
//     */
//    public static SortedMap<String , String> getPayUserInfoFromXml_V3(String xml){
//    	HashMap<String, String> ret = new HashMap<String, String>();
//		Document document = null;
//		try {
//			document = DocumentHelper.parseText(xml);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (null == document) {
//			logger.error("解析xml数据出错!");
//			return null;
//		}
//		Element root = document.getRootElement();
//		List<Element> elements = root.elements();
//		for (Iterator<Element> it = elements.iterator(); it.hasNext();) {
//			Element element = it.next();
//			ret.put(element.getName(),element.getText());
//		}
//		SortedMap<String,String> sort=new TreeMap<String,String>(ret);  
//        return sort;
//    } 
//    
//    /**
//	 * 根据微信平台发送过来的数据验证签名
//	 * @author GUOERZHONG
//	 * @param signature 微信生成的签名 timestamp 时间戳  nonce 随机数  token 开发者自己的密钥
//	 * @return 是否验签成功
//	 */ 
//    public static  boolean checkSign(String signature,String timestamp,String nonce,String token){
//    	String[] strArray=new String[]{token,timestamp,nonce};
//		Arrays.sort(strArray);
//		String concatstr=arrayToString(strArray);
//		String localsign=EncryptUtil.sha(concatstr);//生成的本地签名
//		if(localsign.equals(signature)){
//			return true;
//		}else{
//			return false;
//		}
//    }
//    /**
//     * 创建签名用于比对
//     * @param charSet
//     * @param parameters
//     * @return
//     */
//    public static String createSign(String charSet,SortedMap<String , String> parameters){
//
//        StringBuffer sb = new StringBuffer();
//        
//        for(Map.Entry<String,String> mapping:parameters.entrySet()){
//        	String k = mapping.getKey();
//
//            String v = mapping.getValue();
//            if(null != v && !"".equals(v)
//
//                    && !"sign".equals(k) && !"key".equals(k)) {
//
//                sb.append(k + "=" + v + "&");
//
//            }
//        } 
//        sb.append("key=" + WeixinAlipayConfig.API_KEY);//xxxxxx换成你的API密钥
//        String sign = MD5Util.MD5Encode(sb.toString(), charSet).toUpperCase();
//        return sign;
//
//    }
//    
//    public static String genAppSign(List<NameValuePair> params) {
//		StringBuilder sb = new StringBuilder();
//
//		for (int i = 0; i < params.size(); i++) {
//			sb.append(params.get(i).getName());
//			sb.append('=');
//			sb.append(params.get(i).getValue());
//			sb.append('&');
//		}
//		sb.append("key=");
//		sb.append(WeixinAlipayConfig.app_key);
//
//		String appSign = MD5.getMessageDigest(sb.toString().getBytes()).toUpperCase();
//		return appSign;
//	}
//    
//    
//    public static String genJSAPISign(List<NameValuePair> params) {
//		StringBuilder sb = new StringBuilder();
//
//		for (int i = 0; i < params.size(); i++) {
//			sb.append(params.get(i).getName());
//			sb.append('=');
//			sb.append(params.get(i).getValue());
//			sb.append('&');
//		}
//		sb.append("key=");
//		sb.append(WeixinAlipayConfig.GZ_key);
//
//		String appSign = MD5.getMessageDigest(sb.toString().getBytes()).toUpperCase();
//		return appSign;
//	}
//
//}
