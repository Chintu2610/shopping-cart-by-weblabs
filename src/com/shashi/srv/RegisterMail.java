package com.shashi.srv;

import java.util.Properties;
import java.util.ResourceBundle;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class RegisterMail {

	private static final String FROM_EMAIL;
    private static final String FROM_PASSWORD;

    static {
        // Load properties from the resource bundle
        ResourceBundle rb = ResourceBundle.getBundle("application");
        FROM_EMAIL = rb.getString("mailer.email");
        FROM_PASSWORD = rb.getString("mailer.password");
    }
	
	public static void sendLinkEmail(String toEmail,String username) {
		/* String otp = generateOTP(toEmail); */
		String subject = "Trade System Registration Program.";
		
		
		String body = "Hi " + username + "\n" +
	              "Welcome to Shopping Cart Service! We are thrilled to have you on board and thank you for choosing us for your shopping needs.:\n" +
			    "Your shopping cart is now ready and waiting for you to explore our wide range of products. Whether you are looking for trendy fashion. :\n"+
				" items, tech gadgets, home essentials, or gifts for loved ones, we've got you covered.\n\" "+
				"Here are a few things you can expect from shopping with us:\r\n"+
				 "A seamless browsing and checkout experience\r\n"
				 + "High-quality products from trusted brands\r\n"
				 + "Secure payment options to ensure your transactions are safe\r\n"
				 + "Fast and reliable shipping to get your purchases to you promptly\r\n"
				 + "Friendly customer support to assist you with any queries or concerns\r\n"+
				 "Thank you again for choosing Shopping-Cart. We look forward to serving you and exceeding your expectations!\r\n"
				 + "\r\n"
				 + "Happy shopping!\r\n"
				 + "\r\n"
				 + "Best regards,\n"
				+ "items, tech gadgets, home essentials, or gifts for loved ones, we've got you covered.\r\n"
				+ "\r\n";
				

		sendEmail(toEmail, subject, body);
		return ;
	}

	/*
	 * private static String generateOTP(String email) { Random random = new
	 * Random(); int otp = 100000 + random.nextInt(900000); // Get or create a
	 * session // HttpSession session = request.getSession(true); //
	 * session.setAttribute("otpCreationTime", System.currentTimeMillis());
	 * 
	 * EmailDao.storeOTP(email, otp); System.out.println("email" + email + " " +
	 * "otp" + otp); return String.valueOf(otp); }
	 */

	private static void sendEmail(String toEmail, String subject, String body) {
		Properties properties = System.getProperties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.ssl.enable", "true");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.ssl.protocols", "TLSv1.2"); // Use TLSv1.2 protocol
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
			}
		});
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			message.setSubject(subject);
			message.setText(body);
			Transport.send(message);
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
	}
}
