<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.HTMLData" %>
<%@ page import="modules.activities.GetActivityData" %>
<%@ page import="defaults.activity.Activity" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <%@ include file="html/style.html" %>
    <title>APYAC</title>
</head>
<body>
<%
    String aid = request.getParameter("id");
    PrintWriter script = response.getWriter();
    if (aid == null) {
        script.println("<script>alert('No such article found: AIDNULL');");
        script.println("window.location.replace('./index.jsp');</script>");
        return;
    }else if (aid.equals("-1")) {
        script.println("<script>alert('Not existing article.');");
        script.println("window.location.replace('./index.jsp');</script>");
        return;
    }

    Activity articleData = new GetActivityData().getActivityData(aid);
    articleData.selfDecodeFromBase64();

//Process to HTML type
    String reprocessedContent = "<div class=\"article-content\">";
    String[] toParse = articleData.content.split(" |\n");
    for(int i = 0; i < toParse.length; i++) {
        if (toParse[i].startsWith("http://") || toParse[i].startsWith("https://") || toParse[i].startsWith("www.")) {
            if (toParse[i].startsWith("www.")) reprocessedContent += "<a href=\"http://" + toParse[i] + "\">" + toParse[i] + "</a> ";
            else reprocessedContent += "<a href=\"" + toParse[i] + "\" class=\"article-content\">" + toParse[i] + "</a> ";
        }else{
            reprocessedContent += toParse[i] + " ";
        }
    }

    reprocessedContent = reprocessedContent.replace("\n", "<br>");
    reprocessedContent += "</div>";
%>
<%@ include file="./html/header.jsp" %>
<div class="bloc tc-black" id="bloc-83">
    <div class="container bloc-sm">
        <div class="row">
            <div class="col" style="overflow-wrap: break-word;">
                <style>
                    .article-content {
                        font-family: "Playfair Display", serif;
                    }
                </style>
                <h1 class="mg-md h1-95-style tc-black"><%=articleData.title%><br></h1>
                <h2 class="mg-md tc-black">By Youth Activists Department<br></h2>
                <h3 class="mg-md tc-black">Published Date: <%=articleData.timestamp.split(" ")[0].replace("-", " / ")%><br></h3>
                <p class="article-content">
                    <img src="<%=HTMLData.relative_thumbnail + articleData.thumbnail%>" style="width: auto; height: 400px; display: block; margin-left: auto; margin-right: auto;"/>
                    <%=reprocessedContent%>
                </p>
            </div>
        </div>
    </div>
</div>
<%=HTMLData.CONTAINER_END%>
<%@ include file="html/footer.jsp"%>
</body>
</html>