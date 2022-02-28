package modules.articles;

import defaults.PageExceptionPayload;
import master.CoreBase64;
import master.DBControl;
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

@WebServlet(name = "ArticleAllApprove", value = "/ArticleAllApprove")
public class ArticleAllApprove extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        HttpSession session = request.getSession();
        try {
            if (session.getAttribute("AMLoginData") == null) {
                session.setAttribute("AMShouldRedirect", "./ArticleAllApprove?user=" + request.getParameter("user"));
                response.sendRedirect("./login.jsp");
            }
            if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                AManagement amanager = new AManagement();
                String[] conditions = {"post_status=\"PENDING\"", "post_auth_id=\"" + request.getParameter("user") + "\""};
                ResultSet set = amanager.filterArticles(conditions);
                set.first();
                String articleTitles = "";
                while (set != null) {
                    DBControl.executeQuery("update articles set post_status=\"PUBLIC\" where id=" + set.getString("id") + ";");
                    articleTitles += CoreBase64.decode(set.getString("post_title")) + ", ";
                    if (!set.next()) break;
                }
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "INFO", "All articles from " + request.getParameter("user") + " are published.");
                response.getWriter().println("<script>alert(\"Articles are published.\");");
                response.getWriter().println("window.location.replace(\"./userlist.jsp\");</script>");

                MailSender ms = new MailSender();
                String message = "[large]=Articles Published\n"
                        + "Congratulations! Your articles are published:\n"
                        + articleTitles.replace(", ", "\n");
                set.first();
//                ms.sendEmailAsHQ(set.getString("post_auth_email"), "Your articles are published.", message, true);
            } else {
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for ArticleAllApprove Servlet");
                response.getWriter().println("<script>alert('Permission denied.'); window.history.back();</script>");
            }
        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "ArticleAllApprove Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }
}
