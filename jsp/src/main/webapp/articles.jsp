<%@ page import="java.util.ArrayList" %>
<%@ page import="defaults.article.Article" %>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="master.CoreBase64" %><%--
  Created by IntelliJ IDEA.
  User: hoyounsong
  Date: 2021/04/19
  Time: 12:19 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="html/style.html" %>
    <meta charset="utf-8">
    <title><%=request.getParameter("query").substring(0,1).toUpperCase() + request.getParameter("query").substring(1)%></title>
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

    <%
        ArrayList<Article> articles = new ArrayList<>();
        AManagement amgr = new AManagement();
        try {
            ResultSet rs;
            switch (request.getParameter("query")) {
                case "featured":
                    rs = amgr.filterArticles(new String[]{"post_featured=1", "post_status=\"PUBLIC\""});
                    break;
                case "opinions":
                    rs = amgr.getArticles("Opinion", true);
                    break;
                default:
                    rs = amgr.getArticles("News", true);
            }

            rs.last();
            while(true) {
                Article article_d = new Article();
                article_d.id = rs.getString("id");
                article_d.post_title = rs.getString("post_title");
                article_d.post_photoURLs = rs.getString("post_photoURLs");
                article_d.post_title = CoreBase64.decode(article_d.post_title);
                articles.add(article_d);
                if (!rs.previous()) break;
            }
        }catch(Exception e) {
            session.setAttribute("AMError", new PageExceptionPayload(e, "articles.jsp"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }

    %>
<div class="bloc l-bloc">
    <div class="container bloc-sm">
        <div onclick="hideWarning()" id="opinionwarning" class="row">
            <div onclick="hideWarning()" class="col" style="text-align: center; background-color: red; opacity: 0.7; padding: 10px; border-radius: 10px; color: white">
                <a onclick="hideWarning()">Note: All articles' ideas belong to Amnesty PLUS Editors. These articles are not the official position of Amnesty International.
                    <br>
                    Amnesty PLUS 에 작성된 모든 글은 Amnesty PLUS 에디터가 작성한 글 입니다. 국제앰네스티의 공식 입장이 아닙니다.</a>
            </div>
        </div>
    </div>
</div>
<div class="bloc l-bloc">
    <div class="container bloc-sm">
        <div class="row">
            <h1 style="color: black"><%=request.getParameter("query").substring(0,1).toUpperCase() + request.getParameter("query").substring(1)%></h1>
        </div>
        <div class="row">
            <span class="divider-h"></span>
        </div>
    </div>
</div>
    <div class="bloc l-bloc" id="bloc-242">
        <div class="container bloc-sm">
            <div class="row">
                <div class="col">
                    <%
                        int index = 0;
                        for(int i = 0; i < ((articles.size()/4) + 1); i++) {

                    %>
                    <div class="row">
                        <%for(int ii = 0; ii < 4; ii++) {
                            if (index >= articles.size()) break;
                            Article article_f = articles.get(index);
                        %>
                        <div class="col-lg-3">
                            <a href="./articleView.jsp?id=<%=article_f.id%>">
                                <div class="articleImageContainer"><img src="<%=article_f.post_photoURLs%>" style="padding-top: 20px" class="img-fluid mx-auto d-block articleImage" alt="placeholder image" /></div>
                            </a>
                            <h6 class="h6-style mg-clear">
                                <br>
                            </h6><a href="./articleView.jsp?id=<%=article_f.id%>" class="a-btn a-block archive-title ltc-black link-bloc-183-style"><%=article_f.post_title%></a>
                        </div>
                        <%index++;}%>
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


<script>
    function hideWarning() {
        document.getElementById("opinionwarning").style.display = 'none';
    }
</script>
<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?3062"></script>
<script src="./js/bootstrap.bundle.min.js?1969"></script>
<script src="./js/blocs.min.js?8391"></script>
<script src="./js/lazysizes.min.js" defer></script><!-- Additional JS END -->


</body>
</html>
