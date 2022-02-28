<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.LogsManager" %>
<%@ page import="modules.members.MemberData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="master.DBControl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="defaults.taskforce.TaskForceData" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css?874">
	<link rel="stylesheet" type="text/css" href="style.css?8531">
	
    <title>Write Task Force Letters</title>


    
<!-- Analytics -->
 
<!-- Analytics END -->
    
</head>
<body>
<!-- Main container -->
<div class="page-container">
    
<!-- bloc-0 -->
<div class="bloc bgc-electric-yellow l-bloc " style="background-color: #fcf060;" id="bloc-0">
	<div class="container bloc-lg bloc-sm-lg">
		<div class="row">
			<div class="col">
				<h1 class="mg-clear h1-style mx-auto d-block text-lg-center tc-black">
					Amnesty PLUS Task Force Post Writer
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

<!-- bloc-6 -->
<div class="bloc l-bloc full-width-bloc" id="bloc-6">
	<div class="container bloc-lg bloc-no-padding-lg">
		<div class="row">
			<div class="col-lg-6 offset-lg-3 offset-md-2 col-md-8">
				<form data-form-type="blocs-form" action="UploadLetter" method="POST" enctype="multipart/form-data">
					<div class="form-group">
						<input name="recipient" id="recipient" class="form-control" required placeholder="Recipient"/>
					</div>
					<div class="form-group">
						<input name="writeas" id="writeas" class="form-control" required placeholder="Author ID (Optional)"/>
					</div>
					<div class="form-group">
						<label class="post_text_style mg-sm">
							Country Name<br>
						</label>
						<select class="form-control" required name="countrycode">
							<%
								ResultSet rs = DBControl.executeQuery("select * from taskforce where type=\"nation\";");
								ArrayList<TaskForceData> nations = new ArrayList<>();
								while(rs.next()){
									TaskForceData d = new TaskForceData(rs.getString("id"));
									d.loadContent();
									nations.add(d);
								}
								for(int i = 0; i < nations.size(); i++) {
							%>
							<option value="<%=nations.get(i).countryCode%>">
								<%=nations.get(i).country%>
							</option>
							<%
								}
							%>
						</select>
					</div>
					<input style="color:black" type="file" name="file" accept=".pdf" required>
					<p style="color: black">Letter file</p>
					<button class="bloc-button btn btn-d btn-lg btn-block post_text_style" type="submit">
							Post
						</button>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- bloc-6 END -->

<!-- ScrollToTop Button -->
<a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 32 32"><path class="scroll-to-top-btn-icon" d="M30,22.656l-14-13-14,13"/></svg></a>
<!-- ScrollToTop Button END-->

</div>
<!-- Main container END -->

<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("AMLoginData") == null) {
		session.setAttribute("AMShouldRedirect", "./uploadTaskforce.jsp");
		response.sendRedirect("./login.jsp");
		return;
	}

	PrintWriter script = response.getWriter();
	if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(400)) {
		LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for writepost");
		script.println("<script>alert(\"Sorry, you do not have access to this page.\");");
		script.println("window.location.replace(\"./index.jsp\");</script>");
		return;
	}
%>


<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?1880"></script>
<script src="./js/bootstrap.bundle.min.js?3622"></script>
<script src="./js/blocs.min.js?9534"></script>

</body>
</html>
