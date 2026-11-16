<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Attendance System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body style="background: linear-gradient(135deg, #1a365d 0%, #2b6cb0 100%);">

    <div class="login-wrapper">
        <div class="login-card">
            <h2>Portal Login</h2>
            <p style="color: #718096; margin-bottom: 20px; font-size: 14px;">Student Attendance Management System</p>
            
            <% 
                String error = request.getParameter("error");
                if ("1".equals(error)) {
            %>
                <div style="background:#fed7d7; color:#742a2a; padding:10px; border-radius:5px; margin-bottom:15px; font-size:13px;">
                    Invalid Username or Password!
                </div>
            <% } %>

            <form action="login_process.jsp" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Enter username (admin)" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter password (admin123)" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">Login</button>
            </form>
        </div>
    </div>

</body>
</html>
