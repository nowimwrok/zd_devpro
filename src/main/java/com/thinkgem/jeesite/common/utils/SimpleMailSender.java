package com.thinkgem.jeesite.common.utils;
/**   
 * 简单邮件（不带附件的邮件）发送器   
 */ 
import java.util.Date;    
import java.util.Properties;   
import org.slf4j.Logger;
import javax.mail.Address;    
import javax.mail.BodyPart;    
import javax.mail.Message;    
import javax.mail.Multipart;    
import javax.mail.Session;    
import javax.mail.Transport;    
import javax.mail.internet.InternetAddress;    
import javax.mail.internet.MimeBodyPart;    
import javax.mail.internet.MimeMessage;    
import javax.mail.internet.MimeMultipart;
import com.thinkgem.jeesite.common.web.BaseController;
public class SimpleMailSender extends BaseController {    
/**   
  * 以文本格式发送邮件   
  * @param mailInfo 待发送的邮件的信息   
  */    
    public boolean sendTextMail(MailSenderInfo mailInfo) throws Exception{    
      // 判断是否需要身份认证    
      MyAuthenticator authenticator = null;    
      Properties pro = mailInfo.getProperties();   
      if (mailInfo.isValidate()) {    
      // 如果需要身份认证，则创建一个密码验证器    
        authenticator = new MyAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());    
      }   
      // 根据邮件会话属性和密码验证器构造一个发送邮件的session    
      Session sendMailSession = Session.getDefaultInstance(pro,authenticator); 
      logBefore(logger, "构造一个发送邮件的session");
      
      // 根据session创建一个邮件消息    
      Message mailMessage = new MimeMessage(sendMailSession);    
      // 创建邮件发送者地址    
      Address from = new InternetAddress(mailInfo.getFromAddress());    
      // 设置邮件消息的发送者    
      mailMessage.setFrom(from);    
      // 创建邮件的接收者地址，并设置到邮件消息中    
      Address to = new InternetAddress(mailInfo.getToAddress());    
      mailMessage.setRecipient(Message.RecipientType.TO,to);    
      // 设置邮件消息的主题    
      mailMessage.setSubject(mailInfo.getSubject());    
      // 设置邮件消息发送的时间    
      mailMessage.setSentDate(new Date());    
      // 设置邮件消息的主要内容    
      String mailContent = mailInfo.getContent();    
      mailMessage.setText(mailContent);    
      // 发送邮件    
      Transport.send(mailMessage); 
      logBefore(logger, "发送成功！");
      return true;    
    }    
	public static void logBefore(Logger logger, String interfaceName) {
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}  
    /**   
      * 以HTML格式发送邮件   
      * @param mailInfo 待发送的邮件信息   
      */    
    public  boolean sendHtmlMail(MailSenderInfo mailInfo) throws Exception{    
      // 判断是否需要身份认证    
      MyAuthenticator authenticator = null;   
      Properties pro = mailInfo.getProperties();   
      //如果需要身份认证，则创建一个密码验证器     
      if (mailInfo.isValidate()) {    
        authenticator = new MyAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());   
      }    
      // 根据邮件会话属性和密码验证器构造一个发送邮件的session    
      Session sendMailSession = Session.getDefaultInstance(pro,authenticator);    
        
      // 根据session创建一个邮件消息    
      Message mailMessage = new MimeMessage(sendMailSession);    
      // 创建邮件发送者地址    
      Address from = new InternetAddress(mailInfo.getFromAddress());    
      // 设置邮件消息的发送者    
      mailMessage.setFrom(from);    
      // 创建邮件的接收者地址，并设置到邮件消息中    
      Address to = new InternetAddress(mailInfo.getToAddress());    
      // Message.RecipientType.TO属性表示接收者的类型为TO    
      mailMessage.setRecipient(Message.RecipientType.TO,to);    
      // 设置邮件消息的主题    
      mailMessage.setSubject(mailInfo.getSubject());    
      // 设置邮件消息发送的时间    
      mailMessage.setSentDate(new Date());    
      // MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象    
      Multipart mainPart = new MimeMultipart();    
      // 创建一个包含HTML内容的MimeBodyPart    
      BodyPart html = new MimeBodyPart();    
      // 设置HTML内容    
      html.setContent(mailInfo.getContent(), "text/html; charset=utf-8");    
      mainPart.addBodyPart(html);    
      // 将MiniMultipart对象设置为邮件内容    
      mailMessage.setContent(mainPart);    
      // 发送邮件    
      Transport.send(mailMessage);    
      return true;    
    }    
 
    /*
     * @title:标题
     * @content:内容
     * @type:类型,1:文本格式;2:html格式
     * @tomail:接收的邮箱
     */
    public boolean sendMail(String title,String content,String type,String tomail) throws Exception{   
        
    	//这个类主要是设置邮件   
	     MailSenderInfo mailInfo = new MailSenderInfo();    
	     mailInfo.setMailServerHost("smtp.qq.com");    
	     mailInfo.setMailServerPort("25");    
	     mailInfo.setValidate(true);    
	     mailInfo.setUserName("328390204@qq.com");    
	     mailInfo.setPassword("fuck2014");//您的邮箱密码    
	     mailInfo.setFromAddress("328390204@qq.com");    
	     mailInfo.setToAddress(tomail);    
	     mailInfo.setSubject(title);    
	     mailInfo.setContent(content);    
	     //这个类主要来发送邮件   
	  
	     SimpleMailSender sms = new SimpleMailSender();   
	     
	     if("1".equals(type)){
	    	 return sms.sendTextMail(mailInfo);//发送文体格式    
	     }else if("2".equals(type)){
	    	 return sms.sendHtmlMail(mailInfo);//发送html格式   
	     }
	     return false;
	   }
    /**
     * @param SMTP  	邮件服务器
     * @param PORT		端口
     * @param EMAIL		本邮箱账号
     * @param PAW		本邮箱密码
     * @param toEMAIL	对方箱账号
     * @param TITLE		标题
     * @param CONTENT	内容
     * @param TYPE		1：文本格式;2：HTML格式
     */
    public static void sendEmail(String SMTP, String PORT, String EMAIL, String PAW, String toEMAIL, String TITLE, String CONTENT, String TYPE) throws Exception{ 
    	
        //这个类主要是设置邮件   
	     MailSenderInfo mailInfo = new MailSenderInfo();
	     
	     mailInfo.setMailServerHost(SMTP);    
	     mailInfo.setMailServerPort(PORT);    
	     mailInfo.setValidate(true);    
	     mailInfo.setUserName(EMAIL);    
	     mailInfo.setPassword(PAW);   
	     mailInfo.setFromAddress(EMAIL);    
	     mailInfo.setToAddress(toEMAIL);    
	     mailInfo.setSubject(TITLE);    
	     mailInfo.setContent(CONTENT);    
	     //这个类主要来发送邮件   
	  
	     SimpleMailSender sms = new SimpleMailSender();
	     
	    if("1".equals(TYPE)){
	    	sms.sendTextMail(mailInfo);
	    }else{
	    	sms.sendHtmlMail(mailInfo);
	    }
	     
	   }
    
    
 
  
    /***
     * 针对注册和验证批量发送邮件
     * @Description: TODO
     * @param @param title
     * @param @param content
     * @param @param type
     * @param @param tomail
     * @param @param mailSwitch
     * @param @param bizType
     * @param @return
     * @param @throws Exception   
     * @return boolean  
     * @throws
     * @author lqz
     * @date 2015年8月24日
     */
  public boolean batchSendMail(String title,String content,String type,String tomail,String mailSwitch,int bizType) throws Exception{   
        try{
        	String[] tomailArr=tomail.split(",");
        	SimpleMailSender mail=new SimpleMailSender();
        	String[] mailSwicthArr=mailSwitch.split(",");
        	if(mailSwicthArr[bizType].equals("1")) 
        		for (String singleToMail : tomailArr) {
            		mail.sendMail(title,content,type,singleToMail);
            	}
        	return true;
        }
        catch(Exception ex){
        	 return false;
        }
    	 
	   }
  
  
  
    public static void main(String[] args){   
        //这个类主要是设置邮件   
	     MailSenderInfo mailInfo = new MailSenderInfo();    
	     mailInfo.setMailServerHost("smtp.qq.com");    
	     mailInfo.setMailServerPort("25");    
	     mailInfo.setValidate(true);    
	     mailInfo.setUserName("itfather@1b23.com");    
	     mailInfo.setPassword("tttt");//您的邮箱密码    
	     mailInfo.setFromAddress("itfather@1b23.com");    
	     mailInfo.setToAddress("313596790@qq.com");    
	     mailInfo.setSubject("设置邮箱标题");    
	     mailInfo.setContent("设置邮箱内容");    
	     //这个类主要来发送邮件   
	  
	     SimpleMailSender sms = new SimpleMailSender();   
	     //sms.sendTextMail(mailInfo);//发送文体格式    
	     //sms.sendHtmlMail(mailInfo);//发送html格式   
	     
	     
	     
	 	try{
			SimpleMailSender mail=new SimpleMailSender();
			 mail.sendMail("可是当年可是", "test", "1", "779086713@qq.com");
			}catch(Exception exx)
			{
				exx.printStackTrace();
			}
	   }
    
}   
