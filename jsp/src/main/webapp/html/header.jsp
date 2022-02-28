<%@ page import="master.Configurations" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<%
  if (new Configurations().get("site_close").equals("true")) {
    response.sendRedirect("./closed.jsp");
  }
%>
<style>
body {
  font-family: Arial, Helvetica, sans-serif;
}

@font-face {
	font-family:'AmnestyTradeGothic';
	src: url('https://amnestyplus.org/en/fonts/AmnestyTradeGothic-BdCn20/amnesty.woff');
	src: url('https://amnestyplus.org/en/fonts/AmnestyTradeGothic-BdCn20/amnesty.woff') format('woff');
	font-weight: normal;
	font-style: normal;
}

.navbar-right {
  float: right;
}

.navbar {
  font-family: "AmnestyTradeGothic";
  background-color: black;
}

.navbar a {
  float: left;
  font-size: 16px;
  color: white;
  text-align: center;
  padding: 16px 18px;
  text-decoration: none;
  margin: 10px
}

.drpdwn {
  float: left;
  overflow: hidden;
}

.drpdwn .dropbtn {
  font-size: 16px;
  border: none;
  outline: none;
  color: white;
  padding: 16px 18px;
  background-color: inherit;
  font-family: inherit;
  margin: 10px;
}

.navbar a:hover, .drpdwn:hover .dropbtn {
  background-color: #960018;
}

.lsymb a:hover {
  background-color: black;
}

.hdtitle a:hover {
  background-color: transparent;
}

.drpdwn-content {
  display: none;
  position: absolute;
  background-color: black;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 10;
}

.drpdwn-content a {
  float: none;
  color: white;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.drpdwn-content a:hover {
  background-color: #960018;
}

.drpdwn:hover .drpdwn-content {
  display: block;
}

.logo {
  width: 50px;
  height: 60px;
}

.cntr{
  vertical-align: middle;
}

</style>

<div class="navbar">
  <div class="lsymb" style="display: inline-block; width: 300px;">
    <div style="float: left; padding: 3px">
      <img alt="index.jsp" class="logo" src="img/amlogo_white_nobg.png">
    </div>
    <div class="cntr lsymb">
      <a class="hdtitle lsymb" style="font-size: 35px; padding: 2px;" href="index.jsp">Amnesty PLUS</a>
    </div>
  </div>
  <div class="navbar-right">
    <a href="index.jsp">Home</a>
    <div class="drpdwn">
      <button class="dropbtn">About</button>
      <div class="drpdwn-content">
        <a href="about-us.jsp">Our Mission</a>
        <a href="leadership.jsp">Leadership</a>
        <a href="editors.jsp">Editors</a>
        <a href="youth_activists.jsp">Youth Activists</a>
        <a href="communication.jsp">Communication</a>
        <a href="it_department.jsp">IT Department</a>
        <a href="participating-groups.jsp">Participating Groups</a>
      </div>
    </div>
    <div class="drpdwn">
      <button class="dropbtn">Articles</button>
      <div class="drpdwn-content">
        <a href="articles.jsp?query=featured">Featured Articles</a>
        <a href="articles.jsp?query=news">News</a>
        <a href="articles.jsp?query=opinions">Opinion</a>
      </div>
    </div>
    <div class="drpdwn">
      <button class="dropbtn">Get Involved</button>
      <div class="drpdwn-content">
        <a href="official-get-involved.jsp">Official</a>
        <a href="publication-form.jsp">Unofficial</a>
      </div>
    </div>
    <div class="drpdwn">
      <button class="dropbtn">Activities</button>
      <div class="drpdwn-content">
        <a href="contest.jsp">Contest</a>
        <a href="videos.jsp">Videos</a>
      </div>
    </div>
    <a href="apyac.jsp">Youth Activists</a>
    <a href="taskforce.jsp">Task Force</a>
    <div class="drpdwn">
      <button class="dropbtn">Languages</button>
      <div class="drpdwn-content">
        <a href="https://amnestyplus.org/ko">한국어</a>
        <a href="https://amnestyplus.org/en">English</a>
      </div>
    </div>
  </div>
</div>

