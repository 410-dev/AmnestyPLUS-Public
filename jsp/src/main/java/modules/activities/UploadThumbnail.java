package modules.activities;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import defaults.PageExceptionPayload;
import master.HTMLData;
import master.Shasum;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Base64;

import org.apache.commons.io.FileUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet(name = "UploadThumbnail", value = "/UploadThumbnail")
public class UploadThumbnail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int size = 1024 * 1024 * 10; // 저장가능한 파일 크기
        String file = ""; // 업로드 한 파일의 이름(이름이 변경될수 있다)
        String fileLocation = "/opt/tomcat/apache-tomcat-8.5.61/webapps/ROOT/img/thumbnails/";
        // 실제로 파일 업로드하는 과정
        MultipartRequest multi = new MultipartRequest(request, fileLocation, size, "UTF-8", new DefaultFileRenamePolicy());
        Enumeration files = multi.getFileNames();
        String str = (String)files.nextElement(); // 파일 이름을 받아와 string으로 저장
        file = multi.getFilesystemName(str); // 업로드 된 파일 이름 가져옴
        String newFileName = regenerateFileName(fileLocation + file);
        File origFile = new File(fileLocation + file);
        File regenerated = new File(fileLocation + newFileName + ".png");
        origFile.renameTo(regenerated);
        try {
            new ActivityWrite().task(request, response, multi, newFileName + ".png");
        }catch (Exception e) {
            request.getSession().setAttribute("AMError", new PageExceptionPayload(e, "UploadThumbnail Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }

    private static String regenerateFileName(String fileName) throws IOException {
        File file = new File(fileName);
        String encoded = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(file));
        return new Shasum().doShasum(encoded);
    }
}