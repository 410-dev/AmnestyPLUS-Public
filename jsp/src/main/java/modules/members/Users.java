package modules.members;

import java.sql.ResultSet;

import master.DBControl;

public class Users {
	
	public int setUserData(String username, String queryKey, int value) throws Exception {
		if (doesUserExists(username)) return executeQuery("update members set " + queryKey + " = " + value + " where username = \"" + username + "\";");
		return -1;
	}
	
	public int setUserData(String username, String queryKey, String value) throws Exception {
		if (doesUserExists(username)) return executeQuery("update members set " + queryKey + " = \"" + value + "\" where username = \"" + username + "\";");
		return -1;
	}

	public String getUserDataString(String username, String queryKey) throws Exception {
		if (doesUserExists(username)) {
			ResultSet data = DBControl.executeQuery("select * from members where username = \"" + username + "\";");
			if (data.next()) {
				return data.getString(queryKey);
			}else{
				return null;
			}
		}
		return null;
	}
	
	public int getUserDataInt(String username, String queryKey) throws Exception {
		if (doesUserExists(username)) {
			ResultSet data = DBControl.executeQuery("select * from members where username = \"" + username + "\";");
			if (data.next()) {
				return data.getInt(queryKey);
			}else{
				return -1;
			}
		}
		return -1;
	}
	
	public ResultSet getUserData(String queryKey, String queryValue) throws Exception {
		ResultSet data = DBControl.executeQuery("select * from members where " + queryKey + " = \"" + queryValue + "\";");
		if (data.next()) return data;
		else return null;
	}

	public ResultSet getSimilarUserData(String queryKey, String queryValue, boolean doPublishedPeople) throws Exception {
		ResultSet data;
		if (doPublishedPeople) data = DBControl.executeQuery("select * from members where " + queryKey + " like \"%" + queryValue + "%\" and status=\"NORMAL\";");
		else data = DBControl.executeQuery("select * from members where " + queryKey + " like \"%" + queryValue + "%\";");
		if (data.next()) return data;
		else return null;
	}

	public ResultSet getSimilarUserData(String queryKey, String queryValue, boolean doPublishedPeople, String excludeColumn, String excludeContent) throws Exception {
		ResultSet data;
		if (doPublishedPeople) data = DBControl.executeQuery("select * from members where " + queryKey + " like \"%" + queryValue + "%\" and " + excludeColumn + " not like \"%" + excludeContent + "%\" and status=\"NORMAL\";");
		else data = DBControl.executeQuery("select * from members where " + queryKey + " like \"%" + queryValue + "%\" and " + excludeColumn + " not like \"%" + excludeContent + "%\";");
		if (data.next()) return data;
		else return null;
	}
	
	public ResultSet getAllUserData() throws Exception {
		ResultSet data = DBControl.executeQuery("select * from members;");
		if (data.next()) return data;
		else return null;
	}

	
	private int executeQuery(String statement) throws Exception {
		if (DBControl.executeQuery(statement).next()) return 0;
		return 1;
	}

	private boolean doesUserExists(String username) throws Exception {
		ResultSet resultOfQuery = DBControl.executeQuery("select * from members where username = \"" + username + "\";");
		if (resultOfQuery.next()) {
			if (resultOfQuery.getString("username").equals(username)) return true;
		}
		return false;
	}
}
