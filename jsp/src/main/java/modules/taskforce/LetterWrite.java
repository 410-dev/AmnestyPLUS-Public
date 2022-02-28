package modules.taskforce;

import com.oreilly.servlet.MultipartRequest;
import defaults.PageExceptionPayload;
import defaults.activity.Activity;
import defaults.taskforce.TaskForceData;
import master.CoreBase64;
import master.DBControl;
import master.LogsManager;
import modules.members.MemberData;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class LetterWrite extends HttpServlet {
    public void task(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi, String filename) throws Exception {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        PrintWriter script = response.getWriter();
        if (multi.getParameter("recipient") != null) {
            try {
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime currentTime = LocalDateTime.now();
                TaskForceData payload = new TaskForceData();
                payload.timestamp = timeFormatter.format(currentTime);
                payload.filename = filename;
                payload.countryCode = multi.getParameter("countrycode");
                payload.type = "post";
                payload.recipient = multi.getParameter("recipient");
                ResultSet rs = DBControl.executeQuery("select * from taskforce where type=\"nation\" and countrycode=\"" + multi.getParameter("countrycode") + "\";");
                rs.first();
                payload.country = rs.getString("country");
                if (multi.getParameter("writeas") == null) {
                    payload.author = ((MemberData) session.getAttribute("AMLoginData")).getRealname();
                }else{
                    if (multi.getParameter("writeas").contains(" ")) {
                        payload.author = multi.getParameter("writeas");
                    }else {
                        try {
                            rs = DBControl.executeQuery("select * from members where username = \"" + multi.getParameter("writeas") + "\";");
                            rs.first();
                            payload.author = rs.getString("realname");
                        } catch (Exception ee) {
                            if (ee.toString().contains("position"))
                                script.println("<script>alert('Error: No such user');window.location.replace('./uploadTaskForce.jsp');</script>");
                            return;
                        }
                    }
                }
                addContentToDB(payload);
                LogsManager.addLog("localsys", "@" + payload.author, "INFO", "Letter to \\\"" + payload.recipient + "\\\" added.");
                script.println("<script>alert('Post was successful.');window.location.replace(\"uploadTaskforce.jsp\");</script>");
            } catch (Exception e) {
                session.setAttribute("AMError", new PageExceptionPayload(e, "LetterWrite Servlet"));
                response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
            }
        }else{
            response.getWriter().println("<script>alert('Error: Recipient is not properly declared.'); window.location.replace('uploadTaskforce.jsp');</script>");
        }
    }

    private void addContentToDB(TaskForceData payload) throws Exception {
        String queryStatement = "insert into taskforce(type, recipient, country, author, countrycode, filename, timestamp) values(\"";
        queryStatement += payload.type + "\", \"";
        queryStatement += payload.recipient + "\", \"";
        queryStatement += payload.country + "\", \"";
        queryStatement += payload.author + "\", \"";
        queryStatement += payload.countryCode + "\", \"";
        queryStatement += payload.filename + "\", \"";
        queryStatement += payload.timestamp + "\");";
        DBControl.executeQuery(queryStatement);
    }
}
