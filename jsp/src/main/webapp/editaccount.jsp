<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="master.HTMLData" %>
<%@ page import="modules.members.Users" %>
<%@ page import="master.LogsManager" %>
<%@ page import="modules.members.MemberData" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<title>Edit Account</title>
</head>
<body>


<%
PrintWriter script = response.getWriter();

boolean ownerAccess = false;
boolean adminAccess = false;
if(session.getAttribute("AMLoginData") == null) {
	ownerAccess = false;
	adminAccess = false;
	session.setAttribute("AMShouldRedirect", "./editaccount.jsp?username=" + request.getParameter("username"));
	response.sendRedirect("./login.jsp");
}else{
	if (((MemberData) session.getAttribute("AMLoginData")).getUsername().equals(request.getParameter("username"))) {
		ownerAccess = true;
		adminAccess = false;
	}else if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
		ownerAccess = false;
		adminAccess = true;
	}else{
		ownerAccess = false;
		adminAccess = false;
	}
}


String username = request.getParameter("username");
if (!ownerAccess && !adminAccess) {
	if(session.getAttribute("AMLoginData") == null) LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for editaccount, with request of " + username);
	else  {
		LogsManager.addLog("WARNING", "Access refused for editaccount, because the accessed identity is null.");
	}
	script.println("<script>alert(\"Invalid access.\");");
    script.println("window.location.replace(\"./index.jsp\");</script>");
   	return;
}

if (username == null) username = ((MemberData) session.getAttribute("AMLoginData")).getUsername();

Users user = new Users();
ResultSet userDataSet = user.getUserData("username", username);
String loginAttemptData = "";
if (adminAccess) loginAttemptData = "<p style=\"text-align:center;\">Login Attempts: <b>" + userDataSet.getString("passattempt") + "</b></p>";

String buttonData = "";
if (ownerAccess) {
	buttonData += "<form action=\"./changepassword.jsp\" method=\"POST\" style=\"padding: 4px;text-align:center;\">\n";
	buttonData += "	<input type=\"submit\" value=\"Change Password\" style=\"display: inline-block; position: relative;\"/>\n";
	buttonData += "</form>";
	buttonData += "<form action=\"./viewUserArticle.jsp\" method=\"POST\" style=\"padding: 4px;text-align:center;\">";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>";
	buttonData += "	<input class=\"button\" type=\"submit\" value=\"My Articles\" style=\"display: inline-block; position: relative;\"/>";
	buttonData += "</form>";
	buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px;text-align:center;\">\n";
	buttonData += "	<input type=\"hidden\" name=\"key\" value=\"userrole\"/>\n";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
	buttonData += "<select required name=\"newData\">\n"
			+ "		   <option value=\"Co-Founder\">Co-Founder</option>\n"
			+ "		   <option value=\"Senior Advisor\">Senior Advisor</option>\n"
			+ "		   <option value=\"IT Department\">IT Department</option>\n"
			+ "		   <option value=\"Chief Editor\">Chief Editor</option>\n"
			+ "		   <option value=\"Director of Editing Department\">Director of Editing Department</option>\n"
			+ "		   <option value=\"Division A Editor\">Division A Editor</option>\n"
			+ "		   <option value=\"Division B Editor\">Division B Editor</option>\n"
			+ "		   <option value=\"Division C Editor\">Division C Editor</option>\n"
			+ "		   <option value=\"Division D Editor\">Division D Editor</option>\n"
			+ "		   <option value=\"Director of Youth Activists Department\">Director of Youth Activists Department</option>\n"
			+ "		   <option value=\"Youth Activist\">Youth Activist</option>\n"
			+ "		   <option value=\"Communication Department\">Communication Department</option>\n"
			+ "		 </select>";
	buttonData += "	<input type=\"submit\" value=\"Change Role\" style=\"display: inline-block; position: relative;\"/>\n";
	buttonData += "</form>";
	buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px;text-align:center;\">";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>";
	buttonData += "	<input type=\"hidden\" name=\"key\" value=\"bio\"/>";
	buttonData += " <input type=\"text\" name=\"newData\" placeholder=\"Paste your new bio here\"/>";
	buttonData += "	<input class=\"button\" type=\"submit\" value=\"Update Bio\" style=\"display: inline-block; position: relative;\"/>";
	buttonData += "</form>";
}else if(adminAccess) {
	buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px;text-align:center;\">\n";
	buttonData += "	<input type=\"hidden\" name=\"key\" value=\"userrole\"/>\n";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
	buttonData += "<select required name=\"newData\">\n"
			+ "		   <option value=\"Co-Founder\">Co-Founder</option>\n"
			+ "		   <option value=\"Senior Advisor\">Senior Advisor</option>\n"
			+ "		   <option value=\"IT Department\">IT Department</option>\n"
			+ "		   <option value=\"Chief Editor\">Chief Editor</option>\n"
			+ "		   <option value=\"Director of Editing Department\">Director of Editing Department</option>\n"
			+ "		   <option value=\"Division A Editor\">Division A Editor</option>\n"
			+ "		   <option value=\"Division B Editor\">Division B Editor</option>\n"
			+ "		   <option value=\"Division C Editor\">Division C Editor</option>\n"
			+ "		   <option value=\"Division D Editor\">Division D Editor</option>\n"
			+ "		   <option value=\"Director of Youth Activists Department\">Director of Youth Activists Department</option>\n"
			+ "		   <option value=\"Youth Activist\">Youth Activist</option>\n"
			+ "		   <option value=\"Communication Department\">Communication Department</option>\n"
			+ "		 </select>";
	buttonData += "	<input type=\"submit\" value=\"Change Role\" style=\"display: inline-block; position: relative;\"/>\n";
	buttonData += "</form>";
	buttonData += "<form action=\"AccountDelete\" method=\"POST\" style=\"padding: 4px;text-align:center;\">";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>";
	buttonData += "	<input class=\"button\" type=\"submit\" value=\"Delete account\" style=\"display: inline-block; position: relative;\"/>";
	buttonData += "</form>";
	buttonData += "<form action=\"./viewUserArticle.jsp\" method=\"POST\" style=\"padding: 4px; text-align:center;\">";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>";
	buttonData += "	<input class=\"button\" type=\"submit\" value=\"Articles by this person\" style=\"display: inline-block; position: relative;\"/>";
	buttonData += "</form>";
	buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px;text-align:center;\">\n";
	buttonData += "	<input type=\"hidden\" name=\"key\" value=\"permission\"/>\n";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
	buttonData += "	<input type=\"text\" placeholder=\"New Permission Data\" name=\"newData\"/>\n";
	buttonData += "	<input type=\"submit\" value=\"Change Permission\" style=\"display: inline-block; position: relative;\"/>\n";
	buttonData += "</form>";
	buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px;text-align:center;\">\n";
	buttonData += "	<input type=\"hidden\" name=\"key\" value=\"strikes\"/>\n";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
	buttonData += "	<input type=\"number\" placeholder=\"Strikes\" name=\"newData\"/>\n";
	buttonData += "	<input type=\"submit\" value=\"Change Strikes\" style=\"display: inline-block; position: relative;\"/>\n";
	buttonData += "</form>";
	buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px;text-align:center;\">\n";
	buttonData += "	<input type=\"hidden\" name=\"key\" value=\"status\"/>\n";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
	buttonData += "<select required name=\"newData\">\n"
			+ "		   <option value=\"NORMAL\">Normal</option>\n"
			+ "		   <option value=\"BANNED\">Banned</option>\n"
			+ "		   <option value=\"LOCKED\">Locked</option>\n"
			+ "		   <option value=\"PENDING\">Pending</option>\n"
			+ "		 </select>";
	buttonData += "	<input type=\"submit\" value=\"Change Account Status\" style=\"display: inline-block; position: relative;\"/>\n";
	buttonData += "</form>";
	buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px; text-align:center;\">\n";
	buttonData += "	<input type=\"hidden\" name=\"key\" value=\"passattempts\"/>\n";
	buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
	buttonData += "	<input type=\"text\" placeholder=\"Login Attempts\" name=\"newData\"/>\n";
	buttonData += "	<input type=\"submit\" value=\"Change Login Attempts\" style=\"display: inline-block; position: relative;\"/>\n";
	buttonData += "</form>";
	String editorRole = userDataSet.getString("userrole");
	if (editorRole.endsWith("Editor")) {
		buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px; text-align:center;\">\n";
		buttonData += "	<input type=\"hidden\" name=\"key\" value=\"userrole\"/>\n";
		buttonData += "	<input type=\"hidden\" name=\"newData\" value=\"" + editorRole + ", Task Force\"/>\n";
		buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
		buttonData += "	<input type=\"submit\" value=\"Promote to Task Force\" style=\"display: inline-block; position: relative;\"/>\n";
		buttonData += "</form>";
	}else if (editorRole.endsWith("Task Force")) {
		buttonData += "<form action=\"ChangeAccountData\" method=\"POST\" style=\"padding: 4px; text-align:center;\">\n";
		buttonData += "	<input type=\"hidden\" name=\"key\" value=\"userrole\"/>\n";
		buttonData += "	<input type=\"hidden\" name=\"newData\" value=\"" + editorRole.replace(", Task Force", "") + "\"/>\n";
		buttonData += "	<input type=\"hidden\" name=\"user\" value=\"" + username + "\"/>\n";
		buttonData += "	<input type=\"submit\" value=\"Demote form Task Force\" style=\"display: inline-block; position: relative;\"/>\n";
		buttonData += "</form>";
	}
}
%>

<%@include file="html/header.jsp"%>
<%=HTMLData.CONTAINER_START%>
<%=HTMLData.USER_ELEMENT_IMAGE_START + userDataSet.getString("photoAddress") + HTMLData.USER_ELEMENT_IMAGE_END%>
<h2 style="text-align:center;"><%=userDataSet.getString("realname")%></h2>
<p style="text-align:center;">User ID: <b><%=username%></b></p>
<p style="text-align:center;">Permission: <b><%=userDataSet.getString("permission")%></b></p>
<p style="text-align:center;">Email: <b><%=userDataSet.getString("email")%></b></p>
<p style="text-align:center;">Role: <b><%=userDataSet.getString("userrole")%></b></p>
<p style="text-align:center;">Strikes: <b><%=userDataSet.getString("strikes")%></b></p>
<p style="text-align:center;">Bio:<b><%=userDataSet.getString("bio")%></b></p>
<%=loginAttemptData%>
<%=HTMLData.CONTAINER_END%>
<%=buttonData%>
<%@ include file="./html/footer.jsp" %>
</body>
</html>