package modules.taskforce;

import defaults.taskforce.TaskForceData;
import master.DBControl;

import java.sql.ResultSet;
import java.util.ArrayList;

public class GetTaskForceData {
    public Object[] getAllTaskForceDataAsObjectArray(String type) throws Exception {
        ResultSet rs = DBControl.executeQuery("select * from taskforce where type = \"" + type + "\";");
        ArrayList<TaskForceData> activityDataList = new ArrayList<>();
        rs.last();
        while (true) {
            TaskForceData d = new TaskForceData(rs.getString("id"));
            d.loadContent();
            activityDataList.add(d);
            if (!rs.previous()) break;
        }
        return activityDataList.toArray();
    }
}
