package modules.articles;

import java.sql.ResultSet;

import master.DBControl;
import master.LogsManager;
import master.MailSender;
import master.CoreBase64;

public class AManagement {

	// On publish / reject, only the post title, date and email are referred.

	public String post_id;
	public String post_title;
	public String post_date;
	public String post_edit;
	public String post_type;
	public String post_auth_id;
	public String post_auth_realname;
	public String post_auth_email;
	public String post_auth_role;
	public String post_auth_photo_address;
	public String post_content;
	public String post_photoURLs;

	public void writeToDatabase() throws Exception {
		String SQLStatement = "";
		SQLStatement += "insert into articles(";
		SQLStatement += "post_title, ";
		SQLStatement += "post_date, ";
		SQLStatement += "post_edit, ";
		SQLStatement += "post_type, ";
		SQLStatement += "post_auth_id, ";
		SQLStatement += "post_auth_realname, ";
		SQLStatement += "post_auth_email, ";
		SQLStatement += "post_auth_role, ";
		SQLStatement += "post_auth_photo_address, ";
		SQLStatement += "post_status, ";
		SQLStatement += "post_content, ";
		SQLStatement += "post_photoURLs, ";
		SQLStatement += "post_viewcounts, ";
		SQLStatement += "post_featured)";

		SQLStatement += " values(";
		SQLStatement += "\"" + post_title + "\", ";
		SQLStatement += "\"" + post_date + "\", ";
		SQLStatement += "\"" + post_edit + "\", ";
		SQLStatement += "\"" + post_type + "\", ";
		SQLStatement += "\"" + post_auth_id + "\", ";
		SQLStatement += "\"" + post_auth_realname + "\", ";
		SQLStatement += "\"" + post_auth_email + "\", ";
		SQLStatement += "\"" + post_auth_role + "\", ";
		SQLStatement += "\"" + post_auth_photo_address + "\", ";
		SQLStatement += "\"PENDING\", ";
		SQLStatement += "\"" + post_content + "\", ";
		SQLStatement += "\"" + post_photoURLs + "\", ";
		SQLStatement += "0, ";
		SQLStatement += "0);";

		DBControl.executeQuery(SQLStatement);

		String toSend = "[large]=Article Uploaded\n"
				+ "Your article " + CoreBase64.decode(post_title) + " is waiting to be published by the editors.\n"
				+ "We will let you know once your article is published.\n";
		MailSender mailutil = new MailSender();
//		mailutil.sendEmailAsHQ(post_auth_email, "Your article is sent to the editor.", toSend, true);
//		LogsManager.addLog(post_auth_id, post_auth_realname, "INFO", "Article \\\"" + CoreBase64.decode(post_title) + "\\\" added.");
	}
	
	public void editArticle() throws Exception {
		String SQLStatement = "";
		SQLStatement += "update * set post_content = \"" + post_content + "\"";
		SQLStatement += "from articles where ";
		SQLStatement += "id = " + post_id + ";";
		DBControl.executeQuery(SQLStatement);

		SQLStatement = "";
		SQLStatement += "update * set post_edit = \"" + post_edit + "\"";
		SQLStatement += "from articles where ";
		SQLStatement += "id = " + post_id + ";";
		DBControl.executeQuery(SQLStatement);

		SQLStatement = "";
		SQLStatement += "update * set post_title = \"" + post_title + "\"";
		SQLStatement += "from articles where ";
		SQLStatement += "id = " + post_id + ";";
		DBControl.executeQuery(SQLStatement);

		SQLStatement = "";
		SQLStatement += "update * set post_photoURLs = \"" + post_photoURLs + "\"";
		SQLStatement += "from articles where ";
		SQLStatement += "id = " + post_id + ";";
		DBControl.executeQuery(SQLStatement);

		SQLStatement = "";
		SQLStatement += "update * set post_type = \"" + post_type + "\"";
		SQLStatement += "from articles where ";
		SQLStatement += "id = " + post_id + ";";
		DBControl.executeQuery(SQLStatement);

		SQLStatement += "";
		SQLStatement += "update * set post_status = \"PENDING\"";
		SQLStatement += "from articles where ";
		SQLStatement += "id = " + post_id + ";";
		DBControl.executeQuery(SQLStatement);
	}
	
	public ResultSet filterArticles(String[] conditions) throws Exception {
		// Input: "author = \"someone\"", "status=\"PENDING\""
		if (conditions.length == 0) return null;

		String filteringStatement = "";
		for(int i = 0; i < conditions.length; i++) {
			filteringStatement += conditions[i];
			if (i < conditions.length - 1) {
				filteringStatement += " and ";
			}
		}
		return DBControl.executeQuery("select * from articles where " + filteringStatement + ";");
	}
	
	public String[] getArticle(String articleID) throws Exception {
		String[] toReturn = new String[15];

		ResultSet resultFromSQL = DBControl.executeQuery("select * from articles where id = " + articleID);
		if (!resultFromSQL.next()) {
			toReturn[0] = "error";
			return toReturn;
		}

		/* 0: ID
		 * 1: Title
		 * 2: Date Written
		 * 3: Date Edit
		 * 4: Type
		 * 5: Author ID
		 * 6: Author Realname
		 * 7: Author Email
		 * 8: Author Role
		 * 9: Author Photo Address
		 * 10: Post Status (PENDING / PUBLIC / REJECT / DELETED)
		 * 11: Content
		 * 12: Photos URL
		 * 13: View Counts
		 * 14: Featured
		 */

		toReturn[0] = articleID.toString();
		toReturn[1] = CoreBase64.decode(resultFromSQL.getString("post_title"));
		toReturn[2] = resultFromSQL.getString("post_date");
		toReturn[3] = resultFromSQL.getString("post_edit");
		toReturn[4] = resultFromSQL.getString("post_type");
		toReturn[5] = resultFromSQL.getString("post_auth_id");
		toReturn[6] = resultFromSQL.getString("post_auth_realname");
		toReturn[7] = resultFromSQL.getString("post_auth_email");
		toReturn[8] = resultFromSQL.getString("post_auth_role");
		toReturn[9] = resultFromSQL.getString("post_auth_photo_address");
		toReturn[10] = resultFromSQL.getString("post_status");
		toReturn[11] = CoreBase64.decode(resultFromSQL.getString("post_content"));
		toReturn[12] = resultFromSQL.getString("post_photoURLs");
		toReturn[13] = resultFromSQL.getString("post_viewcounts");
		toReturn[14] = resultFromSQL.getString("post_featured");
		return toReturn;
	}

	public ResultSet getArticleAsResultSet(String articleID) throws Exception {
		return DBControl.executeQuery("select * from articles where id=" + articleID + ";");
	}

	public ResultSet getArticles(String type) throws Exception {
		return DBControl.executeQuery("select * from articles where post_type = \"" + type + "\";");
	}

	public ResultSet getArticles(String type, boolean published) throws Exception {
		if (published) return DBControl.executeQuery("select * from articles where post_type = \"" + type + "\" and post_status = \"PUBLIC\";");
		return DBControl.executeQuery("select * from articles where post_type = \"" + type + "\", ;");
	}
}
