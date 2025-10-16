package com.project.hospital.email;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailSendForPassword {

	 public void sendEmail(String fromEmail, String password, String toEmail, String subject, String authenticationCode) throws Exception{
		 // SMTP 서버 설정
		 Properties props = new Properties();
		 props.put("mail.smtp.host", "smtp.naver.com");
		 props.put("mail.smtp.port", "465");
		 props.put("mail.smtp.auth", "true");
		 props.put("mail.smtp.ssl.enable", "true");
		 props.put("mail.smtp.ssl.trust", "smtp.naver.com");
		 
		 final String finalFromEmail = fromEmail;
	     final String finalPassword = password; 
		 
		 // 인증 정보 설정
		 Session javaxMailSession = Session.getInstance(props, new Authenticator() {
			 @Override
			 protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(finalFromEmail, finalPassword);
	            }
		 });
		 
			 // 이메일 메시지 생성
			 Message message = new MimeMessage(javaxMailSession);
			 message.setFrom(new InternetAddress(fromEmail));
			 message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			 message.setSubject(subject);
			 message.setText(authenticationCode);
			 
			// 이메일 전송
			 Transport.send(message);
		
		 
		 
	 }
}
