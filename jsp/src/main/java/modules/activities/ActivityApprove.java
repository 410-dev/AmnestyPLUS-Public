package modules.activities;

import defaults.PageExceptionPayload;
import master.DBControl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.ResultSet;

@WebServlet(name = "ActivityApprove", value = "/ActivityApprove")
public class ActivityApprove extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{

        }catch(Exception e) {
            request.getSession().setAttribute("AMError", new PageExceptionPayload(e, "Login"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }
}
