package com.thinkgem.jeesite.modules.weixin.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.ConnectException;
import java.net.URL;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;


import org.apache.http.util.TextUtils;
import org.apache.log4j.Logger;
import  com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/*import com.alibaba.fastjson.asm.Label;*/

/**
 * 微信通用接口工具类
 * 
 * @author txw
 * @version 1.0
 * 
 */
public class WeixinUtil {

	public static Logger log = Logger.getLogger(WeixinUtil.class);

	/**
	 * 获取access_token的接口地址（GET） 限200（次/天）
	 */
	public final static String ACCESS_TOKEN = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
	/**
	 * 下载图片素材
	 */
	public final static String DOWNLOAD_MEDIA = "https://api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID";

	private static int count = 3; // 图片下载重试次数
	private static String tokenAndTicket;
	private static long lastTime = System.currentTimeMillis() - 7001 * 1000;
	public static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static void getTokenAndTicket(boolean doRefresh) {
		long currentTime = System.currentTimeMillis();
		String last = format.format(new Date(lastTime));
		String current = format.format(new Date(currentTime));
		StringBuilder info = new StringBuilder(WeixinUtil.format.format(new Date(currentTime)) + ":");
		if (currentTime - lastTime > 7000 * 1000 || doRefresh) {
			String result = WeixinUtil.sendPost(ConstantWeChat.SERVICE_URL, "POST"); // 先从微信后台服务器获取，获取失败从本地获取
			if (!TextUtils.isEmpty(result)) {
				tokenAndTicket = result;
				lastTime = Long.parseLong(tokenAndTicket.split(",")[2]);
				info.append("Get token and ticket success...");
			} else {
				info.append("Get token and ticket failed...");
			}
		} else {
			info.append("User cache get token and ticket...");
		}
		log.info(info);
	}
	/**
	 * 获取token值
	 * 
	 * @return token
	 */
	public static String getToken() {
		getTokenAndTicket(false);
		return tokenAndTicket.split(",")[0];
	}
	
	/**
	 * 获取JS-SDK-ticket
	 * @return
	 */
	public static String getJsTicket() {
		getTokenAndTicket(false);
		return tokenAndTicket.split(",")[1];
	}

	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpsRequest(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod)) {
				httpUrlConn.connect();
			}

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSON.parseObject(buffer.toString());
		} catch (ConnectException ce) {
			log.error("server connection timed out.");
			System.out.println("--------------server connection timed out."+ce);
		} catch (Exception e) {
			log.error("https request error:", e);
			System.out.println("--------------server connection timed out."+e);
		}
		return jsonObject;
	}

	/**
	 * 将微信消息中的CreateTime转换成标准格式的时间（yyyy-MM-dd HH:mm:ss）
	 * 
	 * @param createTime
	 *            消息创建时间
	 * @return String
	 */
	public static String formatTime(String createTime) {
		// 将微信传入的CreateTime转换成long类型，再乘以1000
		long msgCreateTime = Long.parseLong(createTime) * 1000L;
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(new Date(msgCreateTime));
	}

	/**
	 * 发送POST请求，获取数据
	 * 
	 * @param url
	 *            发送请求的URL
	 * @param param
	 *            请求参数 name1=value1&name2=value2
	 */
	public static String sendPost(String url, String param) {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			URLConnection conn = realUrl.openConnection();
			conn.setDoOutput(true);
			conn.setDoInput(true);
			out = new PrintWriter(conn.getOutputStream());
			out.print(param);
			out.flush();
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			log.error(e);
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * 发起https请求并获取结果
	 * @param accessToken
	 * @param mediaID 图片MediaID
	 * @param imagePath 图片保存路径
	 * @param imageName 图片保存名称
	 */
	public static boolean downloadImage(String accessToken, String mediaID, String imagePath, String imageName) {
		StringBuilder info = new StringBuilder(format.format(new Date(System.currentTimeMillis())));
		String requestUrl = DOWNLOAD_MEDIA.replace("ACCESS_TOKEN", accessToken).replace("MEDIA_ID", mediaID);
		InputStream inputStream = null;
		FileOutputStream out = null;
		HttpsURLConnection httpUrlConn = null;
		boolean result = false;
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod("GET");
			String contentType = httpUrlConn.getContentType();
			if ("image/jpeg".equals(contentType)) {
				// 将返回的输入流转换成字符串
				inputStream = httpUrlConn.getInputStream();
				byte[] buffer = new byte[1024];
				int len;
				File file = new File(imagePath, imageName);
				if(!file.exists())    
				{    
					try {
						WeixinUtil.isexitsPath(imagePath+imageName);//判断文件夹是否存在
						file.createNewFile();    //创建一个空白的图片最为替换微信服务器上下载的图片
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				    
				}    
				out = new FileOutputStream(file);
				if (file.exists()) {
					while ((len = inputStream.read(buffer)) != -1) {
						out.write(buffer, 0, len);
					}
					result = true;
					info.append("download weixin image success...");
				} else {
					info.append("Saved image filePath not exists...");
					result = false;
				}
			} else {
				InputStreamReader in = new InputStreamReader(httpUrlConn.getInputStream());
				BufferedReader reader = new BufferedReader(in);
				String lineInfo = null;
				info.append("Download failed");
				while(null != (lineInfo = reader.readLine())) {
					info.append(lineInfo);
				}
  				result = false;
			}
		} catch (Exception e) {
			return false;
		} finally { // 释放资源
			try {
				if (null != httpUrlConn) {
					httpUrlConn.disconnect();
					httpUrlConn = null;
				}
 				if (null != inputStream) {
					inputStream.close();
					inputStream = null;
				}
				if (null != out) {
					out.close();
					out = null;
				}
				log.info(info);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	/**
     * 是否创建目录
     * @param path
     * @return
     */
    public static boolean isexitsPath(String path)throws InterruptedException{
        String [] paths=path.split("/");
        StringBuffer fullPath=new StringBuffer();
        for (int i = 0; i < paths.length; i++) {
            fullPath.append(paths[i]).append("/");
            File file=new File(fullPath.toString());
         if(paths.length-1!=i){
            if(!file.exists()){
                file.mkdir();
                System.out.println("创建目录为："+fullPath.toString());
                Thread.sleep(1500);
            }
         }
        }
        File file=new File(fullPath.toString());
        if (!file.exists()) {
            return true;
        }else{
            return false;
        }
    }
    
}