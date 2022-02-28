import defaults.PageExceptionPayload;
import master.LogsManager;
import modules.members.CheckPermission;
import modules.members.MemberData;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

@WebServlet(name = "Logs", value = "/Logs")
public class Logs extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        try {
            PrintWriter script = response.getWriter();
            if (session.getAttribute("AMLoginData") == null) {
                session.setAttribute("AMShouldRedirect", "./userlist.jsp");
                script.println("<script>window.location.replace(\"./login.jsp\");</script>");
                return;
            }

            if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                script.println("<script>alert(\"You do not have enough permission to access this page. (Access denied)\");</script>");
                script.println("<script>window.location.replace(\"./logout.jsp\");</script>");
                return;
            }

            ResultSet rs = new LogsManager().getLogsAll();
            rs.last();
            script.println("<h1>Server Command Execution Log</h1>");
            while(true) {
                script.println(rs.getString("timestamp") + "\t" + rs.getString("userid") + "\t" + rs.getString("username") + "\t" + rs.getString("logtype") + "\t" + rs.getString("content"));
                if (!rs.previous()) break;
            }

        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "Logs Servlet"));
            response.sendRedirect("./error.jsp");
        }
    }
}
