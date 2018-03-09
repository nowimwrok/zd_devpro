package com.thinkgem.jeesite.common.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.BeanUtils;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsLocationinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsRecentlocationinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsReslog;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsLocationinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsRecentlocationinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsReslogService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsWhitelistService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;

@Transactional(readOnly = true)
public class LBSUtil {
	static String serverIP;
	static String serverPort;
	static String key;
	static String secret;
	static LbsWhitelistService whiteListService=ServiceHelper.getLbsWhitelistService();
	static LbsReslogService reslogService=ServiceHelper.getLbsReslogService();
	static LbsLocationinfoService locationinfoService=ServiceHelper.getLbsLocationinfoService();
	static LbsRecentlocationinfoService recentLocationinfoService = ServiceHelper.getRecentlocationinfoService();
	static OrderinfoService orderService=ServiceHelper.getOrderinfoService();
	static CarService carService=ServiceHelper.getCarService();
	static JobBiz jobService=ServiceHelper.getJobService();
	private static void initConfig(){
			String lbsInfo1=Tools.readTxtFileForThread(Const.LBSINFO);
			String[] config = lbsInfo1.split(",");
			serverIP=config[0];
			serverPort=config[1];
			key=config[2];
			secret=config[3];
	 }
	public static void initConfig(  String serverIP,
	 String serverPort,
	 String companyId,
	 String companyPwd){
		 serverIP=serverIP;
	 serverPort=serverPort;
	 companyId=companyId;
	  companyPwd=companyPwd;
	}
	
	 public static void main(String[] args) {
		 
		  System.out.println(LBSUtil.SendList("13719119825", "粤B435", 2,"",""));
		  try {
			System.out.println(whiteListService.findList(null).size());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 //System.out.println(SendLocation("13719119825"));   
	 }
	 
	 
	 
	
	 /***
	  * 获得此授权手机号码即时的位置信息
	  * @Description: TODO
	  * @param @param mobile
	  * @param @param carNumber
	  * @param @param traderOrder
	  * @param @return   
	  * @return PageData  
	  * @throws
	  * @author zyj
	  * @date 2016年10月10日
	  */
	 @Transactional(readOnly = false)
	 public static PageData SendLocation(String mobile,String carNumber,String traderOrder,String userName, String userIP,boolean isImmediate){
		   
		    initConfig(); 
		    PageData pdResult=new PageData();
		    String url=("http://"+serverIP+serverPort+
					 "/authlbsquery/?key="+key+"&secret="+
					 secret+"&mobile="+mobile);
		      pdResult.put("REQUESTTIME", System.currentTimeMillis()); 
			 pdResult.put("CARNUM", carNumber);
			 pdResult.put("TRADERORDERID", traderOrder);
			 pdResult.putAll(XMLUtil.getLBSXMLProperty(getWebServiceResult(url)));
			 addDBRecord(pdResult,mobile,1,2,true,userName,userIP, isImmediate);
			return pdResult; 
	 }
	 
	 @Transactional(readOnly = false)
	 public static void addDBRecord(PageData pdResult,String mobile, int operationType,int actionType,boolean isAddLocationInfo,
			 String userName, String userIP,boolean isImmediate) {
		  try{ 
			  addResLog( pdResult, mobile,operationType,actionType,userName, userIP,isImmediate);
			  if(isAddLocationInfo&&"0".equals(pdResult.getString("resid")))
				  addLocationInfo( pdResult, mobile,  operationType, actionType,userName,userIP);
			 }catch(Exception ex){
				 ex.printStackTrace();
			 }
		} 
	  
	 
	 /***
	   * 添加定位详情到定位表
	   * @Description: TODO
	   * @param @param jsonObjectResult
	   * @param @param whiteList   
	   * @return void  
	   * @throws
	   * @author zyj
	   * @date 2016年10月10日
	   */
	 @Transactional(readOnly = false)
	  private static void addLocationInfo(PageData pdResult,String mobile, int operationType,int actionType, String userName, String userIP) {
		String address=pdResult.getString("location");
		LbsLocationinfo llinfo = new LbsLocationinfo();
		LbsRecentlocationinfo lrlinfo = new LbsRecentlocationinfo();
		llinfo.setCreatetime(new Date());
		llinfo.setIsNewRecord(true);
		llinfo.setId(IdGen.uuid());
		llinfo.setMobile(mobile);
		llinfo.setLng(pdResult.getString("lng"));
		llinfo.setLat(pdResult.getString("lat"));
		llinfo.setAddress(address);
		llinfo.setLocationtype(String.valueOf(0));
		llinfo.setLocationtime(Tools.str2Date(pdResult.getString("locationtime")));
		llinfo.setUsername(userName);
		llinfo.setUserip(userIP);
		llinfo.setTradeorderid(pdResult.getString("TRADERORDERID"));
		
		
		try {
			//更新订单状态：定位超过订单的指定天数，或者定位状态已经完成需关闭订单的定位状态
			Orderinfo orderinfo = new Orderinfo();
			orderinfo.setId(pdResult.getString("TRADERORDERID"));
			
			Orderinfo order=null;
			if(!Tools.IsNullOrWhiteSpace(orderinfo.getId())){
				 List<Orderinfo> orders=orderService.findLocationOrder(orderinfo); 
				 if(orders.size()>0){
					  order=orders.get(0);
					  llinfo.setCarid( order.getQuoteinfo().getCar().getNumber());	
				 }
			 } 
            //设置订单的车牌号码	  
			if(!Tools.IsNullOrWhiteSpace(pdResult.getString("CARNUM"))){ 
				llinfo.setCarid(pdResult.getString("CARNUM"));	
			}
				 
			//添加历史记录表，更新最近一次定位表,根据结果更新订单定位状态
			locationinfoService.save(llinfo);
			BeanUtils.copyProperties(llinfo,lrlinfo);//把定位数据复制到记录
			
			LbsRecentlocationinfo lr = new LbsRecentlocationinfo();
			lr.setMobile(mobile);
			lr.setTradeorderid(orderinfo.getId());//手机号和订单号确定唯一性
			
			lr =recentLocationinfoService.findByCondition(lr);
			if(lr!=null){
				lrlinfo.setId(lr.getId());
				lrlinfo.setIsNewRecord(false);
			}
			recentLocationinfoService.save(lrlinfo);//保存数据
			
			 if(order!=null){ 
				 String city = address;
				 if(city.contains(";")){
					 city = address.substring(0, address.indexOf(";"));
				 }
				/* int subHour=order.getLocationtimetype()==1?order.getLocationtime():order.getLocationtime()*24;*/
				 if(city.contains(order.getQuoteinfo().getGoods().getConsignAddress().getCity())){       //到达目的地后自动关闭定位，并把钱转移到用户红包字段
				 
					order.setLocationstate(Integer.parseInt(DataDic.LBS_STATUS_END));
					order.setIslocated("0");
					orderService.save(order);
					BscJob bjob=new BscJob();
					bjob.setJobcode(order.getOrderno());
			    	jobService.delete(bjob);
						
				 } 
			 }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/***
	  * 添加操作日志	
	  * @Description: TODO
	  * @param    
	  * @return void  
	  * @throws
	  * @author zyj
	  * @date 2016年10月10日
	  */
	  @Transactional(readOnly = false)
	 public static void addResLog(PageData pdResult, String mobile,int actionType,int operationType,
			 String userName, String userIP,boolean isImmediate){
	 	LbsReslog reslog = new LbsReslog();
	 	reslog.setIsNewRecord(true);
	 	reslog.setId(IdGen.uuid());
	 	reslog.setCompanyid(key);
	 	reslog.setCompanypwd(secret);
	 	reslog.setMobile(mobile);
	 	reslog.setActiontype(String.valueOf(actionType));
	 	reslog.setOpertype(String.valueOf(operationType));
	 	reslog.setResult(pdResult.getString("resid"));
	 	reslog.setResmsg(pdResult.getString("resmsg"));
	 	reslog.setResreason(!isImmediate?"":"立即定位");
	 	reslog.setResfrom("1");//第三方API来源:网站自动运行调用
	 	reslog.setRestimedelay(String.valueOf(System.currentTimeMillis()-Long.parseLong(pdResult.getString("REQUESTTIME"))));//所耗时长
	 	reslog.setOperatetime(new Date());
	 	reslog.setUsername(userName);
	 	reslog.setUserip(userIP);
	 	
	 	try {
	 		reslogService.save(reslog);
	 	} catch (Exception e) {
	 		// TODO Auto-generated catch block
	 		e.printStackTrace();
	 	}
	 }
	  
	public static String getWebServiceResult(String url){
			String result = ""; 
		 try{
		// 创建HttpClient实例   
 	    HttpClient httpclient = new DefaultHttpClient();
 	    // 创建Get方法实例   
         HttpGet httpgets = new HttpGet(url);  
         HttpResponse response = httpclient.execute(httpgets);  
         HttpEntity entity = response.getEntity();  
         if (entity != null) {  
             InputStream instreams = entity.getContent();  
             result = convertStreamToString(instreams).replace("&lt;", "<").replace("&gt;", ">"); 
             httpgets.abort();  
         }  
		 }
		 catch(Exception ex){
			 ex.printStackTrace(); 
		 }
		 return result;
	  }
	  
	 	
	 	public static String convertStreamToString(InputStream is) {    
	         BufferedReader reader = null;
			try {
				reader = new BufferedReader(new InputStreamReader(is,"utf-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}    
	         StringBuilder sb = new StringBuilder();    
	      
	         String line = null;    
	         try {    
	             while ((line = reader.readLine()) != null) {
	                 sb.append(line + "\n");    
	             }    
	         } catch (IOException e) {    
	             e.printStackTrace();    
	         } finally {    
	             try {    
	                 is.close();    
	             } catch (IOException e) {    
	                e.printStackTrace();    
	             }    
	         }    
	         return sb.toString();    
	     }
	 	
	 	/**
	 	 * 将包含unicode的字符串转换成中文
	 	 * @param asciicode
	 	 * @return
	 	 */
	 	private static String asciiToNative( String asciicode )  
	    {  
	        String[] asciis = asciicode.split ("\\\\u");  
	        String nativeValue = asciis[0];  
	        try  
	        {  
	            for ( int i = 1; i < asciis.length; i++ )  
	            {  
	                String code = asciis[i];  
	                nativeValue += (char) Integer.parseInt (code.substring (0, 4), 16);  
	                if (code.length () > 4)  
	                {  
	                    nativeValue += code.substring (4, code.length ());  
	                }  
	            }  
	        }  
	        catch (NumberFormatException e)  
	        {  
	            return asciicode;  
	        }  
	        return nativeValue;  
	    }  
 
	 /***
	  * 白名单操作接口
	   * @Description: TODO
	  * @param @param mobile 
	  * @param @param carNum
	  * @param @param operationType 0删除1添加2查询
	  * @param @param userName 用户名
	  * @param @param userIp 用户IP
	  * @param @return   
	  * @return String  
	  * @throws
	  * @author zyj
	  * @date 2016年10月10日
	  */
	 @Transactional(readOnly = false)
	 public static PageData SendList(String mobile, String carNum, int operationType,String userName,String userIp){
		 initConfig();	
		 PageData pdResult=new PageData();
		 String url=("http://"+serverIP+":"+serverPort+
					 "/authlbsopen/?key="+key+"&secret="+
					 secret+"&mobile="+mobile);
		 pdResult.put("REQUESTTIME", System.currentTimeMillis()); 
		 pdResult.putAll(XMLUtil.getLBSXMLProperty(getWebServiceResult(url)));
		 if(!"1".equals(pdResult.getString("resid"))&&!"0".equals(pdResult.getString("resid"))){
			 url=("http://"+serverIP+":"+serverPort+
					 "/authlbsstatus/?key="+key+"&secret="+
					 secret+"&mobile="+mobile);
			 pdResult.clear();
			 pdResult.put("REQUESTTIME", System.currentTimeMillis()); 
			 pdResult.putAll(XMLUtil.getLBSXMLProperty(getWebServiceResult(url)));
		 }
		 addDBRecord( pdResult,mobile,operationType,1,false,userName,userIp,false);
		 return pdResult;
	 }
}
