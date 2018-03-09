package com.thinkgem.jeesite.common.utils;


import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.sz1card1.sdk.OpenApiClient;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class OrderNumberUtil {

	public static String getOrderNo(String buinsval){
		String buns="00";//业务类型默认是运单
		int num=0;///业务每天流水
		if (DataDic.MODEL_RECHARGE.equals(buinsval)){///0充值
			buns=DataDic.MODEL_RECHARGE;
			num=ServiceHelper.getConsumeService().daynum()+1;
		}else if (DataDic.MODEL_TRADEORDER.equals(buinsval)){///1运单结算
			buns=DataDic.MODEL_TRADEORDER;
			num=ServiceHelper.getConsumeService().daynum()+1;
		}else if (DataDic.MODEL_BIDSETTLE.equals(buinsval)){//2招标结算
			buns=DataDic.MODEL_BIDSETTLE;
			num=ServiceHelper.getBidinfoService().daynum()+1;
		}else if (DataDic.MODEL_BIDDING.equals(buinsval)){ //3竞标押金
			buns=DataDic.MODEL_BIDDING;
			num=ServiceHelper.getBiddingService().daynum()+1;

		}else if (DataDic.MODEL_CASH.equals(buinsval)){//4.提现
			buns=DataDic.MODEL_CASH;
			num=ServiceHelper.getConsumeService().daynum()+1;

		}else if (DataDic.MODEL_TRANCF.equals(buinsval)){//5转账
			buns=DataDic.MODEL_TRANCF;
			num=ServiceHelper.getConsumeService().daynum()+1;

		}else if (DataDic.MODEL_COIN.equals(buinsval)){//6卓币
			buns=DataDic.MODEL_COIN;
			num=ServiceHelper.getConsumeService().daynum()+1;

		}else if (DataDic.MODEL_PETROL.equals(buinsval)){//7油气
			buns=DataDic.MODEL_PETROL;
			num=ServiceHelper.getConsumeService().daynum()+1;

		}else if (DataDic.MODEL_GUEN.equals(buinsval)){//保证金
			buns=DataDic.MODEL_GUEN;
			num=ServiceHelper.getConsumeService().daynum()+1;

		}else if (DataDic.MODEL_BIDORDER.equals(buinsval)){///合同号
			buns=DataDic.MODEL_BIDORDER;
			num=ServiceHelper.getBidOrderService().daynum()+1;
		}else if (DataDic.MODEL_BIDINFO.equals(buinsval)){///合同号
			buns=DataDic.MODEL_BIDINFO;
			num=ServiceHelper.getBidOrderService().daynum()+1;
		}else if (DataDic.MODEL_ORDERINFO.equals(buinsval)){///运单
			buns=DataDic.MODEL_ORDERINFO;
			num=ServiceHelper.getOrderService().daynum()+1;
		}else if (DataDic.MODEL_BIDBL.equals(buinsval)){///提货单
			buns=DataDic.MODEL_BIDBL;
			num=ServiceHelper.getBlinfoService().daynum()+1;
		}else if(DataDic.MODEL_EXCHANGE.equals(buinsval)){
			buns=DataDic.MODEL_EXCHANGE;
			num=ServiceHelper.getUserPetrolExchangeService().daynum()+1;
		}else if(DataDic.MODEL_EXCHANGE.equals(buinsval)){
			buns=DataDic.MODEL_EXCHANGE;
			num=ServiceHelper.getActivityAwardrecordService().daynum()+1;
		}else{
			Consumerecod consumerecod=new Consumerecod();
			consumerecod.setConsumetype(buinsval);
			num=ServiceHelper.getConsumeService().daynum(consumerecod)+1;
			buns=buinsval;
		}
		String orderNo=buns+DateUtil.getDays()+getRandomNumber(4);
		if (num<10){
			orderNo+="000"+num;
		}else if (num>=10 && num <100){
			orderNo+="00"+num;
		}else if (num>=100 && num<1000){
			orderNo+="0"+num;
		}else{
			orderNo+=num;
		}
		return orderNo;
	}


	/***
	 * 获取公共的订单编号：1位平台序号+1位业务类型+17位时间+5位随机数字
	 * @Description: TODO
	 * @param @param system_Module_Enum
	 * @param @param dataType
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author
	 */
	public static String getCommonOrderNumber(Const.System_Module_Enum system_Module_Enum, int dataType){
		return  String.format("%d", system_Module_Enum.ordinal())
				+String.valueOf(dataType)+DateUtil.getDetailTime()+getRandomNumber(5);
	}
	
	/***
	 * 获取招标文号
	 * @param system_Module_Enum
	 * @param dataType
	 * @return
	 */
	public static String getBidCode(Const.System_Module_Enum system_Module_Enum, int dataType){
		return  String.format("%d", system_Module_Enum.ordinal())
				+String.valueOf(dataType)+DateUtil.getDetailTime()+getRandomNumber(2);
	}
	
	
	/***
	 * 根据传递的位数生成随机数据
	 * @Description: TODO
	 * @param @param bitCount
	 * @param @return   
	 * @return long  
	 * @throws
	 * @author
	 */
	public static  long getRandomNumber(int bitCount){
		long startValue=(long) Math.pow(10,bitCount-1);
		long endValue=(long) Math.pow(10,bitCount);
		Random rnd = new Random();
		return   (long)(Math.random()*(endValue-startValue)+startValue);
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Map<String, Object> testMap = new HashMap<>();
		testMap.put("userAccount", "10000");
		testMap.put("where", "1=1 and Mobile='15507599162'");
		testMap.put("pageIndex", 0);
		testMap.put("pageSize", 10);
		testMap.put("orderBy", "");
		testMap.put("cardId", "desc");
		OpenApiClient apiClient = new OpenApiClient("C2549D33134942FB94E936205AA57AA8", "I0AAQY");
		JsonObject jsonObject = apiClient.CallHttpPost("Get_MembersPagedV2", testMap);


		int status = jsonObject.get("status").getAsInt();
		JsonArray array = jsonObject.get("data").getAsJsonArray();
		for(int i=0; i<array.size(); i++){
			System.out.println(" i = " + i + " value = " + array.get(i));
			JsonObject object = array.get(i).getAsJsonObject();
			System.out.println(" ---------->> guid = " + object.get("Guid").getAsString());
		}

		 BigInteger b = new BigInteger("-1888832");
         b = b.abs();
         System.out.println(b.toString());
         BigInteger bs = new BigInteger("1888832");
         bs = bs.abs();
         System.out.println(bs.toString());
		//System.out.println(getOrderNo());
		System.out.println(getCommonOrderNumber(Const.System_Module_Enum.LogisticsWebSystem,1));
	}
}
