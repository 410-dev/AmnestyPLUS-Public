<%@ page import="modules.activities.GetActivityData" %>
<%@ page import="defaults.activity.Activity" %>
<%@ page import="master.HTMLData" %><%--
  Created by IntelliJ IDEA.
  User: hoyounsong
  Date: 2021/04/19
  Time: 12:45 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="html/style.html" %>
    <meta charset="utf-8">
    <title>Youth Activists</title>
</head>
<style>
    .divider-h {
        width:17.56%;
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
    .articleImage {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .articleImageContainer{
        width: 100%;
        height: 180px;
        overflow: hidden;
    }
</style>
<body>
<!-- Main container -->
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file="./html/header.jsp" %>

<!-- Main container -->
<div class="page-container">
    <!-- bloc-243 -->
    <div class="bloc" id="bloc-243">
        <div class="container bloc-lg bloc-sm-lg">
            <div class="row">
                <div class="col">
                    <h1 class="tc-black mg-clear">
                        Youth Activist
                    </h1>
                    <div class="divider-h">
                        <span class="divider"></span>
                    </div>
                    <h3 class="mg-clear">
                        APYAC Report will be uploaded here. Look what our Youth Activists achieved so far!<br>
                    </h3>
                    <h5 class="mg-clear">
                        <br>
                    </h5>
                </div>
            </div>
        </div>
    </div>
    <!-- bloc-243 END -->
<%
    Object[] objectData = new GetActivityData().getAllActivityDataAsObjectArray("apyac");
%>
    <!-- bloc-244 -->
    <div class="bloc l-bloc" id="bloc-244">
        <div class="container bloc-sm">
            <div class="row">
                <div class="col">
                    <%int index = 0;
                        for(int i = 0; i < ((objectData.length/4) + 1); i++) {%>
                    <div class="row">
                        <%for(int ii = 0; ii < 4; ii++) {
                            if (index >= objectData.length) break;
                            Activity activityData = (Activity) objectData[index];
                            activityData.selfDecodeFromBase64();
                            if (activityData.title.equals("decode_fail")) break;%>
                        <div class="col-lg-3">
                            <a href="apyacview.jsp?id=<%=activityData.id%>">
                                <div class="articleImageContainer"><img src="<%=HTMLData.relative_thumbnail + activityData.thumbnail%>" class="img-fluid mx-auto d-block lazyload articleImage" alt="placeholder image" /></div></a>
                            <h6 class="h6-style mg-clear">
                                <br>
                            </h6><a href="apyacview.jsp?id=<%=activityData.id%>" class="a-btn a-block archive-title ltc-black link-bloc-183-style"><%=activityData.title%></a>
                        </div>
                        <%}%>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    <!-- bloc-244 END -->

    <!-- ScrollToTop Button -->
    <a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 32 32"><path class="scroll-to-top-btn-icon" d="M30,22.656l-14-13-14,13"/></svg></a>
    <!-- ScrollToTop Button END-->

<%@include file="html/footer.jsp"%>
</div>
<!-- Main container END -->



<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?3062"></script>
<script src="./js/bootstrap.bundle.min.js?1969"></script>
<script src="./js/blocs.min.js?8391"></script>
<script src="./js/lazysizes.min.js" defer></script><!-- Additional JS END -->


</body>
</html>
