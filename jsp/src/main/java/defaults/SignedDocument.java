package defaults;

import modules.security.AES256Cipher;
import modules.security.HexConvert;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.file.Paths;
import java.util.ArrayList;

public class SignedDocument {
    public static final String IDENTIFIER = "BEGIN_HSFSIGN: ";
    public static final String IDENTIFIER_END = "END_HSFSIGN";
    public static final String PASSWORD = "lJcIOGFHdeEkx7aK";

    public static final String signerVersion = "1.2";

    public final String documentPath;
    public final String documentName;
    public boolean documentSigned = true;
    public String authorIdentity = "";
    public String signIdentity = "";
    public String signedDate = "";
    public String expireDate = "";
    public String signedVersion = "";
    public boolean isDocumentModifiedAfterSign = false;
    public boolean isDocumentSignBroken = false;
    public ArrayList<String[]> unknownData = new ArrayList<>();

    public String exceptions = "";

    public SignedDocument(String documentPath) {
        this.documentPath = documentPath;
        String[] nameIndicator = documentPath.split("/");
        this.documentName = nameIndicator[nameIndicator.length - 1];
    }

    public void updateDocumentInfo() {
        try {
            String stringData = HexConvert.convertToString(Paths.get(documentPath));
            if (stringData == null) {
                documentSigned = false;
                signedVersion = "ERROR: Unable to read file from: " + documentPath;
                return;
            }
            if (stringData.contains(IDENTIFIER)) {
                updateLocalData("bool", "true");
                String signFragment = stringData.split(IDENTIFIER)[1];
                if (signFragment.split(IDENTIFIER_END).length != 1) {
                    updateLocalData("fileMod", "true");
                    return;
                }
                AES256Cipher.getInstance(PASSWORD);
                String[] data = AES256Cipher.AES_Decode(signFragment.split(IDENTIFIER_END)[0]).replace("; ", ";").split(";");
                for(int i = 0; i < data.length; i++) {
                    String subd = data[i];
//                    exceptions += "<br>" + subd + "<br>";
                    updateLocalData(subd.split("=")[0], subd.split("=")[1]);
                }
            }else{
                updateLocalData("bool", "false");
            }
            if (authorIdentity.equals("") || signedDate.equals("") || signIdentity.equals("")) documentSigned = false;
            if (expireDate.equals("")) expireDate = "Undefined";
        }catch (Exception e) {
            isDocumentSignBroken = true;
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            exceptions += sw.toString().replace("\n", "<br>");
        }
    }

    private void updateLocalData(String key, String data) {
        switch(key) {
            case "bool":
                documentSigned = data.equals("true");
                break;
            case "author":
                authorIdentity = data;
                break;
            case "identity":
                signIdentity = data;
                break;
            case "date":
                signedDate = data;
                break;
            case "expire":
                expireDate = data;
                break;
            case "version":
                signedVersion = data;
                break;
            case "fileMod":
                isDocumentModifiedAfterSign = data.equals("true");
                break;
            default:
                unknownData.add(new String[]{key, data});
                break;
        }
    }
}
