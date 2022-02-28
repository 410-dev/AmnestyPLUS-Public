package modules.members;

import defaults.PageExceptionPayload;
import master.LogsManager;
import master.MailSender;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "GiveStrike", value = "/GiveStrike")
public class GiveStrike extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try{
            if (session.getAttribute("AMLoginData") == null) {
                session.setAttribute("AMShouldRedirect", "./GiveStrike?reason=" + request.getParameter("reason"));
                response.sendRedirect("./login.jsp");
            }
            final String value = request.getParameter("user");
            if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                Users useragent = new Users();
                int strikes = useragent.getUserDataInt(value, "strikes") + 1;
                if (strikes >= 3) {
                    LogsManager.addLog("INFO", "Account " + value + " is banned, because strike is now reached 3.");
                    useragent.setUserData(value, "status", "BANNED");
                }
                useragent.setUserData(value, "strikes", strikes);
                LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "INFO", "Gave strike to " + useragent.getUserDataString(value, "realname"));
                response.getWriter().println("<script>alert(\"Added a strike to " + request.getParameter("user") + ".\");window.location.replace(\"./userlist.jsp\");</script>");
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                LocalDateTime currentTime = LocalDateTime.now();
                String contents = "[large]=You have received a strike.\n"
                        + "This is a penalty given to you, because of the violation you have committed.\n"
                        + "[section]=Details\n"
                        + "Date: " + timeFormatter.format(currentTime) + "\n"
                        + "Reason: " + request.getParameter("reason") + "\n"
                        + "Recipient: " + useragent.getUserDataString(value, "realname") + "\n"
                        + "Current Strikes: " + useragent.getUserDataInt(value, "strikes") + "\n"
                        + "\n\nIf you think this is wrong, please contact to the Senior Advisors.";
                new MailSender().sendEmailAsHQ(useragent.getUserDataString(value, "email") , "You have received a strike.", contents, true);

            }else{
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for GiveStrike Servlet");
                response.getWriter().println("<script>alert(\"Access denied.\");window.location.replace(\"./index.jsp\");</script>");
            }
        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "GiveStrike Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }
}
