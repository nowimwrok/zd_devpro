package com.thinkgem.jeesite.common.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.shiro.crypto.hash.SimpleHash;

import com.thinkgem.jeesite.common.security.Digests;


public class Tools {

	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;


	/**
	 * 公共的返回方法
	 * @param state 1:正常
	 * @param message  提示信息
	 * @param entity 对象信息
	 * @return
	 */
	public static Map<String, Object> getMapResult(int state,
											String message, Object entity) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", state);
		map.put("message", message);
		map.put("data", entity);
		return map;
	}

	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		String plain = Encodes.unescapeHtml(plainPassword);
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
		return Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword);
	}

	/**
	 * 验证密码
	 *
	 * @param plainPassword 明文密码
	 * @param password      密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		String plain = Encodes.unescapeHtml(plainPassword);
		byte[] salt = Encodes.decodeHex(password.substring(0, 16));
		byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword));
	}
	/**
	 * 返回状态信息
	 * @param status 状态:-1:系统异常0:权限不足1:成功;2信息缺失
	 * @param type 保存;修改;查询
     * @return
     */
	public static String statusMessage(int status,String type){
		String message="成功";
		switch (status){
			case -5:
				message=type+"银行处理中";//银行处理状态
			   break;
		    case -3:
		        message=type+"失败";
		       break;
		    case -2:
			    message=type+"系统异常";
			    break;
			case -1:
				message=type+"系统异常";
				break;
			case 0:
				message=type+"权限不足";
				break;
			case 1:
				message=type + "成功";
				break;
			case 2:
				message=type+"信息缺失";
				break;
			case 3:
				message=type+"已操作";
				break;
			case 4:
				message=type+"密码错误";
				break;
			case 5:
				message=type+"可用余额不足";
				break;
			case 6:
				message=type+"可用余额不足";
				break;
			case 7:
				message=type+"操作频繁，请稍后再试";
				break;
			case 8:
				message=type+"金额大于单笔交易最高限额";
				break;
			case 10:
				message=type+"电子钱包最低留存额度不足";
				break;
			case 11:
				message=type+"金额大于单日交易最高限额";
				break;
			case 12:
				message=type+"提现金额大于单日累计提现限额";
				break;	
			case 18:
				message=type+"银行卡信息错误，请收款方核对默认银行卡信息";
				break;
			case 19:
				message=type+"应用已签退，正在日结中，等银行结算完毕再开放使用，结算时间为1-2小时";
				break;
		}
		return message;
	}

	/**
	 * 创建一个流水号
	 *@param type 类型
	 * @return
     */
	/*public static String createOrderNo(String type){
		String orderNo="";
		if (type.length()<2){
			type="0"+type;
		}
		orderNo=type+DateUtil.getDetailTime();
		return orderNo;
	}*/

	/***
	 * 转化为两位小数
	 * @param dble
	 * @return
     */
	public static  String  toTwoDecimal(Double dble){
		DecimalFormat df   = new DecimalFormat("######0.00");
		String decimal=df.format(dble);
		return decimal;
	}
	/**
	 * 随机生成六位数验证码 
	 * @return
	 */
	public static int getRandomNum(){
		 Random r = new Random();
		 return r.nextInt(900000)+100000;//(Math.random()*(999999-100000)+100000)
	}
	
	/**
	 * 检测字符串是否不为空(null,"","null")
	 * @param s
	 * @return 不为空则返回true，否则返回false
	 */
	public static boolean notEmpty(String s){
		return s!=null && !"".equals(s) && !"null".equals(s);
	}
	
	/**
	 * 检测字符串是否为空(null,"","null")
	 * @param s
	 * @return 为空则返回true，不否则返回false
	 */
	public static boolean isEmpty(String s){
		return s==null || "".equals(s) || "null".equals(s);
	}
	
	/**
	 * 检测字符串是否为空(null,"","null",whitespace)
	 * @param s
	 * @return 为空则返回true，不否则返回false
	 */
	public static boolean IsNullOrWhiteSpace(String s){
		return s==null || s.isEmpty() || s.equals("");
	}
	
	
	/**
	 * 字符串转换为字符串数组
	 * @param str 字符串
	 * @param splitRegex 分隔符
	 * @return
	 */
	public static String[] str2StrArray(String str,String splitRegex){
		if(isEmpty(str)){
			return null;
		}
		return str.split(splitRegex);
	}
	
	/**
	 * 用默认的分隔符(,)将字符串转换为字符串数组
	 * @param str	字符串
	 * @return
	 */
	public static String[] str2StrArray(String str){
		return str2StrArray(str,",\\s*");
	}
	
	/**
	 * 按照yyyy-MM-dd HH:mm:ss的格式，日期转字符串
	 * @param date
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static String date2Str(Date date){
		return date2Str(date,"yyyy-MM-dd HH:mm:ss");
	}
	
	/**
	 * 按照yyyy-MM-dd HH:mm:ss的格式，字符串转日期
	 * @param date
	 * @return
	 */
	public static Date str2Date(String date){
		if(notEmpty(date)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				return sdf.parse(date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			return new Date();
		}else{
			return null;
		}
	}
	
	/**
	 * 按照参数format的格式，日期转字符串
	 * @param date
	 * @param format
	 * @return
	 */
	public static String date2Str(Date date,String format){
		if(date!=null){
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			return sdf.format(date);
		}else{
			return "";
		}
	}
	
	/**
	 * 把时间根据时、分、秒转换为时间段
	 * @param StrDate
	 */
	public static String getTimes(String StrDate){
		String resultTimes = "";
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    Date now;
	    
	    try {
	    	now = new Date();
	    	Date date=df.parse(StrDate);
	    	long times = now.getTime()-date.getTime();
	    	long day  =  times/(24*60*60*1000);
	    	long hour = (times/(60*60*1000)-day*24);
	    	long min  = ((times/(60*1000))-day*24*60-hour*60);
	    	long sec  = (times/1000-day*24*60*60-hour*60*60-min*60);
	        
	    	StringBuffer sb = new StringBuffer();
	    	//sb.append("发表于：");
	    	if(hour>0 ){
	    		sb.append(hour+"小时前");
	    	} else if(min>0){
	    		sb.append(min+"分钟前");
	    	} else{
	    		sb.append(sec+"秒前");
	    	}
	    		
	    	resultTimes = sb.toString();
	    } catch (ParseException e) {
	    	e.printStackTrace();
	    }
	    
	    return resultTimes;
	}
	
	/**
	 * 写txt里的单行内容
	 * @param fileP  文件路径
	 * @param content  写入的内容
	 */
	public static void writeFile(String fileP,String content){
		String filePath = String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))+"../../";	//项目路径
		filePath = (filePath.trim() + fileP.trim()).substring(6).trim();
		if(filePath.indexOf(":") != 1){
			filePath = File.separator + filePath;
		}
		try {
	        OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(filePath),"utf-8");      
	        BufferedWriter writer=new BufferedWriter(write);          
	        writer.write(content);      
	        writer.close(); 

	        
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	  * 验证邮箱
	  * @param email
	  * @return
	  */
	 public static boolean checkEmail(String email){
	  boolean flag = false;
	  try{
	    String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
	    Pattern regex = Pattern.compile(check);
	    Matcher matcher = regex.matcher(email);
	    flag = matcher.matches();
	   }catch(Exception e){
	    flag = false;
	   }
	  return flag;
	 }
	
	 /**
	  * 验证手机号码
	  * @param mobileNumber
	  * @return
	  */
	 public static boolean checkMobileNumber(String mobileNumber){
	  boolean flag = false;
	  try{
	    Pattern regex = Pattern.compile("^(((13[0-9])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8})|(0\\d{2}-\\d{8})|(0\\d{3}-\\d{7})$");
	    Matcher matcher = regex.matcher(mobileNumber);
	    flag = matcher.matches();
	   }catch(Exception e){
	    flag = false;
	   }
	  return flag;
	 }
	 
	/**
	 * 检测KEY是否正确
	 * @param paraname  传入参数
	 * @param FKEY		接收的 KEY
	 * @return 为空则返回true，不否则返回false
	 */
	/*public static boolean checkKey(String paraname, String FKEY){
		paraname = (null == paraname)? "":paraname;
		return MD5.md5(paraname+DateUtil.getDays()+",fh,").equals(FKEY);
	}*/
	/**
	 * 读取txt里的单行内容
	 * @param fileP  文件路径
	 */
	public static String readTxtFileForThread(String fileP) {
		try {
			String path=Thread.currentThread().getContextClassLoader().getResource("").toString();
			path=path.substring(0, path.indexOf("/WEB-INF"))+"/";
			String filePath =String.valueOf(path);	//项目路径
			filePath = filePath.replaceAll("file:/", "");
			filePath = filePath.replaceAll("%20", " ");
			filePath = filePath.trim() + fileP.trim();
			if(filePath.indexOf(":") != 1){
				filePath = File.separator + filePath;
			}
			String encoding = "utf-8";
			//filePath="G:\\广州行业应用项目组\\珠海物流一期\\06源码管理\\LogisticsSystem\\WebRoot\\admin\\config\\GoodsWebSpiderConfig.txt";
			filePath=new String(filePath.getBytes(),"utf-8");
			//解码文件路径
			filePath=java.net.URLDecoder.decode(filePath,"utf-8");
			File file = new File(filePath);
			if (file.isFile() && file.exists()) { 		// 判断文件是否存在
				InputStreamReader read = new InputStreamReader(
				new FileInputStream(file), encoding);	// 考虑到编码格式
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				while ((lineTxt = bufferedReader.readLine()) != null) {
					return lineTxt;
				}
				read.close();
			}else{
				System.out.println("找不到指定的文件,查看此路径是否正确:"+filePath);
			}
		} catch (Exception e) {
			System.out.println("读取文件内容出错");
		}
		return "";
	} 
	/**
	 * 读取txt里的单行内容
	 * @param fileP  文件路径
	 */
	public static String readTxtFile(String fileP) {
		try {
			 
			String filePath =String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))+"../../";	//项目路径
			filePath = filePath.replaceAll("file:/", "");
			filePath = filePath.replaceAll("%20", " ");
			filePath = filePath.trim() + fileP.trim();
			if(filePath.indexOf(":") != 1){
				filePath = File.separator + filePath;
			}
			String encoding = "utf-8";
			//filePath="G:\\广州行业应用项目组\\珠海物流一期\\06源码管理\\LogisticsSystem\\WebRoot\\admin\\config\\GoodsWebSpiderConfig.txt";
			filePath=new String(filePath.getBytes(),"utf-8");
			File file = new File(filePath);
			if (file.isFile() && file.exists()) { 		// 判断文件是否存在
				InputStreamReader read = new InputStreamReader(
				new FileInputStream(file), encoding);	// 考虑到编码格式
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				while ((lineTxt = bufferedReader.readLine()) != null) {
					return lineTxt;
				}
				read.close();
			}else{
				System.out.println("找不到指定的文件,查看此路径是否正确:"+filePath);
			}
		} catch (Exception e) {
			System.out.println("读取文件内容出错");
		}
		return "";
	}
	
	
	
	/**
	 * 根据传递的密码返回加密信息
	 * @param passWord  传入参数
	 * @return 加密后的字符串
	 */
	public static Object getEncryptedPassword(String passWord){
		return new SimpleHash("SHA-1", passWord, passWord+StringUtil.reverse(passWord));
	}
	
	/**
	 * 根据传递的字符串数据以(',')拼接返回信息
	 * @param para  传入参数
	 * @return 拼接后的字符串
	 */
	/*public static PageData getPageDataByStrArr(String[] para){
		StringBuilder sb=new StringBuilder();
		sb.append("('");
		for (String item : para) {
			sb.append(item + "','");
		}
		String delteArrayStr = sb.substring(0, sb.lastIndexOf("','"))
				+ "')";
		PageData pd = new PageData(); 
		pd.put("delteArrayStr", delteArrayStr);
		return pd;
	}*/
	/**
	 * 根据传递的字符串数据以(',')拼接返回信息
	 * @param para  传入参数
	 * @return 拼接后的字符串
	 */
	public static String StringArrayToSqlInStr(String[] para){
		StringBuilder sb=new StringBuilder();
		sb.append("('");
		for (String item : para) {
			sb.append(item + "','");
		}
		String sqlInStr = sb.substring(0, sb.lastIndexOf("','"))
				+ "')";
		return sqlInStr;
		 
	}
	
	 
	 /**
	  * 
	  * @Description: 判断数组是否含有元素
	  * @param @param array
	  * @param @param v
	  * @param @return   
	  * @return boolean  
	  * @throws
	  * @author lqz
	  * @date 2015年5月21日
	  */
	 public static <T> boolean contains( final T[] array, final T v ) {
		    for ( final T e : array )
		        if ( e == v || v != null && v.equals( e ) )
		            return true;
		    return false;
		}
	
	public static void main(String[] args) {
		System.out.println(getRandomNum());
	}
	
	/***
	 * 代码转换输出
	 * @Description: TODO
	 * @param @param s
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author lqz
	 * @date 2015年6月16日
	 */
	public static final String htmlToCode(String s) 
	{ 
	if(s == null) 
	{ 
	return ""; 
	} else 
	{  
	s = s.replace("\r\n", "<br>&nbsp;&nbsp;");//这才是正确的！
	s= s.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
	 s =s.replace(" ", "&nbsp;"); 
	 s=s.replace("\"", "\\"+"\"");//如果原文含有双引号，这一句最关键！！！！！！
	return s; 
	} 
	}
	
	 static public Integer str2Int(String str) {
	    Integer result = null;
	    if (null == str || 0 == str.length()) {
	        return null;
	    }
	    try {
	        result = Integer.parseInt(str);
	    } 
	    catch (NumberFormatException e) {
	        String negativeMode = "";
	        if(str.indexOf('-') != -1)
	            negativeMode = "-";
	        str = str.replaceAll("-", "" );
	        if (str.indexOf('.') != -1) {
	            str = str.substring(0, str.indexOf('.'));
	            if (str.length() == 0) {
	                return 0;
	            }
	        }
	        String strNum = str.replaceAll("[^\\d]", "" );
	        if (0 == strNum.length()) {
	            return null;
	        }
	        result = Integer.parseInt(negativeMode + strNum);
	    }
	    return result;
	}
	public static int systemModuleEnum2IntValue(Const.System_Module_Enum modelEnum)
	{
		int model=0;
		//注册方式：1：Web网站门户注册2：手机APP注册3：微信公众号注册4.后台系统添加
		if(modelEnum== Const.System_Module_Enum.LogisticsWebSystem)
		{
			model= 1;
		}else if(modelEnum== Const.System_Module_Enum.Android)
		{
			model= 2;
		}else if(modelEnum== Const.System_Module_Enum.Weixin)
		{
			model= 3;
		}else if(modelEnum== Const.System_Module_Enum.IOS)
		{
			model= 4;
		} 
		return model;
	}
	public static Const.System_Module_Enum intValue2System_Module_Enum(int module)
	{
		Const.System_Module_Enum model= Const.System_Module_Enum.LogisticsWebSystem;
		//注册方式：1：Web网站门户注册2：手机APP注册3：微信公众号注册4.后台系统添加
		if(module==1)
		{
			model= Const.System_Module_Enum.LogisticsWebSystem;
		}else if(module==2)
		{
			model= Const.System_Module_Enum.Android;
		}else if(module==3)
		{
			model=Const.System_Module_Enum.Weixin ;
		}else if(module==4)
		{
			model=Const.System_Module_Enum.IOS ;
		}else if(module==0)
		{
			model=Const.System_Module_Enum.All ;
		}
		return model;
	}
	
	
	/***
	 * 格式化微信推送消息参数
	 * @Description: TODO
	 * @param @param dataArr
	 * @param @return   
	 * @return Map<String,String>  
	 * @throws
	 * @author lqz
	 * @date 2015年10月15日
	 */
	public static Map<String,String> getMapData(String...dataArr ){
		Map<String, String> mapData = new HashMap<String, String>();
		mapData.put("first", dataArr[0]);
		int length=dataArr.length;
		for(int i=1;i<=length-1;i++)
		mapData.put("keyword"+i, dataArr[i]); 
		return mapData;
	}


	/***
	 * 格式化微信推送消息参数
	 * @Description: TODO
	 * @param @param dataArr
	 * @param @return   
	 * @return Map<String,String>  
	 * @throws
	 * @author lqz
	 * @date 2015年10月15日
	 */
	/*public static Map<String,String> getMapData(PageData pd ){
		Map<String, String> mapData = new HashMap<String, String>();
		mapData.put("first",pd.getString("FIRST"));
		mapData.put("remark",pd.getString("REMARK")); 
		for(int i=1;i<=5;i++)
			if(pd.containsKey("KEYWORD"+i))
		mapData.put("keyword"+i, pd.getString("KEYWORD"+i));
			else
				break;
		return mapData;
	}*/
}
