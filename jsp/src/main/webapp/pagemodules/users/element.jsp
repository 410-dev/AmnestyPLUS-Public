<%@ page import="master.HTMLData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../html/style.html" %>
<%@ include file="style.html"%>
<%
    String realname = request.getParameter("realname");
    String username = request.getParameter("username");
    String permission = request.getParameter("permission");
    String status = request.getParameter("status");
    String email = request.getParameter("email");
    String userrole = request.getParameter("userrole");
    String strikes = request.getParameter("strikes");
    String photoAddress = request.getParameter("photoAddress");
    String queue  = request.getParameter("queue");
%>

<%=HTMLData.USER_ELEMENT_START%>
<br><h2><%=realname%></h2>
<p><b>User ID: </b><%=username%></p>
<p><b>Permission:  </b><%=permission%></p>
<p><b>Account Status:  </b><%=status%></p>
<p><b>Email:  </b><%=email%></p>
<p><b>Role:  </b><%=userrole%></p>
<p><b>Strikes: </b><%=strikes%></p>
<%=HTMLData.USER_ELEMENT_IMAGE_START + photoAddress + HTMLData.USER_ELEMENT_IMAGE_END%><br>
<div class="block_align_horizontal" style="display: inline-block;">
    <form action="./editaccount.jsp" method="POST" style="text-align:center;">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input class="button" type="submit" value="Edit" style="display: inline-block; position: relative;"/>
    </form>
    <form action="./writemail.jsp" method="GET" style="text-align:center;">
        <input type="hidden" name="user" value="<%=email%>"/>
        <input class="button" type="submit" value="Send Mail" style="display: inline-block; position: relative;"/>
    </form>
    <% if (status.equals("PENDING")) { %>
        <form action="ChangeAccountData" method="POST" style="text-align:center;">
            <input type="hidden" name="key" value="status"/>
            <input type="hidden" name="user" value="<%=username%>"/>
            <input type="hidden" name="newData" value="NORMAL"/>
            <input class="safe_button" type="submit" value="Approve" style="display: inline-block; position: relative;"/>
        </form>
        <form action="AccountDelete" method="POST" style="text-align:center;">
            <input type="hidden" name="user" value="<%=username%>"/>
            <input class="dangerous_button" type="submit" value="Reject" style="display: inline-block; position: relative;"/>
        </form>
    <%}else{%>
        <form action="GiveStrike" method="POST" style="text-align:center;">
            <input type="hidden" name="user" value="<%=username%>"/>
            <input type="text" name="reason" placeholder="Reason" required/>
            <input class="dangerous_button" type="submit" value="Give Strike" style="display: inline-block; position: relative;"/>
        </form>
        <form action="./viewUserArticle.jsp" method="POST" style="text-align:center;">
            <input type="hidden" name="user" value="<%=username%>"/>
            <input class="button" type="submit" value="Articles" style="display: inline-block; position: relative;"/>
        </form>
        <%if (!queue.equals("0")) { %>
            <form action="ArticleAllApprove" method="POST" style="text-align:center;">
                <input type="hidden" name="user" value="<%=username%>"/>
                <input class="safe_button" type="submit" value="Approve All Articles" style="display: inline-block; position: relative;"/>
            </form>
            <form action="ArticleAllReject" method="POST" style="text-align:center;">
                <input type="hidden" name="user" value="<%=username%>"/>
                <input class="dangerous_button" type="submit" value="Reject All Articles" style="display: inline-block; position: relative;"/>
            </form>
        <%}%>
    <%}%>
</div>
<%=HTMLData.USER_ELEMENT_END%>

