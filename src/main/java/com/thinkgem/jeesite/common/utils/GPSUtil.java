package com.thinkgem.jeesite.common.utils;

import com.thinkgem.jeesite.common.service.ServiceException;
import java.rmi.RemoteException;
import java.util.Map;
import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;

public class GPSUtil {


	private String HttpPostUrl(String urls, Map<String, Object> params) {
			String endpoint = "http://121.42.10.101/WebService/ZhuoDaService.asmx";  
	        String result = "no result!";  
	        Service service = new Service();  
	        int num = 0;
	        Call call;  
	        Object[] object = new Object[params.size()];
	        try {  
	            call = (Call) service.createCall();  
	              
	            call.setTargetEndpointAddress(endpoint);// 远程调用路径  
	            call.setOperationName(new QName("http://tempuri.org/",urls));   
	            call.setSOAPActionURI("http://tempuri.org/"+urls);
	            
	            if(params.size()>0){
	            	for (Map.Entry<String, Object> entry : params.entrySet()) {  
		            	  
		                System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
		                // 设置参数名:  
			            call.addParameter(new QName("http://tempuri.org/",entry.getKey()), // 参数名  
			                    XMLType.XSD_STRING,// 参数类型:String  
			                    ParameterMode.IN);// 参数模式：'IN' or 'OUT'
				        object[num] = entry.getValue();//Object是用来存储方法的参数
				        num++;
		            } 
	            }
	           // 设置返回值类型：  
	           // call.setReturnType(XMLType.XSD_STRING);// 返回值类型：String            
	  
                result = (String) call.invoke(object);// 远程调用  
               // System.out.println(result);
	        } catch (ServiceException e) {  
	            e.printStackTrace();  
	        } catch (RemoteException e) {  
	            e.printStackTrace();  
	        } catch (javax.xml.rpc.ServiceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
	        return result;
	}


	/**
	 * 发送请求
	 * @param params
	 * @return
	 */
	public String callHttpPost(String action,Map<String, Object> params){
		return HttpPostUrl(action, params);
	}



}
