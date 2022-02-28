package modules.members;

import defaults.PageExceptionPayload;
import master.LogsManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

@WebServlet(name = "AccountRecovery", value = "/AccountRecovery")
public class AccountRecovery extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("Access not allowed.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (request.getParameter("inputfield") != null) {
                PrintWriter script = response.getWriter();
                IForgot pwr = new IForgot();
                if (request.getParameter("inputfield").contains("@")) {
                    int exitcode = pwr.recoverWithMail(request.getParameter("inputfield"));
                    LogsManager.addLog("INFO", "Recovery requested: " + request.getParameter("inputfield"));
                    if (exitcode == 0) {
                        LogsManager.addLog("INFO", "Recovery request exit success.");
                        script.println("<script>alert(\"Recovery mail sent to: " + request.getParameter("inputfield") + ". Please check your spam mail box too, if you do not see it in inbox.\");</script>");
                        script.println("<script>window.location.replace(\"" + request.getParameter("redirect") + "\");</script>");
                    } else if (exitcode == 1) {
                        LogsManager.addLog("ERROR", "No user with such mail address.");
                        script.println("<script>alert(\"Sorry, there is no user with such mail address. Please check again.\");</script>");
                        script.println("<script>window.history.back();</script>");
                    } else {
                        LogsManager.addLog("ERROR", "Recovery request error: " + exitcode);
                        script.println("<script>alert(\"Sorry, there was an error.\");</script>");
                        script.println("<script>window.location.replace(\"./index.jsp\");</script>");
                    }
                } else {
                    String exitdata = pwr.recoverWithUsername(request.getParameter("inputfield"));
                    LogsManager.addLog("INFO", "Recovery requested for: " + request.getParameter("inputfield"));
                    if (exitdata == null) {
                        LogsManager.addLog("ERROR", "No user with such ID.");
                        script.println("<script>alert(\"Sorry, there is no user with such user ID. Please check again.\");</script>");
                        script.println("<script>window.history.back();</script>");
                    } else if (exitdata.contains("@")) {
                        LogsManager.addLog("INFO", "Recovery request exit success.");
                        script.println("<script>alert(\"Recovery mail sent to: " + exitdata + ". Please check your spam mail box too, if you do not see it in inbox.\");</script>");
                        script.println("<script>window.location.replace(\"" + request.getParameter("redirect") + "\");</script>");
                    } else {
                        LogsManager.addLog("ERROR", "Recovery request error: " + exitdata);
                        script.println("<script>alert(\"Sorry, there was an error.\");</script>");
                        script.println("<script>window.location.replace(\"./index.jsp\");</script>");
                    }
                }
            }
        } catch (Exception e) {
            request.getSession().setAttribute("AMError", new PageExceptionPayload(e, "AccountRecovery Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }
}
