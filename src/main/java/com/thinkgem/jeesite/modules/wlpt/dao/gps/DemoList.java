package com.thinkgem.jeesite.modules.wlpt.dao.gps;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * 测试传输数据的类
 * @author ASUS
 *
 */
public class DemoList {
	private String username;
	private String password;
	private Map<String,Object> list;
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Map<String,Object> addList(){
		String username = "吕晓辉";
		String pwd = "5647a357abd84606a4d7327ff3d077b3a304174521f60cf143108080";
		this.username=username;
		this.password=pwd;
		String carNum = "冀DC4630";
		String railType = "0";
		String railName = "围栏a";
		//入围出围
		Date railTime = new Date();
		Date railLeaveTime = new Date();
		long railStopTime = (railLeaveTime.getTime()-railTime.getTime())/1000/60;
		list = new HashMap<String,Object>();
		
		list.put("carNum", carNum);
		list.put("railType", railType);
		list.put("railName", railName);
		list.put("railStopTime", railStopTime);
		list.put("railTime", railTime);
		list.put("railLeaveTime", railLeaveTime);
//		list = new ArrayList<Object>();
//		list.add(carNum);
//		list.add(railType);
//		list.add(railName);
//		list.add(railStopTime);
//		list.add(railTime);//入围时间
//		list.add(railLeaveTime);
		return list;
	}
	
}
