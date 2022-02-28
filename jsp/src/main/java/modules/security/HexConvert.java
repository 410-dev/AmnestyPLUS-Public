package modules.security;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

public class HexConvert {
    public static String convertToString(Path path) throws IOException {

        if (Files.notExists(path)) return null;

        StringBuilder result = new StringBuilder();
        StringBuilder hex = new StringBuilder();
        StringBuilder input = new StringBuilder();

        int value;

        try (InputStream inputStream = Files.newInputStream(path)) {

            while ((value = inputStream.read()) != -1) {
                hex.append(String.format("%02X ", value));
                if (!Character.isISOControl(value)) input.append((char) value);
                result.append(String.format("%s", input));
                hex.setLength(0);
                input.setLength(0);
            }
        }
        return result.toString();
    }
}
