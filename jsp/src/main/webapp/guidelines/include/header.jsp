<%@ page import="modules.members.CheckPermission" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="modules.members.MemberData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="bloc bgc-electric-yellow l-bloc " style="background-color: #fcf060;" id="bloc-0">
    <div class="container bloc-lg bloc-sm-lg">
        <div class="row">
            <div class="col">
                <h1 class="mg-clear h1-style mx-auto d-block text-lg-center tc-black">
                    Amnesty PLUS Staff Guidelines
                </h1>
            </div>
        </div>
    </div>
</div>

<%
    try {
        PrintWriter script = response.getWriter();
        if (session.getAttribute("AMLoginData") == null) {
            session.setAttribute("AMShouldRedirect", "guidelines/index.jsp");
            script.println("<script>window.location.replace(\"/login.jsp\");</script>");
            return;
        }

        if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(400)) {
            script.println("<script>alert(\"You do not have enough permission to access this page. (Access denied)\");</script>");
            script.println("<script>window.location.replace(\"/logout.jsp\");</script>");
            return;
        }
    }catch(Exception e) {
        session.setAttribute("AMError", new PageExceptionPayload(e, "Guidelines"));
        response.sendRedirect("./error.jsp");
    }
%>