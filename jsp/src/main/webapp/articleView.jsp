<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="master.DBControl" %>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="master.HTMLData" %>
<%@ page import="modules.members.MemberData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="master.CoreBase64" %>
<!DOCTYPE html>
<html>
<%
AManagement manager = new AManagement();
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

// Add more code here
/* 0: ID
 * 1: Title
 * 2: Date Written
 * 3: Date Edit
 * 4: Type
 * 5: Author ID
 * 6: Author Realname
 * 7: Author Email
 * 8: Author Role
 * 9: Author Photo Address
 * 10: Post Status (PENDING / PUBLIC / REJECT / DELETED)
 * 11: Content
 * 12: Photos URL
 * 13: View Counts (Int) as String
 * 14: Featured (Bool) as String
 */

String[] articleData = manager.getArticle(aid);


String pardonButtonData = "<div>";

// Add permission check here!
if (articleData[10].equals("PENDING")) {
	if (session.getAttribute("AMLoginData") == null) {
		script.println("<script>alert('No such article found. Error: NOLOGIN');");
	    script.println("window.location.replace('./index.jsp');</script>");
	    return;
	}else if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
		articleData[1] = "[PENDING] " + articleData[1];
		pardonButtonData += "<form action=\"ArticleApprove\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Approve\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
		pardonButtonData += "<form action=\"ArticleReject\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Reject\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
		pardonButtonData += "<form action=\"ArticleDelete\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Delete\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
	}else{
		script.println("<script>alert('No such article found. Error: ASTAT_PEN');");
	    script.println("window.location.replace('./index.jsp');</script>");
	    return;
	}
   
}else if (articleData[10].equals("REJECT")) {
	if (session.getAttribute("AMLoginData") == null) {
		script.println("<script>alert('No such article found. Error: NLGN');");
	    script.println("window.location.replace('./index.jsp');</script>");
	    return;
	}else if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
		articleData[1] = "[REJECTED] " + articleData[1];
		pardonButtonData += "<form action=\"ArticleApprove\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Pardon & Republish\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
		pardonButtonData += "<form action=\"ArticleDelete\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Delete\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
	}else{
		script.println("<script>alert('No such article found. Error: ASTAT_REJ');");
		script.println("window.location.replace('./index.jsp');</script>");
		return;
	}
}else if (articleData[10].equals("DELETED")) {
	if (session.getAttribute("AMLoginData") == null) {
		script.println("<script>alert('No such article found. Error: NOLOGIN');");
	    script.println("window.location.replace('./index.jsp');</script>");
	    return;
	}else if (((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
		articleData[1] = "[DELETED] " + articleData[1];
		pardonButtonData += "<form action=\"ArticleApprove\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Approve\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
		pardonButtonData += "<form action=\"ArticleReject\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Reject\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
	}else{
		script.println("<script>alert('This article no longer exists.');");
		script.println("window.location.replace('./index.jsp');</script>");
		return;
	}
}else if (articleData[10].equals("PUBLIC")){
	if (session.getAttribute("AMLoginData") != null && ((MemberData) session.getAttribute("AMLoginData")).hasPermissionOf(200)) {
		pardonButtonData += "<form action=\"ArticleDelete\" method=\"POST\" style=\"text-align:center;\">\n";
		pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
		pardonButtonData += "	<input type=\"submit\" value=\"Delete\" style=\"display: inline-block; position: relative;\"/>\n";
		pardonButtonData += "</form>";
		if (articleData[14].equals("0")) {
			pardonButtonData += "<form action=\"ArticleSetFeatured\" method=\"POST\" style=\"text-align:center;\">\n";
			pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
			pardonButtonData += "   <input type=\"hidden\" name=\"bool\" value=\"true\"/>\n";
			pardonButtonData += "	<input type=\"submit\" value=\"Elect as Featured Article\" style=\"display: inline-block; position: relative;\"/>\n";
			pardonButtonData += "</form>";
		}else{
			pardonButtonData += "<form action=\"ArticleSetFeatured\" method=\"POST\" style=\"text-align:center;\">\n";
			pardonButtonData += "	<input type=\"hidden\" name=\"id\" value=\"" + aid + "\"/>\n";
			pardonButtonData += "   <input type=\"hidden\" name=\"bool\" value=\"false\"/>\n";
			pardonButtonData += "	<input type=\"submit\" value=\"Remove from Featured Article\" style=\"display: inline-block; position: relative;\"/>\n";
			pardonButtonData += "</form>";
		}
	}
}
pardonButtonData += "</div>";

//Process to HTML type
String reprocessedContent = "<div class=\"article-content\">";
String imageSlideFiles = "";
String[] toParse = articleData[11].split(" |\n|\u00A0");
int imagesCount = 0;
for(int i = 0; i < toParse.length; i++) {
	if (toParse[i].startsWith("http://") || toParse[i].startsWith("https://") || toParse[i].startsWith("www.")) {
		for(int ii = 0; ii < 3; ii++) {
			if (toParse[i].substring(toParse[i].length() - ii).contains(".")) {
				toParse[i] = toParse[i].substring(0, toParse[i].length() - ii);
				break;
			}
		}
		if (toParse[i].startsWith("www.")) {
			reprocessedContent += "<a href=\"http://" + toParse[i] + "\" class=\"article-content\">" + toParse[i] + "</a>. ";
		} else {
			reprocessedContent += "<a href=\"" + toParse[i] + "\" class=\"article-content\">" + toParse[i] + "</a>. ";
		}
	}else if (toParse[i].startsWith("::::image=")) {
		reprocessedContent += "<img src=\"" + toParse[i].substring("::::image=".length()) + "\" style=\"width: 95%; height: 70%; display: block; margin-left: auto; margin-right: auto;\"/>";
	}else if (toParse[i].startsWith("::::section")) {
		reprocessedContent += "<div><hr><br></div>";
	}else if (toParse[i].startsWith("::::warning=(")) {
		String warningText = "";
		int endIndex = 0;
		for(int j = i; j < toParse.length; j++) {
			if (toParse[j].endsWith(")")) {
				endIndex = j;
				break;
			}
		}
		for(int j = i; j <= endIndex; j++) {
			if (toParse[j].startsWith("::::warning=(")) {
				warningText += toParse[j].replace("::::warning=(", "");
			}else if (j == endIndex) {
				warningText += toParse[j].substring(0, toParse[j].length()-1);
			}else{
				warningText += toParse[j];
			}
			warningText += " ";
		}
		i = endIndex;
		String warningForm = "<div class=\"col-xl-11\" style=\"margin-left: auto; margin-right: auto; padding-bottom: 25px;\">" +
				"<div style=\"background-color: red; opacity: 0.7; padding: 10px; border-radius: 10px; color: white; text-align: center;\">" +
				"<a>" + warningText + "</a>" +
				"</div>" +
				"</div>";
		reprocessedContent = warningForm + reprocessedContent;
	}else if (toParse[i].startsWith("::::image_slide=")) {
		String fileName = "";
		toParse[i] = toParse[i].substring("::::image_slide=".length());
		boolean shouldExit = false;
		while(!shouldExit) {
			while(true) {
				if (toParse[i].equals(";")) {
					i++;
					shouldExit = true;
					break;
				}else if (toParse[i].equals("/")) {
					imagesCount++;
					fileName += "<IMAGESPLIT>";
					i++;
					break;
				}else{
					fileName += "%20" + toParse[i];
					i++;
					break;
				}
			}
		}
		imageSlideFiles = fileName.substring(3);
		imageSlideFiles = imageSlideFiles.substring(0, imageSlideFiles.length()-2);
	}else{
		reprocessedContent += toParse[i] + " ";
	}
}

reprocessedContent = reprocessedContent.replace("\n", "<br>");
reprocessedContent += "</div>";
if (imagesCount > 0) {
	reprocessedContent += "<div>";
	reprocessedContent += HTMLData.SLIDE_START + "\n";
	reprocessedContent += HTMLData.SLIDE_INDICATOR_START + "\n";
	for(int i = 0; i < imagesCount; i++) {
		reprocessedContent += HTMLData.SLIDE_INDICATOR_ELEMENT_START + i + HTMLData.SLIDE_INDICATOR_ELEMENT_END + "\n";
	}
	reprocessedContent += HTMLData.SLIDE_INDICATOR_END + "\n";
	reprocessedContent += HTMLData.SLIDE_CONTENT_START + "\n";
	for(int i = 0; i < imagesCount; i++) {
		reprocessedContent += HTMLData.SLIDE_CONTENT_ELEMENT_START + imageSlideFiles.split("<IMAGESPLIT>")[i] + HTMLData.SLIDE_CONTENT_ELEMENT_END + "\n";
	}
	reprocessedContent += HTMLData.SLIDE_CONTENT_END + "\n";
	reprocessedContent += HTMLData.SLIDE_END + "\n</div>";
}

String citation = "";

if (reprocessedContent.contains("::::citation")) {
	citation = reprocessedContent.split("::::citation")[1];
	reprocessedContent = reprocessedContent.split("::::citation")[0];
}

if (articleData[10].equals("PUBLIC")) {
	try{
		String statement = "update articles set post_viewcounts=" + (Integer.parseInt(articleData[13]) + 1) + " where id=" + articleData[0] + ";";
		DBControl.executeQuery(statement);
	}catch(Exception e){}
}

%>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<title><%=articleData[1]%> - Amnesty PLUS</title>
</head>
<body>
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
				<%=pardonButtonData%>
				<h1 class="mg-md h1-95-style tc-black"><%=articleData[1]%><br></h1>
				<h2 class="mg-md tc-black">By <%=articleData[6]%><br></h2>
				<h3 class="mg-md tc-black">Published Date: <%=articleData[2].split(" ")[0].replace("-", " / ")%><br></h3>
				<p><%=articleData[13]%> Views</p>
				<p class="article-content">
					<%=reprocessedContent%>
					<div style="padding-top: 13px">
						<button onclick="toggle()" id="citationbutton" class="">Show Citation</button>
					</div>
					<p id="citation" class="article-content">
						Works Cited
						<%=citation%>
					</p>
				</p>
			</div>
		</div>
		<div class="row">
			<style>
				.xdivider {
					width:28%;
					background-clip:content-box!important;
					-webkit-background-clip:content-box!important;
					background-color:#FF0034;
					height:45px;
					padding:20px 0;
					display:inline-block;
				}
				.articleImage {
					width: 100%;
					height: 100%;
					object-fit: cover;
				}

				.articleImageContainer{
					/*width: 100%;*/
					height: 180px;
					overflow: hidden;
				}
			</style>
			<div class="col">
				<h3 class="mg-md tc-black" style="padding-top: 20px">Recommended Articles</h3>
				<div class="divider-h xdivider">
					<span class="divider"></span>
				</div>
			</div>
			<style>
				.recommendation a {
					color:black;
					text-decoration: none;
				}

				.recommendation a:visited{
					color:black;
				}

				.recommendation a:link{
					color: black;
				}

				.recommendation a:visited{
					color: black;
				}

				.recommendation a:hover{
					color: black;
				}

				.recommendation a:active {
					color: black;
				}
			</style>
			<div class="row">
			<%
				ResultSet rs = DBControl.executeQuery("select * from articles order by RAND() limit 4;");
				while(rs.next()) {
			%>
				<div class="col-sm-3">
					<div class="recommendation" style="padding-bottom: 30px;">
						<a href="./articleView.jsp?id=<%=rs.getString("id")%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=rs.getString("post_photoURLs")%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=rs.getString("id")%>">
							<h2 style="padding-top: 17px; font-size: 22px"><%=CoreBase64.decode(rs.getString("post_title"))%></h2>
						</a>
					</div>
				</div>
			<%}%>
			</div>
		</div>
	</div>
</div>
<script>
	var isCitationVisible = false;
	document.getElementById("citation").style.display = 'none';
	function toggle() {
		isCitationVisible = !isCitationVisible;
		if (isCitationVisible) {
			document.getElementById("citation").style.display = 'block';
			document.getElementById("citationbutton").innerHTML = "Hide Citation";
		}else{
			document.getElementById("citation").style.display = 'none';
			document.getElementById("citationbutton").innerHTML = "Show Citation";
		}
	}
</script>
<%=HTMLData.CONTAINER_END%>
<%@ include file="html/footer.jsp"%>
</body>
</html>