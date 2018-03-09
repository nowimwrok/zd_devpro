package com.thinkgem.jeesite.modules.weixin.constant;

import com.thinkgem.jeesite.modules.weixin.utils.ConfigUtil;

import com.thinkgem.jeesite.common.utils.Enum.WeChatTemple;

import java.util.HashMap;
import java.util.Map;

import com.thinkgem.jeesite.common.utils.Const.System_Module_Enum;

/**
 * 微信常量
 * @author txw
 * @version 1.0
 */
public class ConstantWeChat {
	
	/**
	 * OAUTH scope
	 */
	public static final String SCOPE_SNSAPI_BASE = "snsapi_base";
	public static final String SCOPE_SNSAPI_USERINFO = "snsapi_userinfo";
	
	/**
	 * 与接口配置信息中的Token要一致
	 */
	public static String TOKEN = ConfigUtil.get("token");
	
	/**
	 * 第三方用户唯一凭证
	 */
	public static String APPID = ConfigUtil.get("appId");
	/**
	 * 第三方用户唯一凭证密钥
	 */
	public static String APPSECRET = ConfigUtil.get("appSecret");
	
	/**
	 * 获取微信后台accessToken服务器地址
	 */
	public static final String SERVICE_URL = ConfigUtil.get("accessTokenUrl");
	public static final String SERVICE_URLS = ConfigUtil.get("serviceUrl");
	/**
	 * 微信增值服务Url地址
	 */
	public static final String ADD_VALUE_URL = ConfigUtil.get("addValueServerUrl");
	
	/**
	 * 模板消息：运单生成通知
	 * 	IwF8U18ppLUoGWKbDExkS0o0Gs2EaU5eMXOYHlao4a4   测试
	 *  MQcG0cdixwZK7qRBX2LfHnDPkan-nuagMqVtypDip4U  正式
	 */
	public static final String NEW_ORDER = "MQcG0cdixwZK7qRBX2LfHnDPkan-nuagMqVtypDip4U";//正式
	//public static final String NEW_ORDER = "IwF8U18ppLUoGWKbDExkS0o0Gs2EaU5eMXOYHlao4a4";//测试
	
	/**
	 * 测试模板消息：发布招标
	 * 6pTMZkphQoMsSiFjJvyiw6wtYaQr3XfMt6t5Ci2X0tg   测试
	 * CPRiX4VxhwFT870Fwp4c3ztuWi_4653Clj1WQUQtkzU   正式
	 */
	public static final String PUB_BID= "0S-sirNxKTMkILy40vSVEM4RYCMen7GSE0CzM5dVN8M";//正式
	//public static final String PUB_BID= "XZr8OCLEOUxvucO7qezwCwxKctUdaV1ilZNL2QMB0a4";//测试
	
	/**
	 * 测试模板消息：中标招标
	 */
	public static final String NOTICE_BID= "KHbwiJkwdbTpmynLj2y420hgCpCJ_OSM8ReftGpX-XQ";//正式
	//public static final String NOTICE_BID= "	OnPVHqMRHc-ot2dIa1-YEs96TO7xfAEoN8xlOJELRT0";//测试
	
	/**CANCEL_BID
	 * 测试模板消息：竞价成功招标
	 */
	public static final String SUCCES_BID= "XWBo2KVVk89ISrnimTpaSfEutNWiQ24fgT7LJ0xWDN4";
	
	/**
	 * 测试模板消息：废标通知
	 */
	public static final String CANCEL_BID= "9abT8sByNBbcH-vNG1xzpqMLM89EfssjQ1zi1u53BQI";
	
	/*public static final String NEW_ORDER = "o1JmpC3v7omM6ANdRCawzxCJrdFSrna4HglJIoeBCTU";*/
	/**
	 * 模板消息：退单状态通知
	 */
	public static final String ORDER_CANCEL = "1RxDtC_FL_yIOm9XzHfJn5PzrAZWqzP6LLKWOwuiDOo";
	
	/**
	 * 模板消息：运单状态更新通知
	 */
	public static final String ORDER_STATUS = "hcr0FXp5Y07IkmiUJeD9VNNw4ehyj_ZuUaC5WN-08Ss";//正式
	//public static final String ORDER_STATUS = "Tjg58XdIWw_Uwfxo8x2lBLsuYz0tPEeyqoD7Ix3NM00";//测试
	
	
	/**
	 * 模板消息：运单状态完成通知
	 */
	public static final String ORDER_STATUS_COMPLETED = "IPujwqdqC8pylBO90QFXKRyadUy1n8cpJYsJTazro00";
	
	/**
	 * 模板消息：运单状态已受理通知
	 */
	public static final String ORDER_STATUS_ACCEPTANCE = "2KSsPq_7EBFx0K5Wl0w_yLgWYgz0Q3_hpyzbQpKdqxk";
	
	
	/**
	 * 模板消息：货源匹配通知
	 */
	/*public static final String GOODS_SOURCE = "2gxujh_KR47Bg-CG5IIy2FoaA28P4gVldBPXOdmPy5A";*/
	public static final String PUB_GOODS = "6oCr-hlFQv2JwppOXyNi5nhvDUiyUF5k2yRUi2th0dk";
	/**
	 * 模板内容：货源匹配通知
	 */
	public static final String GOODS_SOURCE_TMEPLE = "{{first.DATA}}<br>货物名称：{{keyword1.DATA}}<br>重量/体积：{{keyword2.DATA}}<br>发货地/收货地：{{keyword3.DATA}}<br>发货日期：{{keyword4.DATA}}<br>发布时间：{{keyword5.DATA}}<br>{{remark.DATA}}";
	
	/**
	 * 模板消息：车源匹配通知
	 */
	/*public static final String CARS_SOURCE = "a0aMZrnVaQ-enNK-gyw64pbzkXfAZVsOUnfrx1ghYqM";*/
	public static final String CARS_SOURCE = "FJ4lVZwYzvrvWk41V-sGnfaRB3JaUl0DQverhrd0HZo";
	/**
	 * 模板内容：车源匹配通知
	 */
	public static final String CARS_SOURCE_TEMPLE = "{{first.DATA}}<br>车牌号码：{{keyword1.DATA}}<br>车型/车长/载量：{{keyword2.DATA}}<br>发车地/目的地：{{keyword3.DATA}}<br>发车日期：{{keyword4.DATA}}<br>发布时间：{{keyword5.DATA}}<br>{{remark.DATA}}";
	
	
	
	
	
	/***
	 * 根据序号获取模板ID
	 * @Description: TODO
	 * @param @param numberStr
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author lqz
	 * @date 2015年10月21日
	 */
	public static Object getWeChatContent(WeChatTemple weChatTemple)
	{
		Map<String, String> pdContent = new HashMap<>(); 
		String model=ORDER_CANCEL; 
		String name="退单状态通知";
		String temple="{{first.DATA}}<br>退单号：{{keyword1.DATA}}<br>退单内容：{{keyword2.DATA}}<br>退单状态：{{keyword3.DATA}}<br>{{remark.DATA}}";
		if(weChatTemple==WeChatTemple.GOODS_SOURCE)
		{
			model= PUB_GOODS;
			name="货源信息通知";
			temple="{{first.DATA}}<br>货物名称：{{keyword1.DATA}}<br>重量/体积：{{keyword2.DATA}}<br>发货地/收货地：{{keyword3.DATA}}<br>发货日期：{{keyword4.DATA}}<br>发布时间：{{keyword5.DATA}}<br>{{remark.DATA}}";
			
		}else if(weChatTemple==WeChatTemple.NEW_ORDER)
		{
			model= NEW_ORDER;
			name="运单生成通知";
		}else if(weChatTemple==WeChatTemple.ORDER_STATUS)
		{
			model=ORDER_STATUS ;
			name="运单状态更新通知";
		}else if(weChatTemple==WeChatTemple.ORDER_STATUS_COMPLETED)
		{
			model=ORDER_STATUS_COMPLETED ;
			name="运单完成通知";
		}else if(weChatTemple==WeChatTemple.ORDER_STATUS_ACCEPTANCE)
		{
			model=ORDER_STATUS_ACCEPTANCE;
			name="订单已受理通知";
		} else if(weChatTemple==WeChatTemple.CARS_SOURCE)
		{
			model=CARS_SOURCE;
			name="车源信息通知";
			temple="{{first.DATA}}<br>车牌号码：{{keyword1.DATA}}<br>车型/车长/载量：{{keyword2.DATA}}<br>发车地/目的地：{{keyword3.DATA}}<br>发车日期：{{keyword4.DATA}}<br>发布时间：{{keyword5.DATA}}<br>{{remark.DATA}}";
		}else if(weChatTemple==WeChatTemple.PUB_BID)
		{
			model=PUB_BID;
			name="招标发布通知";
		}
		else if(weChatTemple==WeChatTemple.NOTICE_BID)
		{
			model=NOTICE_BID;
			name="中标通知";
		}
		else if(weChatTemple==WeChatTemple.SUCCES_BID)
		{
			model=SUCCES_BID;
			name="竞标成功通知";
		}
		else if(weChatTemple==WeChatTemple.CANCEL_BID)
		{
			model=CANCEL_BID;
			name="竞标成功通知";
		}
		pdContent.put("NAME", name);
		pdContent.put("MODELID", model);
		pdContent.put("TEMPLE", temple);
		return pdContent;
	}
}
