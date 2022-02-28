<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.MailSender" %>
<%@ page import="master.LogsManager" %>
<%@ page import="modules.members.MemberData" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Amnesty PLUS - Write Mail</title>
</head>
<body>
	<h3>Writing mail to: <%=request.getParameter("user")%></h3>
	<form action="writemail.jsp" method="POST">
		<div class="form-group">
			<input required type="hidden" name="user" id="user" value="<%=request.getParameter("user")%>"/><br>
			<input required placeholder="Subject" type="text" name="subject" id="subject" size="72"/><br>
			<textarea required placeholder="Content" name="content" id="content" cols="70" rows="30"></textarea><br>
			<input type="submit" class="btn btn-lg btn-white float-lg-right animated fadeIn" data-appear-anim-style="fadeIn" value="Send"/>
		</div>
	</form>

<%
if (session.getAttribute("AMLoginData") == null) {
	session.setAttribute("AMShouldRedirect", "./writemail.jsp");
	response.sendRedirect("./login.jsp");
	return;
}

String address = request.getParameter("user");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

PrintWriter script = response.getWriter();
if (address == null) {
	script.println("<script>alert(\"Invalid access.\");");
	script.println("window.location.replace(\"./index.jsp\");</script>");
}
if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
	LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for writemail");
	script.println("<script>alert(\"Sorry, you do not have access to this page.\");");
	script.println("window.location.replace(\"./index.jsp\");</script>");
}else if (subject != null){
	new MailSender().sendEmailAsHQ(address , subject, content, true);
	script.println("<script>alert(\"Mail sent to " + address + "\");window.location.replace(\"./userlist.jsp\");</script>");
}

%>

</body>
<script>
function findGetParameter(parameterName) {
    var result = null,
        tmp = [];
    var items = location.search.substr(1).split("&");
    for (var index = 0; index < items.length; index++) {
        tmp = items[index].split("=");
        if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
    }
    return result;
}
var params = findGetParameter("username"); 
document.getElementById('recipient').value = params;
</script>
</html>