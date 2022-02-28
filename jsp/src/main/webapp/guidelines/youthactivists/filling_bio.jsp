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
    <h2><b>Filling in Your Individual Bio</b></h2>
    <p>
        Your individual bio will be uploaded to our website to introduce who you are. <br>
        Through the Google Form linked below fill in both the photo and description of yourself by the due date informed by the Senior Advisors. This will be your first official task in Amnesty PLUS, meaning that a failure to meet the deadline will result in a strike. Please refer to the example in the description for your individual bio!
        <a style="padding-top: 0px" href="https://docs.google.com/forms/d/e/1FAIpQLSfQNqLN8l6Q3Modc_duuGN3jEwXexBGNsv3sI_i_TWoxevXNA/viewform">Link to Bio Submission Form</a>
    </p>
    <a href="./index.jsp"><h3>Back</h3></a>
</div>
</body>
</html>
