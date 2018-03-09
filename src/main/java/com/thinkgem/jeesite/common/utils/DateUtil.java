package com.thinkgem.jeesite.common.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	private final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");

	private final static SimpleDateFormat sdfDay = new SimpleDateFormat(
			"yyyy-MM-dd");
	
	private final static SimpleDateFormat sdfDays = new SimpleDateFormat(
	"yyyyMMdd");

	private final static SimpleDateFormat sdfTime = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	
	private final static SimpleDateFormat sdfDetailTime = new SimpleDateFormat(
			"yyyyMMddHHmmssSSS");

	private final static SimpleDateFormat sdfShortTime = new SimpleDateFormat(
			"yyMMddHHmm"); 
	
	/**
	 * 获取YYYY格式
	 * 
	 * @return
	 */
	public static String getYear() {
		return sdfYear.format(new Date());
	}

	/**
	 * 获取YYYY-MM-DD格式
	 * 
	 * @return
	 */
	public static String getDay() {
		return sdfDay.format(new Date());
	}
	
	
	/**
	 * 获取YYYY-MM-DD 00:00:00格式
	 * 
	 * @return
	 */
	public static String getCurrentDayTime() {
		  SimpleDateFormat sdfCurrentDayTime = new SimpleDateFormat(
				"yyyy-MM-dd 00:00:00");
		return sdfCurrentDayTime.format(new Date());
	}
	
	/**
	 * 获取YYYYMMDD格式
	 * 
	 * @return
	 */
	public static String getDays(){
		return sdfDays.format(new Date());
	}

	/**
	 * 获取YYYY-MM-DD HH:mm:ss格式
	 * 
	 * @return
	 */
	public static String getTime() {
		return sdfTime.format(new Date());
	}
 
	/**
	 * 获取YYYY-MM-DD HH:mm:ss格式
	 * 
	 * @return
	 */
	public static String getTime(String timeMillis) {
		Calendar calendar = Calendar.getInstance();
		 calendar.setTimeInMillis(Long.parseLong(timeMillis));  
		 return sdfTime.format(calendar.getTime()); 
	}
	
	
	
	/**
	 * 获取YYYYMMDDHHmmssnnn格式
	 * 
	 * @return
	 */
	public static String getDetailTime() {
		return sdfDetailTime.format(new Date());
	}
	
	
	public static String getShortTime() {
		return sdfShortTime.format(new Date());
	}
	
	/**
	* @Title: compareDate
	* @Description: TODO(日期比较，如果s>=e 返回true 否则返回false)
	* @param s
	* @param e
	* @return boolean  
	* @throws
	* @author luguosui
	 */
	public static boolean compareDate(String s, String e) {
		if(fomatDate(s)==null||fomatDate(e)==null){
			return false;
		}
		return fomatDate(s).getTime() >=fomatDate(e).getTime();
	}

	
	
	/**
	* @Title: compareTime
	* @Description: TODO(时间比较，如果s>=e 返回true 否则返回false)
	* @param s
	* @param e
	* @return boolean  
	* @throws
	* @author luguosui
	 */
	public static boolean compareTime(String s, String e) {
		if(fomatTime(s)==null||fomatTime(e)==null){
			return false;
		}
		return fomatTime(s).getTime() >=fomatTime(e).getTime();
	}
	/**
	* @Title: compareTime
	* @Description: TODO(时间比较，time在开始时间和结束时间之间 返回true 否则返回false)
	* @param s
	* @param e
	* @return boolean  
	* @throws
	* @author luguosui
	 */
	public static boolean compareTime(String time, String begin,String end) {
		if(fomatTime(time)==null||fomatTime(begin)==null||fomatTime(end)==null){
			return false;
		}
		long currentTimeNumber=fomatTime(time).getTime();
		return  currentTimeNumber>=fomatTime(begin).getTime()&&currentTimeNumber<=fomatTime(end).getTime();
	}
	/***
	 * 比较当前时间是否处于所给当前日期时间的区间之间
	 * @Description: TODO
	 * @param @param beginHour
	 * @param @param endHour
	 * @param @return   
	 * @return boolean  
	 * @throws
	 * @author lqz
	 * @date 2015年10月25日
	 */
	public static boolean compareTime(int beginHour,int endHour) {
		String time=DateUtil.getTime();
		String begin=DateUtil.getHourSub( 
				 DateUtil.getCurrentDayTime(),beginHour);
		String end=DateUtil.getHourSub( 
				 DateUtil.getCurrentDayTime(),endHour);
		return compareTime( time,  begin, end);
	}
	

	/**
	 * 格式化时间
	 * 
	 * @return
	 */
	public static Date fomatTime(String date) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return fmt.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 格式化日期
	 * 
	 * @return
	 */
	public static Date fomatDate(String date) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return fmt.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 校验日期是否合法
	 * 
	 * @return
	 */
	public static boolean isValidDate(String s) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			fmt.parse(s);
			return true;
		} catch (Exception e) {
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			return false;
		}
	}
	public static int getDiffYear(String startTime,String endTime) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			long aa=0;
			int years=(int) (((fmt.parse(endTime).getTime()-fmt.parse(startTime).getTime())/ (1000 * 60 * 60 * 24))/365);
			return years;
		} catch (Exception e) {
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			return 0;
		}
	}
	  /**
     * <li>功能描述：时间相减得到天数
     * @param beginDateStr
     * @param endDateStr
     * @return
     * long 
     * @author Administrator
     */
    public static long getDaySub(String beginDateStr,String endDateStr){
        long day=0;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date beginDate = null;
        Date endDate = null;
        
            try {
				beginDate = format.parse(beginDateStr);
				endDate= format.parse(endDateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
            day=(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
            //System.out.println("相隔的天数="+day);
      
        return day;
    }
    
     
    /**
     * 得到n天之后的日期
     * @param days
     * @return
     */
    public static String getAfterDayDate(String days) {
    	int daysInt = Integer.parseInt(days);
    	
        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();
        
        SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateStr = sdfd.format(date);
        
        return dateStr;
    }
    
    /**
     * 得到n天之后是周几
     * @param days
     * @return
     */
    public static String getAfterDayWeek(String days) {
    	int daysInt = Integer.parseInt(days);
    	
        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();
        
        SimpleDateFormat sdf = new SimpleDateFormat("E");
        String dateStr = sdf.format(date);
        
        return dateStr;
    }
    
    
    /**
     * 得到n个小时之后的时间
     * @param days
     * @return
     */
    public static String getHourSub(int hours) {
    	Calendar calendar = Calendar.getInstance();
		 calendar.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY) -hours);
		  SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  return df.format(calendar.getTime());
    }
    /***
     * 得到传递时间参数的n个小时之后的时间
     * @Description: TODO
     * @param @param time
     * @param @param hours
     * @param @return   
     * @return String  
     * @throws
     * @author lqz
     * @date 2015年10月25日
     */
    public static String getHourSub(String time,int hours) {
    	Calendar calendar = Calendar.getInstance();
		 calendar.setTime(new Date(fomatTime(time).getTime()+hours*60 * 60 * 1000));
		  SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  return df.format(calendar.getTime());
    }
    
    public static void main(String[] args) {
    	try {
			 long  currentTime= System.currentTimeMillis();
			 System.out.println(currentTime);
			 System.out.println(DateUtil.getTime("1448685195093")); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	/*System.out.println(compareTime(DateUtil.getTime(),"2015-08-13 10:44:00"));
    	System.out.println(getDays());
    	System.out.println(getAfterDayWeek("3"));
    	
    	System.out.println(getTime());
    	 System.out.println(getHourSub(-6));

    	System.out.println(compareTime(DateUtil.getTime(),getHourSub( 
    			getCurrentDayTime(),8)));
    	System.out.println(compareTime(DateUtil.getTime(),getHourSub( 
    			getCurrentDayTime(),18)));*/
    }

	/**
	 * 获取今天0点的日期 返回date
	 *  
	 * @return
	 */
	public static Date getCurrentDayTimeDate() {
		SimpleDateFormat sdfTime = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		Date date=new Date();
		try {
			date = sdfTime.parse(getCurrentDayTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}
    
	/**
	 * 返回月份第一天 yyyy-MM-dd hh:mm:ss
	 * @param parameter 0下个月 1 本月 2 上月
	 * @return
	 */
	public static Date getMonthDate(Integer parameter){
		SimpleDateFormat format = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		// 获取前月的第一天
		Calendar cal_1 = Calendar.getInstance();// 获取当前日期
		cal_1.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		cal_1.set(Calendar.HOUR_OF_DAY, 0);
		cal_1.set(Calendar.MINUTE, 0);
		cal_1.set(Calendar.SECOND, 0);
		cal_1.set(Calendar.MILLISECOND, 0);// 设置时分秒为0

		String lastMonths = format.format(cal_1.getTime());// 上月份数据
		cal_1.add(Calendar.MONTH, -1);
		String lastlMonths = format.format(cal_1.getTime());// 上上月份数据
		cal_1.add(Calendar.MONTH, +2);
		String nowMonths = format.format(cal_1.getTime());// 当前月份数据
		
		String returnMonth="";
		if(parameter==0){
			returnMonth=nowMonths;
		}else if(parameter==1){
			returnMonth=lastMonths;
		}else if(parameter==2){
			returnMonth=lastlMonths;
		}else{
			returnMonth=nowMonths;
		}
		Date date=new Date();
		try {
			date=format.parse(returnMonth);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}
	
	/**
	 * 根据传入的日期参数比较大小 返回相差的时间 毫秒 前者减后者
	 * @param date 前者
	 * @param dates 后者
	 * @return
	 */
	public static Double getTimeDateMinus(Date date,Date dates) {
		Double time=0.0;
		if(date!=null&&dates!=null){
			Long datelong= date.getTime();
			Long dateslong= dates.getTime();
			time=Double.valueOf(datelong-dateslong);
		}
		return time;
	}
	/**
	 * 获取YYYY-MM-DD格式
	 *
	 * @return
	 */
	public static String getCurrentDay(Date date) {
		SimpleDateFormat sdfCurrentDayTime = new SimpleDateFormat(
				"yyyy-MM-dd");
		return sdfCurrentDayTime.format(date);
	}
}
