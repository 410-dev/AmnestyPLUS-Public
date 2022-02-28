<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/img/favicon.png">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css?8847">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css?2744">

    <title>Staff Guidelines</title>
</head>
<style>
    a{
        padding-top: 10px;
    }

    h3{
        padding-top: 20px;
    }

    p{
        font-size: 20px;
    }
</style>
<body>
<%@ include file="/guidelines/include/header.jsp" %>
<div class="col-md-auto" style="padding-left: 10%; padding-right: 10%; padding-top: 4%">
    <h2><b>Select your role</b></h2>
    <a href="../index.jsp"><h3>Back</h3></a>
    <a href="./inspector.jsp"><h3>Inspectors</h3></a>
    <a href="./uploaders.jsp"><h3>Uploaders</h3></a>
</div>
</body>
</html>
