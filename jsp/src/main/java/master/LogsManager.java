package master;

import defaults.PageExceptionPayload;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "LogsManager", value = "/LogsManager")
public class LogsManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            LogsManager.addLog(request.getParameter("userid"),
                    request.getParameter("username"),
                    request.getParameter("type"),
                    request.getParameter("content"));
        } catch (Exception e) {
            request.getSession().setAttribute("AMError", new PageExceptionPayload(e, "LogsManager Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }

    public static void addLog(String userid, String username, String type, String content) throws Exception {
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime currentTime = LocalDateTime.now();
        DBControl.executeQuery("insert into logs(timestamp, userid, username, logtype, content) values(\"" +
                timeFormatter.format(currentTime) + "\", \"" +
                userid + "\", \"" +
                username + "\", \"" +
                type + "\", \"" +
                content + "\");");
    }

    public static void addLog(String type, String content) throws Exception {
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime currentTime = LocalDateTime.now();
        DBControl.executeQuery("insert into logs(timestamp, userid, username, logtype, content) values(\"" +
                timeFormatter.format(currentTime) + "\", \"" +
                "localsys\", \"" +
                "System\", \"" +
                type + "\", \"" +
                content + "\");");
    }

    public ResultSet getLogsAll() throws Exception{
        return DBControl.executeQuery("select * from logs;");
    }
}
