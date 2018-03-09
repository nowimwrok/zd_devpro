package com.thinkgem.jeesite.modules.sys.listener;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.thinkgem.jeesite.common.utils.Const;
import org.springframework.web.context.support.WebApplicationContextUtils;


/**
 * 
* 类名称：WebAppContextListener.java
* 类描述： 
* 作者单位： 
* 联系方式：
* @version 1.0
 */
public class WebAppContextListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent event) {
		// TODO Auto-generated method stub
	}

	/* （非 Javadoc）
	 * @see javax.servlet.ServletContextListener#contextInitialized(javax.servlet.ServletContextEvent)
	 */
	public void contextInitialized(ServletContextEvent event) {
		// TODO Auto-generated method stub
		Const.WEB_APP_CONTEXT = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
		//System.out.println("========获取Spring WebApplicationContext");
		try {
			//友情链接
			/*FriendlyLinkService friendlyService=ServiceHelper.getFriendlylinkService();
			PageData condition=new PageData();
			condition.put("MODULE", "1");
			List<PageData> wlptFriendlyList=friendlyService.findByCondition(condition);
			event.getServletContext().setAttribute("WlptFriendlyList", wlptFriendlyList);
			
			condition=new PageData();
			condition.put("MODULE", "0");
			List<PageData> commonFriendlyList=friendlyService.findByCondition(condition);
			event.getServletContext().setAttribute("CommonFriendlyList", commonFriendlyList);
			
			//wlpt首页统计数据
			StatisticsChinaAreaService statisticsChinaAreaService=ServiceHelper.getStatisticsChinaAreaService();
			List<PageData> statisticsChinaAreaList=statisticsChinaAreaService.listAll(null);
			event.getServletContext().setAttribute("StatisticsChinaAreaList", statisticsChinaAreaList);
			
			//系统配置
			InterfaceconfigService interfaceconfigService=ServiceHelper.getInterfaceconfigService();
			List<PageData> interfaceconfigList=interfaceconfigService.listAll(null);
			event.getServletContext().setAttribute("InterfaceconfigList", interfaceconfigList);
			
			//app版本
			*//*AppVersionService appVersionService=ServiceHelper.getAppVersionService();
			 PageData version=appVersionService.findLastedVersion();
			event.getServletContext().setAttribute(Const.SESSION_APP_VERSION, version);
			//app下载链接地址
			String url = Tools.readTxtFile(Const.WLPT_DOMAIN) + "/" + Const.FILEPATHAPPFILE + version.getString("NAME");
			event.getServletContext().setAttribute("appVersion", url);*//*
			
			//获取logo
			AdvertisementService advertisementService=ServiceHelper.getAdvertisementService();
			PageData logoPd=new PageData();
			logoPd.put("NAMES", "zd_logo");
			logoPd.put("ISDELETE", 0);
			logoPd.put("TYPE", "1");
			Page logopg=new Page();
			logopg.setPd(logoPd);
			if(advertisementService.list(logopg).size()>0){
				logoPd=advertisementService.list(logopg).get(0);
			}
			event.getServletContext().setAttribute("logoPd", logoPd);*/
			
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
	}

}
