<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="master.CoreBase64" %>
<%@ page import="master.LogsManager" %>
<%@ page import="modules.members.MemberData" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<title>Articles Written</title>
</head>
<body>
<%

PrintWriter script = response.getWriter();
if (session.getAttribute("AMLoginData") == null) {
	session.setAttribute("AMShouldRedirect", "./viewUserArticle.jsp?user=" + request.getParameter("user"));
	response.sendRedirect("./login.jsp");
}
if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
	LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for viewUserArticle");
	script.println("<script>alert(\"You do not have enough permission to access this page. (Access denied)\");</script>");
	script.println("<script>window.location.replace(\"./index.jsp\");</script>");
	return;
}else if (request.getParameter("user") == null) {
	script.println("<script>alert(\"Parameter is not specified. Unable to proceed.\");</script>");
	script.println("<script>window.location.replace(\"./index.jsp\");</script>");
	return;
}
String body = "";
String[] outerQueryKey = {"post_status=\"PENDING\"", "post_status=\"PUBLIC\"", "post_status=\"DELETED\"", "post_status=\"REJECT\""};
String[] titles = {
	"Waiting for approval",
	"Published",
	"Deleted",
	"Rejected",
};

ResultSet[] sets = new ResultSet[outerQueryKey.length];
String author = request.getParameter("user");
int index = 0;
for(int outer = 0; outer < outerQueryKey.length; outer++) {
	String[] queryRequests = {"post_auth_id=\"" + author + "\"", outerQueryKey[outer]};
	sets[index] = new AManagement().filterArticles(queryRequests);
	index++;
}

session.setAttribute("AMViewName", author);

body += ("<h1 style=\"padding: 20px\">Articles written by " + author + "</h1>");
for(int i = 0; i < sets.length; i++) {
	sets[i].last();
	if (sets[i].getRow() > 0) {
		sets[i].first();
		body += ("<div>");
		body += ("<h2 style=\"padding: 20px\">" + titles[i] + "</h2><hr>");
		while(true) {
			body += ("<a href=./articleView.jsp?id=" + sets[i].getString("id") + " style=\"padding: 20px\">" + "[" + sets[i].getString("post_type") + "]" + CoreBase64.decode(sets[i].getString("post_title")) + "</a><p>\n</p>");
			body += ("<p>\n\n\n\n</p>");
		    if (!sets[i].next()) break;
		}
		body += ("</div>");
	}
}
body += ("<a>End of list</a>");

%>

<%@ include file="./html/header.jsp" %>
<%=body%>
<%@ include file="./html/footer.jsp" %>
</body>
</html>