/*package org.hexway.wxpay.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.http.client.HttpClient;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.hexway.wxpay.util.XSCQRCode;
import org.hexway.wxpay.util.CommonUtil;
import org.hexway.wxpay.util.HttpClientUtil;
import org.hexway.wxpay.util.WeixinAlipayConfig;
import org.hexway.wxpay.util.WxPayV3Helper;
import org.hexway.wxpay.util.XMLUtil;
import org.hexway.wxpay.util.WxUtil;

import cn.com.hexway.controller.base.BaseLogController;
import cn.com.hexway.entity.system.User;
import cn.com.hexway.service.system.user.UserService;
import cn.com.hexway.service.txservice.TxPublishService;
import cn.com.hexway.service.wlpt.trade.ConsumeRecordService;
import cn.com.hexway.util.Const;
import cn.com.hexway.util.DateUtil;
import cn.com.hexway.util.PageData;
import cn.com.hexway.util.Tools;
import cn.com.hexway.util.Const.ChangePointWay_Enum;
import cn.com.hexway.util.Const.System_Module_Enum;
import cn.com.hexway.util.log.LogType;
import cn.com.hexway.util.mail.SimpleMailSender;

@Controller("/control/wlpt/pay/wxpay")
@RequestMapping(value = "wlpt/pay/wxpay")
public class WxpayController extends BaseLogController{
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "consumeRecordService")
	private ConsumeRecordService consumeRecordService;
	@Resource(name = "txPublishService")
	private TxPublishService txPublishService;
	@RequestMapping(value = "/index")
	public ModelAndView loadPayView(HttpServletRequest req){
		ModelAndView mv = this.getModelAndView();
		PageData pData = this.getPageData();
		PageData pd = new PageData();
		try {
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute("loginUser");
		PageData userpd = new PageData();
		if (user == null) {
			//return 跳转到登录页面		
    	}
		userpd.put("USER_ID", user.getUSER_ID());
		userpd = userService.findByUiId(userpd);
		
		String path = req.getContextPath();
		String basePath = req.getScheme() + "://"
				+ req.getServerName() + ":" + req.getServerPort()
				+ path + "/";
		String notify_url=basePath + "wlpt/pay/wxpay/notify";
		//String customDefineAlipayUrl=Tools.readTxtFile(Const.AliPayNotityUrl);
		String trade_no = pData.getString("WIDout_trade_no");
		String total_fee = pData.getString("WIDtotal_fee");
		String body = pData.getString("WIDsubject");
        
		if(customDefineAlipayUrl!=null&&customDefineAlipayUrl!="")
		{
			notify_url=customDefineAlipayUrl;
		}
		if(!isNullOrEmpty(total_fee) && !isNullOrEmpty(trade_no) && !isNullOrEmpty(body)){
			pd.put("out_trade_no", trade_no);
			pd.put("body", body);
			double f = Double.valueOf(total_fee);
			int fee = (int) (f * 100);
			pd.put("total_fee", fee);
			pd.put("notify_url",notify_url);
			String spbill_create_ip=req.getRemoteAddr();
			pd.put("spbill_create_ip", spbill_create_ip);
			String rpsXmlData=WPay(pd);
			Map resultMap;
			
				resultMap = XMLUtil.doXMLParse(rpsXmlData);
			
			if (resultMap.get("return_code") != null
					&& resultMap.get("return_code").equals("SUCCESS")) {
				if (resultMap.get("result_code") != null && resultMap.get("result_code").equals("SUCCESS")) {
 
					String code_url = resultMap.get("code_url").toString();
					XSCQRCode qr = XSCQRCode.from(code_url);
					 
					String pathString=Tools.readTxtFile("admin/config/ewm.txt")+ trade_no +".png";
					SimpleMailSender mail=new SimpleMailSender();
					 
					qr.file(pathString);
					
					//生成订单
					PageData order = new PageData();
					// 保存所需数据
					
					pd.put("ACCOUNTID", userpd.getString("USER_ID"));
					pd.put("ACCOUNTCODE", userpd.getString("NUMBER"));
					// 交易前余额
					if (pData.getString("ConsumeType").equals("3")) {
						// /交易描述
						pd.put("CONSUMEWAYDESP", "担保金充值");
						if (userpd.getString("GuaranteeMoney") != null) {
							pd.put("BALANCEBEFORE",
									userpd.getString("GuaranteeMoney"));
						} else {
							pd.put("BALANCEBEFORE", 0);
						}
					} else if (pData.getString("ConsumeType").equals("1")) {
						// /交易描述
						pd.put("CONSUMEWAYDESP", "平台充值");
						if (userpd.getString("WebBalance") != null) {
							pd.put("BALANCEBEFORE", userpd.getString("WebBalance"));
						} else {
							pd.put("BALANCEBEFORE", 0);
						}
					}
					pd.put("CONSUMERECDID", get32UUID());
					// /订单号
					pd.put("CONSUMECODE", trade_no);
					
					// 交易状态
					pd.put("CONSUMESTATE", 0);
					// 流水帐号（未完成暂时用当前交易订单号填充）
					pd.put("PAYID", trade_no);
					pd.put("CONSUMETIME", DateUtil.getTime().toString());
					// 交易类型（充值/缴纳保证金）
					pd.put("CONSUMETYPE", pData.getString("ConsumeType"));
					// 消费方式:0,平台;1,一卡通;2,第三方接口
					pd.put("CONSUMEWAY", 1);
					// /本次消费金额
					pd.put("AMOUNTCONSUMED", total_fee);
					// 操作者
					pd.put("OPERATOR", user.getUSER_ID());
					PageData consumcdpd = consumeRecordService.findByCondition(pd);
					if (consumcdpd == null) {
						// 下单成功录入数据
						consumeRecordService.save(pd);
						//userloggerinfo.savelog(null, "" + pd, LogType.SAVA);
					} else {

					}
				} else {
					// logger.error("微信统一接口结果--微信支付交易错误");
					//提示错误。
				}

			} else {
			}
			
			mv.addObject("qrpath", "static/wxpay/"+ trade_no +".png");
			mv.addObject("fee", total_fee);
			mv.addObject("order_no", trade_no);
			
		}else{
			
		}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		mv.setViewName("pay/wxpay/index");
		return mv;
	}
	
	 
	*//***
	 * 微信支付V3版本native,app支付异步回调
	 * @param request
	 * @param response
	 * @throws Exception 
	 *//*
	@RequestMapping("/notify")
	public void payNotify(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try
		{
		//---------------------------------------------------------
		//支付通知（后台通知）示例，商户按照此文档进行开发即可
		//---------------------------------------------------------
		PrintWriter out=response.getWriter();
		HashMap<String, String> returnMap=new HashMap<String, String>();
		String receive = WxUtil.readDataFromStream(request.getInputStream());
		logger.info("（微信调用）支付通知接口请求数据：" + receive);
		try{
		SimpleMailSender mail=new SimpleMailSender();
		mail.sendMail("notify回调", "回调参数："+receive, "1", "1462187636@qq.com");
		}catch(Exception exx)
		{}
		if (!StringUtils.isNotBlank(receive)) {
			logger.error("支付通知接口异常：获取信息失败");
			returnMap.put("return_code", "FAIL");
			returnMap.put("return_msg", "支付通知接口异常：获取信息失败");
		}
		else{
			SortedMap<String , String> map = WxUtil.getPayUserInfoFromXml_V3(receive);
			logger.info(receive);
			String sign=(String) map.get("sign");
			logger.info(sign);
			String rSign=WxUtil.createSign("UTF-8",map);
			logger.info(rSign);
			if(rSign.equalsIgnoreCase(sign)){//验证签名成功
				String result_code=map.get("result_code");
				String return_code=map.get("return_code");
				if("SUCCESS".equals(result_code)&&"SUCCESS".equals(return_code)){
					//订单编号
					String orderCode=map.get("out_trade_no");
					//金额
					String total_fee=map.get("total_fee");
					//微信支付订单号
					String transaction_id=map.get("transaction_id");
					PageData pd = new PageData();
					PageData consumcdpd = new PageData(); 
					pd.put("CONSUMECODE", orderCode);
					pd.put("CONSUMESTATE", 0);
					consumcdpd = consumeRecordService.findByCondition(pd);
					
					
					PageData uppd = new PageData();
					logger.info("订单编号："+orderCode+",支付金额:"+total_fee);
					if(StringUtils.isNotBlank(total_fee)){
						double BALANCEAFTER = Double.parseDouble(consumcdpd.getString("AMOUNTCONSUMED"))+ Double.parseDouble(consumcdpd.getString("BALANCEBEFORE"));

						pd.put("sign", sign);
						pd.put("out_trade_no", orderCode);
						pd.put("trade_no", transaction_id);
						txPublishService.txMethodRecharge(pd,consumcdpd,
								System_Module_Enum.LogisticsWebSystem,ChangePointWay_Enum.Recharge,
								this.getCurrentUserPointWay(),this.getCurrentUserPointLevel());
						returnMap.put("return_code", "SUCCESS");
						returnMap.put("return_msg", "改变订单状态成功");
					}else{
						returnMap.put("return_code", "FAIL");
						returnMap.put("return_msg", "改变订单状态不成功");
					}
				}else{
					returnMap.put("return_code", "FAIL");
					returnMap.put("return_msg", "状态返回不成功");
				}
			}else{
				returnMap.put("return_code", "FAIL");
				returnMap.put("return_msg", "验证签名失败");
			}
		}
		out.write(CommonUtil.ArrayToXml(returnMap));
		out.flush();
		out.close();
		}catch(Exception ex)
		{
		   
		}
	}
    public String WPay(PageData pdData)
    {
    	try {
    	WxPayV3Helper wxPrePayHelper = new WxPayV3Helper();
		wxPrePayHelper.setKey(WeixinAlipayConfig.GZ_key);// 密钥
		wxPrePayHelper.SetParameter("appid",WeixinAlipayConfig.GZ_APP_ID);
		wxPrePayHelper.SetParameter("mch_id",WeixinAlipayConfig.GZ_mch_id);
		wxPrePayHelper.SetParameter("device_info", "WEB");

		wxPrePayHelper.SetParameter("nonce_str",CommonUtil.getNonceStr());
		wxPrePayHelper.SetParameter("body", pdData.getString("body")); // 订单描述
		wxPrePayHelper.SetParameter("out_trade_no", pdData.getString("out_trade_no"));// 订单编号
		wxPrePayHelper.SetParameter("total_fee", pdData.getString("total_fee"));// 订单总金额:单位为分
		wxPrePayHelper.SetParameter("spbill_create_ip",pdData.getString("spbill_create_ip"));
		wxPrePayHelper.SetParameter("notify_url",pdData.getString("notify_url"));
		wxPrePayHelper.SetParameter("trade_type", "NATIVE");// JSAPI、NATIVE、APP

		String reqXmlData = wxPrePayHelper.CreatePrePayPackage();
		HttpClient httpClient = HttpClientUtil.getHttpsClient();
		return HttpClientUtil.post(httpClient,WeixinAlipayConfig.weiXinRequestUrl, reqXmlData);
		 
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	 return "";
    }*/
    /*
	public UnifiedOrderResData pay(PageData pdData){
		WxpayConfig.init();

		// 订单时间
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		Date dnow = new Date();
		Date dexpire = new Date(dnow.getTime() + 10*60*1000);// 支付过期十分钟
		String tnow = format.format(dnow);
		String texpire = format.format(dexpire);

		// 订单号 必填字段
		String out_trade_no = pdData.getString("out_trade_no");
		// 商品描述 必填字段
		String body = pdData.getString("body");
		// 总金额 必填字段
		int total_fee = Integer.valueOf(pdData.getString("total_fee"));
		// 产品编号
		String product_id = pdData.getString("product_id");
		// 商品详情
		String detail = pdData.getString("detail");
		// 回调函数
		String notify_url = pdData.getString("notify_url");

		UnifiedOrderReqData unifiedOrderReqData = new UnifiedOrderReqData("WEB", body, detail,
				"", out_trade_no, total_fee, tnow, texpire, "", notify_url, "NATIVE", product_id, "");

		UnifiedOrderResData unifiedOrderResData = new UnifiedOrderResData();
		try {
			String res = new UnifiedOrderService().request(unifiedOrderReqData);
			// 创建返回结果的数据模型
			unifiedOrderResData.fromXML(res);
			unifiedOrderResData.setReturn_msg(new String(unifiedOrderResData.getReturn_msg().getBytes("utf-8")));
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return unifiedOrderResData;
	}
*/
/*}*/
