<%@ page import="java.sql.ResultSet" %>
<%@ page import="master.Configurations" %>
<%@ page import="master.LogsManager" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="modules.members.MemberData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Amnesty PLUS Global Pref</title>
</head>
<body>
<%
    try {
        if (session.getAttribute("AMLoginData") == null) {
            session.setAttribute("AMShouldRedirect", "./preference.jsp");
            response.sendRedirect("./login.jsp");
        }
        if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(100)) {
            LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for preference");
            response.getWriter().println("<script>alert(\"You do not have enough permission to access this page. (Access denied)\");</script>");
            response.getWriter().println("<script>window.location.replace(\"./logout.jsp\");</script>");
            return;
        }
    } catch (Exception e) {
        session.setAttribute("AMError", new PageExceptionPayload(e, "Preference"));
        response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
    }
%>
    <h1>
        Global Preference
    </h1>
    <h4>
        Configurations
        <%
            try {
                ResultSet rs = new Configurations().getAllConfigs();
                while(rs.next()) { %>

        <p>Key: <%=rs.getString("name")%> | Data: <%=rs.getString("data")%></p> <br>

        <% }
            }catch (Exception e) {
                session.setAttribute("AMError", new PageExceptionPayload(e, "preference.jsp"));
                response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
            }

        %>
    </h4>
    <p>

    </p>
    <form action="Configurations" method="POST">
        <input type="hidden" name="task" value="set">
        <input type="text" name="key" placeholder="Key">
        <input type="text" name="value" placeholder="Value">
        <input type="submit" value="Apply">
    </form>
    <form action="Configurations" method="POST">
        <input type="hidden" name="task" value="add">
        <input type="text" name="key" placeholder="Key">
        <input type="text" name="value" placeholder="Value">
        <input type="submit" value="Add">
    </form>
</body>
</html>
