package modules.members;

import java.sql.Connection;
import java.sql.ResultSet;

import master.DBControl;
import master.LogsManager;
import master.Shasum;

public class Login {

	private Connection con = null;

	public final int MAXIMUM_LOGIN_ATTEMPT = 5;

	private final String[] PREPARED_STATEMENT = { "select * from members where username = \"", "\"" };
	
	public ResultSet getDatabaseResult(String username) throws Exception {
		ResultSet databaseResult = DBControl.executeQuery(String.join(username, PREPARED_STATEMENT));
		if (databaseResult.next()) {
			return databaseResult;
		}else {
			return null;
		}
	}

	// Returns -2 and accumulate if password is wrong
	// Returns -1 if no member found
	// Returns 0 if username AND password matches
	// Returns 2 if error

	// Returns 3 if account is locked for too many attempts
	// Returns 4 if account is banned
	// Returns 5 if account is waiting for approval

	// Returns 6 if injection
	// Returns 7 if logged in with recovery key
	public MemberData verifyUser(String username, String shasum) throws Exception {
		MemberData userdata = new MemberData();
		userdata.exitCondition = 1;
		
		if (shasum.contains(";") || shasum.contains("#")) {
			userdata.exitCondition = 6;
			return userdata;
		} else if (username.contains(";") || username.contains("#")) {
			userdata.exitCondition = 6;
			return userdata;
		}

		Shasum hash = new Shasum();
		shasum = hash.doShasum(shasum);

		ResultSet databaseResult = null;
		
		username = username.toLowerCase();

		databaseResult = DBControl.executeQuery(String.join(username, PREPARED_STATEMENT));
		Users usermgr = new Users();

		if (databaseResult.next()) {
			userdata.setId(databaseResult.getString("id"));
			userdata.setUsername(databaseResult.getString("username"));
			userdata.setPassword(databaseResult.getString("password"));
			userdata.setRealname(databaseResult.getString("realname"));
			userdata.setPassattempt(databaseResult.getInt("passattempt"));
			userdata.setPermission(databaseResult.getInt("permission"));
			userdata.setStatus(databaseResult.getString("status"));
			userdata.setEmail(databaseResult.getString("email"));
			userdata.setUserrole(databaseResult.getString("userrole"));
			userdata.setPhotoAddress(databaseResult.getString("photoAddress"));
			userdata.setRecoveryLink(databaseResult.getString("recoveryLink"));
			userdata.setStrikes(databaseResult.getInt("strikes"));
			userdata.setBio(databaseResult.getString("bio"));
			userdata.setCategory(databaseResult.getString("category"));
			databaseResult.close();
			if (userdata.getPassword().equals(shasum)) {
				if (userdata.getStatus().equals("NORMAL")) {
					userdata.exitCondition = 0;
					DBControl.executeQuery("update members set passattempt = 0 where username = \"" + username + "\"");
				} else if (userdata.getStatus().equals("LOCKED")) {
					LogsManager.addLog(username, userdata.getRealname(), "WARNING", "Locked account tried to log in.");
					userdata.exitCondition = 3;
				} else if (userdata.getStatus().equals("BANNED")) {
					LogsManager.addLog(username, userdata.getRealname(), "WARNING", "Banned account tried to log in.");
					userdata.exitCondition = 4;
				} else if (userdata.getStatus().equals("PENDING")) {
					LogsManager.addLog(username, userdata.getRealname(), "INFO", "Pending account tried to log in.");
					userdata.exitCondition = 5;
				} else {
					LogsManager.addLog(username, userdata.getRealname(), "ERROR", "There was an error while processing login.");
					userdata.exitCondition = 2;
				}
			} else if (shasum.equals(hash.doShasum(userdata.getRecoveryLink()))) {
				DBControl.executeQuery("update members set recoveryLink = null where username = \"" + username + "\"");
				LogsManager.addLog("INFO", "Account " + username + " is logged in as recovery key.");
				userdata.exitCondition = 7;
				return userdata;
			} else {
				if (userdata.getPassattempt() == MAXIMUM_LOGIN_ATTEMPT) {
					userdata.exitCondition = 3;
					usermgr.setUserData(username, "status", "LOCKED");
					LogsManager.addLog("WARNING", "Account " + username + " is locked, because there were too many attempts.");
				} else {
					userdata.exitCondition = -2 - userdata.getPassattempt();
					DBControl.executeQuery("update members set passattempt = " + (userdata.getPassattempt() + 1) + " where username = \"" + username + "\"");
				}
			}

		} else {
			userdata.exitCondition = -1;
		}

		if (con != null) con.close();
		return userdata;
	}

}
