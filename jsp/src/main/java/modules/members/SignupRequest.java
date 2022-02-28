package modules.members;

import com.oreilly.servlet.MultipartRequest;
import defaults.PageExceptionPayload;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

public class SignupRequest extends HttpServlet {
    protected void task(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi, String profilePicture) throws ServletException, IOException {
        // 0: Password No match
        // 1: Error
        // 2: Approved
        // 3: ID repitition
        // 4: Email repitition
        // 5: Injection detected
        String username = multi.getParameter("username");
        final String password = multi.getParameter("password");
        final String confirmPassword = multi.getParameter("passwordconfirmation");
        final String realname = multi.getParameter("realname");
        final String email = multi.getParameter("email");
        String userrole = multi.getParameter("role");
        String bio = multi.getParameter("bio");
        final String isLeadership = multi.getParameter("inLeadership");

        HttpSession session = request.getSession();

        if (password != null) {
            PrintWriter script = response.getWriter();

            if (username == null)
                script.println("<script>alert(\"Unable to get proper value from POST request (E:A1). This is an error. You will be redirected to main page.\");window.location.replace(\"./index.jsp\");</script>");
            if (password == null)
                script.println("<script>alert(\"Unable to get proper value from POST request (E:A2). This is an error. You will be redirected to main page.\");window.location.replace(\"./index.jsp\");</script>");
            if (confirmPassword == null)
                script.println("<script>alert(\"Unable to get proper value from POST request (E:A3). This is an error. You will be redirected to main page.\");window.location.replace(\"./index.jsp\");</script>");
            if (realname == null)
                script.println("<script>alert(\"Unable to get proper value from POST request (E:A4). This is an error. You will be redirected to main page.\");window.location.replace(\"./index.jsp\");</script>");
            if (email == null)
                script.println("<script>alert(\"Unable to get proper value from POST request (E:A5). This is an error. You will be redirected to main page.\");window.location.replace(\"./index.jsp\");</script>");
            if (userrole == null)
                script.println("<script>alert(\"Unable to get proper value from POST request (E:A6). This is an error. You will be redirected to main page.\");window.location.replace(\"./index.jsp\");</script>");
            if (bio == null || bio.equals("")) {
                script.println("<script>alert('Bio is not entered. Default value will be used.');</script>");
                bio = realname + " is a " + userrole + " of Amnesty PLUS. Please come back for future bio updates.";
            }

            try {
                if (!password.equals(confirmPassword)) {
                    script.println("<script>alert(\"Password does not match.\");</script>");
                    script.println("<script>window.history.back();</script>");
                    return;
                }
                int exitcode;

                try {
                    exitcode = new Register().addNewUser(username, password, realname, email, userrole, bio, profilePicture, isLeadership);
                }catch(Exception ee) {
                    if (ee.toString().contains("Current position is after the last row")) {
                        exitcode = 2;
                    }else{
                        session.setAttribute("AMError", new PageExceptionPayload(ee, "SignupRequest Servlet"));
                        response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
                        exitcode = 1;
                    }
                }

                script.println("<script>");
                String redirectTo = "";
                switch (exitcode) {
                    case 1:
                        script.println("alert('Sorry, there was an error while processing your request. Please try again later.');");
                        redirectTo = "window.location.replace(\"./index.jsp\");";
                        break;
                    case 2:
                        session.setAttribute("AMLoginStatus", null);
                        session.setAttribute("AMLoginAttempt", null);
                        script.println("alert('Welcome to Amnesty Plus! We need some time to approve your registration. Please check your email for further instruction.')");
                        redirectTo = "window.location.replace(\"./index.jsp\");";
                        break;
                    case 3:
                        script.println("alert('This username is already taken by other account.')");
                        redirectTo = "window.history.back();";
                        break;
                    case 4:
                        script.println("alert('This mail is already taken by other account.')");
                        redirectTo = "window.history.back();";
                        break;
                    case 5:
                        script.println("alert('You cannot have ; or # or _ or space.')");
                        redirectTo = "window.history.back();";
                        break;
                    case 6:
                        script.println("alert('Invalid mail type.')");
                        redirectTo = "window.history.back();";
                        break;
                    default:
                        script.println("alert('Sorry, program returned unknown exit code: " + exitcode + "')");
                        redirectTo = "window.location.replace(\"./index.jsp\");";
                        break;
                }
                script.println(redirectTo + "</script>");
            } catch (Exception e) {
                session.setAttribute("AMError", new PageExceptionPayload(e, "SignupRequest Servlet"));
                response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
                response.sendRedirect("./error.jsp");
            }
        }
    }
}
