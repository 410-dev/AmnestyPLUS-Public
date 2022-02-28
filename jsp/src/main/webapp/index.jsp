<%@ page import="java.sql.ResultSet" %>
<%@ page import="modules.articles.AManagement" %>
<%@ page import="defaults.PageExceptionPayload" %>
<%@ page import="defaults.article.Article" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="html/style.html" %>
	<title>Amnesty PLUS - Home</title>
</head>
<style>
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

	a {
		color:black;
		text-decoration: none;
	}

	a:visited {
		color:black;
	}

	a:link {
		color: black;
	}

	a:visited {
		color: black;
	}

	a:hover {
		color: black;
	}

	a:active {
		color: black;
	}

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
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file="./html/header.jsp" %>
<%!
	private String[] filler = {
			"-1",
			"Coming Soon",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
			"UNDEFINED",
	};

	private String[][] writeArticleDataStructure(int numberOfDisplay, int articleDataSize, ResultSet rs) throws Exception {
		AManagement articlemanager = new AManagement();
		String[][] toReturn = new String[numberOfDisplay][articleDataSize];
		int i = 0;
		try {
			rs.last();
			for(; i < numberOfDisplay; i++) {
				toReturn[i] = articlemanager.getArticle(rs.getString("id"));
				if (!rs.previous()) break;
			}

			while(i < numberOfDisplay) {
				toReturn[i] = filler;
				i++;
			}
		}catch(Exception e) {
			if (e.toString().contains("Current position is before the first row")) {
				while (i < numberOfDisplay) {
					toReturn[i] = filler;
					i++;
				}
			}else{
				throw e;
			}
		}

		return toReturn;
	}

	private String getFirstLineWithoutSystemTagging(String toProcess) {
		final String[] fileExtensions = {"png", "jpg", "svg", "gif"};
		String[] contentSplittedOnSentence = toProcess.split("\\. ");
		for(String str : contentSplittedOnSentence) {
			if(!str.startsWith("::::") && !str.equals("") && !str.contains("http://") && !str.contains("https://")) {
				str = str.replace("\n", "").replace(" <br> ", "");
				if (str.contains(".")) {
					str = str.split("\\.")[0];
				}
				for (String fileExtension : fileExtensions) {
					if (str.startsWith(fileExtension)) {
						return str.substring(fileExtension.length()) + ".".replace("  ", " ");
					}
				}
				return str + ".".replace("  ", " ");
			}
		}
		return "No summary available.";
	}

	private String[][] processSummary(String[][] input) {
		final int contentLocation = 11;
		String[][] toReturn = input;
		for(int i = 0; i < input.length; i++) {
			String toProcess = input[i][contentLocation];
			toReturn[i][contentLocation] = getFirstLineWithoutSystemTagging(toProcess);
		}
		return toReturn;
	}
%>

<%
	// Load article data to splash

	final int numberOfDisplay = 6;
	final int articleDataSize = 15;

	String[][] news = new String[numberOfDisplay][articleDataSize];
	String[][] opinions = new String[numberOfDisplay][articleDataSize];
	String[][] featured = new String[numberOfDisplay][articleDataSize];

	try {
		AManagement articlemanager = new AManagement();
		ResultSet rsnews = articlemanager.getArticles("News", true);
		ResultSet rsopinions = articlemanager.getArticles("Opinion", true);
		ResultSet rsfeatured = articlemanager.filterArticles(new String[]{"post_featured=1"});

		news = writeArticleDataStructure(numberOfDisplay, articleDataSize, rsnews);
		opinions = writeArticleDataStructure(numberOfDisplay, articleDataSize, rsopinions);
		featured = writeArticleDataStructure(numberOfDisplay, articleDataSize, rsfeatured);

		news = processSummary(news);
		opinions = processSummary(opinions);
		featured = processSummary(featured);

	}catch(Exception e) {
		session.setAttribute("AMError", new PageExceptionPayload(e, "index.jsp"));
	}
%>

<body>
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
<div style="padding-bottom: 60px; padding-top: 30px;"> <!-- Featured Article Section -->
	<div class="page-container">
		<div class="bloc none l-bloc">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1 style="color: black">
							Featured Articles
						</h1>
						<div class="divider-h">
							<span class="divider"></span>
						</div>
					</div>
					<div class="col-md-6">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="">
		<div class="container">
			<div class="row">
				<div class="col-md-4"> <!-- Article 1 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=featured[0][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=featured[0][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=featured[0][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=featured[0][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=featured[0][11]%></h4>
					</div> 
				</div> <!-- Article 1 End -->
				<div class="col-md-4"> <!-- Article 2 -->
					<div style="padding-bottom: 30px;"> 
						<a class="articleImageContainer" href="./articleView.jsp?id=<%=featured[1][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=featured[1][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=featured[1][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=featured[1][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=featured[1][11]%></h4>
					</div> 
				</div> <!-- Article 2 End -->
				<div class="col-md-4"> <!-- Article 3 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=featured[2][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=featured[2][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=featured[2][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=featured[2][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=featured[2][11]%></h4>
					</div> 
				</div> <!-- Article 3 End -->
				<div class="col-md-4"> <!-- Article 1 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=featured[3][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=featured[3][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=featured[3][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=featured[3][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=featured[3][11]%></h4>
					</div> 
				</div> <!-- Article 1 End -->
				<div class="col-md-4"> <!-- Article 2 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=featured[4][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=featured[4][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=featured[4][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=featured[4][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=featured[4][11]%></h4>
					</div>
				</div> <!-- Article 2 End -->
				<div class="col-md-4"> <!-- Article 3 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=featured[5][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=featured[5][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=featured[5][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=featured[5][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=featured[5][11]%></h4>
					</div> 
				</div> <!-- Article 3 End -->
			</div>
		</div>
	</div>
</div>  <!-- End Featured Section -->
<div style="padding-bottom: 60px; padding-top: 30px;"> <!-- News Section -->
	<div class="page-container">
		<div class="bloc none l-bloc">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1 style="color: black">
							News
						</h1>
						<div class="divider-h">
							<span class="divider"></span>
						</div>
					</div>
					<div class="col-md-6">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="">
		<div class="container">
			<div class="row">
				<div class="col-md-4"> <!-- Article 1 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=news[0][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=news[0][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=news[0][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=news[0][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=news[0][11]%></h4>
					</div> 
				</div> <!-- Article 1 End -->
				<div class="col-md-4">  <!-- Article 2 -->
					<div style="padding-bottom: 30px;">
						<a href="./articleView.jsp?id=<%=news[1][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=news[1][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=news[1][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=news[1][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=news[1][11]%></h4>
					</div> 
				</div> <!-- Article 2 End -->
				<div class="col-md-4"> <!-- Article 3 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=news[2][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=news[2][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=news[2][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=news[2][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=news[2][11]%></h4>
					</div> 
				</div> <!-- Article 3 End -->
				<div class="col-md-4"> <!-- Article 1 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=news[3][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=news[3][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=news[3][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=news[3][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=news[3][11]%></h4>
					</div> 
				</div> <!-- Article 1 End -->
				<div class="col-md-4"> <!-- Article 2 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=news[4][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=news[4][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=news[4][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=news[4][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=news[4][11]%></h4>
					</div> 
				</div> <!-- Article 2 End -->
				<div class="col-md-4"> <!-- Article 3 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=news[5][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=news[5][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=news[5][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=news[5][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=news[5][11]%></h4>
					</div> 
				</div> <!-- Article 3 End -->
			</div>
		</div>
	</div>
</div>  <!-- End News Section -->
<div style="padding-bottom: 60px; padding-top: 30px;"> <!-- Opinion Section -->
	<div class="page-container">
		<div class="bloc none l-bloc">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1 style="color: black">
							Opinions
						</h1>
						<div class="divider-h">
							<span class="divider"></span>
						</div>
					</div>
					<div class="col-md-6">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="">
		<div class="container">
			<div class="row">
				<div class="col-md-4"> <!-- Article 1 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=opinions[0][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=opinions[0][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=opinions[0][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=opinions[0][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=opinions[0][11]%></h4>
					</div> 
				</div> <!-- Article 1 End -->
				<div class="col-md-4"> <!-- Article 2 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=opinions[1][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=opinions[1][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=opinions[1][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=opinions[1][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=opinions[1][11]%></h4>
					</div> 
				</div> <!-- Article 2 End -->
				<div class="col-md-4"> <!-- Article 3 -->
					<div style="padding-bottom: 30px;">
						<a href="./articleView.jsp?id=<%=opinions[2][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=opinions[2][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=opinions[2][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=opinions[2][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=opinions[2][11]%></h4>
					</div> 
				</div> <!-- Article 3 End -->
				<div class="col-md-4"> <!-- Article 1 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=opinions[3][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=opinions[3][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=opinions[3][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=opinions[3][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=opinions[3][11]%></h4>
					</div> 
				</div> <!-- Article 1 End -->
				<div class="col-md-4"> <!-- Article 2 -->
					<div style="padding-bottom: 30px;"> 
						<a href="./articleView.jsp?id=<%=opinions[4][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=opinions[4][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=opinions[4][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=opinions[4][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=opinions[4][11]%></h4>
					</div> 
				</div> <!-- Article 2 End -->
				<div class="col-md-4"> <!-- Article 3 -->
					<div style="padding-bottom: 30px;">
						<a href="./articleView.jsp?id=<%=opinions[5][0]%>">
							<div class="articleImageContainer"><img class="articleImage" src="<%=opinions[5][12]%>"/></div>
						</a>
						<a style="padding-top: 15px" href="./articleView.jsp?id=<%=opinions[5][0]%>"><h2 style="padding-top: 17px; font-size: 22px"><%=opinions[5][1]%></h2></a>
						<h4 style="color: gray; font-size: 18px;"><%=opinions[5][11]%></h4>
					</div> 
				</div> <!-- Article 3 End -->
			</div>
		</div>
	</div>
</div>  <!-- End Opinion Section -->
<script>
	function hideWarning() {
		document.getElementById("opinionwarning").style.display = 'none';
	}
</script>
<%@ include file="./html/footer.jsp" %>
<script src="./js/jquery-3.5.1.min.js?7930"></script>
<script src="./js/bootstrap.bundle.min.js?1757"></script>
<script src="./js/blocs.min.js?520"></script>
<script src="./js/lazysizes.min.js" defer></script><!-- Additional JS END -->
</body>
</html>