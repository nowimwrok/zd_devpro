package com.thinkgem.jeesite.common.utils;

/***
 * 获取堆栈异常信息
 * @author NF 
 * @time 2015年5月04日
 *
 */
public class LogStackTrace {

	public static String getLogStackTraceInfo(Exception e){
		if(e!=null){
			StringBuffer str=new StringBuffer();
	        StackTraceElement[] trace = e.getStackTrace();
	        
	        str.append(e.toString()+"\r\n");
	        
	        for (StackTraceElement s : trace) {
	            str.append("\tat " + s + "\r\n");
	        }
	        return str.toString();
		}
		return null;
		
	}
}
