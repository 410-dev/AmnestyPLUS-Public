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
import java.sql.ResultSet;

@WebServlet(name = "ChangeAccountData", value = "/ChangeAccountData")
public class ChangeAccountData extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("remote_approve").equals("1")) {
            HttpSession session = request.getSession();
            if (session.getAttribute("AMLoginData") == null) {
                session.setAttribute("AMShouldRedirect", "./ChangeAccountData?remote_approve=1&&data=" + request.getParameter("data"));
                response.sendRedirect("./login.jsp");
            }
            try {
                if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                    response.getWriter().println("<script>alert('Permission denied.'); window.history.back();</script>");
                    return;
                }
                Users useragent = new Users();
                ResultSet rs = DBControl.executeQuery("select * from members where recoveryLink=\"" + request.getParameter("data") + "\";");
                rs.first();
                String username = rs.getString("username");
                useragent.setUserData(username, "status", "NORMAL");
                useragent.setUserData(username, "recoveryLink", "");
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "INFO", "Approved " + username + " remotely.");
                response.getWriter().println("<script>alert('Account " + username + " approved.');window.location.replace(\"./userlist.jsp\");</script>");
            }catch(Exception e) {
                if (e.toString().contains("Current position is before the first row")) {
                    response.getWriter().println("<script>alert('Unable to find user - Perhaps already approved.');");
                    response.getWriter().println("window.location.replace('./adminterminal.jsp');</script>");
                    return;
                }else {
                    session.setAttribute("AMError", new PageExceptionPayload(e, "ChangeAccountData Servlet"));
                    response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
                }
            }
        }else{
            response.getWriter().println("Access not allowed.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try{
            String targetUser = request.getParameter("user");
            String newData  = request.getParameter("newData");
            String key = request.getParameter("key");
            if (session.getAttribute("AMLoginData") == null) {
                session.setAttribute("AMShouldRedirect", "./ChangeAccountData?user=" + targetUser + "&newData=" + newData + "&key=" + key);
                response.sendRedirect("./login.jsp");
            }
            if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200) || targetUser.equals(((MemberData) session.getAttribute("AMLoginData")).getUsername())) {
                try{
                    new Users().setUserData(targetUser, key, newData);
                    if (key.equals("userrole") && !newData.contains("Task Force")) {
                        new Users().setUserData(targetUser, "category", newData);
                    }else if (key.equals("category")) {
                        new Users().setUserData(targetUser, "userrole", newData);
                    }
                    LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "INFO", "Changed user data - ID: " + targetUser + ", Key: " + key + ", Value: " + newData);
                    response.getWriter().println("<script>alert(\"Data successfully updated.\");window.history.back();</script>");
                    return;
                }catch(Exception e) {
                    LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "ERROR", e.toString());
                    response.getWriter().println("<script>alert(\"There was an error while processing your request.\");window.history.back();</script>");
                }
            }else{
                LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for ChangeAccountData Servlet");
                response.getWriter().println("<script>alert('Permission denied.'); window.history.back();</script>");
            }
        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "ChangeAccountData"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }

}
