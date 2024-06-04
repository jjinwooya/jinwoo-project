package itwillbs.p2c3.boogimovie.service;

import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.handler.GenerateRandomCode;
import itwillbs.p2c3.boogimovie.handler.SendMailClient;
import itwillbs.p2c3.boogimovie.vo.MailAuthInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;

@Service
public class MailService {
	
	public MailAuthInfoVO sendAuthMail(MemberVO member) {
		String auth_code = GenerateRandomCode.getRandomCode(50);
		String subject = "(。O ⩊ O。)[BoogiMovie](。O ⩊ O。)";
		String content = "<a href='http://c3d2401t2.itwillbs.com/boogimovie/Member_email_auth?member_id=" + member.getMember_id() 
						+ "&auth_code=" + auth_code + "'>비밀번호 재설정 링크!</a>";
		SendMailClient mailClient = new SendMailClient();
		
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				mailClient.sendMail(member.getMember_email(), subject, content);
			}
		}).start();
		
		MailAuthInfoVO mailAuth = new MailAuthInfoVO(member.getMember_id(), auth_code);
		
		return mailAuth;
	}
}
