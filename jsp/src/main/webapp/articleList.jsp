<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.CoreBase64" %>
<%@ page import="master.HTMLData" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="master.DBControl" %>
<%@ page import="modules.members.MemberData" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<title>Articles</title>
</head>
<body>
<%
	String body = "";
	String rejected = "";

	if (session.getAttribute("AMLoginData") == null) {
		session.setAttribute("AMShouldRedirect", "./articleList.jsp");
		response.sendRedirect("./login.jsp");
	}

	if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
		response.getWriter().println("<script>alert('You do not have enough permission.');window.history.back();</script>");
		return;
	}
	ResultSet queryData = null;
	try{
		queryData = DBControl.executeQuery("select * from articles where post_status = \"PENDING\";");
		while(queryData.next()) {
			body += "<div>\n";
			body += "<a href=./articleView.jsp?id=" + queryData.getString("id") + ">" + CoreBase64.decode(queryData.getString("post_title")) + "   by " + queryData.getString("post_auth_realname") + "</a><p>\n</p>\n";
			body += "<p>\n\n\n\n</p>";
			body += "</div>\n";
		}
		queryData = DBControl.executeQuery("select * from articles where post_status = \"REJECT\";");
		while(queryData.next()) {
			rejected += "<div>\n";
			rejected += "<a href=./articleView.jsp?id=" + queryData.getString("id") + ">" + CoreBase64.decode(queryData.getString("post_title")) + "   by " + queryData.getString("post_auth_realname") + "</a><p>\n</p>\n";
			rejected += "<p>\n\n\n\n</p>";
			rejected += "</div>\n";
		}
	}catch(Exception e) {
		session.setAttribute("AMError", new PageExceptionPayload(e, "articleList.jsp"));
		response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
		response.sendRedirect("./error.jsp");
	}
%>

<%@ include file="./html/header.jsp" %>
<%=HTMLData.CONTAINER_START%>
<h1>Waiting List</h1>
<%=body%>
<br><br>
<h1>Rejected</h1>
<%=rejected%>
<a>End of list</a>
<%=HTMLData.CONTAINER_END%>
<%@ include file="html/footer.jsp"%>
</body>
</html>