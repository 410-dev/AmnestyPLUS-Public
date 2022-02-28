<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="defaults.SignedDocument" %>
<%@ page import="modules.members.MemberData" %>
<%@ page import="master.LogsManager" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css?874">
    <link rel="stylesheet" type="text/css" href="style.css?8531">

    <title>Check Document Signature</title>

</head>
<body>
<!-- Main container -->
<div class="page-container">

    <!-- bloc-0 -->
    <div class="bloc bgc-electric-yellow l-bloc " style="background-color: #fcf060;" id="bloc-0">
        <div class="container bloc-lg bloc-sm-lg">
            <div class="row">
                <div class="col">
                    <h1 class="mg-clear h1-style mx-auto d-block text-lg-center tc-black">
                        Amnesty PLUS Document Signature Checking System (<%=SignedDocument.signerVersion%>)
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
                    <%
                        SignedDocument doc = null;
                        request.setCharacterEncoding("UTF-8");
                        if (session.getAttribute("AMDocumentVerification") != null) {
                            doc = (SignedDocument) session.getAttribute("AMDocumentVerification");
                    %><p style="color: black">Document Name: <%=doc.documentName%></p><%
                    if (doc.documentSigned) { %>
                    <p style="color: green">Document contains a valid signature.</p>
                    <%
                    }else{ %>
                    <p style="color: red">Document is not signed.</p>
                    <%}
                    String str = "<br>";
                    for(String[] s : doc.unknownData) str+= "[ " + s[0] + ": " + s[1] + " ]<br>";
                    %>
                    <% if(doc.documentSigned) {%>
                        <% if(doc.isDocumentModifiedAfterSign) {%>
                            <p style="color: red">File is modified.</p>
                        <%}else{%>
                            <p style="color: green">File is not modified.</p>
                        <%}%>
                        <% if(doc.isDocumentSignBroken) {%>
                            <p style="color: red">File / Signature is broken.</p>
                        <%}else{%>
                            <p style="color: green">File / Signature is not broken.</p>
                        <%}%>
                    <%}%>
                    <div id="record">
                        <p style="color: black">Author: <%=doc.authorIdentity%></p>
                        <p style="color: black">Signed Authority: <%=doc.signIdentity%></p>
                        <p style="color: black">Signed Date: <%=doc.signedDate%></p>
                        <p style="color: black">Valid Until: <%=doc.expireDate%></p>
                        <p style="color: black">Signature Version: <%=doc.signedVersion%></p>
                        <p style="color: black">Unknown Attributes: <%=str%></p>
                        <p style="color: black;"><%=doc.exceptions%></p>
                    </div>
                    <%
                    }
                        if (doc != null && !doc.documentSigned) {%>
                    <script>
                        document.getElementById("record").style.display = 'none';
                    </script>
                    <%}
                        session.removeAttribute("AMDocumentVerification");
                %>

                    <%
                        request.setCharacterEncoding("UTF-8");
                        if(session.getAttribute("Signature") != null) {
                    %><p style="color: black; text-align:left; overflow-wrap: break-word;">Generated Signature:<br><%=SignedDocument.IDENTIFIER + session.getAttribute("Signature").toString() + SignedDocument.IDENTIFIER_END%></p>
                    <br><br><br><p style="color: black; text-align:left; overflow-wrap: break-word;">Signature Contains: <br><%=session.getAttribute("ConfirmData").toString()%></p>
                    <%
                            session.removeAttribute("Signature");
                            session.removeAttribute("ConfirmData");
                        }
                    %>
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
                    <form data-form-type="blocs-form" action="DocumentSignature" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="check"><br>
                        <input style="color:black" type="file" name="file" required><br>
                        <button class="bloc-button btn btn-d btn-lg btn-block post_text_style" type="submit">
                            Verify
                        </button>
                    </form>
                    <br>
                    <br>
                    <br>
                    <%
                        session.setAttribute("AMShouldRedirect", "./checkSign.jsp");
                        if (session.getAttribute("AMLoginData") != null) {
                            if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
                                %>
                                    <form data-form-type="blocs-form" action="DocumentSignature" method="POST">
                                        <input type="hidden" name="action" value="generate"><br>
                                        <input type="text" name="author" placeholder="Author" required><br>
                                        <input type="text" name="valid" placeholder="Valid Until (YYYY-MM-DD)"><br>
                                        <input type="text" name="custom_attributes" placeholder="Custom Attributes (id=data; id=data;)"><br>
                                        <button class="bloc-button btn btn-d btn-lg btn-block post_text_style" type="submit">
                                            Generate
                                        </button>
                                    </form>
                                <%
                            }else{%>
                                <div style="text-align: center;">
                                    <a>You do not have enough permission to generate a signature.</a>
                                </div>
                            <%}
                        }else{%>
                            <div style="text-align: center;">
                                <a href="login.jsp">Login to generate signature</a>
                            </div>
                        <%}%>
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

</body>
</html>
