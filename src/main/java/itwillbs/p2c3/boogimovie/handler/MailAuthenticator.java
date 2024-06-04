package itwillbs.p2c3.boogimovie.handler;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

public class MailAuthenticator extends Authenticator{
	PasswordAuthentication passwordAuthentication;

	public MailAuthenticator() {
		passwordAuthentication = new PasswordAuthentication("wnsgur3435@naver.com", "MWS7XMYMZWW4");
		
	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return passwordAuthentication;
	}

	@Override
	public String toString() {
		return "MailAuthenticator [passwordAuthentication=" + passwordAuthentication + "]";
	}
	
	
}
