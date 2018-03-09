package com.thinkgem.jeesite.common.config;

import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

/**
 * 平台状态配置数据字典文档
 * Created by ForHeart on 16/7/18.
 */
public class DataDic {
    /**
     * 当前对象实例
     */
    private static DataDic dataDic = new DataDic();

    /**
     * 两次数据访问相差的时间大于多少毫秒才执行操作
     */
    public static final Double DATATIMEDIFF=20000.00;

    /**
     * 一卡通对接openid
     */
    public static final String METRO_CARD_OPENID="C2549D33134942FB94E936205AA57AA8";
    /**
     * 一卡通对接secret
     */
    public static final String METRO_CARD_SECRET="I0AAQY";
    
    
    /**
     * 一卡通对接卡密码
     */
    public static final String METRO_CARD_PWD="123456";

    /**
     * 竞标押金
     */
    public static final Double BIDGUARANTEE=Double.valueOf((DictUtils.getDictValue("投标保证金", "bid_bond", ""))!=null?(DictUtils.getDictValue("投标保证金", "bid_bond", "")):"0");
    /**
     * 竞标押金减免充值金额条件
     */
    public static final Double RECHARGETOTAL=Double.valueOf((DictUtils.getDictValue("投标保证金减免条件", "bid_bond_condition", ""))!=null?(DictUtils.getDictValue("投标保证金减免条件", "bid_bond_condition", "")):"0");

    /**
     * 一卡通换卡费用
     */
    public static final String METRO_LOSS_MONEY="20";
    
    /**
     * 一卡通申请时提醒的邮箱  
     * 账号EMAIL
     * 标题 EMAILTITLE
     * 内容EMAILBODY
     */
    public static final String METRO_CARD_APPLY_EMAIL="1058238453@qq.com";
    public static final String METRO_CARD_APPLY_EMAILTITLE="一卡通挂失通知";
    public static final String METRO_CARD_APPLY_EMAILBODY="您有一条新的一卡通挂失操作待处理!!";
    
    //删除标识
    public static final String DEL_FLAG_DELETE = "1";
    public static final String DEL_FLAG_NORMEL = "0";

    /**
     * 是否
     */
    public static final String YES = "1";
    public static final String NO = "0";
    public static final Integer YES_INT = 1;
    public static final Integer NO_INT = 0;
    public static final String YES_STR = "是";
    public static final String NO_STR = "否";

    /**
     * 短信编码
     */
    public static final String SMSCODE_AUTHENSUCCES="authenSucces";///认证通过
    public static final String SMSCODE_AUTHENFILED="authenFiled";///认证驳回
    public static final String SMSCODE_ORDERCANCEL="orderCancel";///运单取消
    public static final String SMSCODE_BIDORDEREND="bidOrderEnd";///合同运输结束
    public static final String SMSCODE_NEWORDER="newOrder";///新运单
    public static final String SMSCODE_DELIVERGOODS="deliveryGoods";///货物送蛋
    public static final String SMSCODE_GETFREIGHT="getfreightCode";///收到运费
    public static final String SMSCODE_NOTBIDED="notBided";///未中标通知
    public static final String SMSCODE_DISPUTE="disputeCode";///争议
    public static final String SMSCODE_RECHARGE="rechargeCode";///充值成功
    public static final String SMSCODE_CASH="cash";///提现
    public static final String SMSCODE_FREIGHTREFUND="freightrefund";///运费退费
    public static final String SMSCODE_NOTIFYS="notifys";///中标通知
    public static final String SMSCODE_PLRINTPAY="printPay";///运费退费
    public static final String SMSCODE_REGISTER="registerSMS";///注册
    public static final String WEB_PATH="www.zhuoda56.com";///平台地址
    public static final String SMSCODE_Apply="userapply";///用户申请
    public static final String SMSCODE_ACCOUNT="accountsms";///账户资金变动
    public static final String UserWithdraw = "userWithdraw";//用户申请提现
    public static final String FENCE_IN="fence_in";//入围
    public static final String FENCE_OUT="fence_out";//出围
    /**
     * 0:加
     * 1:减
     */
    public static final String COUNT_WAY_PLUS = "0";
    public static final String COUNT_WAY_SUB = "1";


    /***
     * 用户认证状态
     * 0:未申请认证
     * 1:等待认证
     * 2:认证通过
     * 3:认证不通过
     */
    public static final String UNAUTHEN = "0";
    public static final String AUTHENWAITING = "1";
    public static final String AUTHENSUCCES = "2";
    public static final String AUTHENFAILED = "3";

    public static final String UNAUTHEN_STR = "未认证";
    public static final String AUTHENWAITING_STR = "已申请";
    public static final String AUTHENSUCCES_STR = "已认证";
    public static final String AUTHENFAILED_STR = "认证不通过";

    /***
     * 用户认证类型
     * 0:个人
     * 1:企业
     */
    public static final String AUTHEN_PERSONAL = "0";
    public static final String AUTHEN_COMPANY = "1";
    public static final String AUTHEN_CAR = "2";
    public static final String AUTHEN_DRIVER = "3";

    /***
     * 认证审核状态
     * 0:等待认证
     * 1:认证通过
     * 2:认证不通过
     */
    public static final String QUALITY_WAITING = "0";
    public static final String QUALITY_SUCCES = "1";
    public static final String QUALITY_FAILED = "2";

    /***
     * 是否完善个人资料
     * 0:未完善
     * 1:已完善
     */
    public static final String ISCOMPLETEINFO = "0";
    public static final String COMPLETEINFO = "1";

    /***
     * 结算资金是否冻结
     * 0:正常
     * 1:冻结
     */
    public static final int SETTLESTATUS = 0;
    public static final int UNSETTLESTATUS = 1;

    /**
     * 角色：
     * 物流平台
     * 车主
     * 货主
     * 管理员
     */
    public static final String ROLE_ENTERPRISE = "enterprise";
    public static final String ROLE_CAROWNER = "carowner";
    public static final String ROLE_GOODSOWNER = "goodsowner";
    public static final String ROLE_SYSTEMACCOUNT = "systemAccount";

    ///终审业务员
    public static final String ROLE_FINALCLERK = "finalClerk";
    //审核业务员
    public static final String ROLE_AUDITCLERK = "auditClerk";
    //财务管理
    public static final String ROLE_FINANCEOFFICER = "financeOfficer";
    //U_financial财务员
    public static final String ROLE_U_FINANCIAL = "U_financial";
    //业务员	U_salesman
    public static final String ROLE_U_SALESMAN = "U_salesman";
    //POS_financial pos机终审专审财务员
    public static final String ROLE_POS_FINANCIAL = "POS_financial";
    
    //POS_auditcial pos初审机财务员
    public static final String ROLE_POS_AUDITCLERK = "POS_auditcial";
    ///系统管理
    public static final String ROLE_SYSADMIN = "dept";


    /**
     * 企业总
     */
    public static final String COMPANYID = "0e7e69feca7a407f88c65ced70a24baf";

    /**
     * 获取平台个人中心菜单
     */
    public static final String MUNE_PERSONAL_ID = "f05692991238422ab8ce3a6477319182";

    /***
     * 获取平台导航菜单
     */
    public static final String MUNE_NAV_ID = "8ef436aa79ba49299f877573d4663a41";

    /**
     * 微信菜单
     */
    public static final String MUNE_WEIXIN_ID="91195d76e7f84dcb87095574d8337245";

    /**
     * 数据分析菜单
     */
    public static final String DATA_ANALYSIS_ID="2f50298d48b74801a86fab1aacad207d";

    /***
     * 注册方式
     * 1：Web网站门户注册
     * 2：手机APP注册
     * 3：微信公众号注册
     * 4:后台系统添加'
     */
    public static final String REG_WEB = "1";
    public static final String REG_APP = "2";
    public static final String REG_WX = "3";
    public static final String REG_WLPT = "4";

    /***
     * 绑定状态
     * 0:等待 1:同意,2失败
     */
    public static final String ATTACH_WAITING = "0";
    public static final String ATTACH_AGGREE = "1";
    public static final String ATTACH_FAILED = "2";

    /***
     * 运单线上支付:0
     * 运单线上支付:1
     */
    public static final String ORDER_ONLINEPAY = "1";
    public static final String ORDER_LINEPAY = "0";

    /**
     * 0:不预支付
     * 1:运单预支付
     */
    public static final String ORDER_PREPAY = "1";
    public static final String ORDER_UNPREPAY = "0";

    /***
     * 货源交易状态
     * 0:未报价
     * 1:开始报价
     * 2:报价完成,剩余吨位为0
     */
    public static final String GDS_UNQUOTE = "0";
    public static final String GDS_QUOTING = "1";
    public static final String GDS_FULLQUOTE = "2";

    /***
     * 1:已报价状态,2报价通过状态3:报价未通过状态4,交易取消
     */
    public static final String QUOTE_QUOTING = "1";
    public static final String QUOTE_SUCCESS = "2";
    public static final String QUOTE_QUOTFILED = "3";
    public static final String QUOTE_QUOTCALCEL = "4";

    /**
     *  数据发布源:0:自发没有明细，1:明细发布，2:合同发布，3招标发布4:合同提货单发布货源
     */
    public static final String GDS_DATASORCE_NORMAL = "0";
    public static final String GDS_DATASORCE_BLNOMAL = "1";
    public static final String GDS_DATASORCE_BIDORDER = "2";
    public static final String GDS_DATASORCE_BIDGDS = "3";
    public static final String GDS_DATASORCE_BIDORDERBL = "4";

    /**
     * 0：轻货 1：成品：2：原材料
     */
    public static final String GDS_ODDTYPE_QH = "0";
    public static final String GDS_ODDTYPE_CP = "1";
    public static final String GDS_ODDTYPE_YCL = "2";



    /**
     * 运单状态
     * 0	新运单
     * 1	已确认
     * 2	已取消
     * 3	已提货
     * 4	已回单
     * 5	已支付
     * 6	发起争议
     * 7    争议完毕
     */
    public static final String ORDER_STATUS_FREE = "-1";
    public static final String ORDER_STATUS_NEW = "0";
    public static final String ORDER_STATUS_SURE = "1";
    public static final String ORDER_STATUS_CANCEL = "2";
    public static final String ORDER_STATUS_TAKEGOODS = "3";
    public static final String ORDER_STATUS_RECEIPT = "4";
    public static final String ORDER_STATUS_PAY = "5";
    public static final String ORDER_STATUS_DISPUTE = "6";
    public static final String ORDER_STATUS_DISPUTE_END = "7";

    /**
     * 运单统计参数
     * 1	新运单
     * 2	运输中
     * 3	待支付
     * 4	已支付
     */
    public static final String ORDER_SUM_NEW = "1";
    public static final String ORDER_SUM_INTRANSIT = "2";
    public static final String ORDER_SUM_NOPAYMENT = "3";
    public static final String ORDER_SUM_END = "4";

    /**
     * 运单支付方式：0：余额；1余额卓币 2账户系统   3，账户系统卓币支付
     */
    public static final String ORDER_PAYWAY_BALANCE = "0";
    public static final String ORDER_PAYWAY_BALANCECOIN = "1";
    public static final String ORDER_PAYWAY_ACCOUNT = "2";
    public static final String ORDER_PAYWAY_ACCOUNTCOIN = "3";


    /**
     * 运单操作日志数据
     * 0:运单状态操作
     * 1:运单支付状态操作
     * 2:运输轨迹记录
     */
    public static final String ORDER_TRACE_TYPE_STATUS = "0";
    public static final String ORDER_TRACE_TYPE_PAY = "1";
    public static final String ORDER_TRACE_TYPE_TRADE = "2";
    public static final String ORDER_TRACE_TYPE_DISPUTE = "3";

    public static final String ORDER_TRACE_TITLE1 = "运单状态";
    public static final String ORDER_TRACE_TITLE2 = "运单支付";
    public static final String ORDER_TRACE_TITLE3 = "运单运输";
    public static final String ORDER_TRACE_TITLE4 = "争议处理";

    /***
     * -1	免运费
     * 0	未支付
     * 1	预冻结
     * 2	冻结
     * 3	支付预款
     * 4	取消冻结
     * 5	余款支付
     */
    public static final String ORDER_PAY_FREE = "-1";
    public static final String ORDER_PAY_UNPAY = "0";
    public static final String ORDER_PAY_PREFORZEN = "1";
    public static final String ORDER_PAY_FORZEN = "2";
    public static final String ORDER_PAY_PAYPREMONEY = "3";
    public static final String ORDER_PAY_CANCELFORZEN = "4";
    public static final String ORDER_PAY_BANANCE = "5";

    /**
     * 0后台系统账户充值，1后台充值、2平台提现
     */
    public static final String CONSUMEAUDIT_SYSRECHARGE = "0";
    public static final String CONSUMEAUDIT_ACCOUNTRECHARGE = "1";
    public static final String CONSUMEAUDIT_ACCOUNTCASH = "2";

    /***
     * consumeaudit_status
     * 审核状态:0:不需要审核；1新建审核；2审核通过；3终审成功－1:申请驳回 4:复核成功5.上传凭据
     */

    public static final String CONSUMEAUDIT_STATUS_FAILED = "-1";
    public static final String CONSUMEAUDIT_STATUS_UNAUDIT = "0";
    public static final String CONSUMEAUDIT_STATUS_NEWAUDIT = "1";
    public static final String CONSUMEAUDIT_STATUS_TRIAL = "2";
    public static final String CONSUMEAUDIT_STATUS_FINALJUDG = "3";
    public static final String CONSUMEAUDIT_STATUS_TOREVIEW = "4";
    public static final String CONSUMEAUDIT_STATUS_UPTECP = "5";
    /**
     * 交易类型：
     * -1后台系统
     * 0:余额充值
     * 1:支付宝充值
     * 2:微信充值
     * 3:结算支付
     * 4:结算提现
     * 5:收到结算
     * 6:冻结线上支付运费
     * 7:支付预支付运费
     * 8：收到预支付运费
     * 9:支付余款运费
     * 10:收到余款运费
     * 11:冻结运费返款
     * 12:争议退费
     * 13:油气返现
     * 14:余额提现
     * 15:账户转账
     * 16:收到转账
     * 17:支付预冻结线上运费
     * 18:收到冻结运费
     * 19:支付争议费用
     * 20:缴纳竞标押金
     * 21:收到竞标押金
     * 22:竞标押金还款
     * 23:收到竞标还款
     * 24:提现退款
     * 25:提现线下支出
     * 26:打印缴费
     * 27:收到缴纳打印
     */

    /*public static final String CONSUMERECODE_TYPE_BACKSYS = "-1";
    public static final String CONSUMERECODE_TYPE_BALANACE = "0";
    public static final String CONSUMERECODE_TYPE_ALPAY = "1";
    public static final String CONSUMERECODE_TYPE_WXPAY = "2";
    public static final String CONSUMERECODE_TYPE_SETTLEPAY = "3";
    public static final String CONSUMERECODE_TYPE_SETTLECASH = "4";
    public static final String CONSUMERECODE_TYPE_GETSETTLE = "5";
    public static final String CONSUMERECODE_TYPE_FORZENONLINE = "6";
    public static final String CONSUMERECODE_TYPE_PAYPREMONEY = "7";
    public static final String CONSUMERECODE_TYPE_GETPREMONEY = "8";
    public static final String CONSUMERECODE_TYPE_PAYONLIENBALANCE = "9";
    public static final String CONSUMERECODE_TYPE_GETONLINEBALANCE = "10";
    public static final String CONSUMERECODE_TYPE_RETURNFORZEN = "11";
    public static final String CONSUMERECODE_TYPE_TRADEMONEYRETURN = "12";
    public static final String CONSUMERECODE_TYPE_PETROLRETURN = "13";
    public static final String CONSUMERECODE_TYPE_CASHMONEY = "14";
    public static final String CONSUMERECODE_TYPE_ACCOUNTTRANSFER = "15";
    public static final String CONSUMERECODE_TYPE_RECEIVEDTRANSFER = "16";
    public static final String CONSUMERECODE_TYPE_PREFORZENONLINE = "17";
    public static final String CONSUMERECODE_TYPE_GETONLINE = "18";
    public static final String CONSUMERECODE_TYPE_PAYDISPUTE = "19";
    public static final String CONSUMERECODE_TYPE_BIDINGPAY = "20";
    public static final String CONSUMERECODE_TYPE_BIDINGGETPAY = "21";
    public static final String CONSUMERECODE_TYPE_BIDINGRETURN = "22";
    public static final String CONSUMERECODE_TYPE_BIDINGGETRETURN = "23";
    public static final String CONSUMERECODE_TYPE_CASHREFUND = "24";
    public static final String CONSUMERECODE_TYPE_CASHLINECASH = "25";
    public static final String CONSUMERECODE_TYPE_PRINTPAY = "26";
    public static final String CONSUMERECODE_TYPE_GETPRINTPAY = "27";*/


    /**
     * 类型名称	   类型编号	描述
     余额充值	        0001	充值模块
     卓币充值	        0002	余额支付卓币购买
     保证金充值	    0003	余额充值保证金
     服务费          0004  服务费
     余额购买油气	        0005	余额购买油气
  购买保险                               0006    购买保险   
  后台处理不通过退还冻结的保险费  0007   后台处理不通过退还冻结的保险费

     运费支出	        0101	运费冻结－运费支出
     运费返款	        0102	运单取消退还冻结运费
     运费收到预付	    0103	上传提货单收到预付运费
     运费预付支出	    0104	上传提货单预付运费支出
     运费余款支付	    0105	确认支付、余款运费支出
     运费收到余款	    0106	收到运费余款部分
     运费争议退款	    0107	收到争议退款
     争议余款支付     0108	争议余款支付（暂时不用）
     卓币运费冻结	    0109	卓币运费冻结
     卓币运费预付	    0110	上传提货单后预付卓币
     卓币运费收到预付	0111	上传提货单后承运方收到预付
     卓币运费支付余款	0112	完成交易：卓币运费支付余款
     卓币运费收到余款	0113	完成交易后收到卓币余款
     运费收到冻结     0114    收到运费冻结
     卓币收到冻结     0115    卓币收到运费冻结
     打印提货单缴费   0116    打印提货单缴费
     收到打印缴费     0117    收到打印缴费
     卓币收到冻结     0118    卓币解冻
     
     卓币支付运单LBS定位服务费	0119	运单lbs定位功能，卓币支付
     卓币收到运单LBS定位服务费  	0120	运单lbs定位功能，收到卓币支付
     
     余额支付运单LBS定位服务费	0121	运单lbs定位功能，余额支付
     余额收到运单LBS定位服务费  	0122	运单lbs定位功能，收到余额支付

     余额支付运单定位服务费 0123  运单开通定位服务调用定位服务功能费用
     余额收到运单定位服务费 0124  平台收到用户支付的运单定位服务费用

     信息查询支付服务费用 0125 用户开启查询用户信息接口支付费用
     信息查询收费服务费用 0126 平台收到用户支付信息查询费用


     招标结算支付	    0201	招标结算支付运费
     招标收到结算	    0202	招标结算收到运费
     招标结算提现	    0203	招标结算提现
     招标结算卓币     0204    招标结算卓币运费
     收到结算卓币     0205    收到卓币结算运费

     缴纳竞标保证金	0301	缴纳竞标保证金
     收到竞标保证金	0302	收到竞标保证金
     退还竞标保证金	0303	退还竞标保证金

     余额提现	        0401	提现模块
     收到余额提现	    0402	收到提现模块
     余额提现	退款     0403	提现失败,提现金额驳回

     余额转账	        0501	转账模块
     余额收到转账     0502	转账模块收到转账
     卓币转账	        0503	卓币转账模块
     卓币收到转账     0504	卓币转账模块收到转账
    卓币兑换	        0505	转账模块
     余额收到兑换     0506	转账模块收到转账
    油气转账	        0507	油气转账模块
     油气收到转账     0508	油气转账模块收到转账    

     卓币充值记录	    0601	卓币充值成功卓币记录
     卓币购买油气  	0602	卓币购买油气记录
     卓币消费        0603    卓币消费购买记录，购买油气收到的卓币

     油气充值记录	    0701	油气充值成功油气变动记录
     油气消费        0702    油气消费
     油气支付充值     0703     油气支付充值
     油气收到消费     0704     油气收到消费
     活动赠送油气	    0705	活动赠送油气成功油气变动记录
     油气支付赠送     0706     油气支付活动赠送
     油气支付兑换	    0707	油气支付兑换
     油气收到兑换     0708     油气收到兑换
     油气POS充值记录	    0709	油气POS充值成功油气变动记录

     保证金充值	    0801	保证金充值到账流水：2条流水余额充值流水、保证金增加流水
     保证金提现	    0802	保证金提现提现到账户余额
     积分兑换余额            0803    增加用户余额     
     一卡通缴费	    0901	一卡通换卡余额扣费
     一卡通缴费	    0902	收到一卡通换卡余额  

     */


    public static final String CONSUMERECODE_TYPE_BALANACE = "0001";
    public static final String CONSUMERECODE_TYPE_COINBALANACE = "0002";
    public static final String CONSUMERECODE_TYPE_GUENALANACE = "0003";
    public static final String CONSUMERECODE_TYPE_GETCONSUME = "0004";
    public static final String CONSUMERECODE_TYPE_PETROLBALANACE = "0005";
    public static final String CONSUMERECODE_TYPE_INSURBALANACE = "0006";
    public static final String CONSUMERECODE_TYPE_REINSURBALANACE = "0007";
    public static final String CONSUMERECODE_TYPE_FORZENONLINE = "0101";
    public static final String CONSUMERECODE_TYPE_RETURNFORZEN = "0102";
    public static final String CONSUMERECODE_TYPE_GETPREMONEY = "0103";
    public static final String CONSUMERECODE_TYPE_PAYPREMONEY = "0104";
    public static final String CONSUMERECODE_TYPE_PAYONLIENMONEY = "0105";
    public static final String CONSUMERECODE_TYPE_GETONLINEMONEY = "0106";
    public static final String CONSUMERECODE_TYPE_DISPUTEMONEYRETURN = "0107";
    public static final String CONSUMERECODE_TYPE_DISPUTEPAYMONEY = "0108";
    public static final String CONSUMERECODE_TYPE_FORZENONLINECOIN = "0109";
    public static final String CONSUMERECODE_TYPE_PAYPRECOIN = "0110";
    public static final String CONSUMERECODE_TYPE_GETPRECOIN = "0111";
    public static final String CONSUMERECODE_TYPE_PAYONLIENCOIN = "0112";
    public static final String CONSUMERECODE_TYPE_GETONLINECOIN = "0113";
    public static final String CONSUMERECODE_TYPE_GETFORZENONLINE = "0114";
    public static final String CONSUMERECODE_TYPE_GETFORZENONLINECOIN = "0115";
    public static final String CONSUMERECODE_TYPE_PRINTPAY = "0116";
    public static final String CONSUMERECODE_TYPE_GETPRINTPAY = "0117";
    public static final String CONSUMERECODE_TYPE_CONREFOUND = "0118";
    public static final String CONSUMERECODE_TYPE_PAYLBSCOIN = "0119";
    public static final String CONSUMERECODE_TYPE_GETLBSCOIN = "0120";
    public static final String CONSUMERECODE_TYPE_PAYLBSMONEY = "0121";
    public static final String CONSUMERECODE_TYPE_GETLBSMONEY = "0122";
    public static final String CONSUMERECODE_TYPE_PAYGPSLOC = "0123";
    public static final String CONSUMERECODE_TYPE_GETGPSLOC = "0124";
    public static final String CONSUMERECODE_TYPE_PAYAUTHINFO = "0125";
    public static final String CONSUMERECODE_TYPE_GETAUTHINFO = "0126";
    


    public static final String CONSUMERECODE_TYPE_SETTLEPAY = "0201";
    public static final String CONSUMERECODE_TYPE_GETSETTLE = "0202";
    public static final String CONSUMERECODE_TYPE_SETTLECASH = "0203";
    public static final String CONSUMERECODE_TYPE_SETTLEPAYCOIN = "0204";
    public static final String CONSUMERECODE_TYPE_GETSETTLECOIN = "0205";


    public static final String CONSUMERECODE_TYPE_BIDINGPAY = "0301";
    public static final String CONSUMERECODE_TYPE_BIDINGGETPAY = "0302";
    public static final String CONSUMERECODE_TYPE_BIDINGRETURN = "0303";

    public static final String CONSUMERECODE_TYPE_CASHMONEY = "0401";
    public static final String CONSUMERECODE_TYPE_GETCASHMONEY = "0402";
    public static final String CONSUMERECODE_TYPE_CASHMONEYRETURN = "0403";


    public static final String CONSUMERECODE_TYPE_ACCOUNTTRANSFER = "0501";
    public static final String CONSUMERECODE_TYPE_RECEIVEDTRANSFER = "0502";
    public static final String CONSUMERECODE_TYPE_COINTRANSFER = "0503";
    public static final String CONSUMERECODE_TYPE_RECEIVEDTRANSFERCOIN = "0504";
    public static final String CONSUMERECODE_TYPE_ACCOUNTEXCHANGE = "0505";
    public static final String CONSUMERECODE_TYPE_RECEIVEDEXCHANGE = "0506";
    public static final String CONSUMERECODE_TYPE_PETROTRANSFER = "0507";
    public static final String CONSUMERECODE_TYPE_RECEIVEDTRANSFERPETRO = "0508";

    public static final String CONSUMERECODE_TYPE_COINRECHARGE = "0601";
    public static final String CONSUMERECODE_TYPE_COINBUYPETROL = "0602";
    public static final String CONSUMERECODE_TYPE_GETCOINCONSUME = "0603";


    public static final String CONSUMERECODE_TYPE_PETROLRECHARGE = "0701";
    public static final String CONSUMERECODE_TYPE_PETROLCONSUME = "0702";
    
    public static final String CONSUMERECODE_TYPE_PAYPETROLRECHARGE = "0703";
    public static final String CONSUMERECODE_TYPE_GETPETROLCONSUME = "0704";

    public static final String CONSUMERECODE_TYPE_PETROLGRANT = "0705";
    public static final String CONSUMERECODE_TYPE_PAYPETROLGRANT = "0706";

    public static final String CONSUMERECODE_TYPE_PETROLEXCHANGE = "0707";
    public static final String CONSUMERECODE_TYPE_RECEIVEDPETROLEXCHANGE = "0708";
    
    public static final String CONSUMERECODE_TYPE_PETROLRECHARGEPOS = "0709";

    public static final String CONSUMERECODE_TYPE_GUNERECHAGE = "0801";
    public static final String CONSUMERECODE_TYPE_GUNECASH = "0802";
    
    public static final String CONSUMERECODE_TYPE_INTEGRALEXCHANGE="0803";
    
    public static final String CONSUMERECODE_TYPE_CARDLOSS = "0901";
    public static final String CONSUMERECODE_TYPE_GETCARDLOSS = "0902";



    /**
     * 账户余额	0
     * 卓币	    1
     * 结算账户 	2
     * 授信账户  3
     * 保证金账户	4
     * 保险账户  5
     * 油气账户   6
     * 竞标保证金 7
     * 帐户余额冻结 8
     * 卓币冻结 9
     * 账户系统10
     * 账户积分11
     */
    public static final String CONSUMERECODE_WAY_BALANCE = "0";
    public static final String CONSUMERECODE_WAY_COIN = "1";
    public static final String CONSUMERECODE_WAY_SETTLE = "2";
    public static final String CONSUMERECODE_WAY_CREDIT = "3";
    public static final String CONSUMERECODE_WAY_GUEN = "4";
    public static final String CONSUMERECODE_WAY_BAOXIAN = "5";
    public static final String CONSUMERECODE_WAY_PETROL = "6";
    public static final String CONSUMERECODE_WAY_BIDINGL = "7";
    public static final String CONSUMERECODE_WAY_FRZBALANCEL = "8";
    public static final String CONSUMERECODE_WAY_FRZCOIN = "9";
    public static final String CONSUMERECODE_WAY_ACCOUNT = "10";
    public static final String CONSUMERECODE_WAY_INTEGRITY="11";

    /**
     * -1后台审核中
     * 0:交易中
     * 1:交易成功
     * 2:交易失败
     * 3:冻结中
     */
    public static final String CONSUMERECODE_STATUS_BACKREING = "-1";
    public static final String CONSUMERECODE_STATUS_CONING = "0";
    public static final String CONSUMERECODE_STATUS_SUCCES = "1";
    public static final String CONSUMERECODE_STATUS_FAILED = "2";
    public static final String CONSUMERECODE_STATUS_FREEZING = "3";


    /**
     * 是否是系统账户交易记录
     * 0:不是
     * 1:是
     */
    public static final String ISSYSRECODE_YES = "1";
    public static final String ISSYSRECODE_NO = "0";

    /**
     * 交易平台：0:后台;1平台2 安卓3 微信4 苹果\
     */
    public static final String SCANTYPE_BACK = "0";
    public static final String SCANTYPE_WEB = "1";
    public static final String SCANTYPE_ANDROID = "2";
    public static final String SCANTYPE_WX = "3";
    public static final String SCANTYPE_IOS = "4";

    /**
     * 交易模块:0账户;1:运单交易;2,运输合同结算3.竞标
     */
    /**
     * 交易模块	值	英文
     * 充值	    0	cz
     * 运单交易	1	yd
     * 招标结算	2	zbj
     * 竞标保证金	3	jb
     * 提现	    4	tx
     * 转账	    5	zz
     * 卓币	    6	zd
     * 油气	    7	yq
     * 保证金	8	bzj
     * 保险    9   bx
     * 合同   HT
     */
    public static final String CONSUMERECODE_MODEL_ACCOUNT = "0";
    public static final String CONSUMERECODE_MODEL_TRADEORDER = "1";
    public static final String CONSUMERECODE_MODEL_SETTLEORDER = "2";
    public static final String CONSUMERECODE_MODEL_BIDDING = "3";
    public static final String CONSUMERECODE_MODEL_CASH = "4";
    public static final String CONSUMERECODE_MODEL_TRANCF = "5";
    public static final String CONSUMERECODE_MODEL_WEBCOIN = "6";
    public static final String CONSUMERECODE_MODEL_PETROL = "7";
    public static final String CONSUMERECODE_MODEL_GUEN = "8";
    public static final String CONSUMERECODE_MODEL_INSUR = "9";



    public static final String MODEL_RECHARGE = "CZ";///充值
    public static final String MODEL_TRADEORDER = "YDJ";//运单结算
    public static final String MODEL_BIDSETTLE = "ZBJ";//招标结算
    public static final String MODEL_BIDDING = "JB";//竞标
    public static final String MODEL_CASH = "TX"; //提现
    public static final String MODEL_TRANCF = "ZZ"; //转帐
    public static final String MODEL_COIN = "ZD"; //卓币
    public static final String MODEL_PETROL = "YQ";  //油气
    public static final String MODEL_GUEN = "BZJ";//保证金
    public static final String MODEL_BIDORDER = "HT"; //合同
    public static final String MODEL_BIDINFO = "ZB"; //招标
    public static final String MODEL_ORDERINFO = "YD";//运单
    public static final String MODEL_BIDBL = "BL";//提货单
    public static final String MODEL_EXCHANGE = "DH";//油气兑换
    public static final String MODEL_ACTIVITY = "HD";//活动




    /***
     * 信息管理字段
     */
    public static final String SAVE_NEWS_SUCCES = "保存新闻成功";
    public static final String DELETE_NEWS_SUCCES = "删除新闻成功";
    public static final String SAVE_POLICY_SUCCES = "保存政策公告成功";
    public static final String DELETE_POLICY_SUCCES = "删除政策公告成功";
    public static final String SAVE_AGREEMENT_SUCCES = "保存系统文案成功";
    public static final String DELETE_AGREEMENT_SUCCES = "删除系统文案成功";
    public static final String NEWS_TYPE = "物流新闻";
    public static final String POLICY_TYPE = "政策公告";
    public static final String CREDIBILITY_TYPE = "物流诚信";
    public static final String CONVENIENCE_TYPE = "便民服务";
    public static final String SAVE_ADVERTISEMENT_SUCCES = "保存广告成功";
    public static final String DELETE_ADVERTISEMENT_SUCCES = "删除广告成功";
    public static final String SAVE_CONVENIENCE_SUCCES = "保存便民服务成功";
    public static final String DELETE_CONVENIENCE_SUCCES = "删除便民服务成功";
    public static final String SAVE_CREDIBILITY_SUCCES = "保存物流诚信成功";
    public static final String DELETE_CREDIBILITY_SUCCES = "删除物流诚信成功";
    public static final String SAVE_FEEDBACK_SUCCES = "保存意见反馈成功";
    public static final String DELETE_FEEDBACK_SUCCES = "删除意见反馈成功";
    public static final String SAVE_FRIENDLYLINK_SUCCES = "保存友情链接成功";
    public static final String DELETE_FRIENDLYLINK_SUCCES = "删除友情链接成功";

    /**
     * 运单交易流程上传凭据类型: 0:提货凭据;1回单凭据
     */
    public static final String TRADERECEIPT_TYPE_TAKEGOODS = "0";
    public static final String TRADERECEIPT_TYPE_RECEIPT = "1";

    /**
     * 争议处理 0:发起争议 1:处理中2:处理完毕 3:已退款
     */
    public static final String DISPUTE_STATUS_CREATE = "0";
    public static final String DISPUTE_STATUS_BEING = "1";
    public static final String DISPUTE_STATUS_END = "2";
    public static final String DISPUTE_STATUS_QUIDCO = "3";

    /**
     * 运单是否发起争议状态 0:否 1:是
     */
    public static final String ORDER_ISDISPUTE_FALSE = "0";
    public static final String ORDER_ISDISPUTE_TRUE = "1";

    /**
     * 司机是否同意争议 0:否 1:是
     */
    public static final String DISPUTE_CONFIRMFALSE = "0";
    public static final String DISPUTE_CONFIRMTRUE = "1";

    /**
     * 争议是否驳回 0:否 1:是
     */
    public static final String DISPUTE_ISREJECT_FALSE = "0";
    public static final String DISPUTE_ISREJECT_TRUE = "1";
    
    /**
     * 争议类型 0:普通争议 1:全额争议
     */
    public static final String DISPUTE_TYPE_ORDINARY = "0";
    public static final String DISPUTE_TYPE_FULL = "1";

    /**
     * 0：草稿；1发布；2.正在交易中3.交易完成4.废标 5.招标截止
     */
    public static final String BIDINFO_STATUS_CAOGAO="0";
    public static final String BIDINFO_STATUS_PUB="1";
    public static final String BIDINFO_STATUS_END="5";
    public static final String BIDINFO_STATUS_TRADING="2";
    public static final String BIDINFO_STATUS_TRADEND="3";
    public static final String BIDINFO_STATUS_CANCEL="4";

    /**
     * 招标状态
     */
    public static final String BIDINFO_STATUS_CAOGAO_STR="草稿";
    public static final String BIDINFO_STATUS_PUB_STR="发布";
    public static final String BIDINFO_STATUS_TRADING_STR="正在交易中";
    public static final String BIDINFO_STATUS_TRADEND_STR="交易完成";
    public static final String BIDINFO_STATUS_CANCEL_STR="废标";
    public static final String BIDINFO_STATUS_END_STR="招标截止";

    /**
     * 招标结算状态
     * 0:未申请，1申请结算，2.申请失败驳回3，申请通过4.支付完成，5确认
     */
    public static final String BID_SETTLE_NOMER="0";
    public static final String BID_SETTLE_APLAY="1";
    public static final String BID_SETTLE_FILED="2";
    public static final String BID_SETTLE_AGREE="3";
    public static final String BID_SETTLE_PAYED="4";
    public static final String BID_SETTLE_SURE="5";

    /**
     * 结算周期类型 settlementType
     * 0：发布招标时间起
     * 1:运输完成起
     */
    public static final String  SETTLEMENT_TYPE_START="0";
    public static final String  SETTLEMENT_TYPE_END="1";
    public static final String  SETTLEMENT_TYPE_START_STR="发布招标时间起";
    public static final String  SETTLEMENT_TYPE_END_STR="运输完成起";

    /**
     * 招标结算统计参数
     * 1:已支付，2未支付
     */
    public static final String BID_SUMTOTAL_END="1";
    public static final String BID_SUMTOTAL_NO="2";

    /**
     * 运输合同的状态
     * 0新建合同，1正在交易，2.申请运输完成3.运输完成申请驳回4.运输完成
     */
    public static final String BIDORDER_STATUS_NOMER="0";
    public static final String BIDORDER_STATUS_TRADING="1";
    public static final String BIDORDER_STATUS_APLAY="2";
    public static final String BIDORDER_STATUS_FILED="3";
    public static final String BIDORDER_STATUS_SUCCESS="4";

    /**
     * 竞标状态
     * 1竞标 2中标 3未中标
     */
    public static final String BIDDING_STATUS_BDING="1";
    public static final String BIDDING_STATUS_GETBID="2";
    public static final String BIDDING_STATUS_FAILED="3";



    /***
     * 竞标保证金
     * 0已支付 1未支付 2已退还保证金
     */
    public static final String BIDDING_GURAN_PAY="0";
    public static final String BIDDING_GURAN_UNPAY="1";
    public static final String BIDDING_GURAN_RETURN="2";

    /**
     * 返回数据参数
     * 0:草稿
     * 1:发布
     * 2:正在交易中
     * 3:交易完成
     * 4:废标
     */
    public static final String BID_STATUS_CG="0";
    public static final String BID_STATUS_FAB="1";
    public static final String BID_STATUS_ZZJY="2";
    public static final String BID_STATUS_JYWC="3";
    public static final String BID_STATUS_FEIB="4";


    /**
     * 提货单状态
     * 1 未发布
     * 2 已发布
     */
    public static final String Bl_STATUS_NOPUBLISH="1";
    public static final String Bl_STATUS_PUBLISH="2";


    /**
     * 提货单类型
     * 1 招标提货单
     * 2 普通提货单
     */
    public static final String Bl_TYPE_BIDBL="0";
    public static final String Bl_TYPE_BL="1";


    /**
     * 提货单交易状态
     * 0未生成 1未运输 2	已运输 3	已完成
     */
    public static final String BL_TRADE_STATUS_WSC="0";
    public static final String BL_TRADE_STATUS_WYS="1";
    public static final String BL_TRADE_STATUS_YYS="2";
    public static final String BL_TRADE_STATUS_YWC="3";

    /**
     * 提货单仓库状态
     * 1已入库 2	待出库 3	已出库
     */
    public static final String BL_WAREHOUSE_STATUS_YRK="1";
    public static final String BL_WAREHOUSE_STATUS_DCK="2";
    public static final String BL_WAREHOUSE_STATUS_YCK="3";



    /**
     * 返回数据参数
     * -3:提交成功，支付未成功
     * -2:账户系统异常
     * 1:正常
     * -1:系统异常
     * 0:权限不足
     * 2:信息缺失
     * 3:已过期,已操作
     * 4:支付密码错误
     * 5:可用余额不足
     * 6:充值金额错误
     * 7:操作频繁
     * 
     * 8:交易限额 单笔交易最高限额
     * 9:交易佣金 单笔交易佣金
     * 10:最低留存额度 电子钱包最低留存额度
     * 11:单日交易最高限额 单日非同名交易最高限额
     * 12:提现限额 单个账户单日累计提现限额
     * 
     * 18:账户系统银行卡信息错误
     * 18:账户系统已签退日结中
     * 一卡通绑定异常
     */
    public static final int RETURN_STATUS_PAYBUG = -5;
    public static final int RETURN_STATUS_ACCOUNTBUG = -2;
    public static final int RETURN_STATUS_NORMAL = 1;
    public static final int RETURN_STATUS_SYSBUG = -1;
    public static final int RETURN_STATUS_AUTHBUG = 0;
    public static final int RETURN_STATUS_INFOBUG = 2;
    public static final int RETURN_STATUS_OVERCONTROLBUG = 3;
    public static final int RETURN_STATUS_PAYPWDBUG = 4;
    public static final int RETURN_STATUS_MONEYBUG = 5;
    public static final int RETURN_STATUS_RECHARGEBUG = 6;
    public static final int RETURN_STATUS_REMORE = 7;
    
    public static final int RETURN_STATUS_TRADEQUOTA = 8;
    public static final int RETURN_STATUS_TRADECOMMISSION = 9;
    public static final int RETURN_STATUS_LOWESTAMOUNT = 10;
    public static final int RETURN_STATUS_TRADEQUOTADAY = 11;
    public static final int RETURN_STATUS_CASHQUOTA = 12;
    public static final int RETURN_STATUS_BINDCARDBUG = 13;
    public static final int RETURN_STATUS_OREDERAPPLYPAY = 15;
    public static final int RETURN_STATUS_BANKBUG = 18;
    public static final int RETURN_STATUS_SIGNOUT = 19;

    
    
    /**
     * 后台的交易流水参数类型
     * 1：充值流水
     * 2：提现流水
     * 3：运单交易流水
     * 4：转账流水
     * 5：竞标流水
     * 6：招标流水
     * 7：其他类型流水
     * 8：油气流水
     * 9：卓币
     */
    public static final String TRADE_PARAMETER_TYPE_RECHARGE ="1";
    public static final String TRADE_PARAMETER_TYPE_CASH ="2";
    public static final String TRADE_PARAMETER_TYPE_TRADEORDER ="3";
    public static final String TRADE_PARAMETER_TYPE_TRANSFER ="4";
    public static final String TRADE_PARAMETER_TYPE_BIDDING ="5";
    public static final String TRADE_PARAMETER_TYPE_BID ="6";
    public static final String TRADE_PARAMETER_TYPE_OTHER ="7";
    public static final String TRADE_PARAMETER_TYPE_PETROL ="8";
    public static final String TRADE_PARAMETER_TYPE_COIN ="9";

    /**
     * 个人中心对账单月份参数
     */
    public static final String ACCOUNT_MONTH_THIS ="thismonth";
    public static final String ACCOUNT_MONTH_LAST ="lastmonth";
    public static final String ACCOUNT_MONTH_LASTTWO ="twolastmonth";

    /**
     * 司机申请绑定 同意
     * 0:申请中
     * 1:同意
     * 2:不同意
     */
    public static final String DRIVER_ISAGREE_APPLY="0";
    public static final String DRIVER_ISAGREE_YES="1";
    public static final String DRIVER_ISAGREE_NO="2";


    /**
     * 地址类型  0 发货 1 收货  2 一卡通 收货
     */
    public static final String ADDRESS_TYPE_FH="0";
    public static final String ADDRESS_TYPE_SH="1";
    public static final String ADDRESS_TYPE_YKTSH="2";

    /**
     * 一卡通状态  0 申请中 1 申请通过  2 申请不通过 3 锁定 4解锁 正常使用
     */
    public static final String METRO_STATUS_SQZ="0";
    public static final String METRO_STATUS_SQTG="1";
    public static final String METRO_STATUS_SQBTG="2";
    public static final String METRO_STATUS_ZX="3";
    public static final String METRO_STATUS_NORMAL="4";

    /**
     * 一卡通操作 状态
     * 0:成功
     * -1:失败
     */
    public static final String METRO_REGISTER_RESULTSTATUS_SUCESS="0";
    public static final String METRO_REGISTER_RESULTSTATUS_FAIL="-1";
    

    /**
     * 一卡通账户状态类型
     * 1:锁定
     * 2:解锁
     */
    public static final String METRO_LOCK_RESULTSTATUS="1";
    public static final String METRO_UNLOCK_RESULTSTATUS="2";
    

    /**
     * LBS定位状态 1:新建未开启 2:定位中3:定位结束
     */
    public static final String LBS_STATUS_CREATE = "1";
    public static final String LBS_STATUS_BEING = "2";
    public static final String LBS_STATUS_END = "3";
    /**
     * 一卡通挂失状态
     * 0:申请挂失
     * 1:处理中
     * 2:处理完毕
     */
    public static final String METRO_LOSS_STATUS_APPLY="0";
    public static final String METRO_LOSS_STATUS_DISPOSE="1";
    public static final String METRO_LOSS_STATUS_END="2";
    

    
    /**
     * 账户类型
     * 1：借款户
     * 2：还款户
     * 3：定向支付户
     * 4：电子钱包
     * 5：监管户
     * 6：内部户
     */
    public static final String BORROWER_ACCOUNT="1";
    public static final String REPAY_ACCOUNT="2";
    public static final String DIRECT_ACCOUNT="3";
    public static final String ELECTRONIC_ACCOUNT="4";
    public static final String REGULATORY_ACCOUNT="5";
    public static final String INNER_ACCOUNT="6";
    
    /**
    * 重置策略
    * none;不重置
    * daily:重置
    */
   public static final String POLICY_NONE="none";
   public static final String POLICY_DAILY="daily";
    
    
    /**
     * 账户系统接口返回码
     * 200 请求成功
     * 302 应用已签退
     * 304 应用正在日结
     * 400 系统内部错误
     * 401 应用校验失败
     * 404 非法参数
     * 406 业务类型错误
     * 500 调用远程接口出错
     * 506 银行业务类错误
     */
    public static final String RETURN_NORMAL="200";
    public static final String RETURN_SIGNOUT="302";
    public static final String RETURN_CHECKOUT="304";
    public static final String RETURN_SYSBUG="400";
    public static final String RETURN_CHECK="401";
    public static final String RETURN_INFOBUG="404";
    public static final String RETURN_TYPEBUG="406";
    public static final String RETURN_INVOKE="500";
    public static final String RETURN_BANKBUG="506";
    
    /**
     * 账户系统接口tradeType类型
     * 1 企业之间虚拟子账号调账
     * 2 企业内部虚拟子账户调账
     * 3 虚拟账户向实体账户划账（本行）
     * 4 虚拟账户向实体账户划账（跨行）
     * 9 冻结金额
     * 10 解冻金额
     */
    public static final String TRANSFER_OUTER="1";
    public static final String TRANSFER_INNER="2";
    public static final String TRANSFER_INNER_BANK="3";
    public static final String TRANSFER_OUTER_BANK="4";
    public static final String TRANSFER_LOCK="5";
    public static final String TRANSFER_UNLOCK="6";
    public static final String TRANSFER_FREEZE="9";
    public static final String TRANSFER_UNFREEZE="10";
    
    /**
     * 账户金额类型
     * 可用余额、在途金额、冻结金额、锁定金额
     */
    public static final String AVAILABLE_BALANCE="availableBalance";
    public static final String UNDETERMINED_BALANCE="undeterminedBalance";
    public static final String FREEZE_BALANCE="freezeBalance";
    public static final String LOCK_BALANCE="lockBalance";
    
    /**
     * 账户系统接口bank类型
     */
    public static final String BANK_TYPE="广发银行";
    
    /**
     * 活动类型
     * 0:大转盘
     * 1:油气充值
     * 2:卓币充值
     */
    public static final String ACTIVITY_TYPE_TURNTABLE="0";
    public static final String ACTIVITY_TYPE_PETRO="1";
    public static final String ACTIVITY_TYPE_COIN="2";
    
    /**
     * 活动状态
     * 0:新建
     * 1:开启
     * 2:无效、不可用
     */
    public static final String ACTIVITY_STATUS_CREATE="0";
    public static final String ACTIVITY_STATUS_OPEN="1";
    public static final String ACTIVITY_STATUS_INVALID="2";
    
    /**
     * 活动礼品类型
     * 0:现金红包
     * 1:礼物
     * 3:油气
     * 4:卓币
     * 5:保险
     */
    public static final String ACTIVITYGIFT_TYPE_CASH="0";
    public static final String ACTIVITYGIFT_TYPE_GIFT="1";
    public static final String ACTIVITYGIFT_TYPE_PETRO="3";
    public static final String ACTIVITYGIFT_TYPE_COIN="4";
    public static final String ACTIVITYGIFT_TYPE_INSUR="5";
    
    /**
     * 礼物发放状态
     * 0未发放，
     * 1已发放
     * 2作废
     * 3已使用
     */
    public static final String ACTIVITYGIFT_STATUS_CREATE="0";
    public static final String ACTIVITYGIFT_STATUS_GRANT="1";
    public static final String ACTIVITYGIFT_STATUS_INVALID="2";
    public static final String ACTIVITYGIFT_STATUS_USE="3";
    
    
    
    /**
     * 诚信等级
     * 等级0
     * 等级1
     * 等级2
     * 等级3
     * 等级4
     * 等级5
     */
    public static final String INTEGRITY_LEVEL_ZERO="0";
    public static final String INTEGRITY_LEVEL_FIRST="1";
    public static final String INTEGRITY_LEVEL_SECOND="2";
    public static final String INTEGRITY_LEVEL_THIRD="3";
    public static final String INTEGRITY_LEVEL_FOURTH="4";
    public static final String INTEGRITY_LEVEL_FIRFTH="5";
    
    /**
     * 诚信积分code
     * authenSucces 认证
     * userLogin 登录
     * guaranteemone 保证金
     * shopmone 商城消费
     * settlemone 结算消费
     * withoutlogincount 不登录天数
     * perfecting  信息完善
     * insurance   保险购买
     * registration  会员注册
     * exchange     积分兑换卓币
     */
    public static final String INTEGRITY_POINT_AUTHENSUCES = "authenSucces";
    public static final String INTEGRITY_POINT_USERLOGIN = "accruelogincount";
    public static final String INTEGRITY_POINT_GUARANTEEMONE = "guaranteemone";
    public static final String INTEGRITY_POINT_SHOPMONE = "shopmone";
    public static final String INTEGRITY_POINT_SETTLEMONE = "settlemone";
    public static final String INTEGRITY_POINT_WITHOUTLOGINCOUNT="withoutlogincount";
    public static final String INTEGRITY_POINT_PERFECTING="perfecting";
    public static final String INTEGRITY_POINT_INSURANCE="insurance";
    public static final String INTEGRITY_POINT_REGISTRATION="registration";
    public static final String INTEGRITY_POINT_EXCHANGE="exchange";
    public static final String INTEGRITY_POINT_WITHLOGIN="withlogin";
    /**
     * 1:已发布
     * 2:已过期
     * 3:已取消
     */
    public static final String CARSOURCE_STATUS_PUB="1";
    public static final String CARSOURCE_STATUS_OVERDUE="2";
    public static final String CARSOURCE_STATUS_CANCEL="3";
    
    /***
     * 保险购买状态
     * 0未支付 1已支付
     */
    public static final String INSUR_UNPAY="0";
    public static final String INSUR_PAY="1";
    
    /***
     * 保单支付方
     * 0发货方 1承运方
     */
    public static final String INSUR_PAYPEOPLE_GOODSOWNER="0";
    public static final String INSUR_PAYPEOPLE_CAROWNER="1";
    
    /***
     * 运单审核支付状态
     * 0已支付 1未支付2支付中
     */
    public static final String ORDER_APPLY_PAY="0";
    public static final String ORDER_APPLY_UNPAY="1";
    public static final String ORDER_APPLY_PAYIN="2";
    
    /**
     * 油气兑换余额审核状态  1:申请中2:申请驳回3:审核通过 4:复核通过
     */
    public static final String EXCHANGE_STATUS_BEING = "1";
    public static final String EXCHANGE_STATUS_SUCESS = "3";
    public static final String EXCHANGE_STATUS_FINALJUDG = "4";
    public static final String EXCHANGE_STATUS_FAIL = "2";
    
    /**
     * 油气兑换余额开票状态  0:未开1:已开2:已收
     */
    public static final String EXCHANGE_INVOICESTATUS_UNOPEN = "0";
    public static final String EXCHANGE_STATUS_OPEN = "1";
    public static final String EXCHANGE_STATUS_RECEIVED = "2";
    
    /**
     * 轮询任务状态
     * 1:处理中
     * 2:处理完毕
     */
    public static final String JOB_ACCOUNT_STATUS_DISPOSE="1";
    public static final String JOB_ACCOUNT_STATUS_END="2";
    
    /**
     * 关注类型
     * 1:车源
     * 2:货源
     * 3:招标
     */
    public static final String COLLECTION_TYPE_CAR="1";
    public static final String COLLECTION_TYPE_GOODS="2";
    public static final String COLLECTION_TYPE_BID="3";
    
    
    /**
     * 规则管理 
     * 1:A类规则
     * 2:B类规则
     * 3:C类规则
     */
    public static final String SYS_TRADE_RULR_A="1";
    public static final String SYS_TRADE_RULR_B="2";
    public static final String SYS_TRADE_RULR_C="3";
    
    /**
     * 规则管理 提现限额单位
     * 0:% 百分比
     * 1:元
     */
    public static final String SYS_TRADE_RULR_UNITPC="0";
    public static final String SYS_TRADE_RULR_UNIT="1";
    
    /**
     * 推送类型
     * 0:短信 1:APP 2:微信
     */
    public static final String RAIL_TYPE_DX="0";
    public static final String RAIL_TYPE_APP="1";
    public static final String RAIL_TYPE_WX="2";
    

    
    /**
     * 推送状态
     * 0:未推送　1:已推送
     */
    public static final String RAIL_NOTPUSH="0";
    public static final String RAIL_PUSH="1";
    
    /**
     * 围栏状态
     * 0:入围 1:出围
     */
    public static final String RAILTYPE_IN="0";
    public static final String RAILTYPE_OUT="1";
    
    /**
     * 围栏状态码
     * 1001:成功
     * 1002:用户校验失败
     * 1003:信息匹配失败
     * 1004:传入参数错误
     * 1010:其他未知错误
     */
    public static final int RAIL_SUCCESS=1001;
    public static final int RAIL_USERFAILED=1002;
    public static final int RAIL_MSGERROR=1003;
    public static final int RAIL_PARAMERROR=1004;
    public static final int RAIL_UNKNOWNERROR=1010;
    
    
    /**
     * 自定义区域订阅类型
     * 1:指定车辆 2:所有车辆
     */
    public static final String THECAR = "1";
    public static final String ALLCAR = "2";
    
    /**
     * 自定义区域事件类型
     * 1.进区域通知 2:出区域通知
     */
    public static final String RAIL_IN = "1";
    public static final String RAIL_OUT = "2";
    public static final String RAIL_ALL = "1,2";
    

    /**
     * 运单围栏是否开通开关
     * 0.关闭 1.开启
     */
    public static final String RAILFLAG_OFF = "0";
    public static final String RAILFLAG_ON = "1";
    
    /**
     * 运单围栏开启状态
     * 0.正常 1.开启 2.关闭
     */
    public static final String RAILSTATE_NORMAL = "0";
    public static final String RAILSTATE_ON = "1";
    public static final String RAILSTATE_OFF = "2";
    /**
     * 是否查询到信息 
     */
    public static final String INFORMATION_YES="1";
    public static final String INFORMATION_NO="2";
    /**
     * 接口来源
     */
    public static final String INFACESSOURCE_YONGKUI="0";
    public static final String INFACESSOURCE_ZJXL="1";
    public static final String INFACESSOURCE_LBS="2";
    public static final int    INFACESSOURCE_ZJXL_INT=1;
    public static final int    INFACESSOURCE_LBS_INT=2;
    /**
     * 接口服务名称
     */
    public static final String INTERFACE_YONGKUID="地图定位";
    public static final String INTERFACE_ZJXLD="地图定位";
    public static final String INTERFACE_LBSD="地图定位";
    public static final String INTERFACE_YONGKUIG="地图轨迹";
    public static final String INTERFACE_ZJXLG="地图轨迹";
    public static final String INTERFACE_LBSG="地图轨迹";
    
    /**
     * LBS地图定位
     */
    public static final String LBS_LOCATION="lbs001";
    /**
     * LBS地图轨迹
     */
    public static final String LBS_TRACK="lbs002";
    /**
     * 永奎地图定位
     */
    public static final String YONGKUI_LOCATION="yongkui001";
    /**
     * 永奎地图轨迹
     */
    public static final String YONGKUI_TRACK="yongkui002";

    /**
     * 车辆入网验证键值
     */
    public static final String ZJXL_TRUCKEXIST="zjxl001";
    /**
     * 车辆行驶信息查询键值
     */
    public static final String ZJXL_TRAVEQUERY="zjxl002";
    /**
     * 道路运输证查询键值
     */
    public static final String ZJXL_QUERYRTCNO="zjxl003";
    /**
     * 车主真实性验证键值
     */
    public static final String ZJXL_OWNERBYVC="zjxl004";
    /**
     * 套牌车验证键值
     */
    public static final String ZJXL_AREABYVClNPO="zjxl005";
    /**
     * 车牌号查车辆最新位置键值
     */
    public static final String ZJXL_LASTlOCATION="zjxl006";
    /**
     * 车架号车辆最新位置查询
     */
    public static final String ZJXL_LOCATIONVIN="zjxl007";
    /**
     * 多辆车的位置查询
     */
    public static final String ZJXL_LOCATIONMULTI="zjxl008";
    /**
     * 车辆轨迹查询（车牌号）
     */
    public static final String ZJXL_HISTRACK="zjxl009";
    /**
     * 车辆轨迹查询（vin号）
     */
    public static final String ZJXL_TRACKVIN="zjxl010";
    /**
     * 逆地理信息查询
     */
    public static final String ZJXL_DECODEADDRESS="zjxl011";
    /**
     * 多维度找车
     */
    public static final String ZJXL_VClBYMULF="zjxl012";
    /**
     * 车辆ID获取车主信息
     */
    public static final String ZJXL_INFOBYVID="zjxl013";
    /**
     * 车辆行驶证信息查询
     */
    public static final String ZJXL_LICENSE="zjxl014";
    /**
     * 发布货源
     */
    public static final String ZJXL_PUBGOODSSORC="zjxl015";
    /**
     * 发布货源短信
     */
    public static final String ZJXL_PUBGOODSMSG="zjxl016";
    /**
     * 离线车辆注册
     */
    public static final String ZJXL_VNOOUTREG="zjxl017";
    /**
     * 删除离线车辆订阅
     */
    public static final String ZJXL_VNOOUTDEL="zjxl018";
    /**
     * 自定义区域注册
     */
    public static final String ZJXL_AREAREG="zjxl019";
    /**
     * 车辆订阅
     */
    public static final String ZJXL_VNOREG="zjxl020";
    /**
     * 删除车辆订阅
     */
    public static final String ZJXL_VNODEL="zjxl021";
    /**
     * 删除自定义区域
     */
    public static final String ZJXL_AREADEL="zjxl022";
    /**
     * 下发车机信息
     */
    public static final String ZJXL_MESSAGEBYVCL="zjxl023";


    /**
     * 消息推送
     */
    public static final String MESSAGE_TYPE_NEWORDER="新运单通知";
    public static final String MESSAGE_TYPE_NEWGOODS="新货源通知";


    /**
     * 消息类型 5客服助手
     */
    public static final String MESSAGE_CONTENTTYPE_KEFU="5";

    /**
     * 消息的系统 2安卓
     */
    public static final String MESSAGE_SCANTYPE_ANDROID="2";

    /**
     * 消息分类 0消息 1货源 2运单
     */
    public static final String MESSAGE_SOURCETYPE_WAYBILL="2";
    public static final String MESSAGE_SOURCETYPE_SOURCEGOODS="1";


    /**
     * 消息是否推送 0未推送 1已推送
     */
    public static final String MESSAGE_STATUS_YES="1";
    public static final String MESSAGE_STATUS_NO="0";

    /**
     * 消息推送类型 0全部 1按角色 2按用户
     */
    public static final String MESSAGE_SENDTYPE_ALL="0";
    public static final String MESSAGE_SENDTYPE_ROLE="1";
    public static final String MESSAGE_SENDTYPE_USER="2";

    /**
     * 消息是否已读 0否 1是
     */
    public static final String MESSAGE_IS_READ_YES="1";
    public static final String MESSAGE_IS_READ_NO="0";
    /**
     * 固定的id值
     */
    public static final String FIXED_ID="123456";
    public static final String FIXED_IDONE="1";
    /**
     * 中交兴路成功状态码
     */
    public static final String ZJXL_STATUS="1001";
    /**
     * 中交兴路超出24时限轨迹
     */
    public static final int ZJXL_RAILBUG = 5;
}
