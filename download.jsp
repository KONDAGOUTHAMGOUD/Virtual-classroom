<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    int fileId = Integer.parseInt(request.getParameter("id"));
    String jdbcURL = "jdbc:mysql://localhost:3306/project";
    String jdbcUsername = "root";
    String jdbcPassword = "tiger";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        String sql = "SELECT file_name, file_data FROM pdf_files WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, fileId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String fileName = rs.getString("file_name");
            Blob fileBlob = rs.getBlob("file_data");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
            InputStream inputStream = fileBlob.getBinaryStream();
            OutputStream outStream = response.getOutputStream();

            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            inputStream.close();
            outStream.close();
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Clean up resources
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
