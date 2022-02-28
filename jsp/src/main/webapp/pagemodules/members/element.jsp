<%@ page import="master.HTMLData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String photoAddress = request.getParameter("photoAddress");
    String realname = request.getParameter("realname");
    String userrole = request.getParameter("userrole");
    String bio = request.getParameter("bio");
%>

<div class="row">
    <div class="col-lg-3">
        <div class="circleProfileContainer">
            <img src="<%=HTMLData.relative_location + photoAddress%>" class="profile"/>
        </div>
    </div>
    <div class="col offset-lg-0">
        <h1 class="mg-md tc-black">
            <%=realname%>
        </h1>
        <h2 class="mg-md tc-black">
            <%=userrole%>
        </h2>
        <h6 class="mg-md">
            <%=bio%>
        </h6>
    </div>
</div>
<br>
