/**  
 * @Title: KeyFilter.java
 * @Package cn.com.hexway.service.sms
 * @Description: TODO
 * @author 荣亮
 * @date 2015年5月7日
 */
package com.thinkgem.jeesite.common.sms.util;

import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.Tools;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * ClassName: KeyFilter 
 * @Description: 短信关键字过滤
 * @author 荣亮
 * @date 2015年5月7日
 */
public class KeyFilter {
	private static Pattern pattern = null;

    // 从words.properties初始化正则表达式字符串
    private static void initPattern() throws IOException {
        StringBuffer patternBuffer = new StringBuffer();
        String filterKey="("+ Tools.readTxtFile(Const.SMS_FILTER_KEY)+")";
		// 装换编码
		pattern = Pattern.compile(filterKey);
    }

    public static String doFilter(String str) {
        try {
			initPattern();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
        Matcher m = pattern.matcher(str);
        str = m.replaceAll("*");
        return str;
    }
}
