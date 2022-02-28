package modules.activities;

import com.oreilly.servlet.MultipartRequest;
import defaults.PageExceptionPayload;
import defaults.activity.Activity;
import master.CoreBase64;
import master.DBControl;
import master.LogsManager;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ActivityWrite extends HttpServlet {
    public void task(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi, String thumbnail) throws Exception {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        PrintWriter script = response.getWriter();
        if (multi.getParameter("content") != null) {
            if (multi.getParameter("content").equals("")) {
                script.println("<script>alert(\"No contents written.\");window.location.replace(\"./writeactivity.jsp\");</script>");
                return;
            }

            try {
                String content = multi.getParameter("content");
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime currentTime = LocalDateTime.now();
                Activity payload = new Activity();
                payload.timestamp = timeFormatter.format(currentTime);
                payload.thumbnail = thumbnail;
                payload.title = multi.getParameter("title");
                payload.type = multi.getParameter("type");

                switch (multi.getParameter("type")) {
                    case "contest": {
                        String[] contestData = new String[6];
                        String[] contentParse = content.split("\n");
                        String[] prefixes = {"description", "time", "topic", "host", "participation", "guideline"};
                        for (int i = 0; i < prefixes.length; i++) {
                            if (contentParse[i].startsWith(prefixes[i] + "=") && !contentParse[i].replace(prefixes[i] + "=", "").equals("")) {
                                contestData[i] = contentParse[i].replace(prefixes[i] + "=", "");
                            } else {
                                script.println("<script>alert('Error: Content not declared properly.');window.location.replace(\"writeactivity.jsp\");</script>");
                                return;
                            }
                        }
                        payload.description = contestData[0];
                        payload.timespan = contestData[1];
                        payload.topic = contestData[2];
                        payload.sponsor = contestData[3];
                        payload.participatelink = contestData[4];
                        payload.guideline = contestData[5];
                        }
                        break;
                    case "video": {
                        if (content.startsWith("http://") || content.startsWith("https://")) {
                            payload.videolink = content;
                        }else if (content.startsWith("youtube.com") || content.startsWith("www.youtube.com")) {
                            payload.videolink = "https://" + content;
                        }else{
                            script.println("<script>alert('Error: Video link not declared properly.');window.location.replace(\"writeactivity.jsp\");</script>");
                            return;
                        }
                        }
                        break;
                    case "apyac": {
                        payload.content = content;
                        }
                        break;
                    default:
                        script.println("<script>alert('Error: Type not declared.');window.location.replace(\"writeactivity.jsp\");</script>");
                        return;
                }
                addContentToDB(payload);
                LogsManager.addLog("localsys", "@_ya", "INFO", "Activity article added.");
                script.println("<script>alert('Post was successful.');window.location.replace(\"writeactivity.jsp\");</script>");
            } catch (Exception e) {
                session.setAttribute("AMError", new PageExceptionPayload(e, "ActivityWrite Servlet"));
                response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
            }
        }
    }

    private void addContentToDB(Activity payload) throws Exception {
        payload.selfEncodeToBase64();
        String queryStatement = "insert into activities(type, timestamp, title, description, timespan, topic, sponsor, participatelink, guideline, videolink, thumbnail, content) values(\"";
        queryStatement += payload.type + "\", \"";
        queryStatement += payload.timestamp + "\", \"";
        queryStatement += payload.title + "\", \"";
        queryStatement += payload.description + "\", \"";
        queryStatement += payload.timespan + "\", \"";
        queryStatement += payload.topic + "\", \"";
        queryStatement += payload.sponsor + "\", \"";
        queryStatement += payload.participatelink + "\", \"";
        queryStatement += payload.guideline + "\", \"";
        queryStatement += payload.videolink + "\", \"";
        queryStatement += payload.thumbnail + "\", \"";
        queryStatement += payload.content + "\");";
        DBControl.executeQuery(queryStatement);
    }
}
