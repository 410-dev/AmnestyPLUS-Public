package defaults.taskforce;

import master.DBControl;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TaskForceData {
    ResultSet rs;
    private boolean loaded = false;
    public String id = "";
    public String type = "";
    public String recipient = "";
    public String country = "";
    public String author = "";
    public String countryCode = "";
    public String filename = "";
    public String timestamp = "";

    public TaskForceData(String id) throws Exception{
        rs = DBControl.executeQuery("select * from taskforce where id=" + id + ";");
    }

    public TaskForceData() {}

    public void loadContent() throws SQLException{
        if (!loaded) {
            rs.last();
            id = rs.getString("id");
            type = rs.getString("type");
            recipient = rs.getString("recipient");
            country = rs.getString("country");
            author = rs.getString("author");
            countryCode = rs.getString("countryCode");
            filename = rs.getString("filename");
            timestamp = rs.getString("timestamp");
            loaded = false;
        }
    }
}
