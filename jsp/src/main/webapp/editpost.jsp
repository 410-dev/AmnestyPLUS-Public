<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.DBControl" %>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="modules.members.Users" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="master.CoreBase64" %>
<%@ page import="master.LogsManager" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="modules.members.MemberData" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="html/style.html"%>
    <title>Edit Post</title>
</head>
<body>
<!-- Main container -->
<div class="page-container">

    <!-- bloc-0 -->
    <div class="bloc bgc-electric-yellow l-bloc " id="bloc-0">
        <div class="container bloc-lg bloc-sm-lg">
            <div class="row">
                <div class="col">
                    <h1 class="mg-clear h1-style mx-auto d-block text-lg-center tc-black">
                        Amnesty PLUS Article Editor
                    </h1>
                </div>
            </div>
        </div>
    </div>
    <!-- bloc-0 END -->

    <!-- bloc-1 -->
    <div class="bloc l-bloc" id="bloc-1">
        <div class="container bloc-lg bloc-sm-lg">
            <div class="row">
                <div class="col">
                </div>
            </div>
        </div>
    </div>
    <!-- bloc-1 END -->

    <!-- bloc-6 -->
    <div class="bloc l-bloc full-width-bloc" id="bloc-6">
        <div class="container bloc-lg bloc-no-padding-lg">
            <div class="row">
                <div class="col-lg-6 offset-lg-3 offset-md-2 col-md-8">
                    <form data-form-type="blocs-form" action="./editpost.jsp" method="POST">
                        <div class="form-group">
                            <input name="title" id="title" class="form-control" required placeholder="Title"/>
                        </div>
                        <div class="form-group">
                            <input name="writeas" id="writeas" class="form-control" placeholder="Author ID (Optional)"/>
                        </div>
                        <div class="form-group">
                            <label class="post_text_style mg-sm">
                                Type of Article<br>
                            </label>
                            <select class="form-control" required name="type" id="type">
                                <option value="News">
                                    News
                                </option>
                                <option value="Opinion">
                                    Opinions
                                </option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="post_text_style">
                                Content
                            </label><textarea id="content" name="content" class="form-control" rows="8" cols="50" required></textarea>
                        </div><button class="bloc-button btn btn-d btn-lg btn-block post_text_style" type="submit">
                        Post
                    </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- bloc-6 END -->

    <!-- ScrollToTop Button -->
    <a class="bloc-button btn btn-d scrollToTop" onclick="scrollToTarget('1',this)"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 32 32"><path class="scroll-to-top-btn-icon" d="M30,22.656l-14-13-14,13"/></svg></a>
    <!-- ScrollToTop Button END-->

</div>
<!-- Main container END -->



<!-- Additional JS -->
<script src="./js/jquery-3.5.1.min.js?1880"></script>
<script src="./js/bootstrap.bundle.min.js?3622"></script>
<script src="./js/blocs.min.js?9534"></script>
<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();
    try{
        if (request.getParameter("articleID") == null && request.getParameter("content") == null) {
            script.println("<script>alert('Invalid access.');window.history.back();</script>");
        }

        if (session.getAttribute("AMLoginData") == null) {
            session.setAttribute("AMShouldRedirect", "./editpost.jsp?articleID=" + request.getParameter("articleID"));
            response.sendRedirect("./login.jsp");
            return;
        }

        if (!((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(400)) {
            LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "WARNING", "Access refused for editpost");
            script.println("<script>alert('Sorry, you do not have access to this page.');");
            script.println("window.location.replace('./index.jsp');</script>");
        }

        if (request.getParameter("articleID") != null) {
            AManagement amanager = new AManagement();
            String[] articleData = amanager.getArticle(request.getParameter("articleID"));

            String content = CoreBase64.decode(articleData[11]);
            content = content.replace(" <br> ", " \\<br> ");

            script.println("<body onload=\"setElementValue('"
                    + CoreBase64.decode(articleData[1]).replace("\n", "")
                    + "', '" + articleData[5].replace("\n", "")
                    + "', '" + articleData[4].replace("\n", "")
                    + "', '" + "content"
                    + "');\">");
        }else if (request.getParameter("content") != null) {
            if (request.getParameter("content").equals("")) {
                script.println("<script>alert('No contents written.');window.location.replace('./writepost.jsp');</script>");
                return;
            }

            if (!request.getParameter("content").startsWith("::::thumbnail=")) {
                script.println("<script>alert('Thumbnail is not declared properly at the beginning of the content.');window.location.replace('./writepost.jsp');</script>");
                return;
            }
            AManagement amanager = new AManagement();
            Users useragent = new Users();

            if (request.getParameter("writeas") != "" && !DBControl.executeQuery("select * from members where username=\"" + request.getParameter("writeas") + "\";").next()) {
                script.println("<script>alert('Error: Unable to find user: " + request.getParameter("writeas") + "');\nwindow.history.back();</script>");
                return;
            }

            String[] parseThumbnail = request.getParameter("content").split("\n");
            if (parseThumbnail[0].replace("::::thumbnail=", "").equals("")) {
                script.println("<script>alert('Thumbnail is not declared properly at the beginning of the content.');window.location.replace('./writepost.jsp');</script>");
                return;
            }

            String content = "";
            for (int i = 1; i < parseThumbnail.length; i++) content += parseThumbnail[i] + "\n";

            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime currentTime = LocalDateTime.now();
            amanager.post_title = CoreBase64.encode(request.getParameter("title"));
            amanager.post_edit = timeFormatter.format(currentTime);
            amanager.post_type = request.getParameter("type");
            amanager.post_photoURLs = parseThumbnail[0].replace("::::thumbnail=", "");
            amanager.post_content = CoreBase64.encode(content.replace("\n", " <br> "));

            amanager.editArticle();
            if (request.getParameter("writeas") == "") script.println("<script>alert('Successfully posted your article.');\nwindow.location.replace('./adminterminal.jsp');</script>");
            else script.println("<script>alert('Successfully posted " + useragent.getUserDataString(amanager.post_auth_id, "realname") + "'s article.');\nwindow.location.replace('./adminterminal.jsp');</script>");
        }
    } catch (Exception e) {
        session.setAttribute("AMError", new PageExceptionPayload(e, "editpost.jsp"));
        script.println("<script>window.location.replace(\"./error.jsp\")</script>");
    }
%>

<script>
    function setElementValue(title, authorid, type, content) {
        document.getElementById('title').value = title;
        document.getElementById('writeas').value = authorid;
        document.getElementById('type').value = type;
        document.getElementById('content').value = content.replace("<br>", "\n");
    }
</script>

</body>
</html>
