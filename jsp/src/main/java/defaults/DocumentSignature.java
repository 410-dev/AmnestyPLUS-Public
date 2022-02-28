package defaults;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import master.LogsManager;
import modules.members.MemberData;
import modules.security.AES256Cipher;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet(name = "DocumentSignature", value = "/DocumentSignature")
public class DocumentSignature extends HttpServlet {

    private static final String signatureIdentity = "Amnesty PLUS Official Website - Signature Generator System";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("action") == null) {
            check(request, response);
        }else{
            try {
                generate(request, response);
                response.sendRedirect("./checkSign.jsp");
            } catch (Exception e) {
                request.getSession().setAttribute("AMError", new PageExceptionPayload(e, "DocumentSignature Servlet"));
                response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
            }
        }
    }

    private void generate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String data = "";
        data += "author=" + request.getParameter("author");
        data += "; identity=" + signatureIdentity;
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime currentTime = LocalDateTime.now();
        String time = timeFormatter.format(currentTime);
        data += "; date=" + time;
        if (request.getParameter("valid") != null && !request.getParameter("valid").equals("")) data += "; expire=" + request.getParameter("valid");
        else data += "; expire=Never Expires";
        data += "; version=" + SignedDocument.signerVersion;
        data += "; " + request.getParameter("custom_attributes");
        data += ";";

        String origData = "Author: " + request.getParameter("author");
        origData += "<br>Identity: " + signatureIdentity;
        origData += "<br>Signed At: " + time;
        if (request.getParameter("valid") != null && !request.getParameter("valid").equals("")) origData += "<br>Expires: " + request.getParameter("valid");
        else origData += "<br>Expires: Never Expires";
        origData += "<br>Signature Version: " + SignedDocument.signerVersion;
        origData += "<br>Custom Attributes: " + request.getParameter("custom_attributes");
        request.getSession().setAttribute("ConfirmData", origData);

        AES256Cipher.getInstance(SignedDocument.PASSWORD);
        String cipherData = AES256Cipher.AES_Encode(data);
        request.getSession().setAttribute("Signature", cipherData);
        LogsManager.addLog(((MemberData) request.getSession().getAttribute("AMLoginData")).getUsername(), ((MemberData) request.getSession().getAttribute("AMLoginData")).getRealname(), "INFO", "Generated document signature: " + cipherData);
    }

    private void check(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int size = 1024 * 1024 * 10; // 저장가능한 파일 크기
        String file = ""; // 업로드 한 파일의 이름(이름이 변경될수 있다)
        String fileLocation = "/opt/tomcat/apache-tomcat-8.5.61/webapps/ROOT/files/cache/";
        // 실제로 파일 업로드하는 과정
        MultipartRequest multi = new MultipartRequest(request, fileLocation, size, "UTF-8", new DefaultFileRenamePolicy());
        Enumeration files = multi.getFileNames();
        String str = (String)files.nextElement(); // 파일 이름을 받아와 string으로 저장
        file = multi.getFilesystemName(str); // 업로드 된 파일 이름 가져옴
        try {
            SignedDocument doc = new SignedDocument(fileLocation + file);
            doc.updateDocumentInfo();
            request.getSession().setAttribute("AMDocumentVerification", doc);
            File f = new File(fileLocation + file);
            f.delete();
            response.sendRedirect("./checkSign.jsp");
        }catch (Exception e) {
            request.getSession().setAttribute("AMError", new PageExceptionPayload(e, "DocumentSignature Servlet"));
            response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
        }
    }

    private static String regenerateFileName(String fileName) throws IOException {
//        File file = new File(fileName);
//        String encoded = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(file));
//        return new Shasum().doShasum(encoded);
        return fileName;
    }
}