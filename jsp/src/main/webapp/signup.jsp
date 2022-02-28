<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="modules.members.Register"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<title>Sign Up</title>
</head>
<body>
	<!-- Main container -->
	<div class="page-container">

		<!-- bloc-22 -->
		<div class="bloc bloc-fill-screen tc-white l-bloc" id="bloc-22">
			<div class="container">
				<div class="row">
					<div
						class="col-sm-10 offset-sm-1 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
						<div class="form-group">
							<img src="img/amlogo_black_nobg.png" data-src="img/amlogo_black_nobg.png" width="100" height="100" class="img-fluid mx-auto d-block img-bloc-22-style animated fadeIn lazyload" alt="logo color-black-nobg" data-appear-anim-style="fadeIn" />
							<h2
								class="mg-md mx-auto d-block text-lg-center tc-black h2-welcome-back--style animated fadeInUp text-md-center"
								data-appear-anim-style="fadeInUp">Glad to meet you.</h2>
							<h4
								class="mg-md text-lg-center tc-black animated animDelay04 fadeInUp text-md-center"
								data-appear-anim-style="fadeInUp">Create account for
								Amnesty PLUS</h4>
							<div class="container-div-0-bloc-22-style"></div>
							<form action="UploadProfileImage" method="POST" enctype="multipart/form-data">
								<input class="form-control animated fadeInUp" placeholder="Username (ID)" required data-appear-anim-style="fadeInUp" name="username" /><br>
								<div class="form-group">
									<div class="container-div-bloc-22-style"></div>
									<input class="form-control animated fadeInUp animDelay04"
										required placeholder="Password" type="password"
										data-appear-anim-style="fadeInUp" name="password" /><br>
									<div class="container-div-0-bloc-22-style"></div>
									<input class="form-control animated fadeInUp animDelay06"
										required placeholder="Password Confirmation" type="password"
										data-appear-anim-style="fadeInUp" name="passwordconfirmation" /><br>
									<div class="container-div-0-bloc-22-style"></div>
									<input class="form-control animated fadeInUp animDelay08"
										required placeholder="Full Name"
										data-appear-anim-style="fadeInUp" name="realname" /><br>
									<div class="container-div-0-bloc-22-style"></div>
									<input class="form-control animated fadeInUp animDelay08"
										required placeholder="E-mail"
										data-appear-anim-style="fadeInUp" name="email" /><br>
									<div class="container-div-0-bloc-22-style"></div>
									<select class="form-control animated fadeInUp animDelay08" data-appear-anim-style="fadeInUp" required name="role">
										<option value="Co-Founder">Co-Founder</option>
										<option value="Senior Advisor">Senior Advisor</option>
										<option value="IT Department">IT Department</option>
										<option value="Chief Editor">Chief Editor</option>
										<option value="Director of Editing Department">Director of Editing Department</option>
										<option value="Division A Editor">Division A Editor</option>
										<option value="Division B Editor">Division B Editor</option>
										<option value="Division C Editor">Division C Editor</option>
										<option value="Division D Editor">Division D Editor</option>
										<option value="Director of Youth Activists Department">Director of Youth Activists Department</option>
										<option value="Youth Activist">Youth Activist</option>
										<option value="Recruitment Coordinator">Recruitment Coordinator</option>
										<option value="Communication Department">Communication Department</option>
									</select><br>
									<input type="checkbox" name="inLeadership" id="inLeadership" value="1">
									<label style="color: black" for="inLeadership">I am in Leadership (Communication / IT Department Only)</label><br>
									<div class="container-div-bloc-22-style"></div>
									<input class="form-control animated fadeInUp animDelay04" placeholder="Paste your bio here..." type="text"
										data-appear-anim-style="fadeInUp" name="bio" /><br>
									<div class="text-center container-div-0-style"></div>
									<input style="color:black" type="file" name="file" accept=".png" required>
									<p style="color: black">You cannot change your profile picture after it is uploaded! Please select it carefully.</p>
									<input type="submit" value="Sign Up"
										class="btn btn-lg btn-white float-lg-right animated fadeIn animDelay08"
										data-appear-anim-style="fadeIn" />
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- bloc-22 END -->

		<!-- ScrollToTop Button -->
		<a class="bloc-button btn btn-d scrollToTop"
			onclick="scrollToTarget('1',this)"><span class="fa fa-chevron-up"></span></a>
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
