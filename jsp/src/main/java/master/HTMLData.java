package master;

public class HTMLData {

	public static String relative_location = "./img/profiles/";
	public static String relative_thumbnail = "./img/thumbnails/";
//	public static String image_location = "/usr/local/apache-tomcat-8.5.57/webapps/ROOT/" + relative_location;
	public static String image_location = "/opt/tomcat/apache-tomcat-8.5.61/webapps/ROOT/" + relative_location;

	public static String CONTAINER_START = "<div class=\"bloc tc-black\" id=\"bloc-83\">\n"
			+ "	<div class=\"container bloc-sm\">\n"
			+ "		<div class=\"row\">\n"
			+ "			<div class=\"col\">\n";
	public static String CONTAINER_END = "			</div>\n"
			+ "		</div>\n"
			+ "	</div>\n"
			+ "</div>";
	
	public static String SEARCH_USER_BOX = "<form action=\"./userlist.jsp\">\n"
		+ " 	 <select required name=\"category\">\n"
		+ "		   <option value=\"realname\">Name</option>\n"
		+ "		   <option value=\"username\">User ID</option>\n"
		+ "		   <option value=\"permission\">Permission</option>\n"
		+ "		   <option value=\"status\">Account Status</option>\n"
		+ "		   <option value=\"email\">Email</option>\n"
		+ "		   <option value=\"userrole\">Role</option>\n"
		+ "		   <option value=\"strikes\">Strikes</option>\n"
		+ "		 </select>"
		+ "      <input type=\"text\" placeholder=\"Search User...\" name=\"userquery\">\n"
		+ "      <input type=\"submit\" value=\"Search\"/>\n"
		+ "    </form>";
	
	public static String SEARCH_ARTICLE_BOX = "<form action=\"./articleList.jsp\">\n"
		+ "         <select required name=\"type\">\n"
		+ "			  <option id=\"type\" value=\"News\">News</option>\n"
		+ "			  <option id=\"type\" value=\"Opinion\">Opinion</option>\n"
		+ "			</select>\n"
		+ "      <input type=\"text\" placeholder=\"Search Article...\" name=\"query\">\n"
		+ "      <input type=\"submit\" value=\"Search\"/>\n"
		+ "    </form>";

	
	public static String USER_ELEMENT_START = "<div class=\"col-sm\" style=\"text-align:center;\">";
	public static String USER_ELEMENT_IMAGE_START = "<img src=\"" + relative_location;
	public static String USER_ELEMENT_IMAGE_END = "\" width=\"100\" height=\"100\" class=\"img-fluid mx-auto d-block lazyloaded\">";
	public static String USER_ELEMENT_END = "</div>";

	public static String MEMBER_TITLE_START = "<h1 class=\"mg-md tc-black text-lg-center\">\n";
	public static String MEMBER_TITLE_END = "</h1>\n<h6 class=\"mg-md\">\n<br>\n</h6>";

	public static String SLIDE_START = "<div id=\"carousel-1\" class=\"carousel slide carousel-style\" data-ride=\"carousel\">";
	public static String SLIDE_INDICATOR_START = "<ol class=\"carousel-indicators\">";
	public static String SLIDE_INDICATOR_ELEMENT_START = "<li data-target=\"#carousel-1\" data-slide-to=\"";
	public static String SLIDE_INDICATOR_ELEMENT_END = "\" class=\"\">\n</li>";
	public static String SLIDE_INDICATOR_END = "</ol>";
	public static String SLIDE_CONTENT_START = "<div class=\"carousel-inner\" role=\"listbox\">";
	public static String SLIDE_CONTENT_ELEMENT_START = "<div class=\"carousel-item\">\n"
			+ "			<img class=\"d-inline-block w-100\" src=\"";
	public static String SLIDE_CONTENT_ELEMENT_END = "\">\n"
			+ "			<div class=\"carousel-caption\">\n"
			+ "			</div>\n"
			+ "		</div>";
	public static String SLIDE_CONTENT_END = "</div><a class=\"carousel-nav-controls carousel-control-prev\" href=\"#carousel-1\" role=\"button\" data-slide=\"prev\"><span class=\"fa fa-chevron-left\"></span><span class=\"sr-only\">Previous</span></a><a class=\"carousel-nav-controls carousel-control-next\" href=\"#carousel-1\" role=\"button\" data-slide=\"next\"><span class=\"fa fa-chevron-right\"></span><span class=\"sr-only\">Next</span></a>";
	public static String SLIDE_END = "</div>";
}
