<%@ page import="master.CoreBase64" %>
<%@ page import="master.DBControl" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="defaults.PageExceptionPayload" %><%--
  Created by IntelliJ IDEA.
  User: hoyounsong
  Date: 2021/04/23
  Time: 1:34 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String queries = request.getParameter("query");
    queries = CoreBase64.decode(queries);
    try {
        ResultSet rs = DBControl.executeQuery(queries);
        rs.last();
        for (int i = 0;; i++) {

            if(!rs.previous()) break;
        }
    } catch (Exception e) {
        session.setAttribute("AMError", new PageExceptionPayload(e, "ajaxsrc/searchresult.jsp"));
        response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
    }
%>