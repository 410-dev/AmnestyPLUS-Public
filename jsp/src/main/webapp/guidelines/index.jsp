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
</style>
<body>
<%@ include file="/guidelines/include/header.jsp" %>
    <div class="row justify-content-md-center">
    <div class="col-md-auto" style="padding: 10%">
        <a href="../adminterminal.jsp"><h3>Back</h3></a>
        <a href="./it_department/index.jsp"><h3>Guidelines for IT Department</h3></a>
        <a href="./editors/index.jsp"><h3>Guidelines for Editors</h3></a>
        <a href="./youthactivists/index.jsp"><h3>Guidelines for Youth Activists</h3></a>
        <a href="./general.jsp"><h3>General Guideline for everyone</h3></a>
    </div>
</div>
</body>
</html>
