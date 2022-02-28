package master;

import defaults.PageExceptionPayload;
import modules.members.MemberData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.ResultSet;

@WebServlet(name = "Configurations", value = "/Configurations")
public class Configurations extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.getWriter().println("Access not allowed.");
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
            try {
                if (request.getParameter("task").equals("set")) {
                    set(request.getParameter("key"), request.getParameter("value"), request.getSession());
                }else if (request.getParameter("task").equals("add")) {
                    add(request.getParameter("key"), request.getParameter("value"), request.getSession());
                }
                response.getWriter().println("<script>window.history.back();</script>");
            } catch (Exception e) {
                request.getSession().setAttribute("AMError", new PageExceptionPayload(e, "Configurations"));
                response.getWriter().println("<script>window.location.replace(\"./error.jsp\")</script>");
            }
        }

        private void set(String key, String value, HttpSession session) throws Exception {
            DBControl.executeQuery("update configurations set data=\"" + value + "\" where name=\"" + key + "\";");
            LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "INFO", "Changed key value - key: " + key + ", value: " + value);
        }

        private void add(String key, String value, HttpSession session) throws Exception {
            LogsManager.addLog(((MemberData) session.getAttribute("AMLoginData")).getUsername(), ((MemberData) session.getAttribute("AMLoginData")).getRealname(), "INFO", "Added new key value - key: " + key + ", value: " + value);
            DBControl.executeQuery("insert into configurations(name, data) values(\"" + key + "\", \"" + value + "\");");
        }

        public String get(String key) throws Exception {
            ResultSet rs = DBControl.executeQuery("select * from configurations where name=\"" + key + "\";");
            rs.first();
            return rs.getString("data");
        }

        public ResultSet getAllConfigs() throws Exception {
            ResultSet rs = DBControl.executeQuery("select * from configurations;");
            return rs;
        }
}
