package master;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class MailSender {

	private boolean runningDebugMode = false;

	public MailSender() throws Exception {
		String config = new Configurations().get("enable_mail");
		runningDebugMode = !config.equals("true");
	}
	
	public void sendEmailAsHQ(String recv, String subject, String contents, boolean doConvertToHTML) throws Exception {
		final String SendAs = "-";
    	final String Password = "-";
    	mailEngine(SendAs, Password, "-", recv, subject, contents, doConvertToHTML);
	}

	private void mailEngine(String SendAs, String Password, String SenderName, String recv, String subject, String contents, boolean doConvertToHTML) throws Exception {
		try {
			if (!runningDebugMode) {
				Properties props = new Properties();
				props.put("mail.transport.protocol", "smtp");
				props.put("mail.smtp.port", 587);
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.auth", "true");
				Session session = Session.getDefaultInstance(props, null);
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress(SendAs, SenderName));
				msg.addRecipient(Message.RecipientType.TO,
						new InternetAddress(recv));
				msg.setSubject(subject);
				if (doConvertToHTML) {
					contents = convertToHTML(contents.split("\n"));
				}
				Multipart mp = new MimeMultipart();
				MimeBodyPart htmlPart = new MimeBodyPart();
				htmlPart.setContent(contents, "text/html");
				mp.addBodyPart(htmlPart);
				msg.setContent(mp);
				Transport transport = session.getTransport();
				// Address removed due to security reason
				transport.sendMessage(msg, msg.getAllRecipients());
				transport.close();
				LogsManager.addLog("INFO", "Mail sent to: " + recv + " | Subject: " + subject);
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	private String convertToHTML(String[] originalString) {
		final String startingTemplate = "<head>\n"
				+ "</head>\n"
				+ "<body>\n"
				+ "  <div style=\"background-color: yellow; text-align: center; position: relative;\" >\n"
				+ "    <img style=\"position: relative; top: 13px;\" src=https://amnestyplus.org/mail_header_logo3.png height=60>\n"
				+ "    <div style=\"background-color: #FFFFFF; margin: auto; padding: 40px; position: relative; top: 30px; text-align: center;\">\n";
		final String[] paragraphTextTemplate = {"<p style=\"font-family: Helvetica; text-align: left; font-size: 17px;\">", "</p>" };
		final String[] largeTextTemplate = {"<p style=\"font-family: Helvetica; text-align: center; font-size: 30px; font-weight: bold;\">", "</p>" };
		String returnValue = startingTemplate;
		for (int i = 0; i < originalString.length; i++) {
			if (originalString[i].startsWith("[large]=")) {
				returnValue += largeTextTemplate[0] + originalString[i].replace("[large]=", "") + largeTextTemplate[1];
			} else if (originalString[i].startsWith("[section]=")) {
				returnValue += originalString[i].replace("[section]=", "<hr>") + largeTextTemplate[1];
			} else {
				returnValue += paragraphTextTemplate[0] + originalString[i] + paragraphTextTemplate[1];
			}
		}
		returnValue += "\n</div>\n</body>";
		return returnValue;
	}
}