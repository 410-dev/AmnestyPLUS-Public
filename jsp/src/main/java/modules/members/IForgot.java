package modules.members;

import java.sql.ResultSet;
import java.util.Random;

import master.DBControl;
import master.MailSender;

public class IForgot {
	private String mailAddress;

	private String generateRecoveryKey() {
		int leftLimit = 48; // numeral '0'
	    int rightLimit = 122; // letter 'z'
	    int targetStringLength = 10;
	    Random random = new Random();
	
	    String generatedString = random.ints(leftLimit, rightLimit + 1)
	      .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
	      .limit(targetStringLength)
	      .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
	      .toString();
	    return generatedString;
	}
	
	public int recoverWithMail(String email) throws Exception {
		ResultSet resultOfQuery = DBControl.executeQuery("select * from members where email = \"" + email + "\"");

		if(resultOfQuery == null) {
			return 1;
		}else if(resultOfQuery.next()) {
			mailAddress = email;
			MailSender mail = new MailSender();
			String recoveryKey = generateRecoveryKey();
			DBControl.executeQuery("update members set recoveryLink = \"" + recoveryKey + "\" where email = \"" + mailAddress + "\"");

			String content = "[large]=Password Recovery\n";
			content += "Hello, " + resultOfQuery.getString("realname") + ".\n";
			content += "This mail is sent because you requested for resetting password.\n";
			content += "If you didn't request, you can ignore this mail.\n";
			content += "If you need to recover, please follow the step.\n\n";
			content += "1. Please go to: https://amnestyplus.org/login.jsp\n";
			content += "2. Login with temporary recovery key.\n";
			content += "   ID:   " + resultOfQuery.getString("username") + "\n";
			content += "   Pass: " + recoveryKey + "\n";
			content += "3. Then immediately change your password. The temporary recovery key is not protected, therefore it is vulnurable.";

			mail.sendEmailAsHQ(mailAddress, "Amnesty PLUS Account Recovery", content, true);
			return 0;
		}else {
			return 1;
		}
	}
	
	public String recoverWithUsername(String username) throws Exception {
		username = username.toLowerCase();
		ResultSet resultOfQuery = DBControl.executeQuery("select * from members where username = \"" + username + "\"");

		if(resultOfQuery == null) {
			return null;
		}else if(resultOfQuery.next()) {
			mailAddress = resultOfQuery.getString("email");
			MailSender mail = new MailSender();
			String recoveryKey = generateRecoveryKey();
			DBControl.executeQuery("update members set recoveryLink = \"" + recoveryKey + "\" where email = \"" + mailAddress + "\"");

			String content = "[large]=Password Recovery\n";
			content += "Hello, " + resultOfQuery.getString("realname") + ".\n";
			content += "This mail is sent by Amnesty PLUS management website, because you requested for resetting password.\n";
			content += "If you didn't request, you can ignore this mail.\n";
			content += "If you need to recover, please follow the step.\n\n";
			content += "1. Please go to: https://amnestyplus.org/login.jsp\n";
			content += "2. Login with temporary recovery key.\n";
			content += "\tYour ID:        " + resultOfQuery.getString("username") + "\n";
			content += "\tTemporary Pass: " + recoveryKey + "\n";
			content += "3. Then immediately change your password. The temporary recovery key is not protected, therefore it is vulnurable.";

			mail.sendEmailAsHQ(mailAddress, "Amnesty PLUS Account Recovery", content, true);
			return mailAddress;
		}else {
			return null;
		}
	}
}
