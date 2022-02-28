<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.LogsManager" %>
<%@ page import="modules.members.MemberData" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css?874">
	<link rel="stylesheet" type="text/css" href="style.css?8531">
	
    <title>Write Post</title>


    
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
					Amnesty PLUS Activity Record Writer
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
				<form data-form-type="blocs-form" action="UploadThumbnail" method="POST" enctype="multipart/form-data">
					<div class="form-group">
						<input name="title" id="title" class="form-control" required placeholder="Title"/>
					</div>
					<div class="form-group">
<%--						<input name="writeas" id="writeas" class="form-control" required placeholder="Author ID (Optional)"/>--%>
					</div>
					<div class="form-group">
						<label class="post_text_style mg-sm">
							Type of Post<br>
						</label>
						<select class="form-control" required name="type">
							<option value="contest">
								Contest
							</option>
							<option value="video">
								Video
							</option>
							<option value="apyac">
								Youth Activists
							</option>
						</select>
					</div>
					<div class="form-group">
						<label class="post_text_style">
							Content
						</label><textarea id="content" name="content" class="form-control" rows="8" cols="50" required></textarea>
					</div>
					<input style="color:black" type="file" name="file" accept=".png" required>
					<p style="color: black">Thumbnail</p>
					<button class="bloc-button btn btn-d btn-lg btn-block post_text_style" type="submit">
							Post
						</button>
				</form>
				<h4>
					Writing manual
				</h4>
				<p>
					Writing for APYAC (Youth Activists):<br>
					- Bold: <‍b>Content to bold<‍/b><br>
					<br>
					Writing for Video<br>
					Just paste the link in the field, then add thumbnail.<br>
					<br>
					Writing for Contest<br>
					All elements are separated based on linebreaks.<br>
					description=<br>
					time=<br>
					topic=<br>
					host=<br>
					participation=<br>
					guideline=<br>
					<br>
				</p>
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
		session.setAttribute("AMShouldRedirect", "./writeactivity.jsp");
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
