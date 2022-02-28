<%@ page import="modules.activities.GetActivityData" %>
<%@ page import="defaults.activity.Activity" %>
<%@ page import="modules.taskforce.GetTaskForceData" %>
<%@ page import="defaults.taskforce.TaskForceData" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="html/style.html" %>
    <meta charset="utf-8">
    <title>Task Force</title>
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

    .welcomeletter {
        font-size: 20px;
    }
</style>
<body>
<!-- Main container -->
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file="./html/header.jsp" %>

<!-- Main container -->
<div class="page-container">
    <div class="container bloc-sm">
        <div class="row">
            <div class="col">
                <h1 class="tc-black mg-clear">
                    Welcome Letter
                </h1>
                <div class="divider-h about-us-divider">
                    <span class="divider"></span>
                </div>
                <h3 class="mg-md tc-black welcomeletter">
                    <p style="text-indent: 2em;"> The Amnesty PLUS Task Force was created with the collective goal of addressing and bringing about tangible change in regards to pressing human rights issues. The purpose of the Task Force is to carry out various projects to fulfill this goal. The Task Force is composed of 15 students from multiple international schools in South Korea, and one director, Lauren Cho, from Korea International School. The flexible nature of the Task Force allows it to be a group uniquely capable of taking on many different types of tasks, making it an important asset to the Amnesty PLUS organization.
                    </p><br><p style="text-indent: 2em;">Currently, the Task Force is focusing on working with Amnesty USA’s Urgent Action Network. The Urgent Action Network uploads various human rights issues around the world that are—as the name suggests—in urgent need of address. These issues can range from unjust imprisonment of journalists, to abortion rights, to protesting government abuses of power. The role of the Task Force in this is to write letters every three weeks for an Urgent Action to aid the efforts of the UA Network.
                    </p><br><p style="text-indent: 2em;">In the future, the Task Force will branch out its projects to expand its reach and potential for change in the South Korean and the global community. Such projects could range from working with other international and local organizations, to opening up independent events and fundraisers. Throughout this process, the Task Force’s goal to help the oppressed and marginalized will always remain its priority.
                    </p><br>Lauren Cho
                    <br>Amnesty PLUS Task Force Director
                    <br>Korea International School
                </h3>
            </div>
        </div>
    </div>
    <%
        Object[] objectData = new GetTaskForceData().getAllTaskForceDataAsObjectArray("post");
    %>
    <!-- bloc-242 -->
    <div class="bloc l-bloc" id="bloc-242">
        <div class="container bloc-sm">
            <div class="row">
                <div class="col">
                    <%
                        int index = 0;
                        for(int i = 0; i < ((objectData.length/4) + 1); i++) {

                    %>
                    <div class="row">
                        <%for(int ii = 0; ii < 4; ii++) {
                            if (index >= objectData.length) break;
                            TaskForceData data = (TaskForceData) objectData[index];
                            data.loadContent();
                        %>
                        <div class="col-lg-3">
                            <a href="./files/taskforce/<%=data.filename%>">
                                <div class="articleImageContainer"><img src="./img/nations/<%=data.countryCode%>.png" class="img-fluid mx-auto d-block articleImage" alt="placeholder image" /></div></a>
                            <h6 class="h6-style mg-clear">
                                <br>
                            </h6><a href="./files/taskforce/<%=data.filename%>" class="a-btn a-block archive-title ltc-black link-bloc-183-style">Dear <%=data.recipient%></a>
                            <a href="./files/taskforce/<%=data.filename%>"><h2 style="color: gray; font-size: 13px;">Written by <%=data.author%></h2></a>
                        </div>
                        <%
                                index++;
                            }
                        %>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    <!-- bloc-242 END -->

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
