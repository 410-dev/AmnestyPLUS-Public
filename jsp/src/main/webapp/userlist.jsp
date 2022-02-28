<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="master.HTMLData" %>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="modules.members.Users" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="master.LogsManager" %>
<%@ page import="modules.members.MemberData" %>
<%request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<%@ include file="pagemodules/users/style.html"%>
	<title>Amnesty PLUS Users Management</title>
</head>
<body>

<%
if (session.getAttribute("AMLoginData") == null) {
	session.setAttribute("AMShouldRedirect", "./userlist.jsp");
	response.sendRedirect("./login.jsp");
}
if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
	LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for userlist");
%>
<script>
	alert("You do not have enough permission to access this page.");
	window.location.replace("./index.jsp");
</script>
<%return;}%>

<%
	Users useragent = new Users();
	AManagement amanager = new AManagement();
	ResultSet userDataSet = null;
	if (request.getParameter("userquery") != null && request.getParameter("category") != null) {
		userDataSet = useragent.getSimilarUserData(request.getParameter("category"), request.getParameter("userquery"), false);
	}else{
		userDataSet = useragent.getAllUserData();
	}
%>

<%@ include file="./html/header.jsp" %>
<%=HTMLData.SEARCH_USER_BOX%>
<%
	boolean runWhile = true;
	while(runWhile && userDataSet != null) {
%>
	<div class="row">
	<%
		for(int i=0; i<3; i++) {
			String[] conditions = {"post_auth_id=\"" + userDataSet.getString("username") + "\"", "post_status=\"PENDING\""};
			ResultSet articles = amanager.filterArticles(conditions);
			articles.last();
			String queue = articles.getRow() + "";
	%>
		<jsp:include page="pagemodules/users/element.jsp" flush="false">
			<jsp:param name="realname" value="<%=userDataSet.getString("realname")%>"/>
			<jsp:param name="username" value="<%=userDataSet.getString("username")%>"/>
			<jsp:param name="permission" value="<%=userDataSet.getString("permission")%>"/>
			<jsp:param name="status" value="<%=userDataSet.getString("status")%>"/>
			<jsp:param name="email" value="<%=userDataSet.getString("email")%>"/>
			<jsp:param name="userrole" value="<%=userDataSet.getString("userrole")%>"/>
			<jsp:param name="strikes" value="<%=userDataSet.getString("strikes")%>"/>
			<jsp:param name="photoAddress" value="<%=userDataSet.getString("photoAddress")%>"/>
			<jsp:param name="queue" value="<%=queue%>"/>
		</jsp:include>
	<%
			if (!userDataSet.next()) {
				runWhile=false;
				break;
			}
		}%>
		<hr>
	</div>
<%}%>
<%@ include file="./html/footer.jsp" %>
</body>
</html>