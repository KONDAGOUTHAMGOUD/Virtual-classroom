<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Photo</title>
</head>
<body>
    <h2>Upload Photo</h2>
     <form action="uploadPhoto" method="post" enctype="multipart/form-data">
        <label for="subjectName">Subject Name:</label>
        <input type="text" id="subjectName" name="subjectName" required><br><br>

        <label for="youtubeLink">YouTube Link:</label>
        <input type="url" id="youtubeLink" name="youtubeLink" required><br><br>

        <label for="photo">Upload Photo:</label>
        <input type="file" id="photo" name="photo" accept="image/*" required><br><br>

        <input type="submit" value="Upload">
    </form>
</body>
</html>
