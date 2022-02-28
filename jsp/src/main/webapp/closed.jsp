<%@ page import="master.Configurations" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
	<link rel="canonical" href="http://setTheBaseURLInProjectSettings.com/index.html" />
	<meta name="robots" content="index, follow" />
    <link rel="shortcut icon" type="image/png" href="favicon.png">
    
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css?8314">
	<link rel="stylesheet" type="text/css" href="style.css?2953">
	
    <title>Home</title>


    
<!-- Analytics -->
 
<!-- Analytics END -->
    
</head>
<body>
<!-- Main container -->
<div class="page-container">

	<%
		if (new Configurations().get("site_close").equals("false")) {
			response.sendRedirect("./index.jsp");
		}
	%>
<!-- bloc-0 -->
<div class="bloc l-bloc " id="bloc-0">
	<div class="container bloc-lg">
		<div class="row">
			<div class="col">
				<h1 class="mg-md h1-style text-lg-center tc-black">
					<%=new Configurations().get("site_close_title")%>
				</h1>
				<h3 class="mg-md text-lg-center h3-style">
					<%=new Configurations().get("site_close_subtitle")%>
				</h3>
			</div>
		</div>
	</div>
</div>
<!-- bloc-0 END -->

<!-- ScrollToTop Button -->
<a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 32 32"><path class="scroll-to-top-btn-icon" d="M30,22.656l-14-13-14,13"/></svg></a>
<!-- ScrollToTop Button END-->


</div>
<!-- Main container END -->
    


<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?4981"></script>
<script src="./js/bootstrap.bundle.min.js?7780"></script>
<script src="./js/blocs.min.js?7859"></script>
<script src="./js/lazysizes.min.js" defer></script><!-- Additional JS END -->


</body>
</html>
