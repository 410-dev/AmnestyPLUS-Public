<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="master.DBControl"%>
<%@ page import="master.Shasum"%>
<%@ page import="modules.members.MemberData" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
    <title>Change Password</title>
</head>
<body>
<!-- Main container -->
<div class="page-container">
    
<!-- bloc-22 -->
<div class="bloc bloc-fill-screen tc-white l-bloc" id="bloc-22">
	<div class="container">
		<div class="row">
			<div class="col-sm-10 offset-sm-1 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
				<div class="form-group">
					<img src="img/amlogo_black_nobg.png" data-src="img/amlogo_black_nobg.png" width="100" height="100" class="img-fluid mx-auto d-block img-bloc-22-style animated fadeIn lazyload" alt="logo color-black-nobg" data-appear-anim-style="fadeIn" />
					<h2 class="mg-md mx-auto d-block text-lg-center tc-black h2-welcome-back--style animated fadeInUp text-md-center" data-appear-anim-style="fadeInUp">
						Let's reset your password.
					</h2>
					<h4 class="mg-md text-lg-center tc-black animated animDelay04 fadeInUp text-md-center" data-appear-anim-style="fadeInUp">
						Reset Password
					</h4>
					<div class="container-div-0-bloc-22-style">
					</div>
					<form action="changepassword.jsp" method="POST">
						<div class="form-group">
							<div class="container-div-bloc-22-style">
							</div>
							<input class="form-control animated fadeInUp animDelay04" required placeholder="New Password" type="password" data-appear-anim-style="fadeInUp" name="password" />
							<div class="container-div-0-bloc-22-style">
								<div class="container-div-bloc-22-style">
									<span class="empty-column"></span>
								</div>
								<br>
						</div>
							<input class="form-control animated fadeInUp animDelay06" required placeholder="Password Confirmation" type="password" data-appear-anim-style="fadeInUp" name="passwordconfirm" />
							<div class="container-div-0-bloc-22-style">
						</div>
							<div class="text-center container-div-0-style">
							</div><input type="submit" value="Change Password" class="btn btn-lg btn-white float-lg-right animated fadeIn animDelay08" data-appear-anim-style="fadeIn"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%
	PrintWriter script = response.getWriter();
	if (session.getAttribute("AMLoginData") != null) {
		String username = "";
		if (session.getAttribute("AMLoginData") != null) username = ((MemberData) session.getAttribute("AMLoginData")).getUsername();
		else if (session.getAttribute("AMRecoveryUser") != null) username = session.getAttribute("AMRecoveryUser").toString();
		else{
			script.println("<script>alert('Invalid access (self:1).');");
			script.println("window.location.replace('./index.jsp');</script>");
			return;
		}

		if (session.getAttribute("AMLoginData") != null && session.getAttribute("AMLoginStatus").toString().equals("7")) {
			session.setAttribute("AMLoginStatus", null);
			return;
		} else if (request.getParameter("password") != null &&
				request.getParameter("passwordconfirm") != null &&
				request.getParameter("password").equals(request.getParameter("passwordconfirm"))) {
			Shasum sha512 = new Shasum();
			DBControl.executeQuery("update members set password=\"" + sha512.doShasum(request.getParameter("password")) + "\" where username=\"" + username + "\";");
			DBControl.executeQuery("update members set recoveryLink=\"\" where username=\"" + username + "\";");
			script.println("<script>alert('Password updated.');");
			script.println("window.location.replace('./index.jsp');</script>");
		}else {
			if (request.getParameter("password") != null && request.getParameter("passwordconfirm") != null) {
				script.println("<script>alert('Password does not match.');");
				script.println("window.history.back();</script>");
			}
		}
		return;
	} else{
		script.println("<script>alert('Invalid access:3');");
		script.println("window.location.replace('./index.jsp');</script>");
	}
%>
<!-- bloc-22 END -->

<!-- ScrollToTop Button -->
<a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><span class="fa fa-chevron-up"></span></a>
<!-- ScrollToTop Button END-->


</div>
<!-- Main container END -->
    

<!-- Additional JS -->
<script src="./js/jquery-3.3.1.min.js?8490"></script>
<script src="./js/bootstrap.bundle.min.js?4557"></script>
<script src="./js/blocs.min.js?779"></script>
<script src="./js/lazysizes.min.js" defer></script>
<script src="./js/loginutil.js?6593"></script>
<!-- Additional JS END -->


</body>
</html>
