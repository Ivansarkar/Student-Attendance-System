<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String user = request.getParameter("username");
    String pass = request.getParameter("password");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_attendance_db", "root", "");

        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, user);
        ps.setString(2, pass);
        rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("user", user);
            session.setAttribute("username", user);
            session.setAttribute("admin", user);
            session.setAttribute("full_name", rs.getString("full_name"));
            response.sendRedirect("dashboard.jsp");
        } else {
            out.println("<script>alert('Invalid Username or Password!'); window.location='index.jsp';</script>");
        }
    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Database Connection Error: " + e.getMessage() + "</h3>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>