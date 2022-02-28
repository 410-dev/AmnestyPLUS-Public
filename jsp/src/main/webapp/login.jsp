<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="modules.members.Login"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Decoder" %>
<%@ page import="master.LogsManager" %>
<%@ page import="modules.members.MemberData" %>
<%@ page import="defaults.PageExceptionPayload" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="html/style.html" %>
	<title>Login</title>
</head>
<body>

<!-- Main container -->
<div class="page-container">
    
<!-- bloc-22 -->
<div class="bloc l-bloc bloc-fill-screen" id="bloc-22">
	<div class="container">
		<div class="row">
			<div class="col-sm-10 offset-sm-1 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
				<div class="form-group">
					<img src="img/amlogo_black_nobg.png" data-src="img/amlogo_black_nobg.png" width="100" height="100" class="img-fluid mx-auto d-block img-bloc-22-style animated fadeIn lazyload" alt="logo color-black-nobg" data-appear-anim-style="fadeIn" />
					<h2 class="mg-md mx-auto d-block text-lg-center tc-black h2-welcome-back--style animated fadeIn" data-appear-anim-style="fadeIn">
						Welcome Back!
					</h2>
					<h4 class="mg-md text-lg-center tc-black animated fadeInDown" data-appear-anim-style="fadeInDown">
						Amnesty PLUS Login
					</h4>
					<p class="text-lg-center" id="loginstatus" data-appear-anim-style="fadeInDown" style="color: #ffffff;">_</p>
					<div class="container-div-0-bloc-22-style">
					</div>
					<form action="login.jsp" method="POST">
					<input class="form-control animated fadeInUp" placeholder="Username" required data-appear-anim-style="fadeInUp" name="username" id="username" />
						<div class="form-group">
							<div class="container-div-bloc-22-style">
								<span class="empty-column"></span>
							</div>
							<br>
							<input class="form-control animated fadeInUp" required placeholder="Password" type="password" data-appear-anim-style="fadeInUp" name="password" id="password" />
							<div class="text-center container-div-0-style">
							</div><input type="submit" class="btn btn-lg btn-white float-lg-right animated fadeIn" data-appear-anim-style="fadeIn" value="Login"/><a href="./recovery.jsp" class="btn btn-lg btn-white float-lg-right animated fadeIn" data-appear-anim-style="fadeIn">I forgot</a><a href="./signup.jsp" class="btn btn-lg btn-white float-lg-right animated fadeIn" data-appear-anim-style="fadeIn">Sign Up</a>
						</div>
					</form>
					<script>
						function loginSuccess(username, redirect) {
					        document.getElementById("loginstatus").style.color = "green";
					        document.getElementById("loginstatus").innerHTML = "Welcome, " + username + "!";
					        setTimeout(function(){
					        	window.location.replace(redirect);
					        }, 500); 
						}

						function loginFail() {
							document.getElementById("loginstatus").innerHTML = "Invalid username or password.";
					        document.getElementById("loginstatus").style.color = "red";
						}
						
						function statusSet(message, color, delay, redirect) {
							document.getElementById("loginstatus").innerHTML = message;
					        document.getElementById("loginstatus").style.color = color;
					        if (delay != undefined && delay != null && delay != 0) {
						        setTimeout(function() {
						        	window.location.replace(redirect);
						        }, delay);
					        }
						}
					</script>
				</div>
			</div>
		</div>
	</div>
</div>
<%
	// REMOVED DUE TO SECURITY REASON
%>
<!-- bloc-22 END -->

<!-- ScrollToTop Button -->
<a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><span class="fa fa-chevron-up"></span></a>
<!-- ScrollToTop Button END-->


</div>
<!-- Main container END -->
    

<script src="./js/jquery-3.3.1.min.js?7754"></script>
<script src="./js/bootstrap.bundle.min.js?7358"></script>
<script src="./js/blocs.min.js?2199"></script>
<script src="./js/lazysizes.min.js" defer></script>
<!-- Additional JS END -->


</body>
</html>
