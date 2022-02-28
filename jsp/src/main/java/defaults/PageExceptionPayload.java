package defaults;

import java.io.PrintWriter;
import java.io.StringWriter;

public class PageExceptionPayload {
    private String errorLocation = "";
    private String stackTrace = "";

    public PageExceptionPayload(Exception e, String errorLocation) {
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        stackTrace = sw.toString();
        this.errorLocation = errorLocation;
    }

    public String[] getData() {
        return new String[]{errorLocation, stackTrace};
    }
}
