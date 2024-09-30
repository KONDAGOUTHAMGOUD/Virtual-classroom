<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/project";
    String jdbcUsername = "root";
    String jdbcPassword = "tiger";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        // Query to retrieve all files
        String sql = "SELECT id, file_name FROM pdf_files";

        // Execute the query
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
%>

<html>
<head>
    <title>File List</title>
</head>
<body>
    <h2>List of Files</h2>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>File Name</th>
            <th>Action</th>
        </tr>

        <%
            // Loop through the result set and display each file with a download link
            while (rs.next()) {
                int fileId = rs.getInt("id");
                String fileName = rs.getString("file_name");
        %>
        <tr>
            <td><%= fileId %></td>
            <td><%= fileName %></td>
            <td><a href="download.jsp?id=<%= fileId %>">Download</a></td>
        </tr>
        <%
            }
        %>
    </table>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Clean up resources
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
