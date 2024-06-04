package itwillbs.p2c3.boogimovie.handler;

import java.util.Date;
import java.util.Properties;

import jakarta.mail.Address;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.Message.RecipientType;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class SendMailClient {
	private static final String HOST = "smtp.naver.com"; 
	private static final String PORT = "587"; 
	private static final String SERNDER_MAIL = "wnsgur3435@Naver.com"; 
	
	public void sendMail(String email, String subject, String content) {
		try {
			Properties props = System.getProperties();
			
			props.put("mail.smtp.host", HOST); // 네이버의 SMTP 서버 주소
//		props.put("mail.smtp.port", "465"); // 네이버 메일 서버 SMTP 서버 포트 번호
			props.put("mail.smtp.port", PORT); // 네이버 메일 서버 SMTP 서버 포트 번호
			props.put("mail.smtp.auth", "true"); // SMTP 서버 접근 시 인증 필요 여부 설정(로그인 필요 여부)
			props.put("mail.smtp.starttls.enable", "true"); // TLS 인증 프로토콜(보안 관련 프로토콜) 사용 여부 설정
			props.put("mail.smtp.ssl.trust", HOST); // SSL 인증에 사용할 신뢰할 수 있는 서버 주소 지정 
			
			Authenticator authenticator = new MailAuthenticator();
			System.out.println(authenticator.toString());
			Session mailSession = Session.getDefaultInstance(props, authenticator);
			
			Message message = new MimeMessage(mailSession);
			
			Address senderAddress = new InternetAddress(SERNDER_MAIL, "부기무비");
			
			Address receiverAddress = new InternetAddress(email);
			
//		message.setHeader("content-type", "text/html; charset=UTF-8");
			
			message.setFrom(senderAddress);
			
			message.setRecipient(RecipientType.TO, receiverAddress);
			
			message.setSubject(subject);
			
			message.setContent("<h3>" + content + "<h3>", "text/html; charset=UTF-8");
			
			message.setSentDate(new Date());
			
			Transport.send(message);
			
			System.out.println("인증메일 발송 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}
