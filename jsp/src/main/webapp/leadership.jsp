<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="master.HTMLData" %>
<%@ page import="modules.members.Users" %>
<%@ page import="defaults.PageExceptionPayload" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<title>Members</title>
</head>
<body>

<%@ include file="./pagemodules/members/style.html" %>
<%@ include file="./html/header.jsp" %>
<%=HTMLData.CONTAINER_START%>

<%
	try{
		String[] types = {"Co-Founder", "Senior Advisor", "Director of Editing Department", "Chief Editor", "Communication Department", "Director of Youth Activists Department", "Recruitment Coordinator", "IT Department"};
		for (int i = 0; i < types.length; i++) {
			ResultSet rs = new Users().getSimilarUserData("category", types[i], true, "category", "-NL");
			if (rs != null) {
				rs.first();
%>

<%=HTMLData.CONTAINER_START%>
<%=HTMLData.MEMBER_TITLE_START%>
<%=types[i].replace("Director of ", "")%>
<%=HTMLData.MEMBER_TITLE_END%>

<% while(true) { %>
<jsp:include page="pagemodules/members/element.jsp" flush="false">
	<jsp:param name="photoAddress" value="<%=rs.getString("photoAddress")%>"/>
	<jsp:param name="realname" value="<%=rs.getString("realname")%>"/>
	<jsp:param name="userrole" value="<%=rs.getString("userrole")%>"/>
	<jsp:param name="bio" value="<%=rs.getString("bio")%>"/>
</jsp:include>

<% if (!rs.next()) break; %>
<%}%>
<%=HTMLData.CONTAINER_END%>
<%}
}
}catch(Exception e) {
	session.setAttribute("AMError", new PageExceptionPayload(e, "leadership.jsp"));
	response.sendRedirect("./error.jsp");
}
%>

<%=HTMLData.CONTAINER_END%>
<%@ include file="./html/footer.jsp" %>

</body>
</html>