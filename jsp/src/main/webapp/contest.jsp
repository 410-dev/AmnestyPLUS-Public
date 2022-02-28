<%@ page import="modules.activities.GetActivityData" %>
<%@ page import="defaults.activity.Activity" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="html/style.html" %>
    <meta charset="utf-8">
    <title>Contests</title>
</head>
<body>
<!-- Main container -->
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file="./html/header.jsp" %>
<%
    Object[] activityArrayAsObject = new GetActivityData().getAllActivityDataAsObjectArray("contest");
%>
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
</style>
<div class="page-container">
    <!-- bloc-209 -->
    <div class="bloc" id="bloc-209">
        <div class="container bloc-lg bloc-sm-lg">
            <div class="row">
                <div class="col">
                    <h1 class="tc-black mg-clear">
                        CONTEST
                    </h1>
                    <div class="divider-h">
                        <span class="divider"></span>
                    </div>
                    <h3 class="mg-md h3-138-style">
                        Besides writing articles, you can also show your inspiration toward human rights protection by participating in contests.
                    </h3>
                </div>
            </div>
        </div>
    </div>
    <!-- bloc-209 END -->

    <!-- bloc-210 -->
    <div class="bloc" id="bloc-210">
        <div class="container bloc-lg bloc-sm-lg">
            <div class="row">
                <div class="col">
                    <%
                        for(int i = 0; i < activityArrayAsObject.length; i++) {
                            Activity activityData = (Activity) activityArrayAsObject[i];
                            activityData.selfDecodeFromBase64();
                    %>
                    <div class="row">
                        <div class="col-lg-1">
                            <h1 class="mg-md tc-black">
                                <%=i + 1%>.
                            </h1>
                        </div>
                        <div class="col" style="overflow-wrap: break-word;">
                            <h2 class="mg-md tc-black">
                                <%=activityData.title%><br>
                            </h2>
                            <h5 class="mg-md tc-black" style=" text-align: left;overflow-wrap: break-word;">
                                <%=activityData.description%>
                            </h5>
                            <h5 class="mg-md tc-black">
                                일시: <%=activityData.timespan%><br>
                            </h5>
                            <h5 class="mg-md tc-black">
                                주제: <%=activityData.topic%>
                            </h5>
                            <h5 class="mg-md tc-black">
                                주최: <%=activityData.sponsor%>
                            </h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="offset-lg-1 col-lg-1">
                            <a href="<%=activityData.participatelink%>" class="btn btn-lg btn-electric-yellow">Participate</a>
                        </div>
                        <div class="col offset-lg-1">
                            <a href="<%=activityData.guideline%>" class="btn btn-lg btn-style btn-electric-yellow" target="_blank">Guideline</a>
                        </div>
                    </div>
                    <%}%>


                </div>
            </div>
        </div>
    </div>
    <!-- bloc-210 END -->

<%--    <!-- bloc-211 -->--%>
<%--    <div class="bloc l-bloc" id="bloc-211">--%>
<%--        <div class="container bloc-lg bloc-no-padding-lg">--%>
<%--            <div class="row">--%>
<%--                <div class="col">--%>
<%--                    <div class="row">--%>
<%--                        <div class="offset-lg-1 col-lg-1">--%>
<%--                            <a href="<%=activityData.participatelink%>" class="btn btn-lg btn-electric-yellow">Participate</a>--%>
<%--                        </div>--%>
<%--                        <div class="col offset-lg-1">--%>
<%--                            <a href="<%=activityData.guideline%>" class="btn btn-lg btn-style btn-electric-yellow" target="_blank">Guideline</a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="row">--%>
<%--                <div class="col">--%>
<%--                    <h1 class="mg-md">--%>
<%--                        <br>--%>
<%--                    </h1>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <!-- bloc-211 END -->--%>
<%--    <%}%>--%>
    <!-- ScrollToTop Button -->
    <a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 32 32"><path class="scroll-to-top-btn-icon" d="M30,22.656l-14-13-14,13"/></svg></a>
    <!-- ScrollToTop Button END-->

</div>
<!-- Main container END -->


<%@ include file="./html/footer.jsp" %>
<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?3062"></script>
<script src="./js/bootstrap.bundle.min.js?1969"></script>
<script src="./js/blocs.min.js?8391"></script>
<script src="./js/lazysizes.min.js" defer></script><!-- Additional JS END -->


</body>
</html>