package modules.members;

import defaults.PageExceptionPayload;
import master.DBControl;
import master.LogsManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

@WebServlet(name = "AccountDelete", value = "/AccountDelete")
public class AccountDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("Access not allowed.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try{
            if (session.getAttribute("AMLoginData") == null) {
                session.setAttribute("AMShouldRedirect", "./AccountDelete?user=" + request.getParameter("user"));
                response.sendRedirect("./login.jsp");
            }
            if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                    LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "INFO", "Deleted account: " + request.getParameter("user"));
                    DBControl.executeQuery("delete from members where username=\"" + request.getParameter("user") + "\";");
                    response.getWriter().println("<script>alert(\"Account " + request.getParameter("user") + " deleted.\");window.location.replace(\"./userlist.jsp\");</script>");
                }else{
                    LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for AccountDelete Servlet");
                    response.getWriter().println("<script>alert(\"Access denied.\");window.location.replace(\"./index.jsp\");</script>");
                }
            }else{
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for AccountDelete Servlet");
                response.getWriter().println("<script>alert('Permission denied.'); window.history.back();</script>");
            }
        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "AccountDelete Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }
}
