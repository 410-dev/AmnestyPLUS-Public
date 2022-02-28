package modules;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/UploadImage")
public class ImageUpload extends HttpServlet {

    private final String UPLOAD_DIRECTORY = "/Users/hoyounsong/Desktop/";
    private static final long serialVersionUID = 1;
    public ImageUpload() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : multiparts) {
                if (!item.isFormField()) {
                    String name = new File(item.getName()).getName();
                    item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
                }
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}
