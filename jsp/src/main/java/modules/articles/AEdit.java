package modules.articles;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class AEdit {
	public void execute(String param) throws Exception{
		AManagement amanager = new AManagement();
		String[] contentArray = param.split("&&");

		// Refer the order to ArticlesManagement variable
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime currentTime = LocalDateTime.now();

		amanager.post_id = contentArray[0];
		amanager.post_title = contentArray[1];
		amanager.post_edit = timeFormatter.format(currentTime);
		amanager.post_content = contentArray[2];
		amanager.post_photoURLs = contentArray[3];
	}
}
