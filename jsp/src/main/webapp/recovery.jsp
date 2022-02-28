<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="modules.members.IForgot" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="html/style.html" %>
	<title>Reset Password</title>
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
						Let's Reset your password.
					</h2>
					<h4 class="mg-md text-lg-center tc-black animated animDelay04 fadeInUp text-md-center" data-appear-anim-style="fadeInUp">
						Reset password for Amnesty PLUS account
					</h4>
					<div class="container-div-0-bloc-22-style">
					</div>
					<form action="AccountRecovery" method="POST">
						<input type="hidden" name="redirect" value="./login.jsp"/>
						<div class="container-div-bloc-22-style">
						</div>
						<input class="form-control animated fadeInUp animDelay04" required placeholder="Username or Email" type="text" data-appear-anim-style="fadeInUp" name="inputfield" />
						<div class="text-center container-div-0-style">
						</div><input type="submit" value="Submit" class="btn btn-lg btn-white float-lg-right animated fadeIn animDelay08" data-appear-anim-style="fadeIn"/>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
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
