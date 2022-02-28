<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="master.HTMLData" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="master.CoreBase64" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="html/style.html" %>
    <title>There was an error</title>
</head>
<body>
<%
PrintWriter script = response.getWriter();
String errorData;
if (session.getAttribute("AMError") == null) {
    script.println("<script>alert(\"No errors were reported. We will redirect you to previous page.\"); window.history.back();</script>");
    return;
}else{
    errorData = ((PageExceptionPayload) session.getAttribute("AMError")).getData()[0] + "\n\n<br><br>" + ((PageExceptionPayload) session.getAttribute("AMError")).getData()[1];
    errorData = CoreBase64.encode(errorData);
    session.removeAttribute("AMError");
}
%>
    <%@ include file="./html/header.jsp" %>
    <%=HTMLData.CONTAINER_START%>
    <div style="padding-top: 150px;">
        <h1 style="text-align: center;">There was an error while processing your request.</h1>
        <h4 style="text-align: center;">
            Sorry for inconvenience. We will fix this as soon as possible.
            <br>
            Reporting this error is very helpful for fixing this error effectively.
        </h4>
        <div style="padding-top: 130px; padding-bottom: 130px; align-content: center; text-align: center">
            <a style="text-align: center" href="https://docs.google.com/forms/d/e/1FAIpQLSdRMM2vWwXLIANYOSTkffzJkAUHEfDoKKmQVAaSEzrE2mceJQ/viewform?usp=pp_url&entry.47964185=<%=errorData%>" style="text-align:center;">Click here to report.</a>
        </div>
        <a style="color: white" onclick="viewlog()">Open Base64 Log</a>
    </div>

    <div id="errorlog" style="display: none">
        <p style="text-align:left; overflow-wrap: break-word;">Error Data: <b><%=errorData%></b><br></p>
    </div>
    <%=HTMLData.CONTAINER_END%>
    <%@ include file="html/footer.jsp"%>
</body>
<script>
    document.getElementById("errorlog").style.display = 'none';
    function viewlog() {
        document.getElementById("errorlog").style.display = 'block';
    }
</script>
</html>