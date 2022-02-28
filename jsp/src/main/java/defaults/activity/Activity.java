package defaults.activity;

import master.CoreBase64;
import master.DBControl;

import java.sql.ResultSet;

public class Activity {
    public String id = ""; // Not encoded
    public String type = ""; // Not encoded
    public String timestamp = "";
    public String title = "";
    public String description = "";
    public String timespan = "";
    public String topic = "";
    public String sponsor = "";
    public String participatelink = "";
    public String guideline = "";
    public String videolink = "";
    public String thumbnail = "";
    public String content = "";

    public Activity(){}
    public Activity(String id) throws Exception {
        loadContent(id);
    }

    public void selfEncodeToBase64() {
        timestamp = CoreBase64.encode(timestamp);
        title = CoreBase64.encode(title);
        description = CoreBase64.encode(description.replace("\n", "<br>"));
        timespan = CoreBase64.encode(timespan);
        topic = CoreBase64.encode(topic.replace("\n", "<br>"));
        sponsor = CoreBase64.encode(sponsor);
        participatelink = CoreBase64.encode(participatelink);
        guideline = CoreBase64.encode(guideline);
        videolink = CoreBase64.encode(videolink);
        thumbnail = CoreBase64.encode(thumbnail);
        content = CoreBase64.encode(content.replace("\n", "<br>"));
    }

    public void selfDecodeFromBase64() {
        timestamp = CoreBase64.decode(timestamp);
        title = CoreBase64.decode(title);
        description = CoreBase64.decode(description);
        timespan = CoreBase64.decode(timespan);
        topic = CoreBase64.decode(topic);
        sponsor = CoreBase64.decode(sponsor);
        participatelink = CoreBase64.decode(participatelink);
        guideline = CoreBase64.decode(guideline);
        videolink = CoreBase64.decode(videolink);
        thumbnail = CoreBase64.decode(thumbnail);
        content = CoreBase64.decode(content);
    }

    public void loadContent(String id) throws Exception {
        ResultSet rs =  DBControl.executeQuery("select * from activities where id = " + id + ";");
        rs.first();
        this.id = id;
        type = rs.getString("type");
        timestamp = rs.getString("timestamp");
        title = rs.getString("title");
        description = rs.getString("description");
        timespan = rs.getString("timespan");
        topic = rs.getString("topic");
        sponsor = rs.getString("sponsor");
        participatelink = rs.getString("participatelink");
        guideline = rs.getString("guideline");
        videolink = rs.getString("videolink");
        thumbnail = rs.getString("thumbnail");
        content = rs.getString("content");
    }
}
