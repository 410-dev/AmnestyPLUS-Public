<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
	<link rel="canonical" href="http://setTheBaseURLInProjectSettings.com/About-Us.html" />
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/img/favicon.png">
    
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css?4921">
	<link rel="stylesheet" type="text/css" href="style.css?9082">
	<link rel="stylesheet" type="text/css" href="./css/all.min.css">
	<link rel="stylesheet" type="text/css" href="./css/all.min.css">
	<link href='https://fonts.googleapis.com/css?family=Playfair+Display&display=swap&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
    <title>About Us</title>


    
<!-- Analytics -->
 
<!-- Analytics END -->
    
</head>
<style>
	.about-us-divider {
		width:16%;
		background-clip:content-box!important;
		-webkit-background-clip:content-box!important;
		background-color:#FF0034;
		height:45px;
		padding:20px 0;
		display:inline-block;
	}

	.meet-divider {
		width:28%;
		background-clip:content-box!important;
		-webkit-background-clip:content-box!important;
		background-color:#FF0034;
		height:45px;
		padding:20px 0;
		display:inline-block;
	}

	.plus-divider {
		width:10%;
		background-clip:content-box!important;
		-webkit-background-clip:content-box!important;
		background-color:#FF0034;
		height:45px;
		padding:20px 0;
		display:inline-block;
	}

	.divider-h span{
		display: block;
		border-top:1px solid transparent;
	}
</style>
<body>

<!-- Main container -->
<div class="page-container">
	<%@ include file="html/header.jsp"%>
<!-- who-we-are -->
<div class="bloc" id="who-we-are">
	<div class="container bloc-sm">
		<div class="row">
			<div class="col">
				<h1 class="tc-black mg-clear">
					Who we are
				</h1>
				<div class="divider-h about-us-divider">
					<span class="divider"></span>
				</div>
				<h1 class="tc-black mg-clear">
					Amnesty PLUS is a group of Amnesty International Korea.
				</h1>
				<h3 class="mg-md tc-black">
					Our mission is&nbsp;to increase awareness on issues of humanitarian injustice from all around the globe by operating an interactive community where eager individuals can freely publish works about their insights and ideas.
				</h3>
				<h3 class="mg-md tc-black">
					We deliver these valuable messages through well-crafted and visually appealing articles, card news, infographics, and videos that are published on the web and shared throughout social media.
				</h3>
				<h3 class="mg-md tc-black">
					In addition, we also encourage online actions, campaigns, and donation bids affiliated with Amnesty International.
				</h3>
				<h3 class="mg-md tc-black">
					Get Involved today in Amnesty PLUS by visiting our “Get Involved” page or freely submitting articles to our page.<br>
				</h3>
			</div>
		</div>
	</div>
</div>
<!-- who-we-are END -->

<!-- plus -->
<div class="bloc" id="plus">
	<div class="container bloc-sm">
		<div class="row">
			<div class="col">
				<h1 class="mg-clear tc-black">
					P.L.U.S.
				</h1>
				<div class="divider-h plus-divider">
					<span class="divider"></span>
				</div>
				<h1 class="mg-clear h1-style tc-black">
					Provide means of accurate and accessible information for an international audience
				</h1>
				<h1 class="mg-md tc-black h1-12-style">
					Link diverse individuals to form an unified community fighting for change.
				</h1>
				<h1 class="mg-md tc-black h1-13-style">
					Understand differing perspectives and formulate our own unique convictions
				</h1>
				<h1 class="mg-md tc-black h1-14-style">
					Solve issues of human injustice one step at a time with the actions of our writers and readers
				</h1>
			</div>
		</div>
	</div>
</div>
<!-- plus END -->

<!-- member -->
<div class="bloc l-bloc" id="member">
	<div class="container bloc-sm">
		<div class="row">
			<div class="col">
				<h1 class="mg-clear h1-color tc-black">
					Meet Amnesty PLUS&nbsp;
				</h1>
				<div class="divider-h meet-divider">
					<span class="divider"></span>
				</div>
				<div class="row">
					<div class="col">
						<a href="./leadership.jsp"><img src="img/missions/leadership.png" class="img-fluid mx-auto d-block lazyload" alt="placeholder image" style="height: 250px;" /></a>
						<a href="./leadership.jsp" class="a-btn a-block link">Leadership</a>
					</div>
					<div class="col">
						<a href="./editors.jsp"><img src="img/missions/editors.png" class="img-fluid mx-auto d-block img-201805-artic-style lazyload" alt="placeholder image" style="height: 250px;" /></a>
						<a href="./editors.jsp" class="a-btn a-block link">Editors</a>
					</div>
					<div class="col">
						<a href="./youth_activists.jsp"><img src="img/missions/youthactivists.png" class="img-fluid mx-auto d-block img-1506933-2-style lazyload" alt="placeholder image" style="height: 250px;" /></a>
						<a href="./youth_activists.jsp" class="a-btn a-block link">Youth Activists</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- member END -->

<!-- ScrollToTop Button -->
<a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 32 32"><path class="scroll-to-top-btn-icon" d="M30,22.656l-14-13-14,13"/></svg></a>
<!-- ScrollToTop Button END-->

	<%@ include file="html/footer.jsp"%>

</div>
<!-- Main container END -->
    


<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?9286"></script>
<script src="./js/bootstrap.bundle.min.js?6573"></script>
<script src="./js/blocs.min.js?3618"></script>
<script src="./js/lazysizes.min.js" defer></script><!-- Additional JS END -->


</body>
</html>
