import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/upload")
public class ImageUploadServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/project"; // Update
    private static final String USER = "root"; // Update
    private static final String PASS = "tiger"; // Update

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Read JSON body
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            String json = sb.toString();
            String byteArrayString = json.substring(json.indexOf("[") + 1, json.indexOf("]"));
            String[] byteStrings = byteArrayString.split(",");
            byte[] imageBytes = new byte[byteStrings.length];

            // Convert string array to byte array
            for (int i = 0; i < byteStrings.length; i++) {
                imageBytes[i] = (byte) Integer.parseInt(byteStrings[i].trim());
            }

            // Store the image in the database
            storeImageInDatabase(imageBytes);

            out.print("{\"status\":\"success\"}");
        } catch (Exception e) {
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }

    private void storeImageInDatabase(byte[] imageBytes) throws Exception {
        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String sql = "INSERT INTO images (image) VALUES (?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setBytes(1, imageBytes);
                preparedStatement.executeUpdate(); // Execute the insert command
            }
        }
    }
}
