package com.thinkgem.jeesite.modules.weixin.wxpay.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import org.apache.log4j.Logger;

public class HttpUtil {
	public static Logger logger = Logger.getLogger(HttpUtil.class);
	/**
	 * java.net实现 HTTP POST方法提交
	 * 
	 * @param url
	 * @param paramContent
	 * @return
	 */
	public static StringBuffer submitPost(String url, String paramContent) {
		StringBuffer responseMessage = null;
		java.net.URLConnection connection = null;
		java.net.URL reqUrl = null;
		OutputStreamWriter reqOut = null;
		InputStream in = null;
		BufferedReader br = null;
		String param = paramContent;
		try {

			//System.out.println("url=" + url + "?" + paramContent + "\n");
			//System.out.println("===========post method start=========");
			logger.debug("url=" + url + "?" + paramContent);
			logger.debug("===========post method start=========");
			responseMessage = new StringBuffer();
			reqUrl = new java.net.URL(url);
			connection = reqUrl.openConnection();
			connection.setDoOutput(true);
			reqOut = new OutputStreamWriter(connection.getOutputStream());
			reqOut.write(param);
			reqOut.flush();
			int charCount = -1;
			in = connection.getInputStream();

			br = new BufferedReader(new InputStreamReader(in, "utf-8"));//GBK
			while ((charCount = br.read()) != -1) {
				responseMessage.append((char) charCount);
			}

			//System.out.println(responseMessage);
			//System.out.println("===========post method end=========");
			logger.debug(responseMessage);
			logger.debug("===========post method end=========");
		} catch (Exception ex) {
			//System.out.println("url=" + url + "?" + paramContent + "\n e=" + ex);
			logger.error("请求异常   url=" + url + "?" + paramContent + " e=" + ex);
		} finally {
			try {
				in.close();
				reqOut.close();
			} catch (Exception e) {
				//System.out.println("paramContent=" + paramContent + "|err=" + e);
				logger.error("请求异常   url=" + url + "?" + paramContent + " e=" + e);
			}

		}
		return responseMessage;
	}

	/**
	 * java.net实现 HTTP或HTTPs GET方法提交
	 * 
	 * @param strUrl
	 *            提交的地址及参数
	 * @return 返回的response信息
	 */
	public static StringBuffer submitGet(String strUrl) {
		URLConnection connection = null;
		BufferedReader reader = null;
		StringBuffer responseMessage = null;
		try {
			logger.debug("send getmethod=" + strUrl);
			//System.out.println("send getmethod=" + strUrl);
			responseMessage = new StringBuffer();
			URL url = new URL(strUrl);
			connection = url.openConnection();
			connection.setDoInput(true);
			connection.setDoOutput(false);
			// 取得输入流，并使用Reader读取
			reader = new BufferedReader(new InputStreamReader(connection
					.getInputStream(), "utf-8"));
			//System.out.println("============Contents of get request===============");
			logger.debug("============Contents of get request===============");
			int charCount = -1;
			while ((charCount = reader.read()) != -1) {
				responseMessage.append((char) charCount);
			}
			logger.debug(responseMessage);
			//System.out.println(responseMessage);
			//System.out.println("============Contents of get request ends==========");
			logger.debug("============Contents of get request ends===============");
		} catch (Exception e) {
			//System.out.println("getmethod is err=" + e);
			logger.error("getmethod is err=" + e);
		} finally {
			try {
				reader.close();
			} catch (Exception e) {
				logger.error("getmethod is err=" + e);
			}
		}
		return responseMessage;
	}

}
