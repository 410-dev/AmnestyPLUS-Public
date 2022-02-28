package modules.members;

import java.sql.ResultSet;
import java.util.Random;

import master.DBControl;
import master.LogsManager;
import master.Shasum;
import master.MailSender;

public class Register {
	
	private ResultSet databaseResult = null;
	private DBControl databaseController = null;
	
    private final String[] PREPARED_STATEMENT = {"insert into members(username, password, realname, passattempt, permission, status, email, userrole, photoaddress, strikes, bio, category) values(", ");"};
    
    // 1 = Error
    // 2 = OK
    // 3 = Username exists
    // 4 = Email exists
    // 5 = Injection
    
    public int addNewUser(String username, String password, String realname, String email, String userrole, String bio, String photoName, String isLeadership) throws Exception {
    	int toReturn = 1;
		username = username.toLowerCase();
		if (password.contains(";") || password.contains("#") || password.contains(" ")) {
			return 5;
		}else if (username.contains(";") || username.contains("#") || username.contains("_") || username.contains(" ")) {
			return 5;
		}

		boolean userExists = doesUserExistInEmail(email);
		if (userExists) return 4;

		userExists = doesUserExistInUsername(username);
		if (userExists) return 3;

		if (!email.contains("@") || !email.contains(".")) return 6;

		String category = userrole;
		if (isLeadership == null && (userrole.equals("IT Department") || userrole.equals("Communication Department"))) {
			category += "-NL";
		}
		toReturn = task_createUser(username, password, realname, email, userrole, bio, photoName, category);
		if(databaseResult != null) databaseResult.close();
    	return toReturn;
    }
    
    private int task_createUser(String username, String password, String realname, String email, String userrole, String bio, String photoName, String category) throws Exception {
    	
    	Shasum shasum = new Shasum();
    	password = shasum.doShasum(password);
    	
    	String SQLStatement = PREPARED_STATEMENT[0];
    	SQLStatement += "\"" + username + "\", ";
    	SQLStatement += "\"" + password + "\", ";
    	SQLStatement += "\"" + realname + "\", ";
    	SQLStatement += "0, 500, \"PENDING\", ";
    	SQLStatement += "\"" + email + "\", ";
    	SQLStatement += "\"" + userrole + "\", ";
    	SQLStatement += "\"" + photoName + "\", ";
    	SQLStatement += "0, ";
    	SQLStatement += "\"" + bio + "\", ";
    	SQLStatement += "\"" + category + "\"";
    	SQLStatement += PREPARED_STATEMENT[1];
		databaseResult = databaseController.executeQuery(SQLStatement);
		String randomData = generateRandomKey();
		new Users().setUserData(username, "recoveryLink", randomData);
		String mailContent = "[large]=Sign Up Request\n"
				+ "There was a signup request from unknown user.\n"
				+ "[section]=Details\n"
				+ "Name: " + realname + "\n"
				+ "ID: " + username + "\n"
				+ "Mail: " + email + "\n"
				+ "Role: " + userrole + "\n"
				+ "Bio:  " + bio + "\n"
				+ "\n\n\n"
				+ "To accept the request, please click <a href=\"http://beta.amnestyplus.org/ChangeAccountData?remote_approve=1&data=" + randomData + "\">here.</a>";
		MailSender mail = new MailSender();
		ResultSet userWithPrivilege = databaseController.executeQuery("select * from members where permission=100;");
		userWithPrivilege.first();
		while(true) {
//			mail.sendEmailAsHQ(userWithPrivilege.getString("email"), "Sign Up Request", mailContent, true);
			if (!userWithPrivilege.next()) break;
		}
		LogsManager.addLog(username, realname, "INFO", "Requested for signup.");
		return 2;
    }
    
    private String generateRandomKey() {
		int leftLimit = 48; // numeral '0'
	    int rightLimit = 122; // letter 'z'
	    int targetStringLength = 15;
	    Random random = new Random();
	
	    String generatedString = random.ints(leftLimit, rightLimit + 1)
	      .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
	      .limit(targetStringLength)
	      .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
	      .toString();
	    return generatedString;
	}
    
    private boolean doesUserExistInEmail(String email) throws Exception {
		databaseResult = databaseController.executeQuery("select * from members where email = \"" + email + "\"");
		return databaseResult.next();
    }
    
    private boolean doesUserExistInUsername(String username) throws Exception{
		databaseResult = databaseController.executeQuery("select * from members where username = \"" + username + "\"");
		return databaseResult.next();
    }

}
