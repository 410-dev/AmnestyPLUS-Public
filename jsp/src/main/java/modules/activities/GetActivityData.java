package modules.activities;

import defaults.activity.Activity;
import master.CoreBase64;
import master.DBControl;

import java.sql.ResultSet;
import java.util.ArrayList;

public class GetActivityData {
    public Activity getActivityData(String id) throws Exception {
        return new Activity(id);
    }

    public Activity[] getAllActivityData(String type) throws Exception {
        ResultSet rs =  DBControl.executeQuery("select * from activities where type = \"" + type + "\";");
        ArrayList<Activity> activityDataList = new ArrayList<>();
        while (rs.next()) activityDataList.add(getActivityData(rs.getString("id")));
        return (Activity[]) activityDataList.toArray();
    }
    public Object[] getAllActivityDataAsObjectArray(String type) throws Exception {
        ResultSet rs =  DBControl.executeQuery("select * from activities where type = \"" + type + "\";");
        ArrayList<Activity> activityDataList = new ArrayList<>();
        while (rs.next()) activityDataList.add(getActivityData(rs.getString("id")));
        return activityDataList.toArray();
    }

}
