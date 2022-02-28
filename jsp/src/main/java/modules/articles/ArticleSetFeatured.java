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

@WebServlet(name = "ArticleSetFeatured", value = "/ArticleSetFeatured")
public class ArticleSetFeatured extends HttpServlet {
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
                String articleTitles = CoreBase64.decode(set.getString("post_title"));
                MailSender ms = new MailSender();

                if (request.getParameter("bool").equals("true")) {
                    DBControl.executeQuery("update articles set post_featured=1 where id=" + request.getParameter("id") + ";");

                    LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "INFO", "Article \\\"" + articleTitles + "\\\" from " + request.getParameter("user") + " is nominated for featured article.");
                    String message = "[large]=Article Nominated\n"
                            + "Your article " + articleTitles + " is elected as the featured article.";
                    set.first();
//                    ms.sendEmailAsHQ(set.getString("post_auth_email"), "Your article became a featured article.", message, true);
                    response.getWriter().println("<script>alert(\"Article is elected as featured article.\");");
                    response.getWriter().println("window.location.replace(\"./userlist.jsp\");</script>");
                }else{
                    DBControl.executeQuery("update articles set post_featured=0 where id=" + request.getParameter("id") + ";");

                    LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "INFO", "Article \\\"" + articleTitles + "\\\" from " + request.getParameter("user") + " is removed from featured list.");
                    String message = "[large]=Article normalized\n"
                            + "Your article " + articleTitles + " is removed from the featured articles list.";
                    set.first();
//                    ms.sendEmailAsHQ(set.getString("post_auth_email"), "Your article is removed from featured articles.", message, true);
                    response.getWriter().println("<script>alert(\"Article is removed from featured articles.\");");
                    response.getWriter().println("window.location.replace(\"./userlist.jsp\");</script>");
                }
            } else {
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for ArticleSetFeatured Servlet");
                response.getWriter().println("<script>alert('Permission denied.'); window.history.back();</script>");
            }
        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "ArticleSetFeatured Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }
}
