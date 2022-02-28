<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="modules.members.Users" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="modules.members.MemberData" %>
<%! String siteversion="Release 210604"; %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/img/favicon.png">

	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css?8847">
	<link rel="stylesheet" type="text/css" href="style.css?2744">

	<title>Amnesty PLUS Admin Terminal</title>

</head>

<%
	try {
		PrintWriter script = response.getWriter();
		if (session.getAttribute("AMLoginData") == null) {
			session.setAttribute("AMShouldRedirect", "./adminterminal.jsp");
			response.sendRedirect("./login.jsp");
			return;
		}

		if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(400)) {
			script.println("<script>alert('You do not have enough permission to access this page. (Access denied)');</script>");
			script.println("<script>window.location.replace('./logout.jsp');</script>");
			return;
		}
	}catch(Exception e) {
		session.setAttribute("AMError", new PageExceptionPayload(e, "AdminTerminal Servlet"));
		response.sendRedirect("./error.jsp");
	}
%>

<body>
<!-- Main container -->
<div class="page-container">

	<!-- bloc-0 -->
	<div class="bloc bgc-electric-yellow l-bloc " style="background-color: #fcf060;" id="bloc-0">
		<div class="container bloc-lg bloc-sm-lg">
			<div class="row">
				<div class="col">
					<h1 class="mg-clear h1-style mx-auto d-block text-lg-center tc-black">
						Amnesty PLUS Administrator
					</h1>
				</div>
			</div>
		</div>
	</div>
	<!-- bloc-0 END -->

	<!-- bloc-1 -->
	<div class="bloc l-bloc" id="bloc-1">
		<div class="container bloc-lg bloc-sm-lg">
			<div class="row">
				<div class="col">
				</div>
			</div>
		</div>
	</div>
	<!-- bloc-1 END -->

	<!-- bloc-3 -->
	<div class="bloc l-bloc" id="bloc-3">
		<div class="container bloc-lg bloc-no-padding-lg">
			<div class="row">
				<div class="col">
					<a href="./index.jsp" class="a-btn a-block terminal_style">Home</a>
					<h6 class="mg-md">
						<br>
					</h6>
					<a href="./login.jsp" class="a-btn a-block terminal_style">Login Page</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./signup.jsp" class="a-btn a-block terminal_style">Sign Up Page</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./writepost.jsp" class="a-btn a-block terminal_style">Post Writing Page</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./writeactivity.jsp" class="a-btn a-block terminal_style">Activity Writing Page</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./uploadTaskforce.jsp" class="a-btn a-block terminal_style">Upload Task Force Letters</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./articleList.jsp" class="a-btn a-block terminal_style">View Article List</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./userlist.jsp" class="a-btn a-block terminal_style">User List Page</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./preference.jsp" class="a-btn a-block terminal_style">Global Preferences</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="Logs" class="a-btn a-block terminal_style">Server Logs</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./guidelines/index.jsp" class="a-btn a-block terminal_style">Staff Guidelines</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./checkSign.jsp" class="a-btn a-block terminal_style">Document Signature Check</a>
					<h6 class="mg-md">
						<br>
					</h6><a href="./logout.jsp" class="a-btn a-block terminal_style">Logout</a>
				</div>
				<div>
					<p><%=siteversion%></p>
					<hr>
					<p><%=((MemberData) session.getAttribute("AMLoginData")).getRealname()%></p>
					<hr>
					<p>Permission: <%=new Users().getUserDataInt(((MemberData) session.getAttribute("AMLoginData")).getUsername(), "permission")%></p>
				</div>
			</div>
		</div>
	</div>
	<!-- bloc-3 END -->

	<!-- ScrollToTop Button -->
	<a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 32 32"><path class="scroll-to-top-btn-icon" d="M30,22.656l-14-13-14,13"/></svg></a>
	<!-- ScrollToTop Button END-->


	<!-- bloc-4 -->
	<div class="bloc l-bloc" id="bloc-4">
		<div class="container bloc-lg bloc-sm-lg">
			<div class="row">
				<div class="col">
				</div>
			</div>
		</div>
	</div>
	<!-- bloc-4 END -->

</div>
<!-- Main container END -->



<!-- Additional JS -->
<script src="./js/bootstrap.bundle.min.js?3622"></script>
<script src="./js/blocs.min.js?9534"></script>


</body>
</html>
