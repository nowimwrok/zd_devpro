/**
 * 
 */
package com.thinkgem.jeesite.common.config;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import com.thinkgem.jeesite.common.utils.Tools;
import org.springframework.core.io.DefaultResourceLoader;

import com.ckfinder.connector.ServletContextFactory;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.utils.PropertiesLoader;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 全局配置类
 * @author 
 * @version 2014-06-25
 */
public class  Global {

	/**
	 * 当前对象实例
	 */
	private static Global global = new Global();
	
	/**
	 * 保存全局属性值
	 */
	private static Map<String, String> map = Maps.newHashMap();
	
	/**
	 * 属性文件加载对象
	 */
	private static PropertiesLoader loader = new PropertiesLoader("config.properties");

	/**
	 * 显示/隐藏
	 */
	public static final String SHOW = "1";
	public static final String HIDE = "0";

	/**
	 * 是/否
	 */
	public static final String YES = "1";
	public static final String NO = "0";
	
	/**
	 * 对/错
	 */
	public static final String TRUE = "true";
	public static final String FALSE = "false";


	/**
	 * 平台联系电话
	 */
	public static final String LINK_WEB = "www.zhuoda56.cn";
	//public static final String LINK_WEB = "zengyujia.tunnel.qydev.com";
	
	public static final String LINK_TEL = "0310-3188756";

	public static final String LINK_ADDRESS = "河北省邯郸市复兴区309国道 邯钢-万事达创业园";

	public static final String PRINTBASEMONEY = "100";
	public static final String PRINTPAYMONEY = "10";
	/**
	 * @Fields SystemTitle : 系统显示标题
	 */
	public static final String SYSTEMTITLE = "卓大物流";
	
	/**
	 * @Fields ScreenInformationTitle : 信息大屏标题
	 */
	public static final String SCREENINFORMATIONTITLE = "邯钢•万事达智慧平台";
	
	/**
	 * @Fields ScreenInformationTitle : 信息大屏监督电话
	 */
	public static final String SCREENINFORMATIONPHONE = "0310-3188756";
	
	/**
	 * @Fields PersonPageTitle : 个人中心标题
	 */
	public static final String  PEPRSONPAGETTLE= "卓大物流平台";//卓大是：我的卓大

	/**
	 * 获取平台个人中心菜单
	 */
	public static final String MUNE_PERSONAL_ID = "f05692991238422ab8ce3a6477319182";

	/***
	 * 获取平台导航菜单
	 */
	public static final String MUNE_NAV_ID = "8ef436aa79ba49299f877573d4663a41";

	/***
	 * 获取平台导航菜单
	 */
	public static final String MUNE_WX_ID = "91195d76e7f84dcb87095574d8337245";
	
	/***
	 * 获取平台公告id
	 */
	public static final String CATEGORY_NOTICE_ID = "5714d2958e414705898426cdd023211b";
	
	/***
	 * 获取平台公告siteid
	 */
	public static final String SITE_NOTICE_ID = "1";
	
	
	
	
	/**
	 * 上传文件基础虚拟路径
	 */
	public static final String USERFILES_BASE_URL = "/userfiles/";
	
	/**
	 * 获取当前对象实例
	 */
	public static Global getInstance() {
		return global;
	}
	
	/**
	 * 获取配置
	 * @see ${fns:getConfig('adminPath')}
	 */
	public static String getConfig(String key) {
		String value = map.get(key);
		if (value == null){
			value = loader.getProperty(key);
			map.put(key, value != null ? value : StringUtils.EMPTY);
		}
		return value;
	}

	/***
	 * 获取读取路径信息
	 * @param path
	 * @return
     */
	public static String getConfigByPath(String path) {
		String value = Tools.readTxtFile(path);
		return value;
	}
	
	/**
	 * 获取管理端根路径
	 */
	public static String getAdminPath() {
		return getConfig("adminPath");
	}
	
	/**
	 * 获取前端根路径
	 */
	public static String getFrontPath() {
		return getConfig("frontPath");
	}
	public static String getWeixinPath() {
		return getConfig("weixinPath");
	}
	/**
	 * 获取URL后缀
	 */
	public static String getUrlSuffix() {
		return getConfig("urlSuffix");
	}
	
	/**
	 * 是否是演示模式，演示模式下不能修改用户、角色、密码、菜单、授权
	 */
	public static Boolean isDemoMode() {
		String dm = getConfig("demoMode");
		return "true".equals(dm) || "1".equals(dm);
	}
	
	/**
	 * 在修改系统用户和角色时是否同步到Activiti
	 */
	public static Boolean isSynActivitiIndetity() {
		String dm = getConfig("activiti.isSynActivitiIndetity");
		return "true".equals(dm) || "1".equals(dm);
	}
    
	/**
	 * 页面获取常量
	 * @see ${fns:getConst('YES')}
	 */
	public static Object getConst(String field) {
		try {
			return Global.class.getField(field).get(null);
		} catch (Exception e) {
			// 异常代表无配置，这里什么也不做
		}
		return null;
	}

	/**
	 * 获取上传文件的根目录
	 * @return
	 */
	public static String getUserfilesBaseDir() {
		String dir = getConfig("userfiles.basedir");
		if (StringUtils.isBlank(dir)){
			try {
				dir = ServletContextFactory.getServletContext().getRealPath("/");
			} catch (Exception e) {
				return "";
			}
		}
		if(!dir.endsWith("/")) {
			dir += "/";
		}
//		System.out.println("userfiles.basedir: " + dir);
		return dir;
	}
	
    /**
     * 获取工程路径
     * @return
     */
    public static String getProjectPath(){
    	// 如果配置了工程路径，则直接返回，否则自动获取。
		String projectPath = Global.getConfig("projectPath");
		if (StringUtils.isNotBlank(projectPath)){
			return projectPath;
		}
		try {
			File file = new DefaultResourceLoader().getResource("").getFile();
			if (file != null){
				while(true){
					File f = new File(file.getPath() + File.separator + "src" + File.separator + "main");
					if (f == null || f.exists()){
						break;
					}
					if (file.getParentFile() != null){
						file = file.getParentFile();
					}else{
						break;
					}
				}
				projectPath = file.toString();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return projectPath;
    }
	
}
