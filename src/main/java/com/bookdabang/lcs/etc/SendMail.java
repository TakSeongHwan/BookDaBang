/**
 * 
 */
package com.bookdabang.lcs.etc;


import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



public class SendMail {
	public static void send(String sendMailAddr, String confirmCode) throws AddressException, MessagingException {
		// SMTP(Send Mail Transfer Protocol)를 이용해 GMail 서버를 이용해 메일 발송
		final String userName = "chltkd10@gmail.com";
		final String password = "!LCSlcs0319";

		// 보낼 메일을 만들자
		Properties prop = new Properties();
		String subject = "Book다방에서 보낸 이메일 인증번호 입니다.";
		String message = "Book다방에서 보낸 이메일 인증번호 입니다. <br/>";
		message += "회원 가입 화면에 아래의 번호를 기입하시고, 인증확인 버튼을 눌러주세요!<br/>";
		message += "<b>인증 번호 : " + confirmCode + "<b><br />";
		message += "감사합니다 !";

		// 메일 셋팅
		prop.put("mail.smtp.starttls.required", "true");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
		prop.put("mail.transport.protocol", "smtp");
		prop.put("mail.smtp.host", "smtp.gmail.com"); // 메일을 보내는 서버의 주소
		prop.put("mail.smtp.port", "465"); // 포트번호
		prop.put("mail.smtp.auth", "true"); // 인증 과정을 거치겠다.
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.ssl.enable", "true"); // SSL을 사용하겠다.
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		Session mailSession = Session.getInstance(prop, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, password);
			}
		}); // 지메일 서버에 로그인 하는 세션을 얻어옴
		System.out.println("메일 세션 : " + mailSession);
		if(mailSession != null) {
			// 얻어온 세션에 받을 사람 주소 , 제목, 내용등을 첨부하고 발송
			MimeMessage mime = new MimeMessage(mailSession);
			
			mime.setFrom(new InternetAddress("bookdabang@bookdabang.com"));//보내는 사람 주소
			mime.addRecipient(RecipientType.TO, new InternetAddress(sendMailAddr));
			mime.setSubject(subject); // 제목 첨부
			mime.setText(message); // 본문 첨부
			Transport.send(mime); //실제 메일 발송
		}

	}
}
