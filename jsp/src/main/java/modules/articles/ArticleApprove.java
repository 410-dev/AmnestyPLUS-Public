package modules.articles;

import defaults.PageExceptionPayload;
import master.DBControl;
import master.CoreBase64;
import master.LogsManager;
import master.MailSender;
import modules.members.CheckPermission;
import modules.members.MemberData;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.ResultSet;

@WebServlet(name = "ArticleApprove", value = "/ArticleApprove")
public class ArticleApprove extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            if (session.getAttribute("AMLoginData") == null) {
                session.setAttribute("AMShouldRedirect", "./ArticleAllApprove?user=" + request.getParameter("username"));
                response.sendRedirect("./login.jsp");
            }
            if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                AManagement amanager = new AManagement();
                ResultSet set = amanager.getArticleAsResultSet(request.getParameter("id"));
                set.first();

                DBControl.executeQuery("update articles set post_status=\"PUBLIC\" where id=" + request.getParameter("id") + ";");
                String articleTitles = CoreBase64.decode(set.getString("post_title"));
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "INFO", "Article \\\"" + articleTitles + "\\\" from " + request.getParameter("user") + " is published.");

                MailSender ms = new MailSender();
                String message = "[large]=Article Published\n"
                        + "Congratulations! Your article is published: "
                        + articleTitles;
                set.first();
//                ms.sendEmailAsHQ(set.getString("post_auth_email"), "Your article is published.", message, true);
                response.getWriter().println("<script>alert(\"Article is published.\");");
                response.getWriter().println("window.location.replace(\"./userlist.jsp\");</script>");
            } else {
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for ArticleApprove Servlet");
                response.getWriter().println("<script>alert('Permission denied.'); window.history.back();</script>");
            }
        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "ArticleApprove Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }
}
