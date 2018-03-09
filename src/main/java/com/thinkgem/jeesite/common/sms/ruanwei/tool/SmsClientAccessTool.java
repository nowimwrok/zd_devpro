package com.thinkgem.jeesite.common.sms.ruanwei.tool;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.restlet.Client;
import org.w3c.dom.Document;
 

/**
 * <p>
 * <date>2012-03-01</date><br/>
 * <span>软维提供的JAVA接口信息（短信，彩信）调用API</span><br/>
 * <span>----------基础访问方法-------------</span>
 * </p>
 * 
 * @author LIP
 * @version 1.0.1
 */
public class SmsClientAccessTool {

	private static SmsClientAccessTool smsClientToolInstance;

	/**
	 * 采用单列方式来访问操作
	 * 
	 * @return
	 */
	public static synchronized SmsClientAccessTool getInstance() {

		if (smsClientToolInstance == null) {
			smsClientToolInstance = new SmsClientAccessTool();
		}
		return smsClientToolInstance;
	}

	/**
	 * <p>
	 * POST方法
	 * </p>
	 * 
	 * @param sendUrl
	 *            ：访问URL
	 * @param sendUrl
	 *            ：参数串
	 * @param backEncodType
	 *            ：返回的编码
	 * @return
	 */
	public String doAccessHTTPPost(String sendUrl, String sendParam,
			String backEncodType) {

		StringBuffer receive = new StringBuffer();
		BufferedWriter wr = null;
		try {
			if (backEncodType == null || backEncodType.equals("")) {
				backEncodType = "UTF-8";
			}

			URL url = new URL(sendUrl);
			HttpURLConnection URLConn = (HttpURLConnection) url
					.openConnection();

			URLConn.setDoOutput(true);
			URLConn.setDoInput(true);
			((HttpURLConnection) URLConn).setRequestMethod("POST");
			URLConn.setUseCaches(false);
			URLConn.setAllowUserInteraction(true);
			HttpURLConnection.setFollowRedirects(true);
			URLConn.setInstanceFollowRedirects(true);

			URLConn.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded;charset=UTF-8");
			URLConn.setRequestProperty("Content-Length", String
					.valueOf(sendParam.getBytes().length));

			DataOutputStream dos = new DataOutputStream(URLConn.getOutputStream());
			dos.writeBytes(sendParam);				
			
			BufferedReader rd = new BufferedReader(new InputStreamReader(URLConn.getInputStream(), backEncodType));
			String line;
			while ((line = rd.readLine()) != null) {
				receive.append(line).append("\r\n");
			}
			rd.close();
			dos.close();
		
		} catch (IOException e) {
			receive.append("访问产生了异常-->").append(e.getMessage());
			e.printStackTrace();
		} finally {
			if (wr != null) {
				try {
					wr.close();
				} catch (IOException ex) {
					ex.printStackTrace();
				}
				wr = null;
			}
		}

		return ((receive.toString()).replaceAll("&lt;","<")).replaceAll("&gt;",">");
	}

	public String doAccessHTTPGet(String sendUrl, String backEncodType) {

		StringBuffer receive = new StringBuffer();
		BufferedReader in = null;
		try {
			if (backEncodType == null || backEncodType.equals("")) {
				backEncodType = "UTF-8";
			}

			URL url = new URL(sendUrl);
			HttpURLConnection URLConn = (HttpURLConnection) url
					.openConnection();

			URLConn.setDoInput(true);
			URLConn.setDoOutput(true);
			URLConn.connect();
			URLConn.getOutputStream().flush();
			in = new BufferedReader(new InputStreamReader(URLConn
					.getInputStream(), backEncodType));

			String line;
			while ((line = in.readLine()) != null) {
				receive.append(line).append("\r\n");
			}

		} catch (IOException e) {
			receive.append("访问产生了异常-->").append(e.getMessage());
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException ex) {
					ex.printStackTrace();
				}
				in = null;

			}
		}

		return receive.toString();
	}
	/*public String Test()
	{
		try {
			//<s:element name="userid" type="s:string" maxOccurs="1" minOccurs="0"/> 
			//<s:element name="account" type="s:string" maxOccurs="1" minOccurs="0"/> 
			//<s:element name="password" type="s:string" maxOccurs="1" minOccurs="0"/> 
			//<s:element name="mobile" type="s:string" maxOccurs="1" minOccurs="0"/> 
			//<s:element name="content" type="s:string" maxOccurs="1" minOccurs="0"/> 
			//<s:element name="sendTime" type="s:string" maxOccurs="1" minOccurs="0"/> 
			//<s:element name="extno" type="s:string" maxOccurs="1" minOccurs="0"/>
			Object[] ttt= {"451","zy-lxkjgs","zy123456","13002007275","测试内容","",""};
			//Client c = new Client(new URL("http://202.105.182.106:8888/SmsWebService.asmx?WSDL"));
			Object[] results =c.invoke("SendSms",ttt);
			String t2t="  ";
			Document d = (Document)results[0]; 
			String t=d.getFirstChild().getFirstChild().getNodeValue();
		    return results[0].toString();
		} catch (MalformedURLException e) {
			// TODO自动生成的catch块
			e.printStackTrace();
		} catch (Exception e) {
			// TODO自动生成的 catch 块
			e.printStackTrace();
		}
		return "";
	}*/
}
