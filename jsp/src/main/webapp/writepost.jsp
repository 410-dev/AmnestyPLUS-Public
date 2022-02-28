<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.DBControl" %>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="modules.members.Users" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="master.CoreBase64" %>
<%@ page import="master.LogsManager" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="modules.members.MemberData" %>
<%@ page import="master.Configurations" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css?874">
	<link rel="stylesheet" type="text/css" href="style.css?8531">
	
    <title>Write Post</title>
    
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
					Amnesty PLUS Article Writer
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
				<form data-form-type="blocs-form" action="./writepost.jsp" method="POST">
					<div class="form-group">
						<input name="title" id="title" class="form-control" required placeholder="Title"/>
					</div>
					<div class="form-group">
						<input name="writeas" id="writeas" class="form-control" placeholder="Author ID (Optional)"/>
					</div>
					<div class="form-group">
						<label class="post_text_style mg-sm">
							Type of Article<br>
						</label>
						<select class="form-control" required name="type">
							<option value="News">
								News
							</option>
							<option value="Opinion">
								Opinions
							</option>
						</select>
					</div>
					<div class="form-group">
						<label class="post_text_style mg-sm">
							Week<br>
						</label>
						<select class="form-control" required name="weeknum">
							<option value="1">
								1
							</option>
							<option value="2">
								2
							</option>
							<option value="3">
								3
							</option>
							<option value="4">
								4
							</option>
							<option value="5">
								5
							</option>
						</select>
					</div>
					<div class="form-group">
						<label class="post_text_style">
							Content
						</label><textarea id="content" name="content" class="form-control" rows="8" cols="50" required></textarea>
					</div><button class="bloc-button btn btn-d btn-lg btn-block post_text_style" type="submit">
							Post
						</button>
				</form>
				<h4>
					Writing manual
				</h4>
				<p>
					::::image=ImageURL‍ ‍ ‍ ‍ ‍  This will insert the image to the paragraph.<br>
					::::section‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ Add section line<br>
					::::citation‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ Set citation section<br>
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
    


<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?1880"></script>
<script src="./js/bootstrap.bundle.min.js?3622"></script>
<script src="./js/blocs.min.js?9534"></script>
<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("AMLoginData") == null) {
		session.setAttribute("AMShouldRedirect", "./writepost.jsp");
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

	if (request.getParameter("content") != null) {
		if (request.getParameter("content").equals("")) {
			script.println("<script>alert(\"No contents written.\");window.history.back();</script>");
			return;
		}

		try {
			AManagement amanager = new AManagement();
			Users useragent = new Users();

			String author = "";

			if (request.getParameter("writeas") != "") {
				if (new Configurations().get("do_check_author").equals("true")) {
					if (DBControl.executeQuery("select * from members where username=\"" + request.getParameter("writeas") + "\";").next()) {
						ResultSet rs = DBControl.executeQuery("select * from members where username=\"" + request.getParameter("writeas") + "\";");
						rs.next();
						author = rs.getString("username");
					} else if (DBControl.executeQuery("select * from members where realname=\"" + request.getParameter("writeas") + "\";").next()) {
						ResultSet rs = DBControl.executeQuery("select * from members where realname=\"" + request.getParameter("writeas") + "\";");
						rs.next();
						author = rs.getString("username");
					} else {
						script.println("<script>alert('Error: Unable to find user: " + request.getParameter("writeas") + "');window.history.back();</script>");
						return;
					}
				}else{
					author = request.getParameter("writeas");
				}
			}

			if (request.getParameter("content").contains("<script>")) {
				if (new Configurations().get("allow_javascript_post").equals("false")) {
					script.println("<script>alert('Writing JavaScript in post is not allowed.');window.history.back();</script>");
					return;
				}
			}

			String content = request.getParameter("content");
			String thumbnail = "";
			String[] thumb = content.split("\n");
			for(String t : thumb) {
				if (t.startsWith("::::image=")) {
					thumbnail = t.replace("::::image=", "");
					break;
				}
			}

			if (thumbnail.equals("")) {
				script.println("<script>alert('Image is not included.');window.history.back();</script>");
				return;
			}

			DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime currentTime = LocalDateTime.now();
			amanager.post_title = CoreBase64.encode(request.getParameter("title"));
			amanager.post_date = timeFormatter.format(currentTime) + "," + request.getParameter("weeknum");
			amanager.post_edit = timeFormatter.format(currentTime);
			amanager.post_type = request.getParameter("type");
			if (request.getParameter("writeas") == "") amanager.post_auth_id = ((MemberData) session.getAttribute("AMLoginData")).getUsername();
			else amanager.post_auth_id = author;
			if (new Configurations().get("do_check_author").equals("false")) amanager.post_auth_realname = author;
			else amanager.post_auth_realname = useragent.getUserDataString(amanager.post_auth_id, "realname");
			amanager.post_auth_email = useragent.getUserDataString(amanager.post_auth_id, "email");
			amanager.post_auth_role = useragent.getUserDataString(amanager.post_auth_id, "userrole");
			amanager.post_auth_photo_address = useragent.getUserDataString(amanager.post_auth_id, "photoAddress");
			amanager.post_photoURLs = thumbnail;
			amanager.post_content = CoreBase64.encode(content.replace("\n", " <br> "));

			amanager.writeToDatabase();
			if (request.getParameter("writeas") == "") script.println("<script>alert(\"Successfully posted your article.\");\nwindow.location.replace(\"./adminterminal.jsp\");</script>");
			else script.println("<script>alert(\"Successfully posted " + useragent.getUserDataString(amanager.post_auth_id, "realname") + "'s article.\");\nwindow.location.replace(\"./adminterminal.jsp\");</script>");

		} catch (Exception e) {
			session.setAttribute("AMError", new PageExceptionPayload(e, "writepost.jsp"));
			response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
			script.println("<script>window.location.replace(\"./error.jsp\")</script>");
		}
	}
%>

</body>
</html>
