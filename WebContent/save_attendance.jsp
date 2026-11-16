<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.time.LocalDate" %>
<%
    // ফর্ম থেকে ডেট নেওয়া, না পেলে সরাসরি আজকের তারিখ নিয়ে নেওয়া হবে
    String date = request.getParameter("date");
    if (date == null || date.trim().isEmpty()) {
        date = request.getParameter("attendance_date");
    }
    if (date == null || date.trim().isEmpty()) {
        date = LocalDate.now().toString(); // YYYY-MM-DD ফরম্যাট
    }

    Enumeration<String> parameterNames = request.getParameterNames();

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_attendance_db", "root", "");

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("status_") || paramName.startsWith("attendance_")) {
                String studentId = paramName.replaceAll("[^0-9]", ""); // শুধু আইডি বের করা
                String status = request.getParameter(paramName);

                if (!studentId.isEmpty() && status != null) {
                   String query = "INSERT INTO attendance (student_id, att_date, status) VALUES (?, ?, ?) " +
               "ON DUPLICATE KEY UPDATE status = VALUES(status)";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, Integer.parseInt(studentId));
                    ps.setString(2, date);
                    ps.setString(3, status);
                    ps.executeUpdate();
                    ps.close();
                }
            }
        }
        out.println("<script>alert('Attendance Saved Successfully!'); window.location='dashboard.jsp';</script>");
    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error saving attendance: " + e.getMessage() + "</h3>");
    } finally {
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>