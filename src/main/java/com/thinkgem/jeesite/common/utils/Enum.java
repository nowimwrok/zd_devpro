package com.thinkgem.jeesite.common.utils;

public class Enum {
	/***
	 * 费用扣除方式 
	 * @author whoami
	 *
	 */
	public static enum FeeDecutionWay{
		
		/**
		 * @Fields SuccessfulTransaction : 从用户余额扣
		 */
		SuccessfulTransaction,
		/**
		 * @Fields StorageInformation : 从用户红包扣除
		 */
		RedPacket,
		/**
		 * @Fields GuaranteeMoney : 从用户保证金扣除
		 */
		GuaranteeMoney,
		/**
		 * @Fields WebBalance : 从网站账户余额扣除
		 */
		WebBalance,
		/**
		 * @Fields CardBalance : 从一卡通账户余额扣除
		 */
		CardBalance,
		/**
		 * @Fields CoinBalance : 从卓币账户余额扣除
		 */
		 CoinBalance
		}
	
	
	public static enum WeChatTemple{
		/***
		 *  @Fields ORDER_CANCEL :退单状态通知 
		 */
		ORDER_CANCEL, 
		/***
		 *  @Fields GOODS_SOURCE :货源信息通知
		 */
		GOODS_SOURCE,
		/***
		 *  @Fields NEW_ORDER :运单生成通知
		 */
		NEW_ORDER,
		/***
		 *  @Fields ORDER_STATUS :运单状态更新通知
		 */
		ORDER_STATUS,
		/***
		 *  @Fields ORDER_STATUS_COMPLETED :运单完成通知
		 */
		ORDER_STATUS_COMPLETED,
		/***
		 *  @Fields ORDER_STATUS_ACCEPTANCE :订单已受理通知
		 */
		ORDER_STATUS_ACCEPTANCE,
		/***
		 *  @Fields CARS_SOURCE :车源信息通
		 */
		CARS_SOURCE,
		/***
		 * 测试发布招标通知
		 */
		PUB_BID,
		/**
		 * 中标通知
		 */
		NOTICE_BID,
		/***
		 * 竞标成功通知通知
		 */
		SUCCES_BID,
		/***
		 * 废标通知
		 */
		CANCEL_BID
	}
}
