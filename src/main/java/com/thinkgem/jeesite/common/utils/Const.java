package com.thinkgem.jeesite.common.utils;

import org.springframework.context.ApplicationContext;

/**
 * 项目名称：
 *
 * @author:fh
 *
 */
public class Const {

	public static final String SYSACCOUNT = "static/config/SYSACCOUNT.txt"; // 短信账户配置路径2\

	public static final String SMS = "static/config/SMS.txt"; // 短信账户配置路径2\

	public static final String SMSCS = "static/config/SMSCS.txt"; // 短信账户配置路径2
	/**
	 * @Fields SMS_FILTER_KEY : 短信过滤关键字txt文件地址
	 */
	public static final String SMS_FILTER_KEY = "admin/config/SmsFilterKey.txt"; // 短信账户配置路径2

	public static final String SMSFUN_APPLY_PHONE="17717769577";
	public static final String SMSFUN_APPLY_PHONE2="18231070054";//提现提醒财务
	/**
	 * 短信功能
	 */
	public static final Integer SMSFUN_REGCODEVALITY=3;   ///短信验证码有效期
	public static final String SMSFUN_REGCODE="用户注册";
	public static final String SMSFUN_AUTHEN="用户认证";
	public static final String SMSFUN_CONSUME="平台交易";
	public static final String SMSFUN_BIDOD="招投标通知";
	public static final String SMSFUN_RAILPUSH="围栏消息推送";

	public enum System_Module_Enum{
		/**
		 * @Fields CeShi : 测试
		 */
		CeShi,
		/**
		 * @Fields NewsPortal : 职能门户
		 */
		NewsPortal,
		/***
		 * @Fields BackStage : 系统后台发送
		 *
		 */
		BackStage,
		/**
		 * @Fields LogisticsWebSystem : 网页版物流平台
		 */
		LogisticsWebSystem,
		/**
		 * @Fields Weixin : 微信公众平台
		 */
		Weixin,
		/**
		 * @Fields Android : 安卓手机客户端
		 */
		Android,
		/**
		 * @Fields IOS : IOS手机客户端
		 */
		IOS,
		/**
		 * @Fields Android_IOS : Android_IOS手机客户端
		 */
		Android_IOS,
		/**
		 * @Fields All : 所有平台
		 */
		All
	}



	public static final String SESSION_SECURITY_CODE = "sessionSecCode";
	public static final String SESSION_WLPT_SECURITY_CODE = "sessionWLPTSecCode";
	public static final String SESSION_USER = "sessionUser";
	public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String SESSION_POINT = "sessionPoint"; //诚信积分
	public static final String SESSION_AREA = "sessionArea"; // 全国地区
	public static final String SESSION_APP_VERSION = "appVersion"; // 版本
	public static final String SESSION_POINTLEVEL = "sessionPointLevel"; //诚信积分等级

	public static final String SESSION_menuList = "menuList"; // 当前菜单
	public static final String SESSION_allmenuList = "allmenuList"; // 全部菜单

	public static final String SESSION_QX = "QX";
	public static final String SESSION_userpds = "userpds";

	public static final String SESSION_USERROL = "USERROL"; // 用户对象
	public static final String SESSION_USERNAME = "USERNAME"; // 用户名
	public static final String SESSION_API_USER = "SESSION_API_USER"; //API用户

	public static final String TRUE = "T";
	public static final String FALSE = "F";
	public static final String LOGIN = "/login_toLogin.do"; // 登录地址

	public static final String GOODSTRADE = "admin/config/GOODSTRADE.txt";///专线交易
	public static final String CARTRADE = "admin/config/CARTRADE.txt";///专线交易

	public static final String LINETRADE = "admin/config/LINETRADE.txt";///专线交易
	public static final String ECSYSNAME = "admin/config/ECSYSNAME.txt";///卓大title
	public static final String LINKPHONE = "admin/config/LINKPHONE.txt";///卓大title
	public static final String SYSNAME = "admin/config/SYSNAME.txt"; // 系统名称路径ECSYSNAME.txt
	public static final String PAGE = "admin/config/PAGE.txt"; // 分页条数配置路径
	public static final String EMAIL = "admin/config/EMAIL.txt"; // 邮箱服务器配置路径
	public static final String SMS1 = "admin/config/SMS1.txt"; // 短信账户配置路径1

	public static final String WLPT_DOMAIN = "admin/config/WlptDomain.txt"; // 短信账户配置路径2
	public static final String COMMON_DOMAIN = "admin/config/CommonDomain.txt"; // 门户网站域名
	public static final String SEARCHINDEX = "admin/config/SEARCHINDEX.txt"; // 全文搜索索引文件路径
	public static final String GOOSWEBSPIDER="admin/config/GoodsWebSpiderConfig.txt";//货源爬虫用户配置
	public static final String CARSOURCEWEBSPIDER="admin/config/CarSourceWebSpiderConfig.txt";//车源爬虫用户配置
	public static final String CARTYPECHEWANG="admin/config/CARTYPECHEWANG.txt";//车旺车型匹配
	public static final String TASKISRUN="static/config/TASKISRUN.txt";//任务是否启动
	public static final String LBSINFO="static/config/LBSConfig.txt";//LBS配置
	public static final String ACCOUNT_API="static/config/ACCOUNT_API.txt";//账户系统配置



	public static final String FILEPATHIMG = "uploadFiles/uploadImgs/"; // 图片上传路径
	public static final String FILEPATHWLPTSITEMAP = "seo/wlptseo/baidu";
	public static final String FILEPATHZHWLSITEMAP = "seo/zhwlseo/baidu";
	public static final String FILEPATHFILE ="uploadFiles/file/"; // 文件上传路径"uploadFiles/file/"
	public static final String FILEPATHUSERFILE ="uploadFiles/userfile/";  //文件上传用户的上传路径
	public static final String FILEPATHAPPFILE = "uploadFiles/appfile/"; // 文件上传路径
	public static final String AliPayNotityUrl = "admin/config/AlipayNotifyUrl.txt"; // 短信账户配置路径2


	public static final String NO_INTERCEPTOR_PATH = "(.*/*.xml)|(.*/*.html)|(.*/*.txt)|(.*/((login)|(logout)|(dataCenter)|(code)|(app)|(static)|(admin)|(main)|(websocket)|(weixin)|(common)|(wlpt)|(upload)|(api)|(uploadFiles)|(temple)|(seo)).*)"; // 不对匹配该值的访问路径拦截（正则）

	public static ApplicationContext WEB_APP_CONTEXT = null; // 该值会在web容器启动时由WebAppContextListener初始化
	public static final String  LOGIN_SUCCEED_RETURN_URL="RETURN_URL";//登陆成功后跳转到原来页面
	/**
	 * APP Constants
	 */
	// app注册接口_请求协议参数)
	public static final String[] APP_REGISTERED_PARAM_ARRAY = new String[] {
			"countries", "uname", "passwd", "title", "full_name",
			"company_name", "countries_code", "area_code", "telephone",
			"mobile" };
	public static final String[] APP_REGISTERED_VALUE_ARRAY = new String[] {
			"国籍", "邮箱帐号", "密码", "称谓", "名称", "公司名称", "国家编号", "区号", "电话", "手机号" };

	// app根据用户名获取会员信息接口_请求协议中的参数
	public static final String[] APP_GETAPPUSER_PARAM_ARRAY = new String[] { "USERNAME" };
	public static final String[] APP_GETAPPUSER_VALUE_ARRAY = new String[] { "用户名" };

	// 部分窗口显示的信息条数
	public static final int PARTVIEW_OFFSET = 0;
	public static final int PARTVIEW_TOP = 5;

	//当前窗体显示的导航栏tab数目
	public static final int TotalTabCount = 6;

	//当前系统使用的数据库名称
	/*public static final String  DB_NAME = "logistics";
	public static final String  DB_NAME = "logistics_wlpt";*/
	public static final String  DB_NAME = "zd_logistics_pro";

	//BLS定位配置
	public static final String  LBS_COST = "0.15";//lbs定位费用单价
	public static final String  LBS_FREEORDER_COUNT = "0";//lbs定位最大次数

	public enum ChangePointWay_Enum{

		/**
		 * @Fields SuccessfulTransaction : 交易成功
		 */
		SuccessfulTransaction,
		/**
		 * @Fields StorageInformation : 仓储信息
		 */
		StorageInformation,
		/**
		 * @Fields RegistrationNum : 工商登记号
		 */
		RegistrationNum,
		/**
		 * @Fields RegisteredCapital : 注册资金
		 */
		RegisteredCapital,
		/**
		 * @Fields Register : 首次注册
		 */
		Register,
		/**
		 * @Fields PersonalMail : 个人邮箱
		 */
		PersonalMail,
		/**
		 * @Fields PersonalIntroduction : 个人介绍
		 */
		PersonalIntroduction,
		/**
		 * @Fields PersonalIdentityCard : 个人身份证
		 */
		PersonalIdentityCard,
		/**
		 * @Fields PersonalIdCardCertification : 个人认证（身份证）
		 */
		PersonalIdCardCertification,
		/**
		 * @Fields PersonalDriveLicCertification : 个人认证（驾驶证）
		 */
		PersonalDriveLicCertification,
		/**
		 * @Fields PersonalAddress : 个人地址
		 */
		PersonalAddress,
		/**
		 * @Fields OrganizationCodeCertification : 组织机构代码证
		 */
		OrganizationCodeCertification,
		/**
		 * @Fields GoodsInformation : 货源信息
		 */
		GoodsInformation,

		/**
		 * @Fields GoodsInformationFake : 货源信息虚假
		 */
		GoodsInformationFake,
		/**
		 * @Fields EnterprisePhone : 联系电话
		 */
		EnterprisePhone,
		/**
		 * @Fields EnterpriseMail : 注册邮箱
		 */
		EnterpriseMail,
		/**
		 * @Fields EnterpriseLegalPerson : 企业法人
		 */
		EnterpriseLegalPerson,
		/**
		 * @Fields EnterpriseIntroduction : 企业简介
		 */
		EnterpriseIntroduction,
		/**
		 * @Fields EnterpriseAddress :  企业地址
		 */
		EnterpriseAddress,
		/**
		 * @Fields DailyLogin : 每日登录
		 */
		DailyLogin,
		/**
		 * @Fields CorporateIdentityCard : 法人身份证
		 */
		CorporateIdentityCard,
		/**
		 * @Fields ContinuousLogin5Days : 连续登录5天
		 */
		ContinuousLogin5Days,
		/**
		 * @Fields ContinuousLogin3Days : 连续登录30天
		 */
		ContinuousLogin3Days,
		/**
		 * @Fields ContinuousLogin10Days : 连续登录10天
		 */
		ContinuousLogin10Days,
		/**
		 * @Fields CarLicenseCertification : 车辆认证（行驶证）
		 */
		CarLicenseCertification,
		/**
		 * @Fields CarSourceInformation : 车源信息
		 */
		CarSourceInformation,


		/**
		 * @Fields CarSourceInformationFake : 车源信息虚假
		 */
		CarSourceInformationFake,


		/**
		 * @Fields LineInformation : 专线信息
		 */
		LineInformation,


		/**
		 * @Fields LineInformationFake : 专线信息虚假
		 */
		LineInformationFake,

		/**
		 * @Fields BusinessLicenseCertification : 仓储信息
		 */
		BusinessLicenseCertification,


		/**
		 * @Fields DefaultBehavior : 违约
		 */
		DefaultBehavior,
		/**
		 * @Fields Dispution : 发生纠纷
		 */
		Dispution,


		/**
		 * @Fields OrganizationCodeFake : 企业认证（组织机构代码证）
		 */
		OrganizationCodeFake,
		/**
		 * @Fields PersonalIdentityCardFake :  	个人身份证
		 */
		PersonalIdentityCardFake,
		/**
		 * @Fields BusinessLicenseFake : 企业认证（营业执照）
		 */
		BusinessLicenseFake,
		/**
		 * @Fields CarLicenseFake:车辆认证（行驶证）
		 */
		CarLicenseFake,
		/**
		 * @Fields PersonalDriveLicFake :个人驾驶证
		 */
		PersonalDriveLicFake,

		/**
		 * @Fields Recharge :充值
		 */
		Recharge,

		/**
		 * @Fields InvitationRegister :邀请注册
		 */
		InvitationRegister,

		/**
		 * @Fields NoMatchWay : 不在加分选项内
		 */
		NoMatchPointWay
	}

	/***
	 * 任务执行周期
	 * @author whoami
	 *
	 */
	public enum Job_Execycle{
		/**
		 * @Fields EXECYCLE_MINUTE : 分
		 */
		EXECYCLE_MINUTE,
		/**
		 * @Fields EXECYCLE_HOUR : 时
		 */
		EXECYCLE_HOUR,
		/**
		 * @Fields EXECYCLE_DAY : 日
		 */
		EXECYCLE_DAY,
		/**
		 * @Fields EXECYCLE_WEEK : 周
		 */
		EXECYCLE_WEEK,
		/**
		 * @Fields EXECYCLE_MONTH : 月
		 */
		EXECYCLE_MONTH
	}
	/***
	 * 定时任务编码
	 * @author whoami
	 *
	 */
	public enum Job_Code{
		/**
		 * @Fields EXECYCLE_MINUTE : 统计分数
		 */
		STATISTICS_RATINGSCALE,
		/**
		 * @Fields STATISTICS_OWNER : 统计个人信息
		 */
		STATISTICS_OWNER,
		/**
		 * @Fields STATISTICS_DATAGENERALIZATION : 统计后台首页数据概括
		 */
		STATISTICS_DATAGENERALIZATION,
		/**
		 * @Fields STATISTICS_DATAGENERALIZATION : 统计各省的车辆数目
		 */
		STATISTICS_CHINAAREA,
		/**
		 * @Fields WEBSPIDER_WLPTSEO : 定时向百度提交sitemap
		 */
		WEBSPIDER_WLPTSEO,
		/**
		 * @Fields TIMEPUSH_CARSOURCE : 定时推送车源
		 */
		TIMEPUSH_CARSOURCE,

		/**
		 *  @Fields USER_FORZEN : 用户授信冻结
		 */
		USER_FORZEN,

		/**
		 *  @Fields LBS云上传
		 */
		LBSUPLOAD,

		/**
		 * @Fields STATISTICS_AUTHEN : 用户认证统计
		 */
		STATISTICS_AUTHEN,

		/**
		 * @Fields STATISTICS_BUSINESS : 业务数据统计
		 */
		STATISTICS_BUSINESS,

		/**
		 * @Fields STATISTICS_CAR : 平台车辆统计
		 */
		STATISTICS_CAR,



		/**
		 * @Fields STATISTICS_REGISTER : 注册统计
		 */
		STATISTICS_REGISTER,

		/**
		 * @Fields STATISTICS_ROLE : 角色会员总量统计
		 */
		STATISTICS_ROLE,

		/**
		 * @Fields STATISTICS_SCORE : 诚信积分统计
		 */
		STATISTICS_SCORE,

		/**
		 * @Fields STATISTICS_TRADEFLOW : 运输流向统计
		 */
		STATISTICS_TRADEFLOW,

		/**
		 * @Fields STATISTICS_TRADETYPE : 货源运输量统计
		 */
		STATISTICS_TRADETYPE,

		/**
		 * @Fields STATISTICS_USERMONEY : 账户资金统计
		 */
		STATISTICS_USERMONEY,


		/**
		 * @Fields STATISTICS_METRO_CARD_CONSUME : 一卡通消费记录同步
		 */
		STATISTICS_METRO_CARD_CONSUME,

		/**
		 * @Fields STATISTICS_METRO_CARD_CONSUME : 一卡通POS机充值记录同步
		 */
		STATISTICS_METRO_CARD_ADDVALUE,

		/**
		 * @Fields STATISTICS_INTEGRITY : 诚信信息统计
		 */
		STATISTICS_INTEGRITY,
		
		/**
		 * @Fields STATISTICS_INTEGRITY : 不登录天数统计
		 */
		STATISTICS_DAYSWITHOUTLOGIN,

		/**
		 * @Fields STATISTICS_ACCOUNT : 平台对账统计
		 */
		STATISTICS_ACCOUNT,

		/**
		 * 备份用户数据统计记录
		 */
		STATISTICS_RECORD,

		/**
		 * 更新车源状态
		 */
		STATISTICS_CARSOURCESTATUS,

		/**
		 * @Fields STATISTICS_JOBACCOUNT : 平台账户体系轮询任务
		 */
		STATISTICS_JOBACCOUNT,

		/**
		 * @Fields BIND_ACCOUNT : 轮询账户系统申请开户接口绑定memberID到平台用户
		 */
		BIND_ACCOUNT,

		/**
		 * @Fields STATISTICS_ACTIVITY_ISSUER : 活动中奖奖品状态更新
		 */
		STATISTICS_ACTIVITY_ISSUER,

		/**
		 * @Fields GPS_UPDATE : 更新围栏信息
		 */
		GPS_UPDATE,
		
		/**
		 * @Fields STATISTICS_RAIL_LOGIN : 调用围栏注册接口
		 */
		STATISTICS_RAIL_LOGIN,
		
		/**
		 * @Fields STATISTICS_RAIL_DELETE : 调用围栏删除接口
		 */
		STATISTICS_RAIL_DELETE,
		/**
		 * @Fields STATISTICS_INTERFACETOKEN : 调用生成接口令牌接口（最好三天生成一次）
		 */
		STATISTICS_INTERFACETOKEN,
		/**
		 * @Fields GOODS_MESSAGE_PUSH : 货源消息推送接口
		 */
		GOODS_MESSAGE_PUSH,
	}
	/**
	 * @Fields TRANSPORT_TYPE : 运输方式
	 */
	public static final String[] TRANSPORT_TYPE = new String[] {"整车", "零担" };
	/**
	 * @Fields TRANSPORT_TYPE : 运输时效
	 */
	public static final String[] TRANSPORT_TIME = new String[] {"1","2","3","4","5","6","7" };
	/**
	 * @Fields 微信支付所需参数
	 */
	public static final String key=null;
	public static final String appID="wx0d8fc2417dec26a9";
	public static final String mchID="1325039401";
	public static final String sdbMchID=null;
	public static final String certLocalPath="190875";
	public static final String certPassword="10010000";

	/**
	 * @Fields SMSFIRST : 运单提示信息的first:短信标题
	 */
	public static final String[] SMSFIRST = new String[] {"尊敬的用户,您有一条新的运单信息","尊敬的用户，您有一条运单状态更新通知","尊敬的用户，您收到一条运费通知" };
	/**
	 * @Fields REMARK : 备注说明
	 */
	public static final String[] REMARK = new String[] {"详情请登录卓大物流查看。"};

	/**
	 * @Fields USERAPPLY : 用户申请
	 */
	public static final String[] USERAPPLY = new String[] {"尊敬的用户,您有一条新的认证申请信息","尊敬的用户,您有一条新的一卡通申请信息","尊敬的用户,您有一条新的提现申请信息"};
	/**
	 * @Fields KEYWORD : 键值
	 */
	public static final String[] KEYWORD = new String[] {"已受理","卖家已确认交易完成","买家已确认交易完成","对不起您的订单已取消，交易无法继续，货物名称:","已完成" };
	public enum GoodsSourceTemple_Enum{
		FROMPROVINCE(0),FROMCITY(1),FROMDISTRICT(2),FROMADDRESS(3),
		TOPROVINCE(4),TOCITY(5),TODISTRICT(6),TOADDRESS(7),
		WORTH(8),GOODSNAME(9),SENDTIME(10),CARTYPE(11),CARLENGTH(12),LOADWEIGHT(13),LINKMOBILE(14),
		LINKMAN(15);
		// 定义私有变量
		private int nCode ;
		GoodsSourceTemple_Enum(int _nCode) {
			this.nCode =_nCode;
		}
		@Override
		public String toString() {
			return String.valueOf ( this . nCode );
		}
	}
	public enum CarSourceTemple_Enum{
		FROMPROVINCE(0),FROMCITY(1),FROMDISTRICT(2),FROMADDRESS(3),
		TOPROVINCE(4),TOCITY(5),TODISTRICT(6),TOADDRESS(7),
		CARTYPE(8),CARLENGTH(9),CARNUMBER(10),LOADWEIGHT(11),
		CONTACTMAN(12),CONTACTMOBILE(13),DEPARTURETIME(14);
		// 定义私有变量
		private int nCode ;
		CarSourceTemple_Enum(int _nCode) {
			this.nCode =_nCode;
		}
		@Override
		public String toString() {
			return String.valueOf ( this . nCode );
		}
	}

}
