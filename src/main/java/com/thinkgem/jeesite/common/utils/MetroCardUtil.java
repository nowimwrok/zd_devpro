package com.thinkgem.jeesite.common.utils;

import com.google.gson.Gson;
import com.sz1card1.sdk.Md5;
import com.sz1card1.sdk.ResultBean;
import com.sz1card1.sdk.SdkJsonParse;
import com.sz1card1.sdk.log.LogUtils;
import com.thinkgem.jeesite.common.config.DataDic;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

public class MetroCardUtil {
	/**
	 * 返回数据的编码格式
	 */
	private static String recEncoding = "UTF-8";
	private static String getRecEncoding() {
		return recEncoding;
	}
	public static void setRecEncoding(String recEncoding) {
		MetroCardUtil.recEncoding = recEncoding;
	}


	private String splitUrl(String action, String data) {
		long timeStamp = System.currentTimeMillis() / 1000L;
		String signature = Md5.md5Digest(DataDic.METRO_CARD_OPENID + DataDic.METRO_CARD_SECRET + timeStamp + data);
		String url = "http://openapi.1card1.cn/OpenApi/"+action+"?openId=" + DataDic.METRO_CARD_OPENID  + "&signature=" + signature + "&timestamp=" + timeStamp;
		LogUtils.printLog("signatureUrl = " + url);
		if("Add_Value".equals(action)){
			System.out.println("充值"+url);
		}
		if("ValueConsume".equals(action)){
			System.out.println("消费data参数:============================"+data);
			System.out.println("消费"+url);
		}
		
		return url;
	}


	private String HttpPostUrl(String urls, String data) {
		PrintWriter printWriter = null;
		BufferedReader bufferedReader = null;
		StringBuffer responseResult = new StringBuffer();
		StringBuffer params = new StringBuffer();
		HttpURLConnection httpURLConnection = null;
		params = params.append("&data=" + data);

		try {
			URL realUrl = new URL(urls);
			httpURLConnection = (HttpURLConnection)realUrl.openConnection();
			httpURLConnection.setRequestProperty("accept", "*/*");
			httpURLConnection.setRequestProperty("connection", "Keep-Alive");
			httpURLConnection.setRequestProperty("Content-Length", String.valueOf(params.length()));
			httpURLConnection.setRequestProperty("Accept-Charset", "UTF-8");
			httpURLConnection.setRequestProperty("contentType", "utf-8");
			httpURLConnection.setRequestProperty("content-type", "application/x-www-form-urlencoded;charset=UTF-8");
			httpURLConnection.setDoOutput(true);
			httpURLConnection.setDoInput(true);
			printWriter = new PrintWriter(httpURLConnection.getOutputStream());
			String dataStr = new String(params.toString().getBytes(), "utf-8");
			printWriter.write(dataStr);
			printWriter.flush();
			int responseCode = httpURLConnection.getResponseCode();
			bufferedReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream(), "Utf-8"));

			String line;
			while((line = bufferedReader.readLine()) != null) {
				responseResult.append(line);
			}

			String var14;
			if(responseCode != 200) {
				ResultBean bean = new ResultBean();
				bean.setStatus(-1);
				bean.setHttpCode(responseCode);
				var14 = SdkJsonParse.toJsonString(bean);
				return var14;
			}

			var14 = responseResult.toString();
			return var14;
		} catch (Exception var23) {

		} finally {
			httpURLConnection.disconnect();

			try {
				if(printWriter != null) {
					printWriter.close();
				}

				if(bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException var22) {
				var22.printStackTrace();
			}

		}

		return null;
	}


	/**
	 * 发送请求
	 * @param params
	 * @return
	 */
	public String callHttpPost(String action,Map params){
		Gson gson = new Gson();
		String toJson = gson.toJson(params);
		String url = splitUrl(action, toJson);
		return HttpPostUrl(url, toJson);
	}



}
